//
//  UIDevice+Addtion.m
//
//
//
//  Copyright (c) 2014年 ilovedev. All rights reserved.
//

#import "UIDevice+Addtion.h"

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <net/if.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mount.h>
#import <mach/mach.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MFMessageComposeViewController.h>

@implementation UIDevice (Addtion)

- (NSString *)platform {
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    return platform;
}

// 是否是iPhone
+ (BOOL)isiPhone
{
    UIDevice* device = [UIDevice currentDevice];
    
    if ([device.model isEqualToString:@"iPhone"]) {
        return YES;
    }
    else {
        return NO;
    }
}

// 是否是iPad
+ (BOOL)isiPad
{
    UIDevice* device = [UIDevice currentDevice];
    
    if ([device.model isEqualToString:@"iPad"]) {
        return YES;
    }
    else {
        return NO;
    }
}

// 是否是iTouch
+ (BOOL)isiPodTouch
{
    UIDevice* device = [UIDevice currentDevice];
    
    if ([device.model isEqualToString:@"iPod touch"]) {
        return YES;
    }
    else {
        return NO;
    }
}

// 支持拔打电话
+ (BOOL)supportTelephone
{
    // 目前逻辑：iPhone支持电话，其余设备不支持
    if ([UIDevice isiPhone]) {
        return YES;
    }
    else {
        return NO;
    }
}

// 支持发送短信
+ (BOOL)supportSendSMS
{
    if ([MFMessageComposeViewController canSendText]) {
        return YES;
    }
    else {
        return NO;
    }
}

// 支持发送邮件
+ (BOOL)supportSendMail
{
    if ([MFMailComposeViewController canSendMail]) {
        return YES;
    }
    else {
        return NO;
    }
}

// 支持摄像头取景
+ (BOOL)supportCamera
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return YES;
    }
    else {
        return NO;
    }
}

// 以全小写的形式返回设备名称
- (NSString*)modelNameLowerCase
{
    return [self.model lowercaseString];
}

// 系统版本，以float形式返回
+ (CGFloat)systemVersionByFloat
{
    return [UIDevice currentDevice].systemVersion.floatValue;//[self.systemVersion floatValue];
}

// 系统版本比较
- (BOOL)systemVersionLowerThan:(NSString*)version
{
    if (version == nil || version.length == 0) {
        return NO;
    }
    
    if ([self.systemVersion compare:version options:NSNumericSearch] == NSOrderedAscending) {
        return YES;
    }
    else {
        return NO;
    }
}

- (BOOL)systemVersionHigherThan:(NSString*)version
{
    if (version == nil || version.length == 0) {
        return NO;
    }
    
    if ([self.systemVersion compare:version options:NSNumericSearch] == NSOrderedDescending) {
        return YES;
    }
    else {
        return NO;
    }
}

- (BOOL)systemVersionNotHigherThan:(NSString*)version
{
    if (version == nil || version.length == 0) {
        return NO;
    }
    
    if ([self.systemVersion isEqualToString:version]) {
        return YES;
    }
    else {
        return [self systemVersionLowerThan:version];
    }
}

- (BOOL)systemVersionNotLowerThan:(NSString *)version
{
    if (version == nil || version.length == 0) {
        return NO;
    }
    
    if ([self.systemVersion isEqualToString:version]) {
        return YES;
    }
    else {
        return [self systemVersionHigherThan:version];
    }
}


// 内存信息
+ (unsigned long)freeMemory{
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t pagesize;
    vm_statistics_data_t vm_stat;
    
    host_page_size(host_port, &pagesize);
    (void) host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    return vm_stat.free_count * pagesize;
}

+ (unsigned long)usedMemory{
    struct task_basic_info info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t kerr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)&info, &size);
    return (kerr == KERN_SUCCESS) ? info.resident_size : 0;
}

- (BOOL)hasMultitasking {
    if ([self respondsToSelector:@selector(isMultitaskingSupported)]) {
        return [self isMultitaskingSupported];
    }
    return NO;
}

- (BOOL)isIphone5
{
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    return ([UIScreen mainScreen].scale == 2.f && screenHeight == 568.0f);
}


@end
