//
//  AbstractViewController.h
//  Monitoring
//
//  Created by Hossam on 4/15/13.
//  Copyright (c) 2013 Inova LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "UIImage+Resize.h"
#import "MasterDetailViewController.h"
#import "Constants.h"
#import "MBProgressHUD.h"
#import "SitesUrlManager.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
@interface AbstractViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPopoverControllerDelegate, MFMailComposeViewControllerDelegate>

{
    SitesUrlManager *sitesUrlManager;
    
    UIRefreshControl *refreshControl;

}

@property (weak, nonatomic) IBOutlet UIButton *uploadRightButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *backButtonLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIView *cusomNavigationBar;

@property (nonatomic, strong) UIPopoverController *popover;

- (IBAction)toggleMasterView:(id)sender;

-(void)displayAlert:(NSString *)title andDescription:(NSString *)decription;
-(void)warnUser:(NSString *)warnningMsg;

-(IBAction)goBack:(id)sender;

-(void)handleLandScapeOrientations;
-(void)handlePortraitOrientations;

- (void) showComposeMailViewController:(NSString*)emailString;

-(void)addPullToRefreshToTableView:(UITableView *)table withTintColor:(UIColor *)color selector:(SEL)selector;
@end
