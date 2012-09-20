//
//  CaptureSessionManager.m
//  MacCoffee
//
//  Created by Zul on 9/19/12.
//  Copyright (c) 2012 Zul. All rights reserved.
//

#import "CaptureSessionManager.h"

@implementation CaptureSessionManager

#pragma mark Capture Session Configuration

- (id)init {
	if ((self = [super init])) {
		[self setCaptureSession:[[AVCaptureSession alloc] init]];
	}
	return self;
}

- (void)addVideoPreviewLayer {
    
	[self setPreviewLayer:[[AVCaptureVideoPreviewLayer alloc] initWithSession:[self captureSession]]];
	[[self previewLayer] setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
}

- (void)addVideoInput {
    
	AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
	if (videoDevice) {
		NSError *error;
		AVCaptureDeviceInput *videoIn = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
		if (!error) {
			if ([[self captureSession] canAddInput:videoIn])
				[[self captureSession] addInput:videoIn];
			else
				NSLog(@"Couldn't add video input");
		}
		else
			NSLog(@"Couldn't create video input");
	}
	else
		NSLog(@"Couldn't create video capture device");
}

- (void)dealloc {
    
	[[self captureSession] stopRunning];
    
//	[previewLayer release],
    self.previewLayer = nil;
//	[captureSession release],
    self.captureSession = nil;
    
//	[super dealloc];
}

@end
