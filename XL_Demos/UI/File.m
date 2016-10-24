//
//  File.m
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/21.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import "File.h"

@interface File ()
@property (nonatomic, strong) NSMutableArray <File *> *childFiles;
@end

@implementation File
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.childFiles = [NSMutableArray array];
    }
    return self;
}

+ (instancetype)fileWithFileType:(FileType)type fileName:(NSString *)name
{
    File *file = [[File alloc] init];
    file.fileType = type;
    file.fileName = name;
    return file;
}
- (void)addFile:(File *)file
{
    [self.childFiles addObject:file];
}
@end
