//
//  MICloudPub+Parser.h
//  test
//
//  Created by Zeug on 14-5-31.
//  Copyright (c) 2014年 hy. All rights reserved.
//

#import "MICloudPub.h"

@interface MICloudPub (Parser)
// 解析登录应答数据
- (int)AnalyticalLoginResp:(NSData *)pdata
                    Result:(Boolean *)result // 登录结果 true是成功，false是失败
                  ErrorMsg:(NSString **)
    errorMsg // 登录结果为false是，这个存储的是错误描述
                      Name:(NSString **)name // 用户名
                      Role:(NSInteger *)role // 权限
         ControlDictionary:
             (NSMutableDictionary **)controlDictionary // 控件类型字典
          MainDisplayItems:(NSMutableArray **)mainDisplayItems // 主界面显示项
        QueryDisplayHeader:
            (NSMutableArray **)queryDisplayHeader // 查询界面显示表头
     QueryCondDisplayItems:
         (NSMutableArray **)queryCondDisplayItems // 查询界面显示项
             FtpConfigInfo:(NSMutableDictionary **)ftpConfigInfo; // FTP配置信息
// 解析记录查询应答数据
- (int)AnalyticalQueryRecordsResp:(NSData *)pdata
                           Result:(Boolean *)result // 登录结果
    // true是成功，false是失败
                         ErrorMsg:(NSString **)
    errorMsg // 登录结果为false是，这个存储的是错误描述
                     TotalRecords:(NSInteger *)totalRecords // 总共多少条记录
                          Columns:(NSMutableArray **)columns     // 列头
                       RecordList:(NSMutableArray **)recordList; // 数据列表

// 解析节点查询应答数据
- (int)AnlyticalRequestNodeResp:(NSData *)pdata
                         Result:(Boolean *)result // 登录结果
    // true是成功，false是失败
                       ErrorMsg:(NSString **)
    errorMsg // 登录结果为false是，这个存储的是错误描述
                             ID:(NSUInteger *)recordID // 记录ID
                         NodeIP:(NSString **)nodeip    // node服务器ip
                       NodePort:(NSInteger *)nodeport  // node服务器端口
                            Kye:(NSString **)key;      // key

// 解析认证请求应答
- (int)AnlyticalAuthorizeResp:(NSData *)pdata
                       Result:
                           (Boolean *)result // 登录结果 true是成功，false是失败
                     ErrorMsg:(NSString **)
    errorMsg // 登录结果为false是，这个存储的是错误描述
                      UdpPort:(NSInteger *)UdpPort       // Rtp数据端口
                NSnapshootNum:(NSInteger *)nSnapshootNum // 总共多少张图片
                   ReportCols:(NSInteger *)reportCols    // 多少列
                   ReportRows:(NSInteger *)neportRows    // 多少行
                  WindowLevel:(NSInteger*)windowLevel    // 窗位
                  WindowWidth:(NSInteger*)windowWidth    // 窗宽
                     MinWidth:(NSInteger*)minWidth    // 最小窗宽
                     MaxWidth:(NSInteger*)maxWidth    // 最大窗宽
                     NodeInfo:(NSMutableArray **)NodeInfo; // node信息

// 解析快照数据
-(int)AnlyticalNodeSnapshootDdta:(NSData*)pdata
                           Index:(NSInteger*)index // 图片索引
                      DataBuffer:(NSData**)dataBuffer;// 图片数据

/*
 解析当前活动视图的事件消息(当前活动窗口的渲染类型,当前活动窗口的窗宽窗位)
 type是GPU3DEVENT_ACTIVEVIEW的时候renderType有值
 type是GPU3DEVENT_WINDOWINFO或者GPU3DEVENT_TRANSFERWINDOWINFO的windowLevel和windowWidth有值
 */
-(int)AnlyticalNodeGpuviewEvent:(NSData*)pdata
                           Type:(NSInteger*)type
                     renderType:(NSInteger*)renderType
                    WindowLevel:(NSInteger*)windowLevel
                    WindowWidth:(NSInteger*)windowWidth;
@end
