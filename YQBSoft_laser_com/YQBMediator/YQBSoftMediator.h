//
//  YQBMediator.h
//  YQBMediator
//
//  Created by 上海钰壳网络科技有限公司 on 17/3/7.
//  Copyright © 2017年 上海钰壳网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YQBSoftMediator : NSObject



/**
 中间件实例化
 
 @return 中间件的实例化的对象
 */
+ (instancetype)shareYQBSoftMediator;


/**
 远程APP调用的入口
 
 @param url 打开连接的URL 例如  scheme://[target]/[action]?[params]
 
 @param completion 操作结果的回调
 
 @return 返回值
 */
- (id)performActionWithUrl:(NSURL *)url completion:(void(^)(NSDictionary *info))completion;

/**
 处理本地组件之间调用的入口
 
 @param targetName 被调用的目标
 
 @param actionName 被调用的函数名
 
 @param params 被调用的函数的参数名 以NSDictionary格式传入
 
 @return 被调用的函数的返回值 若返回值为nil 则返回值为空或者该函数调用失败
 */
- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params;





@end
