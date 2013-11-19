//
//  keyBoardAccessoryView.m
//  Monitoring
//
//  Created by Hossam on 4/14/13.
//  Copyright (c) 2013 Inova LLC. All rights reserved.
//

#import "KeyBoardAccessoryView.h"

@implementation KeyBoardAccessoryView
@synthesize parentView, textFieldsStepper, myTextFields;

#define BAR_HEIGHT 44
#define MIN_VALUE 0

-(id)initWithView:(UIView *)aParentView
{
    self.parentView = aParentView;
    
    minValue = MIN_VALUE;
    maxValue = MIN_VALUE;
    
    self.myTextFields = [NSMutableArray array];

    float keyBoardHeight = 216.0f;
    CGRect frame = CGRectMake(0, parentView.frame.size.height - keyBoardHeight - BAR_HEIGHT, parentView.frame.size.width, BAR_HEIGHT);
    self = [super initWithFrame:frame];
    
    if (self) {
        self.barStyle = UIBarStyleBlackTranslucent;
        
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.9f;
        self.textFieldsStepper = [[UIStepper alloc] initWithFrame:CGRectMake(24, 8, 95, 27)];
        
        
        self.textFieldsStepper.maximumValue = maxValue;
        self.textFieldsStepper.minimumValue = minValue;
        
        [self.textFieldsStepper addTarget:self action:@selector(stepperValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:self.textFieldsStepper];
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTypingClicked:)];
        
        
        UINavigationItem *item = [[UINavigationItem alloc] init];
        item.rightBarButtonItem = doneButton;
        item.leftBarButtonItem = leftButton;
        
        [self pushNavigationItem:item animated:NO];
        
    }
    
    return self;
}


-(void)stepperValueChanged:(UIStepper *)sender
{
    UIResponder *responder = (UIResponder *)[self.myTextFields objectAtIndex:sender.value];
    [responder becomeFirstResponder];
}

-(void)doneTypingClicked:(id)sender
{
    [self.parentView endEditing:YES];
}

-(void)addTextField:(UITextField *)textField
{
    
    textField.inputAccessoryView = self;
    [self.myTextFields addObject:textField];
    self.textFieldsStepper.maximumValue = maxValue;
    maxValue++;
    //stepper will be hidden if we have only one responder
    self.textFieldsStepper.hidden = maxValue <= 1;
}

-(void)addTextView:(UITextView *)textView
{
    
    textView.inputAccessoryView = self;
    [self.myTextFields addObject:textView];
    self.textFieldsStepper.maximumValue = maxValue;
    maxValue++;

    //stepper will be hidden if we have only one responder
    self.textFieldsStepper.hidden = maxValue <= 1;
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


@end
