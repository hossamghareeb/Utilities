//
//  AbstractViewController.m
//  Monitoring
//
//  Created by Hossam on 4/15/13.
//  Copyright (c) 2013 Inova LLC. All rights reserved.
//

#import "AbstractViewController.h"
#import "MasterViewController.h"
@interface AbstractViewController ()

@end

@implementation AbstractViewController


@synthesize popover;

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
    
    //add custom font for navigation title (if exist)
    UIFont *font =  [UIFont fontWithName:CUSTOM_FONT_TITILLIUM_250wt size:25];

    self.titleLabel.font = font;
    sitesUrlManager = [[SitesUrlManager alloc]init];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (NEEDS_LANDSCAPE_IPAD && UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(orientationChanged:)  name:UIDeviceOrientationDidChangeNotification  object:nil];
    }
    
}

- (void)orientationChanged:(NSNotification *)notification{
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        //load the portrait view
        [self handlePortraitOrientations];
    }
    else if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight)
    {
        //load the landscape view
        [self handleLandScapeOrientations];
    }
}

-(void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];}

- (IBAction)toggleMasterView:(id)sender
{
    
    
    [self.view endEditing:YES];
    MasterDetailViewController *master = (MasterDetailViewController *)self.navigationController.parentViewController;
    [master toggleView];
}

-(void)displayAlert:(NSString *)title andDescription:(NSString *)decription
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:decription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}

-(void)warnUser:(NSString *)warnningMsg
{
    if (self.navigationController.view) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        // Configure for text only and offset down
        hud.mode = MBProgressHUDModeText;
        hud.labelText = warnningMsg;
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:2];
    }

}

-(void)showHUDLoadingView:(NSString *)Msg
{

}


#define MASTER_WIDTH ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)? 256 : 240

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    [self.view setNeedsLayout];
    //    return YES;
    //[self.view setNeedsDisplay];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if (NEEDS_LANDSCAPE_IPAD) {
            if(UIInterfaceOrientationIsLandscape(toInterfaceOrientation))
                //now we are in landscape mode
                [self handleLandScapeOrientations];
            {
                
            }
            if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
                //now we are in portrait mode
                  [self handlePortraitOrientations];
                
            }
            return YES;
        }
        else
        {
            return UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
        }
        
    }
        
    else
        return UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
    
}
- (NSUInteger)supportedInterfaceOrientations
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
         return NEEDS_LANDSCAPE_IPAD?  UIInterfaceOrientationMaskAll : UIInterfaceOrientationMaskPortrait;
    else
        return UIInterfaceOrientationMaskPortrait;
    
}

- (BOOL)shouldAutorotate {
    return [self shouldAutorotateToInterfaceOrientation:self.interfaceOrientation];
}



-(void)handleLandScapeOrientations{
    
}
-(void)handlePortraitOrientations{
  
}

#pragma mark -
#pragma mark Other Actions
#pragma mark -

-(IBAction)goBack:(id)sender;
{

    
    if([[self.navigationController viewControllers]count]>1){
        [self.navigationController popViewControllerAnimated:YES];
    }else if([[self.navigationController viewControllers]count]==1){
        [self toggleMasterView:sender];
    }
}

#pragma mark -
#pragma mark DidUnload
#pragma mark -

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTitleLabel:nil];
    [self setCusomNavigationBar:nil];
    [self setBackButtonLabel:nil];
    [self setBackButton:nil];


    [super viewDidUnload];
}


- (void) showComposeMailViewController:(NSString*)emailString
{
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail])
		{
			MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
			picker.mailComposeDelegate = self;
			[picker setToRecipients:[NSArray arrayWithObjects:emailString, nil]];
            [self presentViewController:picker animated:YES completion:nil];

		}
		else
		{
			[self launchMailAppOnDevice:emailString];
		}
	}
    else
        
        [self launchMailAppOnDevice:emailString];
}
-(void)launchMailAppOnDevice:(NSString*)emailString
{
	NSString *recipients = @"mailto:";
	
	
	NSString *email = [NSString stringWithFormat:@"%@%@", recipients, emailString];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}


-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void)addPullToRefreshToTableView:(UITableView *)table withTintColor:(UIColor *)color selector:(SEL)selector
{
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl setTintColor:color];
    [refreshControl addTarget:self action:selector forControlEvents:UIControlEventValueChanged];
    [table addSubview:refreshControl];
}

@end
