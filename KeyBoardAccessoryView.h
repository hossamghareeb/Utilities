//
//  keyBoardAccessoryView.h
//  Monitoring
//
//  Created by Hossam on 4/14/13.
//  Copyright (c) 2013 Inova LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyBoardAccessoryView : UINavigationBar
{
    int minValue;
    int maxValue;
}

@property (weak) UIView *parentView;
@property (nonatomic, strong) UIStepper *textFieldsStepper;
@property (nonatomic, strong) NSMutableArray *myTextFields;

-(id)initWithView:(UIView *)parentView;
-(void)addTextField:(UITextField *)textField;
-(void)addTextView:(UITextView *)textView;
@end
