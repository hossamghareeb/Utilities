//
//  ScrollableViewController.h
//  Monitoring
//
//  Created by Hossam on 4/17/13.
//  Copyright (c) 2013 Inova LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractViewController.h"

//Any view controller contains scroll view and wanna change it's content size during editting or finish editting, will inherits from this class and assign to it the scroll view

@interface ScrollableViewController : AbstractViewController




@property (nonatomic, assign) UIScrollView *currentScrollView;
@property (nonatomic, weak) UITextField *activeField;

-(void)keyboardWasShown:(NSNotification *)notification;
-(void)keyboardWillBeHidden:(NSNotification *)notification;

@end
