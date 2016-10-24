//
//  BaseDm.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/9/1.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "BaseDm.h"
#import <objc/runtime.h>
#import <objc/message.h>
@implementation BaseDm
- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self) {
        [self convertFromDic:dic];
    }
    return self;
}
-(NSDictionary *)convertFromDic:(NSDictionary *)obj
{
    NSDictionary *dic = [obj isKindOfClass:[NSString class]] ? [(NSString *)obj JSONValue] : obj;
    if (![dic isKindOfClass:[NSDictionary class]])
        return nil;
    [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSRange r = [key rangeOfString:@"__"];
        NSString *method = r.location == NSNotFound ? key : [key substringFromIndex:r.location+r.length];
        if ([method.lowercaseString isEqualToString:@"id"])
            method = [NSString stringWithFormat:@"%@_id", NSStringFromClass([self class])];
        objc_property_t property = class_getProperty(self.class, [method cStringUsingEncoding:NSUTF8StringEncoding]);
        if (!property)
            return;
        
        SEL sel = NSSelectorFromString([NSString stringWithFormat:@"set%@:", method.uppercaseFirstCharacter]);
        if ([self respondsToSelector:sel])
        {
            id obj = [dic objectForKey:key];
            if ([obj isKindOfClass:[NSString class]]
                || [obj isKindOfClass:[NSNumber class]])
            {
                ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)self, sel, obj);
            }
        }
    }];
    return dic;
}
-(NSMutableDictionary *)convertToDicWith:(Class)clz
{
    Class cls = clz ? clz : [self class];
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList(cls, &propertyCount);
    NSMutableDictionary *mdic  = [NSMutableDictionary dictionaryWithCapacity:propertyCount];
    for (unsigned int i = 0; i < propertyCount; i++) {
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(properties[i])];
        SEL sel = NSSelectorFromString([NSString stringWithFormat:@"%@", propertyName]);
        if ([self respondsToSelector:sel])
        {
            id obj = [self performSelector:sel];
            if (!obj)
                continue;
            if ([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]])
            {
                if ([propertyName isEqualToString:[NSString stringWithFormat:@"%@_id", NSStringFromClass(cls)]])
                    propertyName = @"id";
                [mdic setObject:obj forKey:propertyName];
            }
            else if ([obj isKindOfClass:[BaseDm class]])
            {
                BaseDm *dm = obj;
                [mdic setObject:[dm convertToDic] forKey:propertyName];
            }
            else if ([obj isKindOfClass:[NSArray class]])
            {
                [mdic setObject:obj forKey:propertyName];
            }
        }
    }
    free(properties);
    return mdic;
}

-(NSMutableDictionary *)convertToDic
{
    return [self convertToDicWith:nil];
}
@end
