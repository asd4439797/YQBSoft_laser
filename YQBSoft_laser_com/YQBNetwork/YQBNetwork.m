//
//  TestStaticLibrary.m
//  TestStaticLibrary
//
//  Created by 上海钰壳网络科技有限公司 on 17/2/4.
//  Copyright © 2017年 上海钰壳网络科技有限公司. All rights reserved.
//

#import "YQBNetwork.h"
#import "AFNetworking.h"
#import <objc/runtime.h>
#import "NetworkingError.h"
#import "YQBNetworkBaseResponseModel.h"


#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__);
#define LOG_METHOD NSLog(@"%s", __func__);
#else
#define NSLog(...); #define LOG_METHOD;
#endif


static NetworkingError *error;

@implementation YQBNetwork


/*Get方式请求接口*/
+ (void)GET:(NSString *)url andParameter:(id)parameter andRequestDataState:(YQBSoftNetworkingRequestDataState)requestDateState andNetWorkingCompleteSuccessBlock:(YQBSoftNetWorkingCompleteBlock)completeBlock {
    [YQBNetwork request:url andParameter:parameter andRequestState:YQBSoftRequestGetState andRequestDataState:requestDateState andNetWorkingCompleteBlock:completeBlock];
}

/*Post方式请求接口*/
+ (void)Post:(NSString *)url andParameter:(id)parameter andRequestDataState:(YQBSoftNetworkingRequestDataState)requestDateState andNetWorkingCompleteSuccessBlock:(YQBSoftNetWorkingCompleteBlock)completeBlock {
    NSLog(@"请求基类参数");
    [YQBNetwork request:url andParameter:parameter andRequestState:YQBSoftRequestPostState andRequestDataState:requestDateState andNetWorkingCompleteBlock:completeBlock];
}



/*上传图片的请求接口*/
+ (void)uploadDataToService:(NSString *)url andParameter:(id)parameter andName:(NSString *)name andFileName:(NSString *)fileName andImage:(UIImage *)image andProgress:(YQBNetWorkingProgressBlock)uploadProgressBlock andCompleteBlock:(YQBSoftNetWorkingCompleteBlock)completeBlock {
    __weak typeof(self) weakSelf = self;;
    //1。创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //上传文件参数
        NSData *fData = UIImageJPEGRepresentation(image, 0.05);
        NSData *imageData = UIImagePNGRepresentation([UIImage imageWithData:fData]);
        //这个就是参数
        [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //打印下上传进度
        NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        [YQBNetwork handleProgressBlock:uploadProgressBlock andProgress:uploadProgress];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功
        NSLog(@"请求成功：%@",responseObject);
        [weakSelf handleResponseResult:responseObject andCompleteBlock:completeBlock];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf handleFileRequestWithSuccessResponseObject:error andCompleteFileBlock:completeBlock];
        //请求失败
        NSLog(@"请求失败：%@",error);
    }];
}


/*下载文件的请求接口*/
+ (void)downloadDataFromService:(NSString *)url andParameter:(id)parameter andFilePath:(NSString *)filePath andDownProgressBlock:(YQBNetWorkingProgressBlock)downProgressBlock andCompleteBlock:(YQBSoftNetWorkingCompleteBlock)completeBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.确定请求的URL地址
    
    //3.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    //下载任务
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //打印下下载进度
        NSLog(@"%lf",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        [YQBNetwork handleProgressBlock:downProgressBlock andProgress:downloadProgress];
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //下载地址
        NSLog(@"默认下载地址:%@",filePath);
//        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error != nil) {
            [YQBNetwork handleFileRequestWithSuccessResponseObject:error andCompleteFileBlock:completeBlock];
        } else {
            [YQBNetwork handleFileRequestWithSuccessResponseObject:response andCompleteFileBlock:completeBlock];
        }
        //下载完成调用的方法
        NSLog(@"下载完成：");
        NSLog(@"%@--%@",response,filePath);
    }];
    //开始启动任务
    [task resume];
}


