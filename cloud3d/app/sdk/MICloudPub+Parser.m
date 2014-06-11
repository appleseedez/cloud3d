//
//  MICloudPub+Parser.m
//  test
//
//  Created by Zeug on 14-5-31.
//  Copyright (c) 2014年 hy. All rights reserved.
//

#import "MICloudPub+Parser.h"

@implementation MICloudPub (Parser)

- (int)AnalyticalLoginResp:(NSData *)pdata
                    Result:(Boolean *)result // 登录结果 true是成功，false是失败
                  ErrorMsg:(NSString **)errorMsg // 登录结果为false是，这个存储的是错误描述
                      Name:(NSString **)name // 用户名
                      Role:(NSInteger *)role // 权限
         ControlDictionary:(NSMutableDictionary **)controlDictionary // 控件类型字典
          MainDisplayItems:(NSMutableArray **)mainDisplayItems // 主界面显示项
        QueryDisplayHeader:(NSMutableArray **)queryDisplayHeader // 查询界面显示表头
     QueryCondDisplayItems:(NSMutableArray **)queryCondDisplayItems // 查询界面显示项
             FtpConfigInfo:(NSMutableDictionary **)ftpConfigInfo // FTP配置信息
{
    
    const char *data = (const char *)[pdata bytes];
    NSStringEncoding enc =
    CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    int pos = 0;
    int len = 0;
    
    // 判断登陆结果
    *result =
    ([[MICloudPub sharedInstance] Get8:data offset:pos] == 0 ? false : true);
    pos += 1;
    if (*result)
    {
        // 解析Name
        len = [[MICloudPub sharedInstance] GetLE16:data + pos];
        pos += 2;
        *name = [[NSString alloc] initWithBytes:data + pos length:len encoding:enc];
        pos += len;
        
        // 解析权限
        *role = [[MICloudPub sharedInstance] GetLE16:data + pos];
        pos += 2;
        
        // 解析字典列表
        size_t size = [[MICloudPub sharedInstance] GetLE16:data + pos];
        pos += 2;
        *controlDictionary = [NSMutableDictionary dictionaryWithCapacity:size];
        for (size_t i = 0; i < size; ++i) {
            // 解析key
            len = [[MICloudPub sharedInstance] GetLE16:data + pos];
            pos += 2;
            NSString *keyname =
            [[NSString alloc] initWithBytes:data + pos length:len encoding:enc];
            pos += len;
            
            // 解析value
            size_t vcsize = [[MICloudPub sharedInstance] GetLE16:data + pos];
            pos += 2;
            NSMutableArray *valueArray = [[NSMutableArray alloc] initWithCapacity:vcsize];
            for (size_t j = 0; j < vcsize; ++j) {
                // 解析value元素
                len = [[MICloudPub sharedInstance] GetLE16:data + pos];
                pos += 2;
                NSString *valuestr =
                [[NSString alloc] initWithBytes:data + pos length:len encoding:enc];
                pos += len;
                
                [valueArray addObject:valuestr];
            }
            
            [*controlDictionary setObject:valueArray forKey:keyname];
        }
        
        // 解析导入DICOM文件显示配置 IOS客户端不需要此配置
        size = [[MICloudPub sharedInstance] GetLE16:data + pos];
        pos += 2;
        for (size_t i = 0; i < size; ++i) {
            // 解析value
            // 解析姓名
            len = [[MICloudPub sharedInstance] GetLE16:data + pos];
            pos += 2;
            NSString *name =
            [[NSString alloc] initWithBytes:data + pos length:len encoding:enc];
            pos += len;
            
            // 解析英文显示名
            len = [[MICloudPub sharedInstance] GetLE16:data + pos];
            pos += 2;
            NSString *nameen =
            [[NSString alloc] initWithBytes:data + pos length:len encoding:enc];
            pos += len;
            
            // 解析中文显示名
            len = [[MICloudPub sharedInstance] GetLE16:data + pos];
            pos += 2;
            NSString *namecn =
            [[NSString alloc] initWithBytes:data + pos length:len encoding:enc];
            pos += len;
            NSLog(@"[%@] \t [%@] \t [%@ ]", name, nameen, namecn);
        }
        
        // 解析导入DICOM查询配置 IOS客户端不需要此配置
        size = [[MICloudPub sharedInstance] GetLE16:data + pos];
        pos += 2;
        for (size_t i = 0; i < size; ++i) {
            // 解析value
            // 解析名称
            len = [[MICloudPub sharedInstance] GetLE16:data + pos];
            pos += 2;
            NSString *name =
            [[NSString alloc] initWithBytes:data + pos length:len encoding:enc];
            pos += len;
            
            // 解析英文显示名
            len = [[MICloudPub sharedInstance] GetLE16:data + pos];
            pos += 2;
            NSString *nameen =
            [[NSString alloc] initWithBytes:data + pos length:len encoding:enc];
            pos += len;
            
            // 解析中文显示名
            len = [[MICloudPub sharedInstance] GetLE16:data + pos];
            pos += 2;
            NSString *namecn =
            [[NSString alloc] initWithBytes:data + pos length:len encoding:enc];
            pos += len;
            
            // 解析控件类型
            len = [[MICloudPub sharedInstance] GetLE16:data + pos];
            pos += 2;
            NSString *type =
            [[NSString alloc] initWithBytes:data + pos length:len encoding:enc];
            pos += len;
            
            NSLog(@"[%@] \t [%@] \t [%@ ]\t [%@]", name, nameen, namecn, type);
        }
        
        // 解析主界面显示项
        size = [[MICloudPub sharedInstance] GetLE16:data + pos];
        pos += 2;
        *mainDisplayItems = [[NSMutableArray alloc] initWithCapacity:size];
        for (size_t i = 0; i < size; ++i)
        {
            NSMutableArray *valueArray = [[NSMutableArray alloc] initWithCapacity:3];
            // 解析value
            // 解析名称
            len = [[MICloudPub sharedInstance] GetLE16:data + pos];
            pos += 2;
            NSString *name =
            [[NSString alloc] initWithBytes:data + pos length:len encoding:enc];
            pos += len;
            [valueArray addObject:name];
            
            // 解析英文显示名
            len = [[MICloudPub sharedInstance] GetLE16:data + pos];
            pos += 2;
            NSString *nameen =
            [[NSString alloc] initWithBytes:data + pos length:len encoding:enc];
            pos += len;
            [valueArray addObject:nameen];
            
            // 解析中文显示名
            len = [[MICloudPub sharedInstance] GetLE16:data + pos];
            pos += 2;
            NSString *namecn =
            [[NSString alloc] initWithBytes:data + pos length:len encoding:enc];
            pos += len;
            [valueArray addObject:namecn];
            
            [*mainDisplayItems addObject:valueArray];
        }
        
        // 查询结果显示表头
        size = [[MICloudPub sharedInstance] GetLE16:data + pos];
        pos += 2;
        *queryDisplayHeader = [[NSMutableArray alloc] initWithCapacity:size];
        for (size_t i = 0; i < size; ++i)
        {
            NSMutableArray *valueArray = [[NSMutableArray alloc] initWithCapacity:3];
            // 解析value
            // 解析名称
            len = [[MICloudPub sharedInstance] GetLE16:data + pos];
            pos += 2;
            NSString *name =
            [[NSString alloc] initWithBytes:data + pos length:len encoding:enc];
            pos += len;
            [valueArray addObject:name];
            
            // 解析英文显示名
            len = [[MICloudPub sharedInstance] GetLE16:data + pos];
            pos += 2;
            NSString *nameen =
            [[NSString alloc] initWithBytes:data + pos length:len encoding:enc];
            pos += len;
            [valueArray addObject:nameen];
            
            // 解析中文显示名
            len = [[MICloudPub sharedInstance] GetLE16:data + pos];
            pos += 2;
            NSString *namecn =
            [[NSString alloc] initWithBytes:data + pos length:len encoding:enc];
            pos += len;
            [valueArray addObject:namecn];
            
            [*queryDisplayHeader addObject:valueArray];
        }
        
        // 解析查询界面显示项
        size = [[MICloudPub sharedInstance] GetLE16:data + pos];
        pos += 2;
        *queryCondDisplayItems = [[NSMutableArray alloc] initWithCapacity:size];
        for (size_t i = 0; i < size; ++i)
        {
            NSMutableArray *valueArray = [[NSMutableArray alloc] initWithCapacity:4];
            // 解析value
            // 解析名称
            len = [[MICloudPub sharedInstance] GetLE16:data + pos];
            pos += 2;
            NSString *name =
            [[NSString alloc] initWithBytes:data + pos length:len encoding:enc];
            pos += len;
            [valueArray addObject:name];
            
            // 解析英文显示名
            len = [[MICloudPub sharedInstance] GetLE16:data + pos];
            pos += 2;
            NSString *nameen =
            [[NSString alloc] initWithBytes:data + pos length:len encoding:enc];
            pos += len;
            [valueArray addObject:nameen];
            
            // 解析中文显示名
            len = [[MICloudPub sharedInstance] GetLE16:data + pos];
            pos += 2;
            NSString *namecn =
            [[NSString alloc] initWithBytes:data + pos length:len encoding:enc];
            pos += len;
            [valueArray addObject:namecn];
            
            // 解析控件类型
            len = [[MICloudPub sharedInstance] GetLE16:data + pos];
            pos += 2;
            NSString *type =
            [[NSString alloc] initWithBytes:data + pos length:len encoding:enc];
            pos += len;
            [valueArray addObject:type];
            
            [*queryCondDisplayItems addObject:valueArray];
        }
        
        // study编辑界面配置 ios客户端不需要
        size = [[MICloudPub sharedInstance] GetLE16:data + pos];
        pos += 2;
        for (size_t i = 0; i < size; ++i)
        {
            // 解析value
            // 解析名称
            len = [[MICloudPub sharedInstance] GetLE16:data + pos];
            pos += 2;
            NSString *name =
            [[NSString alloc] initWithBytes:data + pos length:len encoding:enc];
            pos += len;
            
            // 解析英文显示名
            len = [[MICloudPub sharedInstance] GetLE16:data + pos];
            pos += 2;
            NSString *nameen =
            [[NSString alloc] initWithBytes:data + pos length:len encoding:enc];
            pos += len;
            
            // 解析中文显示名
            len = [[MICloudPub sharedInstance] GetLE16:data + pos];
            pos += 2;
            NSString *namecn =
            [[NSString alloc] initWithBytes:data + pos length:len encoding:enc];
            pos += len;
            
            // 解析控件类型
            len = [[MICloudPub sharedInstance] GetLE16:data + pos];
            pos += 2;
            NSString *type =
            [[NSString alloc] initWithBytes:data + pos length:len encoding:enc];
            pos += len;
            
            NSLog(@"[%@] \t [%@] \t [%@ ]\t [%@]", name, nameen, namecn, type);
        }

        // 解析FTP配置信息
        size = [[MICloudPub sharedInstance] GetLE16:data + pos];
        pos += 2;
        *ftpConfigInfo = [NSMutableDictionary dictionaryWithCapacity:size];
        for (size_t i = 0; i < size; ++i)
        {
            // 解析key
            len = [[MICloudPub sharedInstance] GetLE16:data + pos];
            pos += 2;
            NSString *keyname = [[NSString alloc] initWithBytes:data + pos length:len encoding:enc];
            pos += len;
            
            NSString *value;
            // 解析value
            // 取type
            enum VariantType vattype = (enum VariantType) [[MICloudPub sharedInstance] Get8 : data offset : pos];
            pos += 1;
            
            switch (vattype)
            {
                case VAR_BOOLEAN: {
                    bool tmp = (bool)[[MICloudPub sharedInstance] Get8:data offset:pos];
                    pos += 1;
                    value = [[NSString alloc] initWithFormat:@"%d", tmp];
                    
                    break;
                }
                case VAR_STRING: {
                    len = [[MICloudPub sharedInstance] GetLE16:data + pos];
                    pos += 2;
                    value =
                    [[NSString alloc] initWithBytes:data + pos length:len encoding:enc];
                    pos += len;
                    
                    break;
                }
                case VAR_CHAR:
                case VAR_UCHAR: {
                    uint8_t tmp = [[MICloudPub sharedInstance] Get8:data offset:pos];
                    pos += 1;
                    value = [[NSString alloc] initWithFormat:@"%d", tmp];
                    
                    break;
                }
                case VAR_SHORT:
                case VAR_USHORT: {
                    uint16_t tmp = [[MICloudPub sharedInstance] GetLE16:data + pos];
                    pos += 2;
                    value = [[NSString alloc] initWithFormat:@"%d", tmp];
                    
                    break;
                }
                case VAR_INT:
                case VAR_UINT: {
                    uint32_t tmp = [[MICloudPub sharedInstance] GetLE32:data + pos];
                    pos += 4;
                    value = [[NSString alloc] initWithFormat:@"%d", tmp];
                    
                    break;
                }
                case VAR_LONGLONG:
                case VAR_ULONGLONG: {
                    uint64_t tmp = [[MICloudPub sharedInstance] GetLE64:data + pos];
                    pos += 8;
                    value = [[NSString alloc] initWithFormat:@"%llu", tmp];
                    
                    break;
                }
                case VAR_FLOAT: {
                    float tmp = (float)[[MICloudPub sharedInstance] GetLE32:data + pos];
                    pos += 4;
                    value = [[NSString alloc] initWithFormat:@"%f", tmp];
                    
                    break;
                }
                case VAR_DOUBLE: {
                    double tmp = (double)[[MICloudPub sharedInstance] GetLE64:data + pos];
                    pos += 8;
                    value = [[NSString alloc] initWithFormat:@"%f", tmp];
                    
                    break;
                }
                default:
                    break;
            }
            
            [*ftpConfigInfo setObject:value forKey:keyname];
        }
    } else {
        // 解析错误描述
        len = [[MICloudPub sharedInstance] GetLE16:data + pos];
        pos += 2;
        *errorMsg =
        [[NSString alloc] initWithBytes:data + pos length:len encoding:enc];
        pos += len;
    }
    
    return 0;
}

