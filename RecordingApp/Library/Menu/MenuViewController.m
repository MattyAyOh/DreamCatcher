//
//  MenuViewController.m
//  RecordingApp
//
//  Created by Mitul Patel on 30/12/15.
//  Copyright (c) 2015 Om Info. All rights reserved.
//


#import "MenuViewController.h"
#import "AppDelegate.h"

@interface MenuViewController ()
{
    float sectionHeight;
}

@end

@implementation MenuViewController
{
    NSMutableArray *myArray;
}
@synthesize tableview;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

#pragma mark - ViewLifeCycle
#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    list = [[NSMutableArray alloc]init];
    [list addObject:@"Dreamcatcher"];
    [list addObject:@"Search Notes"];
    [list addObject:@"Password Setting"];
    [list addObject:@"Share This App"];
    [list addObject:@"Rate This App"];
    [list addObject:@"Contact"];
    [list addObject:@"Go To Website"];
    [list addObject:@"Help"];

    list_image= [[NSMutableArray alloc]init];
    [list_image addObject:@"Cloud1"];
    [list_image addObject:@"SearchNotes"];
    [list_image addObject:@"PasswordSetting"];
    [list_image addObject:@"ShareThisApp"];
    [list_image addObject:@"RateThisApp"];
    [list_image addObject:@"Contact"];
    [list_image addObject:@"GoToWebsite"];
    [list_image addObject:@"Help"];

    /*
    tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, 100, 50)];
    
    UIImage *image = [UIImage imageNamed:@"Cloud1"];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:image];
   */
  
    
}

#define mark ===========tableView============
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [list count];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    
    UILabel *lbltitle=[[UILabel alloc] initWithFrame:CGRectMake(40,2,200,35)];
    
    lbltitle.text = [list objectAtIndex:indexPath.row];
    
    [cell.contentView addSubview:lbltitle];
    
    UIImageView *seperator=[[UIImageView alloc] initWithFrame:CGRectMake(10,6,20,26)];
    
    seperator.image=[UIImage imageNamed:[list_image objectAtIndex:indexPath.row]];
    
    seperator.contentMode = UIViewContentModeScaleAspectFit;
    
    [cell.contentView addSubview:seperator];
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.textLabel.textColor=[UIColor blackColor];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    storyboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    switch (indexPath.row)
    {
        case 0:
        {
            HomeViewController *mainview = [storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
            
            /*
            [ApplicationDelegate.navCon1 pushViewController:mainview animated:YES];
            
            [ApplicationDelegate.menu showRootController:YES];
            */
            
            ApplicationDelegate.navCon1 = [[UINavigationController alloc] initWithRootViewController:mainview];
            
            ApplicationDelegate.navCon1.navigationBar.barStyle = UIBarStyleDefault;
            
            ApplicationDelegate.navCon1.navigationBar.translucent=NO;
            
            [ApplicationDelegate.menu setRootController:ApplicationDelegate.navCon1 animated:YES];
            
            break;
        }
            
        case 1:
        {
            
            HomeViewController *mainview = [storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
            
            ApplicationDelegate.navCon1 = [[UINavigationController alloc] initWithRootViewController:mainview];
            
            ApplicationDelegate.navCon1.navigationBar.barStyle = UIBarStyleDefault;
            
            ApplicationDelegate.navCon1.navigationBar.translucent=NO;
            
            [ApplicationDelegate.menu setRootController:ApplicationDelegate.navCon1 animated:YES];
            
            break;
        }
            
        case 2:
        {
            HomeViewController *mainview = [storyboard instantiateViewControllerWithIdentifier:@"PasswordSetting"];
            
            //mainview.selecttab=@"0";
            
            ApplicationDelegate.navCon1 = [[UINavigationController alloc] initWithRootViewController:mainview];
            
            ApplicationDelegate.navCon1.navigationBar.barStyle = UIBarStyleDefault;
            
            ApplicationDelegate.navCon1.navigationBar.translucent=NO;
            
            [ApplicationDelegate.menu setRootController:ApplicationDelegate.navCon1 animated:YES];
             
            break;
        }
            
        case 3:
        {
            HomeViewController *mainview = [storyboard instantiateViewControllerWithIdentifier:@"ShareThisApp"];
            
            //mainview.selecttab=@"0";
            
            ApplicationDelegate.navCon1 = [[UINavigationController alloc] initWithRootViewController:mainview];
            
            ApplicationDelegate.navCon1.navigationBar.barStyle = UIBarStyleDefault;
            
            ApplicationDelegate.navCon1.navigationBar.translucent=NO;
            
            [ApplicationDelegate.menu setRootController:ApplicationDelegate.navCon1 animated:YES];
            
            break;
        }
            
        case 4:
        {
            HomeViewController *mainview = [storyboard instantiateViewControllerWithIdentifier:@"RateThisApp"];
            
            //mainview.selecttab=@"0";
            
            ApplicationDelegate.navCon1 = [[UINavigationController alloc] initWithRootViewController:mainview];
            
            ApplicationDelegate.navCon1.navigationBar.barStyle = UIBarStyleDefault;
            
            ApplicationDelegate.navCon1.navigationBar.translucent=NO;
            
            [ApplicationDelegate.menu setRootController:ApplicationDelegate.navCon1 animated:YES];
            
            break;
        }
            
        case 5:
        {
            HomeViewController *mainview = [storyboard instantiateViewControllerWithIdentifier:@"Contact"];
            
            //mainview.selecttab=@"0";
            
            ApplicationDelegate.navCon1 = [[UINavigationController alloc] initWithRootViewController:mainview];
            
            ApplicationDelegate.navCon1.navigationBar.barStyle = UIBarStyleDefault;
            
            ApplicationDelegate.navCon1.navigationBar.translucent=NO;
            
            [ApplicationDelegate.menu setRootController:ApplicationDelegate.navCon1 animated:YES];
            
            break;
        }
            
        case 6:
        {
            HomeViewController *mainview = [storyboard instantiateViewControllerWithIdentifier:@"GoToWebsite"];
            
            //mainview.selecttab=@"0";
            
            ApplicationDelegate.navCon1 = [[UINavigationController alloc] initWithRootViewController:mainview];
            
            ApplicationDelegate.navCon1.navigationBar.barStyle = UIBarStyleDefault;
            
            ApplicationDelegate.navCon1.navigationBar.translucent=NO;
            
            [ApplicationDelegate.menu setRootController:ApplicationDelegate.navCon1 animated:YES];
            
            break;
        }
            
        case 7:
        {
            HomeViewController *mainview = [storyboard instantiateViewControllerWithIdentifier:@"Help"];
            
            //mainview.selecttab=@"0";
            
            ApplicationDelegate.navCon1 = [[UINavigationController alloc] initWithRootViewController:mainview];
            
            ApplicationDelegate.navCon1.navigationBar.barStyle = UIBarStyleDefault;
            
            ApplicationDelegate.navCon1.navigationBar.translucent=NO;
            
            [ApplicationDelegate.menu setRootController:ApplicationDelegate.navCon1 animated:YES];
            
            break;
        }            
            
        default:
            break;
    }
    
    
}

- (void)resetDefaults {
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
  
    
   // [tableview reloadData];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [self setTableview:nil];
    [super viewDidUnload];
}

@end
