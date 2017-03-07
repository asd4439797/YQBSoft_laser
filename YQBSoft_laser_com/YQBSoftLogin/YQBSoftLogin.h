//
//  YQBSoftLogin.h
//  YQBSoftLogin
//
//  Created by 上海钰壳网络科技有限公司 on 17/2/17.
//  Copyright © 2017年 上海钰壳网络科技有限公司. All rights reserved.
//



#import <Foundation/Foundation.h>
/**
    此处返回结果不仅限于登陆这个一个操作，适用该类下所有回调
 */

static NSString  *sysRecord = @"success";

static NSString  *successRecord = @"操作成功";

static NSString *test;

typedef enum LoginFrameworkResponseState{
    /*操作返回成功*/
    YQBSoftLoginResponesSuccess,
    /*操作返回失败*/
    YQBSoftLoginResponesFail
}YQBSoftLoginResponseState;

typedef void (^YQBSoftLoginCompleteBlock)(YQBSoftLoginResponseState state,NSString *messageDetails);

/**
    登陆类型的参数选项
 */
typedef enum LoginFrameworkLoginStyle{
        /*账号密码登录*/
        YQBSoftPassword,
        /*短信验证码等录*/
        YQBSoftMessage
}YQBSoftLoginStyle;

/**
    获取短信验证码的类型
 */
typedef enum LoginFrameworkVerCodeStyle{
    /*获取登录验证码*/
    YQBSoftVerCodeLogin,
    /*获取注册验证码*/
    YQBSoftVerCodeRegister,
    /*其余验证码*/
    YQBSoftVerCodeOther
}YQBVerCodeStyle;

@interface YQBSoftLogin : NSObject





/**
 登录的前置操作

 @return 是否允许登录
 */
+ (BOOL)pre_processingYQBSoftLogin;

/**
 登录
 
 @param parameter 请求参数列表
 @param loginStyle 登录的类型
 @param completeBlock 登录结果的回调
 */

+ (void)yqbsoftLoginWithParameter:(id)parameter andLoginStyle:(YQBSoftLoginStyle)loginStyle andCompleteBlock:(YQBSoftLoginCompleteBlock)completeBlock;



/**
 登录完成之后的操作

 @param response 登录操作的结果
 @param msg 登录操作结果的消息
 */
+ (void)post_processingYQBSoftLogin:(YQBSoftLoginResponseState)response andMsg:(NSString *)msg;


/**
 注册账户的前置操作

 @return 是否允许注册账户
 */
+ (BOOL)pre_processingYQBSoftRegister;

/**
 注册

 @param parameter 请求参数列表
 @param completeBlock 注册结果的回调
 */
+ (void)yqbsoftRegisterWithParameter:(id)parameter andCompleteBlock:(YQBSoftLoginCompleteBlock)completeBlock;


/**
 注册完成后的后续操作

 @param response 返回的操作结果
 @param msg 返回操作结果的消息
 */
+ (void)post_processingYQBSoftRegister:(YQBSoftLoginResponseState)response andMsg:(NSString *)msg;



/**
 获取验证码的前置操作
 
 @return 是否允许获取验证码
 */
+ (BOOL)pre_processingYQBSoftGetVerCode;

/**
 获取验证码

 @param parameter 请求参数列表
 @param verCodeStyle 获取验证码的类型
 @param completeBlock 请求结果的回调信息
 */

+ (void)yqbsoftGetVerCodeWithParameter:(id)parameter andVerCodeStyle:(YQBVerCodeStyle)verCodeStyle andCompleteBlock:(YQBSoftLoginCompleteBlock)completeBlock;



/**
 获取验证码完成后的后续操作

 @param response 返回获取验证码的结果
 @param msg <#msg description#>
 */
+ (void)post_processingYQBSoftGetVerCode:(YQBSoftLoginResponseState)response andMsg:(NSString *)msg;


/**
 退出登录的前置操作
 
 @return 是否允许获取验证码
 */
+ (BOOL)pre_processingYQBSoftOutLogin;


/**
 退出登录

 @param parameter 请求参数列表   passwd   旧密码   newpasswd  新密码
 @param completeBlock 请求结果回调
 */
+ (void)yqbsoftOutLoginWithParameter:(id)parameter andCompleteBlock:(YQBSoftLoginCompleteBlock)completeBlock;

/**
 退出登录完成后的后续操作
 */
+ (void)post_processingYQBSoftOutLogin:(YQBSoftLoginResponseState)response andMsg:(NSString *)msg;

/**
 找回密码的前置操作
 
 @return 是否允许获取验证码
 */
+ (BOOL)pre_processingYQBSoftFindPassword;


/**
 找回密码

 @param parameter 请求参数列表
 @param completeBlock 请求结果回调
 */
+ (void)yqbsoftFindPasswordWithParameter:(id)parameter andCompleteBlock:(YQBSoftLoginCompleteBlock)completeBlock;

/**
 找回密码完成后的后续操作
 */
+ (void)post_processingYQBSoftFindPassword:(YQBSoftLoginResponseState)response andMsg:(NSString *)msg;

/**
 重置密码的前置操作
 
 @return 是否允许获取重置密码
 */
+ (BOOL)pre_processingYQBSoftResetPassword;

/**
 重置密码

 @param parameter 请求参数列表
 @param completeBlock 请求回调结果
 */
+ (void)yqbsoftResetPasswordWithParameter:(id)parameter andCompleteBlock:(YQBSoftLoginCompleteBlock)completeBlock;


/**
 重置密码的后续操作

 @param response 重置密码的结果
 @param msg 重置密码的提示
 */
+ (void)post_processingYQBSoftResetPassword:(YQBSoftLoginResponseState)response andMsg:(NSString *)msg;





@end
