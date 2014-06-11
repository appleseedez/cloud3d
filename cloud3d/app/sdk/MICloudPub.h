//
//  MICloudPub.h
//  MICloudPub
//
//  Created by chenjianjun on 14-5-26.
//  Copyright (c) 2014年 hy. All rights reserved.
//

#import <Foundation/Foundation.h>

enum MICloudAppType {
  MICLOUD_APP_UNKNOWN = 0,
  MICLOUD_APP_MASTER = 1,
  MICLOUD_APP_CLIENT = 2,
  MICLOUD_APP_NODE = 3,
  MICLOUD_APP_MACHINE = 4,
  MICLOUD_APP_CONSOLE = 5,
};

// 命令字ID
enum MessageIds
{
  MSG_UNKNOWN = 0,
  /* Master */
  CM_LOGIN = 1, // 登录请求
  SM_LOGIN = 2, // 登录请求应答
  SM_ERROR = 3,
  CM_QUERY_RECORDS = 4, // 记录查询请求
  SM_QUERY_RECORDS = 5, // 记录查询请求应答
  CM_ADD_STUDY = 6,
  SM_ADD_STUDY = 7,
  CM_REQUEST_NODE = 8, // 记录节点服务器请求
  SM_REQUEST_NODE = 9, // 记录节点服务器请求应答
  CM_VERIFY_STUDY = 10,
  SM_VERIFY_STUDY = 11,
  CM_SAVE_STUDY = 12,
  SM_SAVE_STUDY = 13,
  CM_SCU_TASK_FIND = 14,
  MC_SCU_TASK_FIND = 15,
  CM_SCU_TASK_TRY_MOVE = 16,
  MC_SCU_TASK_TRY_MOVE = 17,
  CM_SCU_TASK_REAL_MOVE = 18,
  MC_SCU_TASK_REAL_MOVE = 19,

  /* Node */
  CM_NODE_AUTHORIZE = 51,  // 认证请求
  SM_NODE_AUTHORIZE = 52,  // 认证请求应答
  SM_NODE_SEND_IMAGE = 53, // 快照图像数据
  CM_NODE_RESIZE_WINDOW = 54,
  SM_NODE_RESIZE_WINDOW = 55,
  CM_NODE_MOUSE_EVENT = 56, // 手势操作请求
  CM_NODE_CAPTURE_SNAPSHOOT = 57,
  SM_NODE_SNAPSHOOT_DATA = 58,
  CM_NODE_SAVE_REPORT = 59,
  SM_NODE_SAVE_REPORT = 60,
  SM_NODE_KEY_EVENT = 61,
  SM_NODE_GPUVIEW_EVENT = 62,// 当前活动视图的事件消息(当前活动窗口的渲染类型,当前活动窗口的窗宽窗位)
  CM_NODE_GPU_WINDOW_INFO = 63,// 2D状态下的窗宽窗位信息
  CM_NODE_TOOLS_ID = 64,// 工具id
  CM_NODE_TRANSFER_SHADERTYPE = 65,// 传输函数里面的着色模式
  CM_NODE_TRANSFER_WINDOWINFO = 66,// 传输函数窗宽窗位信息
  CM_NODE_TRANSFER_SHOWRAGE = 67,// 传输函数的显示范围
  CM_NODE_TRANSFER_NODEINFO = 68,// 传输函数的参数信息

  /* Console */
  CM_MACHINE_STATUS_INFO = 101,
  SM_MACHINE_STATUS_INFO = 102,
  SM_ADD_MACHINE = 103,
  SM_DEL_MACHINE = 104,
  CM_CONSLOLE_QUERY = 105,
  MC_CONSLOLE_QUERY = 106,

  /* Other */
  MACHINE_MASTER_DEL_NODE = 111,
  NODE_MASTER_STATUS = 199,
  MSG_HELLO = 200,     // 连接打招呼
  MSG_KEEPALIVE = 201, // 心跳
};

// 协议里面的数据类型枚举
enum VariantType
{
  VAR_BOOLEAN = 0,
  VAR_STRING = 1,
  VAR_CHAR = 2,
  VAR_UCHAR = 3,
  VAR_SHORT = 4,
  VAR_USHORT = 5,
  VAR_INT = 6,
  VAR_UINT = 7,
  VAR_LONGLONG = 8,
  VAR_ULONGLONG = 9,
  VAR_FLOAT = 10,
  VAR_DOUBLE = 11,
};

