//
//  YQBSoftLogin.m
//  YQBSoftLogin
//
//  Created by 上海钰壳网络科技有限公司 on 17/2/17.
//  Copyright © 2017年 上海钰壳网络科技有限公司. All rights reserved.
//

#import "YQBSoftLogin.h"
#import "YQBNetwork.h"
#import "YQBNetworkBaseResponseModel.h"
#import "YQBLoginFrameworkUrl.h"
#import "UserInfoModel.h"
@interface YQBSoftLogin(){

}

@end

@implementation YQBSoftLogin



+ (BOOL)pre_processingYQBSoftLogin {

    return YES;
}

/**
 登录
 
 @param parameter 请求参数列表
 @param loginStyle 登录的类型
 @param completeBlock 登录结果的回调
 */
+ (void)yqbsoftLoginWithParameter:(id)parameter andLoginStyle:(YQBSoftLoginStyle)loginStyle andCompleteBlock:(YQBSoftLoginCompleteBlock)completeBlock {
    __weak typeof(self) weakLoginSelf = self;
    if (![self pre_processingYQBSoftLogin]) {
        NSLog(@"_____YQBLogin______前置操作禁止登录");
        return;
    }
    NSLog(@"_____YQBLogin______允许登录");
    NSLog(@"_____YQBLogin______登录的Url为 === %@",[YQBLoginFrameworkUrl yqbsoftGetLoginUrl]);
    [YQBNetwork Post:[YQBLoginFrameworkUrl yqbsoftGetLoginUrl] andParameter:parameter andRequestDataState:YQBSoftRequestDataJsonState andNetWorkingCompleteSuccessBlock:^(YQBNetworkBaseResponseModel * result) {
        NSLog(@"_____YQBLogin______登录的结果返回为 == %@ ===", result.msg);
        if ([result.sysRecode isEqualToString:@"success"]) {
            [UserInfoModel setUserModel:result.dataObj];
            completeBlock(YQBSoftLoginResponesSuccess,sysRecord);
            [weakLoginSelf post_processingYQBSoftLogin:YQBSoftLoginResponesSuccess andMsg:@"登录成功"];
        } else {
            completeBlock(YQBSoftLoginResponesFail,result.msg);
            [weakLoginSelf post_processingYQBSoftLogin:YQBSoftLoginResponesFail andMsg:result.msg];
        }
    }];
}

+ (void)post_processingYQBSoftLogin:(YQBSoftLoginResponseState)response andMsg:(NSString *)msg {
    if (response == YQBSoftLoginResponesSuccess) {
        id JpushClass = NSClassFromString(@"JPUSHService");
        SEL getRegisterIdSelect = NSSelectorFromString(@"registrationID");
        if ([JpushClass respondsToSelector:getRegisterIdSelect]) {
            NSString * registerId  =    [JpushClass performSelector:getRegisterIdSelect];
            if (![registerId isKindOfClass:[NSString class]]) {
                NSLog(@"_____YQBLogin______获取Jpush RegistrationID 失败");
                return;
            }
            
            NSLog(@"%@",[UserInfoModel getUserToken]);
            
            NSDictionary *parameterDictionary = @{@"tokenkey":[UserInfoModel getUserToken],@"registrationID":registerId};
            
            [YQBNetwork GET:[YQBLoginFrameworkUrl yqbsoftGetRegistrationIDUrl] andParameter:parameterDictionary andRequestDataState:YQBSoftRequestDataFormState andNetWorkingCompleteSuccessBlock:^(YQBNetworkBaseResponseModel *result) {
                if ([result.sysRecode isEqualToString:sysRecord]) {
                    NSLog(@"_____YQBLogin______registrationID 注册成功");
                } else {
                    NSLog(@"_____YQBLogin______registrationID 注册失败");
                }
            }];
        } else {
            NSLog(@"_____YQBLogin______未找到JpushSDK registrationID 函数,如未导入极光推送，请忽略此条信息");
        }
    }
}


+ (BOOL)pre_processingYQBSoftRegister {
    
    return YES;
}

/**
 注册
 
 @param parameter 请求参数列表
 @param completeBlock 注册结果的回调
 */
+ (void)yqbsoftRegisterWithParameter:(id)parameter andCompleteBlock:(YQBSoftLoginCompleteBlock)completeBlock {
    __weak typeof(self) weakLoginSelf = self;
    if (![self pre_processingYQBSoftRegister]) {
        NSLog(@"_____YQBLogin______前置操作禁止注册");
    }
}

+ (void)post_processingYQBSoftRegister:(YQBSoftLoginResponseState)response andMsg:(NSString *)msg {

}


+ (BOOL)pre_processingYQBSoftGetVerCode {

    return YES;
}

