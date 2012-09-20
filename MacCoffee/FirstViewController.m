//
//  FirstViewController.m
//  MacCoffee
//
//  Created by Zul on 9/19/12.
//  Copyright (c) 2012 Zul. All rights reserved.
//

#import "FirstViewController.h"

@implementation FirstViewController

- (void)viewDidLoad {
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    
	[self setCaptureManager:[[CaptureSessionManager alloc] init]];
    
//	[[self captureManager] addVideoInput];
    [[self captureManager] addVideoInputFrontCamera:NO]; // set to YES for Front Camera, No for Back camera
    [[self captureManager] addStillImageOutput];
	[[self captureManager] addVideoPreviewLayer];
	CGRect layerRect = [[[self view] layer] bounds];
	[[[self captureManager] previewLayer] setBounds:layerRect];
	[[[self captureManager] previewLayer] setPosition:CGPointMake(CGRectGetMidX(layerRect),
                                                                  CGRectGetMidY(layerRect))];
	[[[self view] layer] addSublayer:[[self captureManager] previewLayer]];
    
    UIImageView *overlayImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MC_XL_frame.png"]];
//    [overlayImageView setFrame:CGRectMake(30, 100, 260, 200)];
    [overlayImageView setFrame:CGRectMake(0, 0, screenWidth, screenHeight - 60)];
    [[self view] addSubview:overlayImageView];
//    [overlayImageView release];
    
    UIButton *overlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [overlayButton setImage:[UIImage imageNamed:@"scanbutton.png"] forState:UIControlStateNormal];
    [overlayButton setFrame:CGRectMake(screenWidth / 2 - 30, screenHeight - screenHeight / 3, 60, 30)];
    [overlayButton addTarget:self action:@selector(scanButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:overlayButton];
    
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth / 2 - 60, screenHeight / 3, 120, 30)];
    [self setScanningLabel:tempLabel];
//    [tempLabel release];
	[self.scanningLabel setBackgroundColor:[UIColor clearColor]];
	[self.scanningLabel setFont:[UIFont fontWithName:@"Courier" size: 18.0]];
	[self.scanningLabel setTextColor:[UIColor redColor]];
	[self.scanningLabel setText:@"Processing..."];
    [self.scanningLabel setHidden:YES];
	[[self view] addSubview:self.scanningLabel];
    
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveImageToPhotoAlbum) name:kImageCapturedSuccessfully object:nil];
    
	[[self.captureManager captureSession] startRunning];
}

- (void) scanButtonPressed {
	[[self scanningLabel] setHidden:NO];
    
//	[self performSelector:@selector(hideLabel:) withObject:[self scanningLabel] afterDelay:2];
    
     [[self captureManager] captureStillImage];
}

- (void)saveImageToPhotoAlbum
{
    
    UIImage *personImage = [self captureManager].stillImage;
    UIImage *hatImage = [UIImage imageNamed:@"MC_XL_frame.png"];
    CGSize finalSize = [personImage size];
//    CGSize hatSize = [hatImage size];
    UIGraphicsBeginImageContext(finalSize);
    [personImage drawInRect:CGRectMake(0,0,finalSize.width,finalSize.height)];
//    CGFloat xScaleFactor = finalSize.width / hatSize.width;
//    CGFloat yScaleFactor = finalSize.height / hatSize.height;
//    [hatImage drawInRect:CGRectMake(0 * xScaleFactor, 0 * yScaleFactor, hatSize.width * xScaleFactor, hatSize.height * yScaleFactor)];
    
    [hatImage drawInRect:CGRectMake(0, 0, finalSize.width, finalSize.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error != NULL) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Image couldn't be saved" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
//        [alert release];
    }
    else {
        [[self scanningLabel] setHidden:YES];
    }
}

- (void)hideLabel:(UILabel *)label {
	[label setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
//    [captureManager release],
    self.captureManager = nil;
//    [scanningLabel release],
    self.scanningLabel = nil;
//    [super dealloc];
}

@end