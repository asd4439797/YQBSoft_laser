//
//  YQBNetworkBaseResponseModel.m
//  YQBNetwork
//
//  Created by 上海钰壳网络科技有限公司 on 17/2/21.
//  Copyright © 2017年 上海钰壳网络科技有限公司. All rights reserved.
//

#import "YQBNetworkBaseResponseModel.h"

@implementation YQBNetworkBaseResponseModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionaty {
    if (self) {
        [self setValuesForKeysWithDictionary:dictionaty];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"YQBNetworkBaseResponseModel  UndefinKey = %@  Value = %@",key,value);
}


@end