- (int)AnalyticalQueryRecordsResp:(NSData *)pdata
                           Result:(Boolean *)result // 登录结果true是成功，false是失败
                         ErrorMsg:(NSString **)errorMsg // 登录结果为false是，这个存储的是错误描述
                     TotalRecords:(NSInteger *)totalRecords // 总共多少条记录
                          Columns:(NSMutableArray **)columns // 列头
                       RecordList:(NSMutableArray **)recordList {
    const char *data = (const char *)[pdata bytes];
    NSStringEncoding enc =
    CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    int pos = 0;
    int len = 0;
    
    // 查询结果
    *result =
    ([[MICloudPub sharedInstance] Get8:data offset:pos] == 0 ? false : true);
    pos += 1;
    if (*result) {
        // 解析总共多少条记录
        *totalRecords = [[MICloudPub sharedInstance] GetLE32:data + pos];
        pos += 4;
        
        // 解析列头
        size_t size = [[MICloudPub sharedInstance] GetLE16:data + pos];
        pos += 2;
        *columns = [[NSMutableArray alloc] initWithCapacity:size];
        for (size_t i = 0; i < size; ++i) {
            // 解析value
            len = [[MICloudPub sharedInstance] GetLE16:data + pos];
            pos += 2;
            NSString *value =
            [[NSString alloc] initWithBytes:data + pos length:len encoding:enc];
            pos += len;
            
            [*columns addObject:value];
        }
        
        // 解析记录数据
        size = [[MICloudPub sharedInstance] GetLE16:data + pos];
        pos += 2;
        *recordList = [[NSMutableArray alloc] initWithCapacity:size];
        for (size_t i = 0; i < size; ++i)
        {
            // 解析数据
            size_t jsize = [[MICloudPub sharedInstance] GetLE16:data + pos];
            pos += 2;
            NSMutableArray *recordalue = [[NSMutableArray alloc] initWithCapacity:jsize];
            
            for (size_t j = 0; j < jsize; ++j)
            {
                NSString *value;
                // 取type
                enum VariantType vattype = (enum VariantType)
                [[MICloudPub sharedInstance] Get8 : data offset : pos];
                pos += 1;
                switch (vattype) {
                    case VAR_BOOLEAN: {
                        bool tmp = (bool)[[MICloudPub sharedInstance] Get8:data offset:pos];
                        pos += 1;
                        value = [[NSString alloc] initWithFormat:@"%d", tmp];
                        
                        break;
                    }
                    case VAR_STRING: {
                        len = [[MICloudPub sharedInstance] GetLE16:data + pos];
                        pos += 2;
                        value = [[NSString alloc] initWithBytes:data + pos
                                                         length:len
                                                       encoding:enc];
                        pos += len;
                        
                        break;
                    }
                    case VAR_CHAR:
                    case VAR_UCHAR: {
                        uint8_t tmp = [[MICloudPub sharedInstance] Get8:data offset:pos];
                        pos += 1;
                        value = [[NSString alloc] initWithFormat:@"%d", tmp];
                        
                        break;
                    }
                    case VAR_SHORT:
                    case VAR_USHORT: {
                        uint16_t tmp = [[MICloudPub sharedInstance] GetLE16:data + pos];
                        pos += 2;
                        value = [[NSString alloc] initWithFormat:@"%d", tmp];
                        
                        break;
                    }
                    case VAR_INT:
                    case VAR_UINT: {
                        uint32_t tmp = [[MICloudPub sharedInstance] GetLE32:data + pos];
                        pos += 4;
                        value = [[NSString alloc] initWithFormat:@"%d", tmp];
                        
                        break;
                    }
                    case VAR_LONGLONG:
                    case VAR_ULONGLONG: {
                        uint64_t tmp = [[MICloudPub sharedInstance] GetLE64:data + pos];
                        pos += 8;
                        value = [[NSString alloc] initWithFormat:@"%llu", tmp];
                        
                        break;
                    }
                    case VAR_FLOAT: {
                        float tmp = (float)[[MICloudPub sharedInstance] GetLE32:data + pos];
                        pos += 4;
                        value = [[NSString alloc] initWithFormat:@"%f", tmp];
                        
                        break;
                    }
                    case VAR_DOUBLE: {
                        double tmp = (double)[[MICloudPub sharedInstance] GetLE64:data + pos];
                        pos += 8;
                        value = [[NSString alloc] initWithFormat:@"%f", tmp];
                        
                        break;
                    }
                    default:
                        break;
                }
                
                [recordalue addObject:value];
            }
            
            [*recordList addObject:recordalue];
        }
    } else {
        // 解析错误描述
        len = [[MICloudPub sharedInstance] GetLE16:data + pos];
        pos += 2;
        *errorMsg =
        [[NSString alloc] initWithBytes:data + pos length:len encoding:enc];
        pos += len;
    }
    
    return 0;
}

