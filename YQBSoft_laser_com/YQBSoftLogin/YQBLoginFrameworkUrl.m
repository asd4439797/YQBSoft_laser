//
//  YQBLoginFrameworkUrl.m
//  YQBSoftLogin
//
//  Created by 上海钰壳网络科技有限公司 on 17/2/22.
//  Copyright © 2017年 上海钰壳网络科技有限公司. All rights reserved.
//

#import "YQBLoginFrameworkUrl.h"

@implementation YQBLoginFrameworkUrl


/**
 获取登录接口
 
 @return 登录接口的连接
 */
+ (NSString *)yqbsoftGetLoginUrl{
    return [NSString stringWithFormat:@"%@%@",[self getHostUrl],YQB_Login_Login];
}


/**
 获取验证码的接口
 
 @return 返回验证码
 */
+ (NSString *)yqbsoftGetVerCodeUrl {
    return [NSString stringWithFormat:@"%@%@",[self getHostUrl],YQB_Login_GetVerCode];
}

/**
 获取修改密码的接口
 
 @return 修改密码的接口
 */
+ (NSString *)yqbsoftGetResetPasswordUrl {

    return [NSString stringWithFormat:@"%@%@",[self getHostUrl],YQB_Login_ResetPassword];

}


/**
 获取退出登录的接口
 
 @return 退出登录的接口
 */
+ (NSString *)yqbsoftGetLoginOutUrl {
    return [NSString stringWithFormat:@"%@%@",[self getHostUrl],YQB_Login_Logout];

}


/**
 获取注册的接口
 
 @return 注册的接口
 */
+ (NSString *)yqbsoftGetRegisterUrl {
    
    return [NSString stringWithFormat:@"%@%@",[self getHostUrl],YQB_Login_Register];
    
}

/**
 获取找回密码的接口
 
 @return 找回密码的接口
 */
+ (NSString *)yqbsoftGetFindPasswordUrl {

    return [NSString stringWithFormat:@"%@%@",[self getHostUrl],YQB_Login_FindPassword];
}


/**
 获取向服务器注册RegistrationID的Url
 
 @return 极光RegistrationID
 */

+ (NSString *)yqbsoftGetRegistrationIDUrl {

    return [NSString stringWithFormat:@"%@%@",[self getHostUrl],YQB_Login_FindPassword];
}


+ (NSString *)getHostUrl{
    return [self getUrlHostWithKey:ServiceKey];
}

+ (NSString *)getUrlHostWithKey:(NSString *)plistKey {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"NetworkPropertyList" ofType:@"plist"];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    NSLog(@" plist文件%@=======%@",plistKey,dictionary[plistKey]);
    return dictionary[plistKey];
}


@end
