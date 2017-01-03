import UIKit

import Foundation


let noConnectionStringNotification = "com.IOTAlert.internetConnection"
let paginationVal: String = "10"

@available(iOS 8.0, *)
var internetConnection: Int = 0

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var navController: UINavigationController?
    var isNetworkAvailable: Bool = true
    var intPage: Int = 0
    
    var hostReachability: Reachability?
    var internetReachability: Reachability?
    var wifiReachability: Reachability?
    var reachability: Reachability?
    
    
    //User defined method
    
    
    
    
    
    
    func checkStatus (reachability: Reachability) {
        
        
        let netStatus: NetworkStatus = reachability.currentReachabilityStatus()
        var connectionRequired: Bool = reachability.connectionRequired()
        var statusString: String = ""
        
        switch netStatus {
            
        case NotReachable:
            statusString = NSLocalizedString("Access Not Available", comment: "Text field text for access is not available")
            /*Minor interface Detail- coonectionRequired may return YES/True even when the host is unreachable. We cover that up here*/
            
            self.isNetworkAvailable = false
            connectionRequired = false //should connection required be true
            break
            
        case ReachableViaWWAN:
            self.isNetworkAvailable = true
            
            statusString = NSLocalizedString("Reachable WWAN", comment: "")
            break
            
        case ReachableViaWiFi:
            self.isNetworkAvailable = true
            statusString = NSLocalizedString("Reachable Wifi", comment: "")
            
        default:
            print("Invalid reachability")
        }
        
        if connectionRequired
        {
            let connectionRequiredFormatString = NSLocalizedString(", Connection Required", comment: "Concatenation of status string with connection requirement")
            statusString = statusString + connectionRequiredFormatString
        }
        NSNotificationCenter.defaultCenter().postNotificationName("ChangeInternetConnection", object: nil)
    }
    
   
    
    func checkInternetConnection () {
        
       // NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("reachabilityChanged:"), name: kReachabilityChangedNotification, object: nil)
        
        let remoteHostName: String = "www.apple.com"
        
        
        self.hostReachability = Reachability.init(hostName: remoteHostName)
        self.hostReachability!.startNotifier()
        self.updateInterfaceWithReachability(self.hostReachability!)
        
        self.internetReachability = Reachability.reachabilityForInternetConnection()
        self.internetReachability!.startNotifier()
        self.updateInterfaceWithReachability(self.internetReachability!)
        
        self.wifiReachability = Reachability.reachabilityForLocalWiFi()
        self.wifiReachability!.startNotifier()
        self.updateInterfaceWithReachability(self.wifiReachability!)
    }

    
    
    
    func updateInterfaceWithReachability (reachability: Reachability)  {
        
        if reachability == self.hostReachability
        {
            self.checkStatus(reachability)
            
            //let netStatus: NetworkStatus = reachability.currentReachabilityStatus()
            let connectionRequired: Bool = reachability.connectionRequired()
            
            
            
            var baseLabelText: String = ""
            
            
            
            if connectionRequired
            {
                baseLabelText = NSLocalizedString("Cellular data network is available.\nInternet traffic will be routed through it after a connection is established.", comment: "Reachability text if a connection is required")
            }
            else
            {
                baseLabelText = NSLocalizedString("Cellular data network is active.\nInternet traffic will be routed through it.", comment: "Reachability text if a connection is not required")
            } 
        }
        
        
        if reachability == self.internetReachability
        {
            self.checkStatus(reachability)
        }
        
        if reachability == self.wifiReachability
        {
            self.checkStatus(reachability)
        }
        
    }
    
    func reachabilityChanged (note: NSNotification) {
        
        let curReach: Reachability = note.object as! Reachability
        
        self.updateInterfaceWithReachability(curReach)
        
    }
    
    
    
    func AlertViewShow (Title: String, Message: String, Delegate: UIAlertViewDelegate) {
        
        let alert: UIAlertView = UIAlertView.init(title: Title, message: Message, delegate: Delegate, cancelButtonTitle: "OK", otherButtonTitles: "")
        
        alert.show()
    }

    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        
        if self.isNetworkAvailable
        {
            let hub: SBNotificationHub = SBNotificationHub.init(connectionString: "Endpoint=sb://softwebiotnotificationhub-ns.servicebus.windows.net/;SharedAccessKeyName=DefaultFullSharedAccessSignature;SharedAccessKey=nkaDen99qk/bIC94W7+oel7eWqkSfTx0mC7PaXAFWMs=", notificationHubPath: "softwebiotnotificationhub")
            print("Device Token \(deviceToken)")
            
            
            
            hub.registerNativeWithDeviceToken(deviceToken, tags: nil, completion:{(error: NSError!) -> Void in
                
                print("Device Token : \(deviceToken)")
                
                if error != nil
                {
                    print("Error registering for notifications: \(error!)")
                }
            })
        }
        else
        {
            let nilObject: UIAlertViewDelegate? = nil
            AlertViewShow("IOT Alert", Message: "Internet not Available", Delegate: nilObject!)
        }
    }
    
    func detectSensorType (aStrValue: NSString) -> NSString {
        
        if aStrValue.rangeOfString("Gas").location != NSNotFound
        {
            return "Gas"
        }else if aStrValue.rangeOfString("Fire").location != NSNotFound
        {
            return "Flame"
        }else if aStrValue.rangeOfString("Motion").location != NSNotFound
        {
            return "Motion"
        }else if aStrValue.rangeOfString("Humidity").location != NSNotFound
        {
            return "Humidity"
        }
        else if aStrValue.rangeOfString("Temperature").location != NSNotFound
        {
            return "Temperature"
        }
        
        return ""
        
    }
    
    func _ConvertUTCTimeToLocalTimeWithFormat(rfc3339DateTimeString: String,LanguageCode lgc: String, CountryCode ctc: String, Formated formated: Bool) -> NSDate {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        let date = dateFormatter.dateFromString(rfc3339DateTimeString)
        return date!
        
        
//        let sRFC3339DateFormatter = NSDateFormatter()
//        let timeZone: NSTimeZone = NSTimeZone.localTimeZone()
//        let myPOSIXLocale: NSLocale = NSLocale.init(localeIdentifier: "\(timeZone)")
//        
//        sRFC3339DateFormatter.locale = myPOSIXLocale
//        sRFC3339DateFormatter.dateFromString("yyyy-MM-dd'T'HH:mm:ss.SSS")
//        sRFC3339DateFormatter.timeZone = NSTimeZone.init(name: "UTC")
//        return sRFC3339DateFormatter.dateFromString(rfc3339DateTimeString)!
        
        //let date: NSDate = sRFC3339DateFormatter.dateFromString(rfc3339DateTimeString)!
        
        /*if formated == true
        {
            var userVisibleDateTimeString: NSString
            
            if date != nil
            {
                if sUserVisibleDataFormatter != nil
                {
                    sUserVisibleDataFormatter = NSDateFormatter.init()
                    sUserVisibleDataFormatter?.dateStyle = .MediumStyle
                    sUserVisibleDataFormatter?.timeStyle = .ShortStyle
                }
                
                //Convert the date object to a user-visible date string
                userVisibleDateTimeString = sUserVisibleDataFormatter!.stringFromDate(date!)
                
                return userVisibleDateTimeString as String
            }
            
        } */
        
        //return date
        
    }


    //func application(application: UIApplication, didRecieveRemoteNotificaion userInfo: NSDictionary, fetchCompletionHandler completetionHandler: UIBackgroundFetchResult -> Void) {
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        
        
        //{"aps":{"alert":"Temperature reached to 37.3.Board: raspberrypi.Time: 2015-07-09T14:02:02.0000000","badge":1,"sound":"default"},"AdditionalInfo":"<null>","SensorType":"Temperature"}
        
       
        
        let userInfoDictionary = userInfo as NSDictionary
        print("\(userInfoDictionary.valueForKey("SensorType")!) --- \(userInfo)")
        
        
        UIApplication.sharedApplication().applicationIconBadgeNumber = (userInfo["aps"]!["badge"]!) as! Int
        
        if let sensorType = userInfo["SensorType"]
        {
            if sensorType.isEqualToString("Temperature")
            {
                NSUserDefaults.standardUserDefaults().setValue("\(NSUserDefaults.standardUserDefaults().valueForKey("Badge_Temp")!.intValue + 1)", forKey: "Badge_Temp")
            }
            else if sensorType.isEqualToString("Motion")
            {
                NSUserDefaults.standardUserDefaults().setValue("\(NSUserDefaults.standardUserDefaults().valueForKey("Badge_Motion")!.intValue + 1)", forKey: "Badge_Motion")
            }
            else if sensorType.isEqualToString("Flame")
            {
                NSUserDefaults.standardUserDefaults().setValue("\(NSUserDefaults.standardUserDefaults().valueForKey("Badge_Flame")!.intValue + 1)", forKey: "Badge_Flame")
            }
            else if sensorType.isEqualToString("Humidity")
            {
                print("Went into Humidity")
                
                NSUserDefaults.standardUserDefaults().setValue("\(NSUserDefaults.standardUserDefaults().valueForKey("Badge_Humidity")!.intValue + 1)", forKey: "Badge_Humidity")
            }
            else if sensorType.isEqualToString("Gas")
            {
                NSUserDefaults.standardUserDefaults().setValue("\(NSUserDefaults.standardUserDefaults().valueForKey("Badge_Gas")!.intValue + 1)", forKey: "Badge_Gas")
            }
            
            let userInfoArray: NSArray = (userInfoDictionary.valueForKey("aps")?.valueForKey("alert")?.componentsSeparatedByString("Time: "))!
            
            let aStrQuery: String = "insert into SensorDetail (SensorType,AdditionalInfo,alert,sensorDate) VALUES ('\(sensorType)' , '\(userInfoDictionary.valueForKey("AdditionalInfo")!)' , '\(userInfoDictionary.valueForKey("aps")!.valueForKey("alert")!)' , '\(self._ConvertUTCTimeToLocalTimeWithFormat(userInfoArray.objectAtIndex(1) as! String, LanguageCode: "", CountryCode: "", Formated: true))') "
            
            

            Database.shareDatabase().Insert(aStrQuery)
        }
        

        
        let aLastViewController: UIViewController = self.navController!.viewControllers.last! as UIViewController
        
        if aLastViewController.isKindOfClass(ListView)
        {
            let listVC: ListView = aLastViewController as! ListView
            listVC.reloadDataFromdb()
        }
    }
    
    

        
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
            // Override point for customization after application launch.
            
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"checkForReachability:", name: kReachabilityChangedNotification, object: nil);
        
        self.reachability = Reachability.reachabilityForInternetConnection();
        self.reachability!.startNotifier();
        
        //window!.addSubview(ListView().noIntenretConnectionString)
        
            self.navController = self.window!.rootViewController as? UINavigationController
            self.checkInternetConnection()
            
            self.intPage = 10
        
            
            Database.shareDatabase().createEditableCopyOfDatabaseIfNeeded()
        
        
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        UIApplication.sharedApplication().registerForRemoteNotifications()
        
        
            /*let reachabilitySelector: Selector = "isRegisteredForRemoteNotification:"
            
            if application.respondsToSelector(reachabilitySelector)
            {
                //iOS 8 Notifications, registerUserNotificationSettingsNotBeingHighlighted
                let settings = UIUserNotificationSettings.init(forTypes: [.Sound, .Alert, .Badge], categories: nil)
                application.registerUserNotificationSettings(settings)
                
                application.registerForRemoteNotifications()
            }
            else
            {
                //ios > 8 notifications
                let types: UIRemoteNotificationType = [.Alert, .Badge, .Sound]
                
                application.registerForRemoteNotificationTypes(types)
            } */
            
            if NSUserDefaults.standardUserDefaults().objectForKey("Badge_Temp") == nil
            {
                NSUserDefaults.standardUserDefaults().setValue("0", forKey: "Badge_Temp")
                NSUserDefaults.standardUserDefaults().setValue("0", forKey: "Badge_Motion")
                NSUserDefaults.standardUserDefaults().setValue("0", forKey: "Badge_Flame")
                NSUserDefaults.standardUserDefaults().setValue("0", forKey: "Badge_Humidity")
                NSUserDefaults.standardUserDefaults().setValue("0", forKey: "Badge_Gas")
            }
            
            UIApplication.sharedApplication().applicationIconBadgeNumber = 0
            
            return true
        }
        
        func applicationWillResignActive(application: UIApplication) {
            // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
            // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        }
        
        func applicationDidEnterBackground(application: UIApplication) {
            // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
            // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        }
        
        func applicationWillEnterForeground(application: UIApplication) {
            // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        }
        
        func applicationDidBecomeActive(application: UIApplication) {
            // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        }
        
        func applicationWillTerminate(application: UIApplication) {
            // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        }
    
   
        func checkForReachability(notification:NSNotification) {
        
       
            
        if let networkReachability = notification.object as? Reachability {
            let remoteHostStatus = networkReachability.currentReachabilityStatus()
            
            
            
            if (remoteHostStatus == NotReachable) {
                internetConnection = 1
                
                print("Not reachable")
            }
            
            else if (remoteHostStatus == ReachableViaWiFi) {
               internetConnection = 0
                print("Reachable")
            }
            else {
                internetConnection = 0
            }
            
            NSNotificationCenter.defaultCenter().postNotificationName(noConnectionStringNotification, object: internetConnection)
        } else {
            print("Unknown")
        }
    }
        
        
        
    }
    