/// 传输函数节点
#pragma pack(push,1)
struct TransferNode
{
    float   pos;            ///< 位置
    float   alpha;          ///< Alpha通道
    float   ambient[3];     ///< 环境光
    float   diffuse[3];     ///< 漫反射
    float   specular[3];    ///< 镜面反射
};
#pragma pack(pop)

#define GPU3DEVENT_ACTIVEVIEW           1
#define GPU3DEVENT_WINDOWINFO           2
#define GPU3DEVENT_TRANSFERWINDOWINFO   3

#define HEAD_PACKET_SIZE sizeof(int32)

// 套接字协议
@protocol MICloudSocketDelegate <NSObject>
- (int)RecvTcpData:(int)seq MsgID:(enum MessageIds)msgid Data:(NSData *)data;
- (int)RecvUdpData:(int)seq Data:(NSData *)data;
- (int)StatusReporting:(int)seq status:(int)status;
@end

@interface MICloudPub : NSObject

// 套接字委托
@property(nonatomic, retain) id<MICloudSocketDelegate> socketDelegate;

/*
 函数说明:获取单例
 返回值:单例指针
 */
+ (MICloudPub *)sharedInstance;
- (id)init;

// 字节操作
-(void)Set8:(void*)memory offset:(size_t)offset value:(unsigned char)v;
-(unsigned char)Get8:(const void*)memory offset:(size_t)offset;
-(void)SetLE16:(void*)memory value:(unsigned short)v;
-(unsigned short)GetLE16:(const void*)memory;
-(void)SetLE32:(void*)memory value:(unsigned int)v;
-(unsigned int)GetLE32:(const void*)memory;
-(void)SetLE64:(void*)memory  value:(unsigned long long)v;
-(unsigned long long)GetLE64:(const void*)memory;

/*
 函数说明:初期化
 返回值:true:成功 false:失败
 */
- (bool)InitNet;

/*
 函数说明:初期化销毁
 */
- (void)UInitNet;

/*
 函数说明:创建一个TCP客户端连接
 参数1:发送心跳的时间(建议设置为10秒一次)
 参数2:接收数据缓存区大小,建议设置20480(20K)
 返回值:大于0:连接标识 -1:失败
 */
- (int)CreateTcpClient:(int)breattime
        withMaxPkgSize:(int)max_packet_size;

/*
 函数说明:关闭一个tcp客户端
 参数1:创建时返回的连接标识
 返回值:0:成功 其他值:失败
 */
- (int)CloseTcpClient:(int)fd;

/*
 函数说明:获取一个tcp客户端的套接字句柄
 参数1:创建时返回的连接标识
 返回值:-1:失败 大于0:套接字句柄
 */
- (int)GetTcpSocketFd:(int)fd;

/*
 函数说明:创建一个UDP客户端连接
 返回值:大于0:连接标识 -1:失败
 */
- (int)CreateUdpClient;

/*
 函数说明:关闭一个udp客户端
 参数1:创建时返回的连接标识
 返回值:0:成功 其他值:失败
 */
- (int)CloseUdpClient:(int)fd;

/*
 函数说明:获取一个UDP客户端的套接字句柄
 参数1:创建时返回的连接标识
 返回值:-1:失败 大于0:套接字句柄
 */
- (int)GetUdpSocketFd:(int)fd;

/*
 函数说明:TCP客户端连接服务器
 参数1:创建时返回的连接标识
 参数2:服务器名
 参数3:服务器端口
 返回值:true:成功 false:失败
 */
- (bool)Connect:(int)fd
       HostName:(NSString *)hostname
       HostPort:(int)port;

/*
 函数说明:发送TCP数据
 参数1:创建时返回的连接标识
 参数2:发送的数据
 返回值:发送的字节数
 */
- (int)SendTCPData:(int)fd
              Data:(NSData *)data;

/*
 函数说明:发送UDPP数据
 参数1:创建时返回的连接标识
 参数2:发送的数据
 参数3:接收数据的目的IP地址
 参数4:接收数据的目的端口
 返回值:发送的字节数
 */
- (int)SendUDPData:(int)fd
              Data:(NSData *)data
                IP:(NSString *)ip
              Port:(int)port;

/*
 函数说明:发送hello
 参数1:创建时返回的连接标识
 返回值:-1:失败 大于0是成功
 */
- (int)SendHelloData:(int)fd;

/*
 函数说明:发送心跳包
 参数1:创建时返回的连接标识
 返回值:-1:失败 大于0是成功
 */
- (int)SendHeartbeatData:(int)fd;

