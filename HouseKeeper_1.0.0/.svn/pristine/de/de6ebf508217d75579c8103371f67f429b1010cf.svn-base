//
//  LKCameraTool.m
//  HouseKeeper
//
//  Created by sunny on 2018/7/13.
//  Copyright © 2018年 heshenghui. All rights reserved.
//

#import "LKCameraTool.h"
#import <Photos/Photos.h>
#import "LKBaseViewController.h"

@interface LKCameraTool()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) UIViewController *currentVC;

@end

@implementation LKCameraTool
LKSingletonM(LKCameraTool)

- (void)showPickerController:(UIViewController *)vc pictureHandle:(LKCameraToolGetPicture)pictureHandle {
    self.currentVC = vc;
    self.pictureHandle = pictureHandle;
    [self checkCameraStatusAvaiable];
}
- (void)checkCameraStatusAvaiable {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied)) {
        // 无相机权限
        [Dialog showCustomAlertViewWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" firstButtonName:@"取消" secondButtonName:@"确定" dismissHandler:^(NSInteger index) {
            if (index == 1) {
                if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                }
            }
        }];
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        /// 系统还未知是否访问，第一次开启相机时
        /// 继续调用相机 防止用户首次拍照拒绝授权时相机页黑屏
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self checkCameraStatusAvaiable];
                });
            }
        }];
    } else {
        [self pushImagePickerController];
    }
}
// 调用相机
- (void)pushImagePickerController {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: sourceType]) {
        self.imagePickerController.sourceType = sourceType;
//        self.imagePickerController.allowsEditing = YES;
        [self.currentVC presentViewController:self.imagePickerController animated:YES completion:^{
            
        }];
    } else {
        DLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}
#pragma mark - imagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [self fixOrientation:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:image forKey:@"currentImage"];
        [params setObject:self.currentVC forKey:@"currentVC"];
        NSDate *nowDate = [NSDate date];
        NSTimeInterval timeInterval = [nowDate timeIntervalSince1970];
        [params setObject:[NSString stringWithFormat:@"%ld",(long)timeInterval] forKey:@"currentTime"];
        [[NSNotificationCenter defaultCenter] postNotificationName:LKTakePhotoSucessNotiation object:params];
        if (self.pictureHandle != nil) {
            self.pictureHandle(params);
        }
    }
    [picker dismissViewControllerAnimated:YES completion:^{

    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        [picker dismissViewControllerAnimated:YES completion:^{

        }];
    }
}

/** lazy */
- (UIImagePickerController *)imagePickerController {
    if (_imagePickerController == nil) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
//        _imagePickerController.allowsEditing = YES;
    }
    return _imagePickerController;
}
/** 图片方向处理 */
- (UIImage *)fixOrientation:(UIImage *)aImage {

    UIImageOrientation imageOrientation = aImage.imageOrientation;
    if (self.imagePickerController.cameraDevice == UIImagePickerControllerCameraDeviceFront) {
        UIImage *image = [[UIImage alloc] initWithCGImage:aImage.CGImage scale:1.0f orientation:UIImageOrientationLeftMirrored];
        return image;
    }else {
        // No-op if the orientation is already correct
        if (aImage.imageOrientation == UIImageOrientationUp)
            return aImage;
    }

    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;

    switch (imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;

        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;

        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }

    switch (imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;

        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }

    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;

        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }

    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
@end
