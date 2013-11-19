//
//  ScrollableViewController.m
//  Monitoring
//
//  Created by Hossam on 4/17/13.
//  Copyright (c) 2013 Inova LLC. All rights reserved.
//

#import "ScrollableViewController.h"

@interface ScrollableViewController ()

@end

@implementation ScrollableViewController
@synthesize currentScrollView, activeField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self registerForKeyboardNotifications];
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self unRegisterForKeyboardNotifications];
}


#pragma mark-
#pragma mark Registering KeyBoard Actions
#pragma mark-

- (void)unRegisterForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}



#pragma mark-
#pragma mark KeyBoard Actions handling
#pragma mark-

#define DEVICE_IS_PORTRAIT [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown

-(void)keyboardWasShown:(NSNotification *)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    float kbHeight = DEVICE_IS_PORTRAIT ? kbSize.height : kbSize.width;
    
    NSLog(@"kbheight %f", kbHeight);
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbHeight, 0.0);
    
    self.currentScrollView.contentInset = contentInsets;
    self.currentScrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbHeight;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        [self.currentScrollView scrollRectToVisible:activeField.frame animated:YES];
    }
    
}

-(void)keyboardWillBeHidden:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.currentScrollView .contentInset = contentInsets;
    self.currentScrollView .scrollIndicatorInsets = contentInsets;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