/**
 获取验证码
 
 @param parameter 请求参数列表
 @param verCodeStyle 获取验证码的类型
 @param completeBlock 请求结果的回调信息
 */
+ (void)yqbsoftGetVerCodeWithParameter:(id)parameter andVerCodeStyle:(YQBVerCodeStyle)verCodeStyle andCompleteBlock:(YQBSoftLoginCompleteBlock)completeBlock {
    __weak typeof(self) weakLoginSelf = self;
    [YQBNetwork GET:[YQBLoginFrameworkUrl yqbsoftGetVerCodeUrl] andParameter:parameter andRequestDataState:YQBSoftRequestDataFormState andNetWorkingCompleteSuccessBlock:^(YQBNetworkBaseResponseModel *result) {
                if ([result.sysRecode isEqualToString:sysRecord]) {
                    completeBlock(YQBSoftLoginResponesSuccess,sysRecord);
                    [weakLoginSelf post_processingYQBSoftGetVerCode:YQBSoftLoginResponesSuccess andMsg:sysRecord];
                } else {
                    completeBlock(YQBSoftLoginResponesFail,result.msg);
                    [weakLoginSelf post_processingYQBSoftGetVerCode:YQBSoftLoginResponesFail andMsg:result.msg];
                }
    }];
}

+ (void)post_processingYQBSoftGetVerCode:(YQBSoftLoginResponseState)response andMsg:(NSString *)msg {


}


+ (BOOL)pre_processingYQBSoftOutLogin {
    
    return YES;
}

/**
 退出登录
 
 @param parameter 请求参数列表
 @param completeBlock 请求结果回调
 */
+ (void)yqbsoftOutLoginWithParameter:(id)parameter andCompleteBlock:(YQBSoftLoginCompleteBlock)completeBlock {
    __weak typeof(self) weakLoginSelf = self;
    [YQBNetwork Post:[YQBLoginFrameworkUrl yqbsoftGetLoginOutUrl] andParameter:parameter andRequestDataState:YQBSoftRequestDataJsonState andNetWorkingCompleteSuccessBlock:^(YQBNetworkBaseResponseModel *result) {
        if ([result.sysRecode isEqualToString:sysRecord]) {
            [UserInfoModel logout];
            completeBlock(YQBSoftLoginResponesSuccess,successRecord);
            [weakLoginSelf post_processingYQBSoftOutLogin:YQBSoftLoginResponesSuccess andMsg:successRecord];
        } else {
            completeBlock(YQBSoftLoginResponesFail,result.msg);
            [weakLoginSelf post_processingYQBSoftOutLogin:YQBSoftLoginResponesSuccess andMsg:successRecord];
        }
    }];
}

+ (void)post_processingYQBSoftOutLogin:(YQBSoftLoginResponseState)response andMsg:(NSString *)msg {


}

+ (BOOL)pre_processingYQBSoftFindPassword {

    return YES;
}

/**
 找回密码
 
 @param parameter 请求参数列表
 @param completeBlock 请求结果回调
 */
+ (void)yqbsoftFindPasswordWithParameter:(id)parameter andCompleteBlock:(YQBSoftLoginCompleteBlock)completeBlock {
    __weak typeof(self) weakLoginSelf = self;

}


+ (void)post_processingYQBSoftFindPassword:(YQBSoftLoginResponseState)response andMsg:(NSString *)msg {

}

+ (BOOL)pre_processingYQBSoftResetPassword {

    return YES;
}

/**
 重置密码
 
 @param parameter 请求参数列表
 @param completeBlock 请求回调结果
 */
+ (void)yqbsoftResetPasswordWithParameter:(id)parameter andCompleteBlock:(YQBSoftLoginCompleteBlock)completeBlock {
    __weak typeof(self) weakLoginSelf = self;
    [YQBNetwork Post:[YQBLoginFrameworkUrl yqbsoftGetResetPasswordUrl] andParameter:parameter andRequestDataState:YQBSoftRequestDataJsonState andNetWorkingCompleteSuccessBlock:^(YQBNetworkBaseResponseModel *result) {
        NSLog(@"_____YQBLogin______==========YQBResetPasswdRecode %@==========",result.sysRecode);
        if ([result.sysRecode isEqualToString:sysRecord]) {
            [weakLoginSelf post_processingYQBSoftResetPassword:YQBSoftLoginResponesSuccess andMsg:successRecord];
            completeBlock(YQBSoftLoginResponesSuccess,successRecord);
        } else {
            [weakLoginSelf post_processingYQBSoftResetPassword:YQBSoftLoginResponesSuccess andMsg:successRecord];
            completeBlock(YQBSoftLoginResponesFail,result.msg);
        }
    }];
}

+ (void)post_processingYQBSoftResetPassword:(YQBSoftLoginResponseState)response andMsg:(NSString *)msg {


}






@end