- (int)AnlyticalRequestNodeResp:(NSData *)pdata
                         Result:(Boolean *)result // 登录结果 true是成功，false是失败
                       ErrorMsg:(NSString **)errorMsg // 登录结果为false是，这个存储的是错误描述
                             ID:(NSUInteger *)recordID // 记录ID
                         NodeIP:(NSString **)nodeip    // node服务器ip
                       NodePort:(NSInteger *)nodeport  // node服务器端口
                            Kye:(NSString **)key       // key
{
    const char *data = (const char *)[pdata bytes];
    NSStringEncoding enc =
    CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    int pos = 0;
    int len = 0;
    
    // 查询结果
    *result =
    ([[MICloudPub sharedInstance] Get8:data offset:pos] == 0 ? false : true);
    pos += 1;
    if (*result) {
        // 解析ID
        *recordID = (NSUInteger)[[MICloudPub sharedInstance] GetLE64 : data + pos];
        pos += 8;
        
        // 解析NODE ip
        len = [[MICloudPub sharedInstance] GetLE16:data + pos];
        pos += 2;
        *nodeip =
        [[NSString alloc] initWithBytes:data + pos length:len encoding:enc];
        pos += len;
        
        // NODE服务器端口
        *nodeport = [[MICloudPub sharedInstance] GetLE16:data + pos];
        pos += 2;
        
        // key
        len = [[MICloudPub sharedInstance] GetLE16:data + pos];
        pos += 2;
        *key = [[NSString alloc] initWithBytes:data + pos length:len encoding:enc];
        pos += len;
    } else {
        // 解析错误描述
        len = [[MICloudPub sharedInstance] GetLE16:data + pos];
        pos += 2;
        *errorMsg =
        [[NSString alloc] initWithBytes:data + pos length:len encoding:enc];
        pos += len;
    }
    
    return 0;
}

