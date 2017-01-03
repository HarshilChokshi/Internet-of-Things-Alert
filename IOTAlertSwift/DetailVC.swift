import UIKit
import Foundation
import MessageUI


let degree = 31




extension String {
    func insert(string:String,ind:Int) -> String {
        return  String(self.characters.prefix(ind)) + string + String(self.characters.suffix(self.characters.count-ind))
    }
}


@available(iOS 8.0, *)
class DetailVC: UIViewController, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {
    
    @IBOutlet var imgSensor: UIImageView!
    @IBOutlet var imgMotion: UIImageView!
    @IBOutlet var lblTimeHeading, lblTime, lblHumidity: UILabel!
    @IBOutlet var lblDetailHeading, lblDetail: UILabel!
    @IBOutlet var scrDetail: UIScrollView!
    @IBOutlet var actIndicator, actOfficeInd: UIActivityIndicatorView?
    var intDegree: NSInteger = 0
    var isImageFound: Bool = true
    @IBOutlet var alert_Indi_view: UIView!
    @IBOutlet var btnIgnore: UIBarButtonItem!
    
    @IBOutlet weak var button_Alert: UIButton!
    @IBOutlet weak var View_RedBG: UIView!
    @IBOutlet weak var lbl_AlertRedLabel: UILabel!
    @IBOutlet weak var lbl_AlertRedTime: UILabel!
    @IBOutlet weak var lblThreshold: UILabel!
    
    var alertDict: NSDictionary!
    
    
    
