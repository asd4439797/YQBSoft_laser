//
//  YQBLoginFrameworkUrl.h
//  YQBSoftLogin
//
//  Created by 上海钰壳网络科技有限公司 on 17/2/22.
//  Copyright © 2017年 上海钰壳网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ServiceKey         @"ServiceDevAddress"

/*登录*/
#define YQB_Login_Login              @"/web/mi/mlogin/loginToken.json"

/*获取验证码*/
#define YQB_Login_GetVerCode      @"/web/mi/mlogin/getVerCode.img"

/*找回密码*/
#define YQB_Login_FindPassword      @""

/*重置密码*/
#define YQB_Login_ResetPassword     @"/web/mi/mlogin/updatePasswordToken.json"

/*注册*/
#define YQB_Login_Register     @""

/*退出登录*/
#define YQB_Login_Logout     @"/web/mi/mlogin/loginOut.json"



@interface YQBLoginFrameworkUrl : NSObject

/**
 获取登录接口
 
 @return 登录接口的连接
 */
+ (NSString *)yqbsoftGetLoginUrl;


/**
 获取验证码的接口

 @return 返回验证码
 */
+ (NSString *)yqbsoftGetVerCodeUrl;


/**
 获取修改密码的接口

 @return 修改密码的接口
 */
+ (NSString *)yqbsoftGetResetPasswordUrl;


/**
 获取退出登录的接口

 @return 退出登录的接口
 */
+ (NSString *)yqbsoftGetLoginOutUrl;


/**
 获取注册的接口

 @return 注册的接口
 */
+ (NSString *)yqbsoftGetRegisterUrl;




/**
 获取找回密码的接口

 @return 找回密码的接口
 */
+ (NSString *)yqbsoftGetFindPasswordUrl;


/**
 获取向服务器注册RegistrationID的Url
 
 @return 极光RegistrationID
 */
+ (NSString *)yqbsoftGetRegistrationIDUrl;


@end
