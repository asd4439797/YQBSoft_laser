//
//  YQBNetworkBaseResponseModel.h
//  YQBNetwork
//
//  Created by 上海钰壳网络科技有限公司 on 17/2/21.
//  Copyright © 2017年 上海钰壳网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>


@class NetworkingError;
@interface YQBNetworkBaseResponseModel : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionaty;

@property (nonatomic,strong)NSDictionary *dataObj;

@property (nonatomic,copy)NSString *errorCode;

@property (nonatomic,copy)NSString *msg;

@property (nonatomic,copy)NSString *success;

@property (nonatomic,copy)NSString *sysRecode;

@property (nonatomic,strong)NetworkingError *responseError;

@end
