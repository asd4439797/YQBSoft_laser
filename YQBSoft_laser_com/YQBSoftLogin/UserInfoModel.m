//
//  UserInfoModel.m
//  YQ_IOS_Framework
//
//  Created by 上海钰壳网络科技有限公司 on 16/10/2.
//  Copyright © 2016年 上海钰壳网络科技有限公司. All rights reserved.
//

#import "UserInfoModel.h"
//#import "JPUSHService.h"
//#import "SGVerifyUtil.h"
#import <UIKit/UIKit.h>
static UserInfoModel *userModel;
@interface UserInfoModel()<NSSecureCoding,NSCoding>{
    NSDictionary *_userInfoDict;
}

@end

@implementation UserInfoModel



-(NSString *)notificationString {
    if (_notificationString == nil) {
        return @"";
    }
    return _notificationString;
};





-(NSString *)currentProtect {
    if (_currentProtect == nil) {
        return @"";
    }
    return _currentProtect;
}

- (NSString *)currentTaskCode {
    if (_currentTaskCode == nil) {
        return @"";
    }
    return _currentTaskCode;
}

- (instancetype)initWithDictionary:(NSDictionary *)otherDictionary {
    self  = [super init];
    if (self) {
        
    }
    return self;
}

+ (NSString *)getUserPhone {
    return [UserInfoModel shareUserModel].userPhone;
}

+ (NSString *)getUserToken {
    if ([UserInfoModel shareUserModel].ticketTokenid == nil) {
        return @"";
    }
  return [UserInfoModel shareUserModel].ticketTokenid;
}

- (instancetype)initWithDitcionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

+ (instancetype)shareUserModel {
    if (userModel == nil) {
        @synchronized (self) {
            NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
            NSString *docPath = [[paths lastObject] stringByAppendingString:@"/UserInfo.data"];
            NSDictionary * userDictionary = [NSKeyedUnarchiver unarchiveObjectWithFile:docPath];
            userModel = [[UserInfoModel alloc]initWithDitcionary:userDictionary];
        }
    }
    return userModel;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"UserModel The Key == %@ Is Not Define",key);
}

+ (NSString *)getUserRole {
    NSInteger  roleString = [[UserInfoModel shareUserModel].extensions.role.roleType integerValue];
    if ( roleString == 0) {
        return @"行销专员";
    } else if (roleString == 1) {
        return @"行销经理";
    } else if (roleString == 2) {
        return @"置业顾问";
    } else if (roleString == 3) {
        return @"销售经理";
    } else if (roleString == 4) {
        return @"案场鉴定";
    } else if (roleString == 5) {
        return @"销售总监";
    } else if(roleString == 6){
        return @"行销总监";
    }else if (roleString == 7){
        return @"副总经理";
    }
    return @"暂无该职位";
}

+ (BOOL)setUserModel:(NSDictionary *)userInfo {
    
    return [self savewithDictionary:userInfo];
}

+ (BOOL)logOut {
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *docPath = [[paths lastObject] stringByAppendingString:@"/UserInfo.data"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtPath:docPath error:nil];
}

+ (BOOL)SaveCurrentStateWithKey:(NSString *)key andValue:(NSString *)value{
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *docPath = [[paths lastObject] stringByAppendingString:@"/UserInfo.data"];
    NSDictionary * userDictionary = [NSKeyedUnarchiver unarchiveObjectWithFile:docPath];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:userDictionary];
    [dictionary setValue:value forKey:key];
    userDictionary = [NSDictionary dictionaryWithDictionary:dictionary];
  return  [NSKeyedArchiver archiveRootObject:userDictionary toFile:docPath];
}

+ (BOOL)savewithDictionary:(NSDictionary *)userInfoDictionary {
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *docPath = [[paths lastObject] stringByAppendingString:@"/UserInfo.data"];
    userModel = [[UserInfoModel alloc]initWithDitcionary:userInfoDictionary];
    return [NSKeyedArchiver archiveRootObject:userInfoDictionary toFile:docPath];
}

#pragma mark - NSCoding 
- (void)encodeWithCoder:(NSCoder *)aCoder {
}

- (instancetype)initWithCoder:(NSCoder *)acoder
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (BOOL)supportsSecureCoding {
    
    return YES;
}

- (void)setExtensions:(UserRoleMenu *)extensions {
    _extensions = [[UserRoleMenu alloc]initWithDictionary:(NSDictionary *)extensions];
}

- (NSString *)projectCode {
    if (_projectCode == nil) {
        _projectCode = @"";
    }
    return _projectCode;
}

- (NSString *)teamCode {
    if (_teamCode == nil) {
        _teamCode = @"";
    }
    return _teamCode;
}

+ (void)logout {
     NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *docPath = [[paths lastObject] stringByAppendingString:@"/UserInfo.data"];
    
    if (userModel != nil) {
//        [JPUSHService setTags:[NSSet set] alias:@"" fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
//            NSLog(@"当前设备标示为%d -------%@-------%@",iResCode,iTags,iAlias);
//        }];
    }
    userModel = nil;
     NSLog(@"退出完成");
    [fileMgr removeItemAtPath:docPath error:nil];
}

@end

@implementation UserRoleMenu

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}

- (void)setRole:(UserRoleModel *)role {
    _role = [[UserRoleModel alloc]initWithDictionary:(NSDictionary *)role];
}

- (void)setMenu:(NSArray<UserMenuModel *> *)menu {
    NSMutableArray *tmpArray = [NSMutableArray array];
    NSArray *childrenTmpArray = [NSArray arrayWithArray:menu];;
    NSArray *childrenArray = childrenTmpArray[0][@"children"];
    for (NSDictionary * dictionary in childrenArray) {
        UserMenuModel *menuModel = [[UserMenuModel alloc]initWithDictionary:dictionary];
        if ([[self getHomeControllerWithViewControllerKey:menuModel.menuAction] isKindOfClass:[UIViewController class]]) {
            [tmpArray addObject:[[UserMenuModel alloc] initWithDictionary:dictionary]];
        } else {
        
        }
    }
    _menu = tmpArray;
}




- (UIViewController *)getHomeControllerWithViewControllerKey:(NSString *)key {


    return nil;
}


@end

@implementation UserRoleModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}

@end

@implementation UserMenuModel


-(NSString *)menuIcon {
    if (_menuIcon == nil) {
        return @"no_pic";
    }
    return _menuIcon;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
