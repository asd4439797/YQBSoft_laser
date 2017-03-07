//
//  UserInfoModel.h
//  YQ_IOS_Framework
//
//  Created by 上海钰壳网络科技有限公司 on 16/10/2.
//  Copyright © 2016年 上海钰壳网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AMapPOI;

typedef enum userRole {
//    拉客的
    MarketingSpecialist,
//    拉客的经理
    MarketingSpecialistManager,
//    卖房子的
    SalesConsultant,
//    卖房子的经理
    SalesConsulatantManager,
//    鉴定客户的
    Appraisal,
//    总监
    Director,
}UserRole;

@class UserRoleMenu;
@class UserMenuModel;
@class UserRoleModel;
typedef enum userSex{
    SexMan,
    SexWoman
}UserSex;

@interface UserInfoModel : NSObject


@property (nonatomic,strong)AMapPOI *poi;

@property (nonatomic,copy)NSString *notificationString;


@property (nonatomic,assign)double lon;

@property (nonatomic,assign)double lat;


@property (nonatomic,copy)NSString *currentProtect;

@property (nonatomic,copy)NSString *currentTaskCode;



/**
 用户唯一识别令牌Tokenkey
 */
@property (nonatomic,copy,readonly) NSString *ticketTokenid;


/**
 用户手机号
 */
@property (nonatomic,copy,readonly) NSString *userPhone;

/**
 用户角色代码
 */
@property (nonatomic,assign,readonly)NSInteger role;

/**
 用户名
 */
@property (nonatomic,copy) NSString *userName;

/**
 用户真实姓名
 */
@property (nonatomic,copy)NSString *userRelname;

/**
 项目名称
 */
@property (nonatomic,copy)NSString *project;

/**
 项目代码
 */
@property (nonatomic,copy)NSString *projectCode;

/**
 用户代码
 */
@property (nonatomic,copy)NSString *userCode;

/**
 角色代码
 */
@property (nonatomic,copy)NSString *roleCode;

/**
 团队代码
 */
@property (nonatomic,copy)NSString *teamCode;

/**
 用户性别
 */
@property (nonatomic,assign)UserSex userSex;

/**
 用户菜单
 */
@property (nonatomic,strong)UserRoleMenu *extensions;


/**
 公司名称
 */
@property (nonatomic,copy)NSString *companyName;

/**
 公司代码
 */
@property (nonatomic,copy)NSString *tenantCode;

/**
 用户昵称
 */
@property (nonatomic,copy)NSString *userNickname;

/**
 用户Pcode
 */
@property (nonatomic,copy)NSString *userPcode;

/**
 团队名称
 */
@property (nonatomic,copy)NSString *teamName;

/**
 未知
 */
@property (nonatomic,strong)NSDictionary *map;

/**
 创建时间
 */
@property (nonatomic,copy)NSString *gmtCreate;


/**
 公司代码
 */
@property (nonatomic,copy)NSString *companyCode;


/**
 设置UserModel，并保存写入本地文件

 @param userInfo 登录的时候获取的用户参数
 @return 是否操作成功
 */
+ (BOOL)setUserModel:(NSDictionary *)userInfo;



+ (instancetype)shareUserModel;

/**
 获取用户令牌

 @return 用户令牌
 */
+ (NSString *)getUserToken;

/**
 获取用户手机号

 @return 用户手机号
 */
+ (NSString *)getUserPhone;

/**
 退出登录
 */
+ (void)logout;

/**
 修改并且在本地保存修改对应的参数

 @param key 需要修改的Key
 @param value 修改后的参数
 @return 是否修改成功
 */
+ (BOOL)SaveCurrentStateWithKey:(NSString *)key andValue:(NSString *)value;

@end

@interface UserRoleMenu : NSObject

/**
 菜单列表
 */
@property (nonatomic,strong)NSArray <UserMenuModel *>*menu;

/**
 用户角色模型
 */
@property (nonatomic,strong)UserRoleModel *role;


- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

@interface UserRoleModel : NSObject

/**
 用户当前状态
 */
@property (nonatomic,copy)NSString *dataState;

/**
 用户创建时间
 */
@property (nonatomic,copy)NSString *gmtCreate;

/**
 用户最后一次修改时间
 */
@property (nonatomic,copy)NSString *gmtModified;

/**
 备注
 */
@property (nonatomic,copy)NSString *memo;

/**
 用户角色Code
 */
@property (nonatomic,copy)NSString *roleCode;

/**
 角色ID
 */
@property (nonatomic,copy)NSString *roleId;

/**
 角色名字
 */
@property (nonatomic,copy)NSString *roleName;

/**
 角色类型
 */
@property (nonatomic,copy)NSString *roleType;

/**
 请联系管理员
 */
@property (nonatomic,copy)NSString *tenantCode;


- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

@interface UserMenuModel : NSObject

/**
 菜单操作
 */
@property (nonatomic,copy)NSString *menuAction;

/**
 组合菜单代码
 */
@property (nonatomic,copy)NSString *menuCode;

/**
 菜单明细代码
 */
@property (nonatomic,copy)NSString *menuDetailsCode;

/**
 菜单名称
 */
@property (nonatomic,copy)NSString *menuName;

/**
 菜单顺序
 */
@property (nonatomic,copy)NSString *menuOrder;

/**
 菜单是否显示
 */
@property (nonatomic,copy)NSString *menuShow;

/**
 菜单的Icon
 */
@property (nonatomic,copy)NSString *menuIcon;

@property (nonatomic,assign)BOOL isReady;


- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
