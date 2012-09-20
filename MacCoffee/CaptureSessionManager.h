//
//  CaptureSessionManager.h
//  MacCoffee
//
//  Created by Zul on 9/19/12.
//  Copyright (c) 2012 Zul. All rights reserved.
//

#import <CoreMedia/CoreMedia.h>
#import <AVFoundation/AVFoundation.h>

@interface CaptureSessionManager : NSObject {
    
}

@property (retain) AVCaptureVideoPreviewLayer *previewLayer;
@property (retain) AVCaptureSession *captureSession;

- (void)addVideoPreviewLayer;
- (void)addVideoInput;

@end
