
#define Helvetica_FONT(FontSize) [UIFont fontWithName:@"HelveticaNeue" size:FontSize]

#define Helvetica_FONTBOLD(FontSize) [UIFont fontWithName:@"HelveticaNeue-Bold" size:FontSize]



#define NavigationBarColor [UIColor colorWithRed:153.0/255.0f green:50.0/255.0 blue:118.0/255.0 alpha:1.0]



#define STORYBORD [UIStoryboard storyboardWithName:@"Main" bundle:nil]
#define iPAD_STORYBORD [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil]

#define ApplicationDelegate        ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define APP_DELEGATE_WINDOW                 ((UIWindow*)((AppDelegate*)[[UIApplication sharedApplication] delegate])).window
#define APP_DELEGATE_LOCATION               ((AppDelegate *)APP_DELEGATE).deviceLocation
#define UserDefaults                        [NSUserDefaults standardUserDefaults]
#define NotificationCenter                  [NSNotificationCenter defaultCenter]
#define SharedApplication                   [UIApplication sharedApplication]
#define Bundle                              [NSBundle mainBundle]
#define MainScreen                          [UIScreen mainScreen]
#define ShowNetworkActivityIndicator()      [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
#define HideNetworkActivityIndicator()      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO
#define NavBar                              self.navigationController.navigationBar
#define NavBarHide                          self.navigationController.navigationBarHidden
#define HideBackButton                      self.navigationItem setHidesBackButton = YES
#define TabBar                              self.tabBarController.tabBar
#define NavBarHeight                        self.navigationController.navigationBar.bounds.size.height
#define TabBarHeight                        self.tabBarController.tabBar.bounds.size.height
#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height
#define ViewWidth(v)                        v.frame.size.width
#define ViewHeight(v)                       v.frame.size.height
#define ViewX(v)                            v.frame.origin.x
#define ViewY(v)                            v.frame.origin.y
#define SelfViewWidth                       self.view.bounds.size.width
#define SelfViewHeight                      self.view.bounds.size.height
#define RectX(f)                            f.origin.x
#define RectY(f)                            f.origin.y
#define RectWidth(f)                        f.size.width
#define RectHeight(f)                       f.size.height
#define RectSetWidth(f, w)                  CGRectMake(RectX(f), RectY(f), w, RectHeight(f))
#define RectSetHeight(f, h)                 CGRectMake(RectX(f), RectY(f), RectWidth(f), h)
#define RectSetX(f, x)                      CGRectMake(x, RectY(f), RectWidth(f), RectHeight(f))
#define RectSetY(f, y)                      CGRectMake(RectX(f), y, RectWidth(f), RectHeight(f))
#define RectSetSize(f, w, h)                CGRectMake(RectX(f), RectY(f), w, h)
#define RectSetOrigin(f, x, y)              CGRectMake(x, y, RectWidth(f), RectHeight(f))
#define DATE_COMPONENTS                     NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
#define TIME_COMPONENTS                     NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit
#define FlushPool(p)                        [p drain]; p = [[NSAutoreleasePool alloc] init]
#define RGB(r, g, b)                        [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define HEXCOLOR(c)                         [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0];

#define DocumentsDirectory [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES) objectAtIndex:0]

//For setting static images for iPhone 4 and iPhone 5
#define ASSET_BY_SCREEN_HEIGHT(regular, longScreen) (([[UIScreen mainScreen] bounds].size.height <= 480.0) ? regular : longScreen)

//For Checking device is iPhone 4 or iPhone 5
#define isIphone4() (([[UIScreen mainScreen] bounds].size.height == 480.0) ? 1 : 0)
#define isIphone5() (([[UIScreen mainScreen] bounds].size.height == 568.0) ? 1 : 0)
#define isIphone6() (([[UIScreen mainScreen] bounds].size.height == 667.0) ? 1 : 0)
#define isIphone6PLUS() (([[UIScreen mainScreen] bounds].size.height == 736.0) ? 1 : 0)

#define IS_IOS8  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending)

#define IS_RETINA  ([[UIScreen mainScreen] scale] == 2.0f)
#define isIpad() (([[UIDevice currentDevice] userInterfaceIdiom]== UIUserInterfaceIdiomPad) ? 1 : 0)


#define SmallNavigationBarColor [UIColor colorWithRed:148.0/255.0f green:43.0/255.0f blue:107.0/255.0f alpha:1.0]


#define AlertViewShow(Title,Message,Delegate) {UIAlertView *alert = [[UIAlertView alloc]initWithTitle:Title message:Message delegate:Delegate cancelButtonTitle:@"OK" otherButtonTitles: nil];[alert show];}


// Check OS Version
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define HEIGHT_IPHONE_5 568
#define IS_IPHONE_4 ([[UIScreen mainScreen] bounds ].size.height < HEIGHT_IPHONE_5)


//Step:1
//To stop print NSLog write this code
#define __DEBUG__

#ifdef __DEBUG__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif

//Step:2
//and When don't want logs in app then just comment the first line i.e
#define __DEBUG__