/*
 函数说明:发送登录请求
 参数1:创建时返回的连接标识
 参数2:用户名
 参数3:用户密码
 参数4:登录的客户端类型 0- PC客户端  1–其他
 返回值:-1:失败 大于0是成功
 */
- (int)SendLogin:(int)fd
        UserName:(NSString *)username
        UserPass:(NSString *)passwd
      ClientType:(int)clienttype;

/*
 函数说明:发送记录查询请求
 参数1:创建时返回的连接标识
 参数2:查询条件 key(NSString*)-value(NSString*)方式存储
 参数3:开始时间
 参数4:结束时间
 参数5:查询偏移量，从第几条开始查询
 参数6:返回多少条查询记录
 返回值:-1:失败 大于0是成功
 */
- (int)SendQueryRecords:(int)fd
             Conditions:(NSDictionary *)dict
              BeginDate:(NSString *)startTime
                EndDate:(NSString *)endTime
                 OffSet:(int)offSet
               RowCount:(int)rowCount;

/*
 函数说明:发送节点查询请求
 参数1:创建时返回的连接标识
 参数2:ID号
 返回值:-1:失败 大于0是成功
 */
- (int)SendQueryNode:(int)fd
                  ID:(unsigned long)idNumber;

/*
 函数说明:发送认证请求
 参数1:创建时返回的连接标识
 参数2:KEY,是节点查询请求应答的时候由Master服务器返回的
 参数3:图像显示的宽
 参数4:图像显示的高
 返回值:-1:失败 大于0是成功
 */
- (int)SendNodeAuthotize:(int)fd
                     Key:(NSString *)key
                   Width:(int)width
                  Height:(int)height;

/*
 函数说明:发送手势操作请求
 参数1:创建时返回的连接标识
 参数2:手势类型
 参数3:x坐标
 参数4:y坐标
 参数5:偏移量
 返回值:-1:失败 大于0是成功
 */
- (int)SendMouseEvent:(int)fd
                 type:(int)type
                   dx:(int)x
                   dy:(int)y
               offset:(int)offset;

/*
 函数说明:发送窗宽窗位(2D状态下的窗宽窗位信息)
 参数1:创建时返回的连接标识
 参数2:windowLevel
 参数3:windowWidth
 返回值:-1:失败 大于0是成功
 */
- (int)SendNodeGpuWindowInfo:(int)fd
                 WindowLevel:(int)windowLevel
                 WindowWidth:(int)windowWidth;

/*
 函数说明:发送工具ID
 参数1:toolsID
 返回值:-1:失败 大于0是成功
 */
- (int)SendNodeToolsID:(int)fd
                 ToolsID:(int)toolsID;

/*
 函数说明:发送传输函数里面的着色模式
 参数1:shaderType
 返回值:-1:失败 大于0是成功
 */
- (int)SendNodeShaderType:(int)fd
                  ShaderType:(int)shaderType;

/*
 函数说明:发送传输函数窗宽窗位
 参数1:创建时返回的连接标识
 参数2:windowLevel
 参数3:windowWidth
 返回值:-1:失败 大于0是成功
 */
- (int)SendNodeTransferWindowInfo:(int)fd
                      WindowLevel:(int)windowLevel
                      WindowWidth:(int)windowWidth;

/*
 函数说明:发送传输函数的显示范围
 参数1:创建时返回的连接标识
 参数2:showRageMin
 参数3:showRageMax
 返回值:-1:失败 大于0是成功
 */
- (int)SendNodeTransferShowRage:(int)fd
                    ShowRageMin:(float)showRageMin
                    ShowRageMax:(float)showRageMax;
/*
 函数说明:发送传输函数的参数信息
 参数1:创建时返回的连接标识
 参数2:showRageMin
 参数3:showRageMax
 返回值:-1:失败 大于0是成功
 */
- (int)SendNodeTransferInfo:(int)fd
              TransferNodes:(NSArray*)transferNodes;

/*
 函数说明:数据解码
 参数1:原始待解码数据
 参数2:解码以后的yuv数据存放缓存区
 参数2:解码以后的yuv数据存放缓存区大小
 参数3:解码后的数据宽度
 参数4:解码后的数据高度
 返回值:0是成功 其他值是失败
 */
-(int)H264DataDecode:(NSData*)pDataIn
          YUVDataBuf:(uint8_t*)yuvDataBuf
       YUVDataBufLen:(int)yuvDataBufLen
               Width:(int*)width
              Height:(int*)height;

@end