/*处理文件上传或下载成功的函数*/
+ (void)handleFileRequestWithSuccessResponseObject:(id)responseObject andCompleteFileBlock:(YQBSoftNetWorkingCompleteBlock)completeBlock {
    if ([responseObject isKindOfClass:[NSError class]]) {
        
    } else {
    
    }

}



/*请求方式的筛选*/
+ (void)request:(NSString *)urlString andParameter:(id)parameter andRequestState:(YQBSoftNetwrokingRequestStyleState)requestState andRequestDataState:(YQBSoftNetworkingRequestDataState)state andNetWorkingCompleteBlock:(YQBSoftNetWorkingCompleteBlock)completeBlock {
    /*程序内阻止应用访问网络*/
    if (error!= nil) {
        YQBNetworkBaseResponseModel *model = [[YQBNetworkBaseResponseModel alloc]init];
        model.sysRecode = @"Fail";
        model.msg = @"应用内网络访问阻止";
        completeBlock(model);
        return;
    }
    /**/
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    if (requestState == YQBSoftResponseJsonState) {
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    }
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSDictionary *parameterDictionary;
    if ([parameter isKindOfClass:[NSDictionary class]]) {
        parameterDictionary  = [NSDictionary dictionaryWithDictionary:parameter];
    } else {
        NSString *className = NSStringFromClass([parameter class]);
        parameterDictionary = [parameter dictionaryWithValuesForKeys:[YQBNetwork getIvarListWithClassString:className]];
    }
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:parameterDictionary];
    if (state == YQBSoftRequestDataJsonState) {
        if (dictionary[@"tokenkey"] != nil) {
            urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"?tokenkey=%@",dictionary[@"tokenkey"]]];
        }
    }
    parameterDictionary = [NSDictionary dictionaryWithDictionary:dictionary];
    NSLog(@"请求参数为 %@",parameterDictionary);
    if (requestState == YQBSoftRequestGetState) {
        [manager GET:urlString parameters:parameterDictionary progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"操作成功 返回参数为 %@",responseObject);
            [YQBNetwork handleResponseResult:responseObject andCompleteBlock:completeBlock];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"操作失败 返回参数为 %@",error.localizedDescription);
            [YQBNetwork handleResponseFailResult:error andCompleteBlock:completeBlock];
        }];
    } else {
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager POST:urlString parameters:parameterDictionary progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"操作成功 返回参数为 %@",responseObject);
            [YQBNetwork handleResponseResult:responseObject andCompleteBlock:completeBlock];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"操作失败 返回参数为 %@",error.localizedDescription);
            [YQBNetwork handleResponseFailResult:error andCompleteBlock:completeBlock];
        }];
    }
 }



/*统一处理回调结果*/
+ (void)handleResponseResult:(id)responseObject andCompleteBlock:(YQBSoftNetWorkingCompleteBlock)completeBlock{
    YQBNetworkBaseResponseModel * responseModel = [[YQBNetworkBaseResponseModel alloc]initWithDictionary:responseObject];
    if (![responseModel.sysRecode isEqualToString:@"success"]) {
        responseModel.responseError = [[NetworkingError alloc]init];
        responseModel.responseError.errorCode = @"-200";
        responseModel.responseError.errorReasonDescribe = responseModel.msg;
    }
    if (completeBlock!= nil) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"kBaseControllerNotification" object:responseModel];
    } else {
        responseModel.responseError = [[NetworkingError alloc]init];
        responseModel.responseError.errorCode = @"-400";
        responseModel.responseError.errorReasonDescribe = @"回调参数为空";
        responseModel.msg = @"回调参数为空";

        NSLog(@"回调参数为空");
    }
    completeBlock(responseModel);
}