- (int)AnlyticalAuthorizeResp:(NSData *)pdata
                       Result:(Boolean *)result // 登录结果 true是成功，false是失败
                     ErrorMsg:(NSString **)errorMsg // 登录结果为false是，这个存储的是错误描述
                      UdpPort:(NSInteger *)udpPort       // Rtp数据端口
                NSnapshootNum:(NSInteger *)nSnapshootNum // 总共多少张图片
                   ReportCols:(NSInteger *)reportCols    // 多少列
                   ReportRows:(NSInteger *)neportRows    // 多少行
                  WindowLevel:(NSInteger*)windowLevel    // 窗位
                  WindowWidth:(NSInteger*)windowWidth    // 窗宽
                     MinWidth:(NSInteger*)minWidth    // 最小窗宽
                     MaxWidth:(NSInteger*)maxWidth    // 最大窗宽
                     NodeInfo:(NSMutableArray **)NodeInfo
{
    const char *data = (const char *)[pdata bytes];
    NSStringEncoding enc =
    CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    int pos = 0;
    int len = 0;
    
    // 查询结果
    *result =
    ([[MICloudPub sharedInstance] Get8:data offset:pos] == 0 ? false : true);
    pos += 1;
    if (*result)
    {
        // Rtp数据端口
        *udpPort = [[MICloudPub sharedInstance] GetLE16:data + pos];
        pos += 2;
        
        // 总共多少张图片
        *nSnapshootNum = [[MICloudPub sharedInstance] GetLE32:data + pos];
        pos += 4;
        
        // 多少列
        *reportCols = [[MICloudPub sharedInstance] GetLE32:data+pos];
        pos += 4;
        
        // 多少行
        *neportRows = [[MICloudPub sharedInstance] GetLE32:data+pos];
        pos += 4;
        
        // 窗位
        *windowLevel = [[MICloudPub sharedInstance] GetLE32:data+pos];
        pos += 4;
        
        // 窗宽
        *windowWidth = [[MICloudPub sharedInstance] GetLE32:data+pos];
        pos += 4;
        
        // 最小窗宽
        *minWidth = [[MICloudPub sharedInstance] GetLE32:data+pos];
        pos += 4;
        
        // 最大窗宽
        *maxWidth = [[MICloudPub sharedInstance] GetLE32:data+pos];
        pos += 4;
        
        // 解析FTP配置信息
        // 解析记录数据
        size_t size = [[MICloudPub sharedInstance] GetLE16:data + pos];
        pos += 2;
        *NodeInfo = [[NSMutableArray alloc] initWithCapacity:size];
        for (size_t i = 0; i < size; ++i)
        {
            NSString *value;
            // 取type
            enum VariantType vattype = (enum VariantType)
            [[MICloudPub sharedInstance] Get8 : data offset : pos];
            pos += 1;
            switch (vattype) {
                case VAR_BOOLEAN: {
                    bool tmp = (bool)[[MICloudPub sharedInstance] Get8:data offset:pos];
                    pos += 1;
                    value = [[NSString alloc] initWithFormat:@"%d", tmp];
                    
                    break;
                }
                case VAR_STRING: {
                    len = [[MICloudPub sharedInstance] GetLE16:data + pos];
                    pos += 2;
                    value = [[NSString alloc] initWithBytes:data + pos
                                                     length:len
                                                   encoding:enc];
                    pos += len;
                    
                    break;
                }
                case VAR_CHAR:
                case VAR_UCHAR: {
                    uint8_t tmp = [[MICloudPub sharedInstance] Get8:data offset:pos];
                    pos += 1;
                    value = [[NSString alloc] initWithFormat:@"%d", tmp];
                    
                    break;
                }
                case VAR_SHORT:
                case VAR_USHORT: {
                    uint16_t tmp = [[MICloudPub sharedInstance] GetLE16:data + pos];
                    pos += 2;
                    value = [[NSString alloc] initWithFormat:@"%d", tmp];
                    
                    break;
                }
                case VAR_INT:
                case VAR_UINT: {
                    uint32_t tmp = [[MICloudPub sharedInstance] GetLE32:data + pos];
                    pos += 4;
                    value = [[NSString alloc] initWithFormat:@"%d", tmp];
                    
                    break;
                }
                case VAR_LONGLONG:
                case VAR_ULONGLONG: {
                    uint64_t tmp = [[MICloudPub sharedInstance] GetLE64:data + pos];
                    pos += 8;
                    value = [[NSString alloc] initWithFormat:@"%llu", tmp];
                    
                    break;
                }
                case VAR_FLOAT: {
                    float tmp = (float)[[MICloudPub sharedInstance] GetLE32:data + pos];
                    pos += 4;
                    value = [[NSString alloc] initWithFormat:@"%f", tmp];
                    
                    break;
                }
                case VAR_DOUBLE: {
                    double tmp = (double)[[MICloudPub sharedInstance] GetLE64:data + pos];
                    pos += 8;
                    value = [[NSString alloc] initWithFormat:@"%f", tmp];
                    
                    break;
                }
                default:
                    break;
            }
            
            [*NodeInfo addObject:value];
        }
    }
    else
    {
        // 解析错误描述
        len = [[MICloudPub sharedInstance] GetLE16:data+pos];
        pos += 2;
        *errorMsg = [[NSString alloc] initWithBytes:data+pos length:len encoding:enc];
        pos += len;
    }
    
    return 0;
}

