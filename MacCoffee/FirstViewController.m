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
    
	[self setCaptureManager:[[CaptureSessionManager alloc] init]];
    
	[[self captureManager] addVideoInput];
    
	[[self captureManager] addVideoPreviewLayer];
	CGRect layerRect = [[[self view] layer] bounds];
	[[[self captureManager] previewLayer] setBounds:layerRect];
	[[[self captureManager] previewLayer] setPosition:CGPointMake(CGRectGetMidX(layerRect),
                                                                  CGRectGetMidY(layerRect))];
	[[[self view] layer] addSublayer:[[self captureManager] previewLayer]];
    
    UIImageView *overlayImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"overlaygraphic.png"]];
    [overlayImageView setFrame:CGRectMake(30, 100, 260, 200)];
    [[self view] addSubview:overlayImageView];
//    [overlayImageView release];
    
    UIButton *overlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [overlayButton setImage:[UIImage imageNamed:@"scanbutton.png"] forState:UIControlStateNormal];
    [overlayButton setFrame:CGRectMake(130, 320, 60, 30)];
    [overlayButton addTarget:self action:@selector(scanButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:overlayButton];
    
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 120, 30)];
    [self setScanningLabel:tempLabel];
//    [tempLabel release];
	[self.scanningLabel setBackgroundColor:[UIColor clearColor]];
	[self.scanningLabel setFont:[UIFont fontWithName:@"Courier" size: 18.0]];
	[self.scanningLabel setTextColor:[UIColor redColor]];
	[self.scanningLabel setText:@"Scanning..."];
    [self.scanningLabel setHidden:YES];
	[[self view] addSubview:self.scanningLabel];
    
	[[self.captureManager captureSession] startRunning];
}

- (void) scanButtonPressed {
	[[self scanningLabel] setHidden:NO];
	[self performSelector:@selector(hideLabel:) withObject:[self scanningLabel] afterDelay:2];
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