    //User defined Functions
    
  

    
    func IgoneBtnClick (btnIgnore: UIButton) {
        
        
        
        if alertDict.valueForKey("SensorType")?.isEqualToString("Temperature") == true
        {
           NSUserDefaults.standardUserDefaults().setValue(NSString.init(string: "0"), forKey: "Badge_Temp")
        }
        else if alertDict.valueForKey("SensorType")?.isEqualToString("Motion") == true
        {
            NSUserDefaults.standardUserDefaults().setValue(NSString.init(string: "0"), forKey: "Badge_Motion")
        }
        else if alertDict.valueForKey("SensorType")?.isEqualToString("Flame") == true
        {
            NSUserDefaults.standardUserDefaults().setValue(NSString.init(string: "0"), forKey: "Badge_Flame")
        }
        else if alertDict.valueForKey("SensorType")?.isEqualToString("Humidity") == true
        {
            NSUserDefaults.standardUserDefaults().setValue(NSString.init(string: "0"), forKey: "Badge_Humidity")
        }
        else if alertDict.valueForKey("SensorType")?.isEqualToString("Gas") == true
        {
            NSUserDefaults.standardUserDefaults().setValue(NSString.init(string: "0"), forKey: "Badge_Gas")
        }
        
        Database.shareDatabase().Update("UPDATE SensorDetail SET isChecked='True' where SensorType = '\(alertDict.valueForKey("SensorType"))'")
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    func randomNumberBetween (min: NSInteger, maxNumber max: NSInteger) -> NSInteger {
        
        return  min + random() % (max + min)
    }
    
    func _ConvertUTCTimeToLocalTimeWithFormat(rfc3339DateTimeString: String, LanguageCode lgc: String, CountryCode ctc: String, Formated formated: Bool) -> String {
        
        /*var sUserVisibleDataFormatter: NSDateFormatter?
        var sRFC3339DateFormatter: NSDateFormatter?
        
        let timeZone: NSTimeZone = NSTimeZone.localTimeZone()
        
        
        
        sRFC3339DateFormatter = NSDateFormatter.init()
        
        let myPOSIXLocale: NSLocale = NSLocale.init(localeIdentifier: "\(timeZone)")
        
        sRFC3339DateFormatter!.locale = myPOSIXLocale
        sRFC3339DateFormatter!.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        sRFC3339DateFormatter!.timeZone = NSTimeZone.init(name: "UTC")
        
        
        
        var fixedrfc3339DateTimeString: String = rfc3339DateTimeString.substringToIndex(rfc3339DateTimeString.endIndex.predecessor())
        fixedrfc3339DateTimeString = fixedrfc3339DateTimeString.insert("'", ind: 10)
        fixedrfc3339DateTimeString = fixedrfc3339DateTimeString.insert("'", ind: 12)
        fixedrfc3339DateTimeString = fixedrfc3339DateTimeString.insert("Z", ind: 28)
        
        print(fixedrfc3339DateTimeString)
        
        let date: NSDate? = sRFC3339DateFormatter!.dateFromString(fixedrfc3339DateTimeString)
        
        print("This is the date \(date)")
        
        if formated == true
        {
            var userVisibleDateTimeString: String
           
            
            if date != nil
            {
                print("This is the \(date)")
                
                if sUserVisibleDataFormatter != nil
                {
                    sUserVisibleDataFormatter = NSDateFormatter.init()
                    sUserVisibleDataFormatter?.dateStyle = .MediumStyle
                    sUserVisibleDataFormatter?.timeStyle = .ShortStyle
                }
                
                //Convert the date object to a user-visible date string
                userVisibleDateTimeString = sUserVisibleDataFormatter!.stringFromDate(date!)
                
                return userVisibleDateTimeString
            }
            
        }
        
        return "Hi" */
        
        /*let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        let fixedrfc3339DateTimeString: String = rfc3339DateTimeString.substringToIndex(rfc3339DateTimeString.endIndex.predecessor())
        guard let date = dateFormatter.dateFromString(fixedrfc3339DateTimeString) else {
            assert(false, "no date from string")
            return ""
        }
        
        dateFormatter.dateFormat = "yyyy MMM EEEE HH:mm"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        let timeStamp = dateFormatter.stringFromDate(date)
        
        return timeStamp */
        
        
        var fixedrfc3339DateTimeString: String = rfc3339DateTimeString.substringToIndex(rfc3339DateTimeString.endIndex.predecessor())
        fixedrfc3339DateTimeString = fixedrfc3339DateTimeString.insert(" ", ind: 10)
        fixedrfc3339DateTimeString = fixedrfc3339DateTimeString.insert("ime: ", ind: 12)
        
        return fixedrfc3339DateTimeString
        }
    
    

    func additionalInfoSensor (isHumidity: Bool) {
        
        let timeInfo: NSArray = alertDict.valueForKey("alert")!.componentsSeparatedByString("Time: ")
        
        if alertDict.valueForKey("SensorType")?.isEqualToString("Temperature") == true
        {
            //let temperatureAlertDictObject: NSArray = alertDict.valueForKey("alert")!.componentsSeparatedByString("Temperature reached to ")[1].componentsSeparatedByString(".Board")
            
            //print("This is the object at first index \(temperatureAlertDictObject[0])")
            
            
           //if temperatureAlertDictObject[0] as! Bool
            //{
                lblHumidity.text = String(format: "%.1f°F", ((CFloat(alertDict["alert"]!.componentsSeparatedByString("Temperature reached to ")[1].componentsSeparatedByString(".Board")[0])! * 9) / 5) + 32)
            //}
            
            lblThreshold.text = "Temp <= 59°F or Temp >= 86°F"
        }
        
        if alertDict.valueForKey("SensorType")?.isEqualToString("Humidity") == true
        {
            //let humidityAlertDictObject: NSArray = alertDict.valueForKey("alert")!.componentsSeparatedByString("Humidity reached to ")[1].componentsSeparatedByString(".Board")
            //if humidityAlertDictObject[0] as! Bool
            //{
                lblHumidity.text = String(format: "%.1f%%", CFloat(alertDict["alert"]!.componentsSeparatedByString("Humidity reached to ")[1].componentsSeparatedByString(".Board")[0])!)
            //}
        
            lblThreshold.text = "Humidity >= 50%"
        }
        
        let strTime: String = self._ConvertUTCTimeToLocalTimeWithFormat(timeInfo.objectAtIndex(1) as! String, LanguageCode: "", CountryCode: "", Formated: true)
        
        
        
        
        lblTime.text = strTime
        
        lbl_AlertRedTime.text = strTime
        
        if !isHumidity
        {
            lblHumidity.hidden = true
            imgSensor.hidden = false
        }
        else
        {
            imgSensor.hidden = true
            lblHumidity.hidden = false
        }
        
        print("\(alertDict.valueForKey("SensorType")!)")
        
        if alertDict.valueForKey("SensorType")!.isEqualToString("Motion") == true
        {
            print("Went into Motion")
            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                
                self.actIndicator?.startAnimating()
                
                let imgFrame: CGRect = self.imgMotion.frame
                
                self.imgMotion.frame = imgFrame
                
                let baseUrl: String = "https://commoniotstorage.blob.core.windows.net/motioncaptureimages-direct/"
                
                let imgURL: String = baseUrl.stringByAppendingString(self.alertDict.valueForKey("AdditionalInfo")! as! String)
                
                print("\(self.alertDict!)")
                
                
                
                let data: NSData? = NSData.init(contentsOfURL: NSURL.init(fileURLWithPath: imgURL))!
                
                
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    
                    
                    if data == nil
                    {
                        self.actIndicator?.stopAnimating()
                        let nilObject: UIAlertViewDelegate? = nil
                        UIAlertView.init(title: "IOT Alert", message: "No Image Found", delegate: nilObject, cancelButtonTitle: "OK").show()
                    }
                    else
                    {
                        self.scrDetail.contentSize = CGSizeMake(320, self.imgMotion.frame.origin.y + self.imgMotion.frame.size.height + 20)
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            
                            self.imgMotion.image = UIImage.init(data: data!)
                            self.actIndicator?.stopAnimating()
                        }
                    }
                }
            }
        }
        
        else
        {
            imgMotion.hidden = true
            actIndicator?.hidden = true
        }
        
        if alertDict.valueForKey("SensorType")?.isEqualToString("Motion") == true
        {
            // do nothing
        }
        else if alertDict.valueForKey("SensorType")?.isEqualToString("Gas") == true
        {
            lbl_AlertRedLabel.text = "Harmful Gas Level has been detected. 9-1-1 has been called. Please Evacuate the Area safely."
        }
        else if alertDict.valueForKey("SnesorType")?.isEqualToString("Flame") == true
        {
            lbl_AlertRedLabel.text = "Fire has been detected. 9-1-1 has been called. Please Evacuate the Area safely."
        }
        
        if alertDict.valueForKey("SensorType")!.isEqualToString("Motion") || alertDict.valueForKey("SensorType")!.isEqualToString("Gas") || alertDict.valueForKey("SensorType")!.isEqualToString("Flame")
        {
            
            alert_Indi_view.hidden = false
        }
        else
        {
            View_RedBG.hidden = true
            button_Alert.hidden = true
            
            lbl_AlertRedLabel.hidden = true
            lbl_AlertRedTime.hidden = true
            
            alert_Indi_view.hidden = true
        }
        
        if alertDict.valueForKey("SensorType")?.isEqualToString("Motion") == true
        {
            lbl_AlertRedLabel.hidden = true
            lbl_AlertRedTime.hidden = true
            
            lblThreshold.hidden = true
            (self.view.viewWithTag(312) as! UILabel).hidden = true
            
        }
        
        if alertDict.valueForKey("SensorType")!.isEqualToString("Gas") || alertDict.valueForKey("SensorType")!.isEqualToString("Flame")
        {
            lblTimeHeading.hidden = true
            lblTime.hidden = true
            lblThreshold.hidden = true
            
            (self.view.viewWithTag(312) as! UILabel).hidden = true

        }
        
    }
    
    
    func checkTemperatureSymbol () {
        
        imgSensor.hidden = true
        lblHumidity.hidden = false
        
        intDegree = self.randomNumberBetween(30, maxNumber: 40)
        
    }
    
    func IgnoreBtnAdd () {
        
        let button: UIButton = UIButton.init(type: UIButtonType.Custom)
        button.tag = 1030
        button.frame = CGRectMake(0, 0, 50, 40)
        button.titleLabel!.font = UIFont.systemFontOfSize(13)
        button.setTitle("Ignore", forState: UIControlState.Normal)
        button.addTarget(self, action: Selector("IgoneBtnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        button.setTitleColor(UIColor.init(red: 0.0/255.0, green: 163.0/255.0, blue: 240.0/255.0, alpha: 1.0), forState: UIControlState.Normal)
        
        let barButton: UIBarButtonItem = UIBarButtonItem.init(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    
    
    func displayOfficeImage () {
        
        lblHumidity.hidden = true
        imgSensor.hidden = false
        
        actOfficeInd!.startAnimating()
        
        let weakCellImg: UIImageView = imgSensor
        
        
        
        let file: NSURL? = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("office", ofType: "png")!)
        
        if file != nil
        {
            let nilObject: UIImage? = nil
           
            weakCellImg.sd_setImageWithURL(file, placeholderImage: nilObject , completed: {(image: UIImage?, error: NSError?, cacheType: SDImageCacheType!, imageURL: NSURL?) -> Void in
                weakCellImg.image = image
                self.actOfficeInd!.stopAnimating()
            } )
        }
        else
         {
            actOfficeInd!.stopAnimating()
        }
    }
    
    func heightForTitle (text: String, size fontSize: CGFloat, width lblWidth: CGFloat) -> CGFloat {
        
        let attributedText: NSAttributedString = NSAttributedString.init(string: text, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(fontSize)])
        
        do {
            
            let rect: CGRect = try attributedText.boundingRectWithSize(CGSize.init(width: lblWidth, height: CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, context: nil)
            return ceil(rect.size.height)
        } catch let error as NSException {
            print("Exception height For Label : \(error)")
        }
    }
    
    func widthForDegree(text: String, size fontSize: CGFloat, width lblWidth: CGFloat) -> CGFloat {
        
        let attributedText: NSAttributedString = NSAttributedString.init(string: text, attributes: [NSFontAttributeName:UIFont.init(name: "MagistralBlackC", size: 80)!])
        
        do {
            
            let rect: CGRect = try attributedText.boundingRectWithSize(CGSize.init(width: lblWidth, height: CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, context: nil)
            
            return ceil(rect.size.width)
        } catch let error as NSException {
            print("Exception height For Label : \(error)")
        }
    }
    
    
    
    func imageAsPerSensor () {
        
        var isHumidity: Bool = false
        
        
        
        if alertDict.valueForKey("SensorType")?.isEqualToString("Motion") == true
        {
            self.displayOfficeImage()
        }
        else if alertDict.valueForKey("SensorType")?.isEqualToString("Temperature") == true
        {
            isHumidity = true
            self.checkTemperatureSymbol()
            
        }
        else if alertDict.valueForKey("SensorType")?.isEqualToString("Flame") == true
        {
            self.displayOfficeImage()
        }
        else if alertDict.valueForKey("SensorType")?.isEqualToString("Gas") == true
        {
            self.displayOfficeImage()
        }
        else {
            isHumidity = true
            self.checkTemperatureSymbol()
        }
        
        self.IgnoreBtnAdd()
        self.additionalInfoSensor(isHumidity)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("This is the value of temperature  \(alertDict.valueForKey("SensorType")!.isEqualToString("Temperature"))")
        self.title = "\(alertDict.valueForKey("SensorType")!) Sensor"
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func HourCalculation (PostDate: String) -> String {
        
        let dateFormat: NSDateFormatter = NSDateFormatter()
        dateFormat.dateFormat = "yyyy/MM/dd HH:mm:ss z"
        
        let gmt: NSTimeZone = NSTimeZone.init(abbreviation: "GMT")!
        dateFormat.timeZone = gmt
        
        let ExpDate: NSDate = dateFormat.dateFromString(PostDate)!
        let calender: NSCalendar = NSCalendar.currentCalendar()
        
        let nscalenderunit: NSCalendarUnit = [.Day,.WeekOfYear,.Month,.Year,.Hour,.Minute,.Second]
        
        let components: NSDateComponents = calender.components(nscalenderunit , fromDate:ExpDate, toDate: NSDate.init(), options:[])
        
        var time: String = ""
        
        if components.year != 0
        {
            if components.year == 1
            {
                time = "\(Int(components.year)) year"
            }
            else
            {
                time = "\(Int(components.year)) years"
            }
        }
            
        else if components.month != 0
        {
            if components.month == 1
            {
                time = "\(Int(components.month)) month"
            }
            else
            {
                time = "\(Int(components.month)) months"
            }
        }
            
        else if components.weekOfYear != 0
        {
            if components.weekOfYear == 1
            {
                time = "\(Int(components.weekOfYear)) week"
            }
            else
            {
                time = "\(Int(components.weekOfYear)) weeks"
            }
        }
            
        else if components.day != 0
        {
            if components.day == 1
            {
                time = "\(Int(components.day)) day"
            }
                
            else
            {
                time = "\(Int(components.day)) days"
            }
        }
            
        else if components.hour != 0
        {
            if components.hour == 1
            {
                time = "\(Int(components.hour)) hour"
            }
            else
            {
                time = "\(Int(components.hour)) hours"
            }
        }
            
        else if components.minute != 0
        {
            if components.minute == 1
            {
                time = "\(Int(components.minute)) min"
            }
            else
            {
                time = "\(Int(components.minute)) mins"
            }
        }
            
        else if components.second >= 0
        {
            if components.second == 0
            {
                time = "1 sec"
            }
            else
            {
                time = "\(Int(components.second)) secs"
            }
        }
        
        return time + " ago"
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        dispatch_async(dispatch_get_main_queue(), {() -> Void in
            self.imageAsPerSensor()
            
        })
        
        actOfficeInd!.stopAnimating()
        actIndicator!.stopAnimating()
        
        
        
        button_Alert.setTitle(self.HourCalculation(alertDict.valueForKey("sensorDate") as! String) , forState: UIControlState.Normal)
        let textAttributes: [String : AnyObject] = [
            NSForegroundColorAttributeName : UIColor(red: 147.0 / 255.0, green: 149.0 / 255.0, blue: 151.0 / 255.0, alpha: 1.0),
            NSBackgroundColorAttributeName : UIColor(red: 147.0 / 255.0, green: 149.0 / 255.0, blue: 151.0 / 255.0, alpha: 1.0)
        ]
        
        self.navigationController!.navigationBar.titleTextAttributes = textAttributes
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Action Method
    
    @IBAction func btnMailClick (sender: AnyObject) {
        
        let ApplicationObject: AppDelegate = (UIApplication.sharedApplication().delegate as? AppDelegate)!
        
        if ApplicationObject.isNetworkAvailable
        {
            let mailComposer: MFMailComposeViewController = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            
            if MFMailComposeViewController.canSendMail()
            {
                
                //use the document file name for the subject
                mailComposer.setToRecipients(["ripal@softwebsolutions.com"]) //use the document file name for the subject
                mailComposer.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
                mailComposer.modalPresentationStyle = UIModalPresentationStyle.FormSheet
                mailComposer.mailComposeDelegate = self
            
                if alertDict.valueForKey("SensorType")?.isEqualToString("Motion") == true
                {
                    mailComposer.setSubject("Alert !!! Motion Detected")
                    mailComposer.setMessageBody("Motion has been detected. 9-1-1 has been called.", isHTML: false)
                    
                }else if alertDict.valueForKey("SensorType")?.isEqualToString("Gas") == true
                {
                    mailComposer.setSubject("Alert !!! Harmful Gas Detected")
                    mailComposer.setMessageBody("Harmful Gas Level has been detected. 9-1-1 has been called. Please Evacuate the Area safely.", isHTML: false)
                }
                else
                {
                    mailComposer.setSubject("Alert !!! Fire Detected")
                    mailComposer.setMessageBody("Fire has been detected. 9-1-1 has been called. Please Evacuate the Area safely.", isHTML: false)
                }
                
                self.presentViewController(mailComposer, animated: true, completion: nil)
                
            }
            else
            {
                let alrt: UIAlertView = UIAlertView.init(title: "IOT Alert", message: "Unable to send mail", delegate: nil, cancelButtonTitle: "")
               
                    
                alrt.show()
            }
            
        }
        else
        {
            let alertViewObject: UIAlertViewDelegate? = nil
            AlertViewShow("IOT Alert", Message: "Internet not available", Delegate: alertViewObject)
        }
        
    }
    
   
    
    @IBAction func btnMessageClick (sender: AnyObject) {
        
        var aStrMessage: String
        
        if alertDict.valueForKey("SensorType")?.isEqualToString("Motion") == true
        {
            aStrMessage = "Motion has been detected. 9-1-1 has been called."
        }
        else if alertDict.valueForKey("SensorType")?.isEqualToString("Gas") == true 
        {
            aStrMessage = "Harmful Gas Level has been detected. 9-1-1 has been called. Please Evacuate the area safely"
        } else
        {
            aStrMessage = "Fire has bee detected. 9-1-1 has been called. Please Evacuate the area safely"
        }
        
        let controller: MFMessageComposeViewController = MFMessageComposeViewController.init()
        
        if MFMessageComposeViewController.canSendText()
        {
            controller.body = aStrMessage
            controller.recipients = ["+1 405 588 7337"]
            controller.messageComposeDelegate = self
            self.presentViewController(controller, animated: true, completion: nil)
            
        }
    }
    
    func AlertViewShow (Title: String, Message: String, Delegate: UIAlertViewDelegate?) {
        
        
        let alert: UIAlertView = UIAlertView.init(title: Title, message: Message, delegate: Delegate, cancelButtonTitle: "OK")
        alert.show()
    }
    
    
    @IBAction func btnPhoneClick(sender: AnyObject) {
        
        let phoneNumber: String = "+1-405-588-7337" //dynamically assigned
        let phoneURLString: String = "tel: " + phoneNumber
        let phoneURL: NSURL = NSURL.init(string: phoneURLString)!
        UIApplication.sharedApplication().openURL(phoneURL)
        
    }
    
    @IBAction func btnAlarmClick (sender: AnyObject) {
        
        let nilAlertViewObject: UIAlertViewDelegate? = nil
        AlertViewShow("IOT Alert", Message: "Your emergency alarm is on", Delegate: nilAlertViewObject)
    }
    
    //Message compose delegate
    
    func messageComposeViewController (controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
        
        if result == MessageComposeResultCancelled
        {
            let nilAlertViewObject: UIAlertViewDelegate? = nil
            AlertViewShow("IOT Alert", Message: "Message cancelled", Delegate:nilAlertViewObject)
        }
        else if result == MessageComposeResultSent
        {
            let nilAlertViewObject: UIAlertViewDelegate? = nil
            AlertViewShow("IOT Alert", Message: "Message send", Delegate: nilAlertViewObject)
        }
        else
        {
            let nilAlertViewObject: UIAlertViewDelegate? = nil
            AlertViewShow("IOT Alert", Message: "Message Failed", Delegate: nilAlertViewObject)
        }
        
        
    }
    
    //Mail compose Delegate
    
    func mailComposeContoller (controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        if let checkIfErrorExists = error {
            let alrt: UIAlertView = UIAlertView.init(title: "IOT Alert", message: "Unable to send", delegate: nil, cancelButtonTitle: "")
            
            alrt.show()
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        else
        {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
}