-(int)AnlyticalNodeSnapshootDdta:(NSData*)pdata
                           Index:(NSInteger*)index // 图片索引
                      DataBuffer:(NSData**)dataBuffer// 图片数据
{
    const char* data=(const char*)[pdata bytes];
    int pos = 0;
    int len = 0;
    
    // index
    *index = (NSInteger)[[MICloudPub sharedInstance] Get8:data offset:pos];
    pos += 1;
    
    // data
    len = [[MICloudPub sharedInstance] GetLE16:data+pos];
    pos += 2;
    *dataBuffer = [NSData dataWithBytes:data+pos length:len];
    
    return 0;
}

-(int)AnlyticalNodeGpuviewEvent:(NSData*)pdata
                           Type:(NSInteger*)type
                     renderType:(NSInteger*)renderType
                    WindowLevel:(NSInteger*)windowLevel
                    WindowWidth:(NSInteger*)windowWidth
{
    const char* data=(const char*)[pdata bytes];
    int pos = 0;
    
    // type
    *type = (NSInteger)[[MICloudPub sharedInstance] GetLE32:data+pos];
    pos += 4;
    
    switch(*type)
	{
        case GPU3DEVENT_ACTIVEVIEW:
		{
            *renderType = (NSInteger)[[MICloudPub sharedInstance] GetLE32:data+pos];
            pos += 4;
            
            break;
		}
        case GPU3DEVENT_WINDOWINFO:
		{
            *windowLevel = (NSInteger)[[MICloudPub sharedInstance] GetLE32:data+pos];
            pos += 4;
            
            *windowWidth = (NSInteger)[[MICloudPub sharedInstance] GetLE32:data+pos];
            pos += 4;
            
            break;
		}
        case GPU3DEVENT_TRANSFERWINDOWINFO:
		{
            *windowLevel = (NSInteger)[[MICloudPub sharedInstance] GetLE32:data+pos];
            pos += 4;
            
            *windowWidth = (NSInteger)[[MICloudPub sharedInstance] GetLE32:data+pos];
            pos += 4;
            
            break;
		}
        default:
            return -1;
	}
    
    return 0;
}

@end