/*统一处理请求失败的回调*/
+ (void)handleResponseFailResult:(NSError *)error andCompleteBlock:(YQBSoftNetWorkingCompleteBlock)completeBlock {
    YQBNetworkBaseResponseModel * responseModel = [[YQBNetworkBaseResponseModel alloc]initWithDictionary:@{}];
    if (completeBlock!= nil) {
        responseModel.responseError = [[NetworkingError alloc]init];
        responseModel.responseError.errorCode = @"-200";
        responseModel.responseError.errorReasonDescribe = error.localizedDescription
        ;
        responseModel.msg = error.localizedDescription;
    } else {
        responseModel.responseError = [[NetworkingError alloc]init];
        responseModel.responseError.errorCode = @"-400";
        responseModel.responseError.errorReasonDescribe = @"回调参数为空";
        responseModel.msg = error.localizedDescription;
    }
    NSLog(@"==========YQBNetworkSysReocrd ==== %@==========",responseModel.sysRecode);
    
    NSData *errorData = error.userInfo[@"com.alamofire.serialization.response.error.data"];
    NSString *errorString = [[NSString alloc]initWithData:errorData encoding:NSUTF8StringEncoding];
    NSLog(@"DEBUG  RESPONSE ERROR________%@_______", errorString);

    completeBlock(responseModel);
}


/*处理上传或者下载进度*/
+ (void)handleProgressBlock:(YQBNetWorkingProgressBlock)progressBlock andProgress:(NSProgress *)progress{
    if (progressBlock != nil) {
        progressBlock(progress);
    }
}


/*统一处理错误类*/
+ (NetworkingError *)errorWithDescribe:(NSString *)describe andErrorCode:(NSString *)errorCode andErrorState:(YQBNetworkError)state {
    NetworkingError *networkError = [[NetworkingError alloc]init];
    networkError.errorState = state;
    networkError.errorReasonDescribe = describe;
    networkError.errorCode = errorCode;
    return networkError;
}


/**
    监测当前网络状态
 */
+ (void)MonitorCurrentNetworkState:(YQBSoftGetNetworkStateBlock)networkStateBlock {
    //1.创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    /*枚举里面四个状态  分别对应 未知 无网络 数据 WiFi
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,      未知
     AFNetworkReachabilityStatusNotReachable     = 0,       无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,       蜂窝数据网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2,       WiFi
     };
     */
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //这里是监测到网络改变的block  可以写成switch方便
        //在里面可以随便写事件
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                networkStateBlock(YQBSoftNetworkingStateUnKnow);
                NSLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                networkStateBlock(YQBSoftNetworkingStateNoNetworking);
                NSLog(@"无网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                networkStateBlock(YQBSoftNetworkingStateReachableViaWWAN);
                NSLog(@"蜂窝数据网");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                networkStateBlock(YQBSoftNetworkingStateReachableViaWiFi);
                NSLog(@"WiFi网络");
                break;
                
            default:
                break;
        }
        
    }] ;

}


+ (void)isCanConnectInternet:(BOOL)canConnect {
    if (!canConnect) {
        error = [[NetworkingError alloc]init];
        error.errorCode = @"-300";
        error.errorReasonDescribe = @"";
        error.errorState = YQBSoftApplicationError;
    } else {
        error = nil;
    }
}


/*单模型转换成字典*/
+ (NSArray *)getIvarListWithClassString:(NSString *)classString {
    unsigned int count;
    Class natureClass = NSClassFromString(classString);
    NSMutableArray *natureArray = [NSMutableArray array];
    Ivar *ivarList = class_copyIvarList(natureClass, &count);
    for (int i =0; i < count; i++) {
        NSMutableString *nameStr = [NSMutableString stringWithUTF8String:ivar_getName(ivarList[i])];
        [nameStr deleteCharactersInRange:NSMakeRange(0, 1)];
        [natureArray addObject:nameStr];
        NSLog(@"***ivarName:%@", nameStr);
    }
    free(ivarList);
    return natureArray;
}


@end
