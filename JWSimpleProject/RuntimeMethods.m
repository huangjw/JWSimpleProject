//
//  RuntimeMethods.m
//  JWSimpleProject
//
//  Created by huangjw on 2017/5/18.
//  Copyright © 2017年 huangjw. All rights reserved.
//

#import "RuntimeMethods.h"

@implementation RuntimeMethods

/**
 获取类名
 
 @param class 相应类
 @return NSString：类名
 */
+ (NSString *)fetchClassName:(Class)class;
{
    const char *className = class_getName(class);
    return [NSString stringWithUTF8String:className];
}

/**
 获取成员变量
 
 @param class 成员变量所在的类
 @return 返回成员变量字符串数组
 */
+ (NSArray *)fetchIvarList:(Class)class;
{
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList(class, &count);
    
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++) {
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithCapacity:2];
        const char *ivarName = ivar_getName(ivarList[i]);
        const char *ivarType = ivar_getTypeEncoding(ivarList[i]);
        dictionary[@"ivarName"] = [NSString stringWithUTF8String:ivarName];
        dictionary[@"type"] = [NSString stringWithUTF8String:ivarType];
        [list addObject:dictionary];
    }
    free(ivarList);
    return [NSArray arrayWithArray:list];
}

/**
 获取类的属性列表, 包括私有和公有属性，即定义在延展中的属性
 
 @param class Class
 @return 属性列表数组
 */
+ (NSArray *)fetchPropertyList:(Class)class;
{
    unsigned int count = 0;
    objc_property_t *propertyList = class_copyPropertyList(class, &count);
    
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        [list addObject:[NSString stringWithUTF8String:propertyName]];
    }
    free(propertyList);
    return [NSArray arrayWithArray:list];
}

/**
 获取对象方法列表：getter, setter, 对象方法等。但不能获取类方法
 
 @param class 方法所在的类
 @return 该类的方法列表
 */
+ (NSArray *)fetchMethodList:(Class)class;
{
    unsigned int count = 0;
    Method *methodList = class_copyMethodList(class, &count);
    
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++ ) {
        Method method = methodList[i];
        SEL methodName = method_getName(method);
        [list addObject:NSStringFromSelector(methodName)];
    }
    free(methodList);
    return [NSArray arrayWithArray:list];
}

/**
 获取协议列表
 
 @param class 实现协议的类
 @return 返回该类实现的协议列表
 */
+ (NSArray *)fetchProtocolList:(Class)class;
{
    unsigned int count = 0;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList(class, &count);
    
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++ ) {
        Protocol *protocol = protocolList[i];
        const char *protocolName = protocol_getName(protocol);
        [list addObject:[NSString stringWithUTF8String:protocolName]];
    }
    return [NSArray arrayWithArray:list];
}

/**
 添加新的方法
 
 @param class 被添加方法的类
 @param methodSel SEL
 @param methodSelImpl 提供IMP的SEL
 */
+ (void)addMethod:(Class)class method:(SEL)methodSel method:(SEL)methodSelImpl;
{
    Method method = class_getInstanceMethod(class, methodSelImpl);
    IMP methodIMP = method_getImplementation(method);
    const char *types = method_getTypeEncoding(method);
    class_addMethod(class, methodSel, methodIMP, types);
}

/**
 方法交换
 
 @param class 交换方法所在的类
 @param method1 方法1
 @param method2 方法2
 */
+ (void)methodSwap:(Class)class firstMethod:(SEL)method1 secondMethod:(SEL)method2;
{
    Method firstMethod = class_getInstanceMethod(class, method1);
    Method secondMethod = class_getInstanceMethod(class, method2);
    method_exchangeImplementations(firstMethod, secondMethod);
}

+ (void)methodReplace:(Class)class originMethod:(SEL)originMethod newMethod:(SEL)newMethod
{
    Method method = class_getInstanceMethod(class, originMethod);
    class_replaceMethod(class, newMethod, method_getImplementation(method), method_getTypeEncoding(method));

}

@end
