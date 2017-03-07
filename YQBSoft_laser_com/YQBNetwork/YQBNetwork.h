//
//  TestStaticLibrary.h
//  TestStaticLibrary
//
//  Created by 上海钰壳网络科技有限公司 on 17/2/4.
//  Copyright © 2017年 上海钰壳网络科技有限公司. All rights reserved.
//

/**
    基于AFNetworking封装的网络框架,适用于钰壳网络 开头以YQBSoft 1.0.1
 */

#import <Foundation/Foundation.h>

/*请求返回的数据格式*/
typedef enum NetworkingResponseState{
        YQBSoftResponseJsonState
}YQBSoftNetworkingResponseState;

/*请求的数据格式*/
typedef enum NetwrokingRequestDateState{
    /*表单提交*/
        YQBSoftRequestDataFormState,
    /*Json格式提交*/
        YQBSoftRequestDataJsonState,
}YQBSoftNetworkingRequestDataState;

/*请求类型的格式*/
typedef enum NetwrokingRequestStyleState{
    /*Post方式请求*/
        YQBSoftRequestPostState,
    /*Get方式请求*/
        YQBSoftRequestGetState,
}YQBSoftNetwrokingRequestStyleState;

typedef enum NetworkingResponseDataState{
    /*有数据的返回值*/
    YQBSoftResponseHaveData,
    /*没有数据的返回值*/
    YQBSoftResponseNoHaveData
}YQBSoftNetworkingResponseDataState;


typedef enum NetworkingState{
    /*当前网络状态未知*/
    YQBSoftNetworkingStateUnKnow,
    /*当前网络状态无网络*/
    YQBSoftNetworkingStateNoNetworking,
    /*当前网络状态为蜂窝数据网络*/
    YQBSoftNetworkingStateReachableViaWWAN,
    /*当前网络状态为WIFI*/
    YQBSoftNetworkingStateReachableViaWiFi,
}YQBSoftNetworkingState;


/*网络请求的类型*/
typedef enum NetworkingRequestType{
    /*无结果的网络请求*/
    YQBNetworkRequestNoResult,
    /*加载后续数据的网络请求*/
    YQBNetworkRequestLoadMore,
    /*刷新当前列表的网络请求*/
    YQBNetworkRequestRefresh
}YQBNetworkingRequestType;


@class YQBNetworkBaseResponseModel;
/*
    接口请求成功时回调的,如果result类型为NSError,则接口调用失败,
 */
typedef void (^YQBSoftNetWorkingCompleteBlock)(YQBNetworkBaseResponseModel * result);

/*
    文件上传或下载的进度
 */
typedef void (^YQBNetWorkingProgressBlock)(NSProgress *progress);

/*
    查询当前网络状态的回调
 */
typedef void (^YQBSoftGetNetworkStateBlock)(YQBSoftNetworkingState networkState);

/*
 上传文件结果的回调
 */
typedef void (^YQBSoftNetWorkingCompleteUpDataBlock)(NSURLResponse *response,NSURL *filePath,NSError *completionError);

/*
 下载文件结果的回调
 */
typedef void (^YQBSoftNetWorkingCompleteDownloadDataBlock)(NSURLResponse *response,NSURL *filePath,NSError *completionError);


@class UIImage;

@interface YQBNetwork : NSObject

/**
    POST请求
    url   连接的URL
    parameter    参数列表
    completeBlock   请求完成时候的回调
    requestDateState   请求方式的选择
*/
+ (void)Post:(NSString *)url andParameter:(id)parameter andRequestDataState:(YQBSoftNetworkingRequestDataState)requestDateState andNetWorkingCompleteSuccessBlock:(YQBSoftNetWorkingCompleteBlock)completeBlock;

/**
    GET请求
    url   连接的URL
    parameter    参数列表
    completeBlock   请求完成时候的回调
    requestDateState 请求的方式选择
 */
+ (void)GET:(NSString *)url andParameter:(id)parameter andRequestDataState:(YQBSoftNetworkingRequestDataState)requestDateState andNetWorkingCompleteSuccessBlock:(YQBSoftNetWorkingCompleteBlock)completeBlock;

/**
    上传图片的接口
    url                                 请求上传的链接
    parameter                        请求的参数列表
    name                              上传的类型
    fileName                          文件名
    mineType                         上传的文件类型
    progressBlock                    上传的进度条回调
    completeBlock                    上传的结果回调
 */

+ (void)uploadDataToService:(NSString *)url andParameter:(id)parameter andName:(NSString *)name andFileName:(NSString *)fileName andImage:(UIImage *)image andProgress:(YQBNetWorkingProgressBlock)uploadProgressBlock andCompleteBlock:(YQBSoftNetWorkingCompleteBlock)completeBlock;

/**
    文件下载  暂不可用
    url                                 请求的URL连接
    parameter                       请求的参数列表
    filePath                          请求的文件地址
    downProgressBlock            下载文件进度的回调
    completeBlock                   文件下载完成的时候回调
 */

+ (void)downloadDataFromService:(NSString *)url andParameter:(id)parameter andFilePath:(NSString *)filePath andDownProgressBlock:(YQBNetWorkingProgressBlock)downProgressBlock andCompleteBlock:(YQBSoftNetWorkingCompleteBlock)completeBlock;

/**
    长连接
 */


/**
    是否监测当前网络状态
 */

+ (void)MonitorCurrentNetworkState:(YQBSoftGetNetworkStateBlock)networkStateBlock;

/**
    是否阻止全局接口调用 默认是允许网络访问
 */
+ (void)isCanConnectInternet:(BOOL)canConnect;

/*
 
 */



@end
