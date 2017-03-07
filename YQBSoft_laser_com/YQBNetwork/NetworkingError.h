//
//  NetworkingError.h
//  YQBNetwork
//
//  Created by 上海钰壳网络科技有限公司 on 17/2/10.
//  Copyright © 2017年 上海钰壳网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum NetworkError{
    /*网络连接错误*/
        YQBSoftConnectError,
    /*接口逻辑错误*/
        YQBSoftInterfaceError,
    /*程序阻止接口访问*/
        YQBSoftApplicationError,
    /*需要重新登录的错误*/
        YQBSoftReloginError
}YQBNetworkError;

/*接口请求错误类*/

@interface NetworkingError : NSObject

/**
 -200 逻辑接口错误
 -300 HTTP接口错误返回
 */
@property (nonatomic,copy)NSString *errorCode;

@property (nonatomic,assign)YQBNetworkError errorState;

@property (nonatomic,copy)NSString *errorReasonDescribe;

@end
