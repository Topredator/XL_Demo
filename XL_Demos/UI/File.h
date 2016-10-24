//
//  File.h
//  XL_Demos
//
//  Created by zhouxiaolu on 16/7/21.
//  Copyright © 2016年 Topredator. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, FileType) {
    FileType_Folder = 0, // 文件夹
    FileType_File //   文件
};

@interface File : NSObject

/**
 *  存放子文件数组
 */
@property (nonatomic, strong, readonly) NSMutableArray <File *> *childFiles;
/**
 *  文件类型
 */
@property (nonatomic, assign) FileType fileType;

/**
 *  文件名称
 */
@property (nonatomic, copy) NSString *fileName;

/**
 *  遍历构造器
 *
 *  @param type 文件类型
 *  @param name 文件名称
 *
 *  @return 文件对象
 */
+ (instancetype)fileWithFileType:(FileType)type fileName:(NSString *)name;

/**
 *  添加子文件
 *
 *  @param file 文件
 */
- (void)addFile:(File *)file;

@end
