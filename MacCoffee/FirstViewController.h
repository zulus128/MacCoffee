//
//  FirstViewController.h
//  MacCoffee
//
//  Created by Zul on 9/19/12.
//  Copyright (c) 2012 Zul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaptureSessionManager.h"

@interface FirstViewController : UIViewController

@property (retain) CaptureSessionManager *captureManager;
@property (nonatomic, retain) UILabel *scanningLabel;

@end
