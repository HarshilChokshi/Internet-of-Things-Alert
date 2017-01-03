import UIKit
import Foundation
import QuartzCore
import SystemConfiguration


class ListView: UIViewController {
    
    @IBOutlet var tblListView: UITableView!
    var mutArrAlertList: NSMutableArray!
    @IBOutlet var lblNoData: UILabel!
    //  @IBOutlet var btnEdit: UIButton
    @IBOutlet weak var View_Grid: UIView!
    @IBOutlet var noIntenretConnectionString: UILabel!
    let ApplicationDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
   
    
    
    
    
    func buttonAction (ClickedButton: UIButton) {
        
        print("Button Clicked")
        
        let btn: UIButton = ClickedButton
        
        if btn.selected
        {
            View_Grid.hidden = false
            btn.selected = false
            
            btn.setImage(UIImage.init(named: "List_icon.png"), forState: UIControlState.Normal)
            
        }
        else
        {
            
            View_Grid.hidden = true
            btn.selected = true
            btn.setImage(UIImage.init(named: "Grid_icon.png"), forState: UIControlState.Normal)
            tblListView.hidden = false
        }
    }
    
    @IBAction func btnGridSensorClick (sender: UIButton) {
        
        var aStrQuery: String = ""
        
        if sender.tag == 1021
        {
            //Temperature
            aStrQuery = "select * from SensorDetail where SensorType = 'Temperature' order by sensorDate DESC limit 1"
            print("Temperature button clicked")
        }
        else if sender.tag == 1022
        {
            //Humidity
            aStrQuery = "select * from SensorDetail where SensorType = 'Humidity' order by sensorDate DESC limit 1"
            print("Humidity button clicked")
        }
        else if sender.tag == 1023
        {
            //Gas
            aStrQuery = "select * from SensorDetail where SensorType = 'Gas' order by sensorDate DESC limit 1"
            print("Gas button clicked")
        }
        else if sender.tag == 1024
        {
            //Flame
            aStrQuery = "select * from SensorDetail where SensorType = 'Flame' order by sensorDate DESC limit 1"
            print("Flame button clicked")
        }
        else if sender.tag == 1025
        {
            //Motion
            aStrQuery = "select * from SensorDetail where SensorType = 'Motion' order by sensorDate DESC limit 1"
            print("Motion button clicked")
        }
        
        mutArrAlertList = Database.shareDatabase().SelectAllFromTable(aStrQuery)
        
        print("This is the array \(mutArrAlertList)")
        
        if mutArrAlertList.count > 0
        {
            self.performSegueWithIdentifier("DetailVC", sender: self.mutArrAlertList.objectAtIndex(0))
            
        }
        
        else
        {
            tblListView.hidden = true
            lblNoData.hidden = false
        }
    }
    
    func displayTableAsPerData () {
        
        
        
        if (view.viewWithTag(1030) as? UIButton)?.selected == true
        {
            
            
            if mutArrAlertList.count > 0
            {
                lblNoData.hidden = true
            }
            else
            {
                lblNoData.hidden = false
            }
        }
        else
        {
            
            if mutArrAlertList.count > 0
            {
                tblListView.hidden = false
                lblNoData.hidden = true
            }
            else
            {
                tblListView.hidden = true
                lblNoData.hidden = false
                
                
            }
        }
        
        
        tblListView.reloadData()
    }

    
    //mark Bounce Animation Function
    
    /*func addBounceAnim (sender: UIView) {
        
        let viewLayer: CALayer = sender.layer
        viewLayer.cornerRadius = 1.0
        let popInAnimation: CAKeyframeAnimation = CAKeyframeAnimation.init(keyPath: "transform.scale")
        popInAnimation.duration = 0.5
        let nilObject: AnyObject? = nil
        popInAnimation.values = NSArray(objects: NSNumber.init(float: 0.9), NSNumber.init(float: 1.1), NSNumber.init(float: 1.0), NSNumber.init(float: 1.0), nilObject!) as [AnyObject]
        popInAnimation.keyTimes =  NSArray(objects: NSNumber.init(float: 0.0), NSNumber.init(float: 0.4), NSNumber.init(float: 0.8), NSNumber.init(float: 1.0), nilObject!) as? [NSNumber]
        
        viewLayer.addAnimation(popInAnimation, forKey: "transform.scale")
    } */
    
    
    
    func SetTheBadgeIconOnGrid () {
        
        var badgePrdListHeader: SW_CustomBadge
        var btn: UIButton?
        var currentBadgeValue: Int32 = 0
        
        
        if ((NSUserDefaults.standardUserDefaults().valueForKey("Badge_Temp")!.intValue) > 0)
        {
            print("This is the value of temperature notification: \(NSUserDefaults.standardUserDefaults().valueForKey("Badge_Motion")!)")
            
            btn = self.view.viewWithTag(1021) as? UIButton
            
            currentBadgeValue = (NSUserDefaults.standardUserDefaults().valueForKey("Badge_Temp")!.intValue)!
            
            print("The value of current badge is: \(NSUserDefaults.standardUserDefaults().valueForKey("Badge_Temp")!.intValue)")
            
            if ((btn!.viewWithTag(btn!.tag+10) as? SW_CustomBadge) != nil)
            {
                
                (btn!.viewWithTag(btn!.tag+10) as? SW_CustomBadge)!.removeFromSuperview()
            }
            if btn != nil || currentBadgeValue != 0
            {
                print("This is the current badge value \(currentBadgeValue)")
                
                badgePrdListHeader = SW_CustomBadge.init(string: "\(currentBadgeValue)", withStringColor: UIColor.whiteColor(), withInsetColor: UIColor.init(red: 240.0/255.0, green: 64.0/255.0, blue: 61.0/255.0, alpha: 0.9), withBadgeFrame: false, withBadgeFrameColor: UIColor.whiteColor(), withScale: 1.0, withShining: false)
                
            
                badgePrdListHeader.tag = btn!.tag + 10
                badgePrdListHeader.frame = CGRectMake(btn!.frame.size.width - 10, 0, badgePrdListHeader.frame.size.width, badgePrdListHeader.frame.size.height)
                //self.addBounceAnim (badgePrdListHeader)
                badgePrdListHeader.userInteractionEnabled = false
                badgePrdListHeader.exclusiveTouch = false
                btn!.addSubview(badgePrdListHeader)
                
                
                let badgePrdListHeaderLabel: UILabel = UILabel()
                badgePrdListHeaderLabel.frame = CGRectMake(btn!.frame.size.width - 4, 0, badgePrdListHeader.frame.size.width/2, badgePrdListHeader.frame.size.height)
                badgePrdListHeaderLabel.text = "\(currentBadgeValue)"
                badgePrdListHeaderLabel.textAlignment = NSTextAlignment.Center
                badgePrdListHeaderLabel.textColor = UIColor.whiteColor()
                badgePrdListHeaderLabel.backgroundColor = UIColor.clearColor()
                btn!.addSubview(badgePrdListHeaderLabel)
                
            }
            
        }
            
           currentBadgeValue = 0
            
        if ((NSUserDefaults.standardUserDefaults().valueForKey("Badge_Motion")!.intValue) > 0)
        {
            
            
            btn = self.view.viewWithTag(1025) as? UIButton
            
            currentBadgeValue = (NSUserDefaults.standardUserDefaults().valueForKey("Badge_Motion")!.intValue)!
            
            if ((btn!.viewWithTag(btn!.tag+10) as? SW_CustomBadge) != nil)
            {
                
                (btn!.viewWithTag(btn!.tag+10) as? SW_CustomBadge)!.removeFromSuperview()
            }
            if btn != nil || currentBadgeValue != 0
            {
                badgePrdListHeader = SW_CustomBadge.init(string: "\(currentBadgeValue)", withStringColor: UIColor.whiteColor(), withInsetColor: UIColor.init(red: 240.0/255.0, green: 64.0/255.0, blue: 61.0/255.0, alpha: 0.9), withBadgeFrame: false, withBadgeFrameColor: UIColor.whiteColor(), withScale: 1.0, withShining: false)
                
                badgePrdListHeader.tag = btn!.tag + 10
                badgePrdListHeader.frame = CGRectMake(btn!.frame.size.width - 10, 0, badgePrdListHeader.frame.size.width, badgePrdListHeader.frame.size.height)
                //self.addBounceAnim (badgePrdListHeader)
                badgePrdListHeader.userInteractionEnabled = false
                badgePrdListHeader.exclusiveTouch = false
                btn!.addSubview(badgePrdListHeader)
                
                let badgePrdListHeaderLabel: UILabel = UILabel()
                badgePrdListHeaderLabel.frame = CGRectMake(btn!.frame.size.width - 4, 0, badgePrdListHeader.frame.size.width/2, badgePrdListHeader.frame.size.height)
                badgePrdListHeaderLabel.text = "\(currentBadgeValue)"
                badgePrdListHeaderLabel.textAlignment = NSTextAlignment.Center
                badgePrdListHeaderLabel.textColor = UIColor.whiteColor()
                badgePrdListHeaderLabel.backgroundColor = UIColor.clearColor()
                btn!.addSubview(badgePrdListHeaderLabel)
                
                
            }
            
        }
        
        currentBadgeValue = 0

        if ((NSUserDefaults.standardUserDefaults().valueForKey("Badge_Flame")?.intValue) > 0)
        {
            btn = self.view.viewWithTag(1024) as? UIButton
            
            currentBadgeValue = (NSUserDefaults.standardUserDefaults().valueForKey("Badge_Flame")?.intValue)!
            
            if ((btn!.viewWithTag(btn!.tag+10) as? SW_CustomBadge) != nil)
            {
                (btn!.viewWithTag(btn!.tag+10) as? SW_CustomBadge)!.removeFromSuperview()
            }
            if btn != nil || currentBadgeValue != 0
            {
                badgePrdListHeader = SW_CustomBadge.init(string: "\(currentBadgeValue)", withStringColor: UIColor.whiteColor(), withInsetColor: UIColor.init(red: 240.0/255.0, green: 64.0/255.0, blue: 61.0/255.0, alpha: 0.9), withBadgeFrame: false, withBadgeFrameColor: UIColor.whiteColor(), withScale: 1.0, withShining: false)
                
                badgePrdListHeader.tag = btn!.tag + 10
                badgePrdListHeader.frame = CGRectMake(btn!.frame.size.width - 8, 0, badgePrdListHeader.frame.size.width, badgePrdListHeader.frame.size.height)
                //self.addBounceAnim (badgePrdListHeader)
                badgePrdListHeader.userInteractionEnabled = false
                badgePrdListHeader.exclusiveTouch = false
                btn!.addSubview(badgePrdListHeader)
                
                let badgePrdListHeaderLabel: UILabel = UILabel()
                badgePrdListHeaderLabel.frame = CGRectMake(btn!.frame.size.width - 2, 0, badgePrdListHeader.frame.size.width/2, badgePrdListHeader.frame.size.height)
                badgePrdListHeaderLabel.text = "\(currentBadgeValue)"
                badgePrdListHeaderLabel.textAlignment = NSTextAlignment.Center
                badgePrdListHeaderLabel.textColor = UIColor.whiteColor()
                badgePrdListHeaderLabel.backgroundColor = UIColor.clearColor()
                btn!.addSubview(badgePrdListHeaderLabel)
                
                
            }
            
        }
        
        currentBadgeValue = 0
        
        if ((NSUserDefaults.standardUserDefaults().valueForKey("Badge_Humidity")?.intValue) > 0)
        {
            btn = self.view.viewWithTag(1022) as? UIButton
            
            currentBadgeValue = (NSUserDefaults.standardUserDefaults().valueForKey("Badge_Humidity")?.intValue)!
            
            if ((btn!.viewWithTag(btn!.tag+10) as? SW_CustomBadge) != nil)
            {
                (btn!.viewWithTag(btn!.tag+10) as? SW_CustomBadge)!.removeFromSuperview()
            }
            if btn != nil || currentBadgeValue != 0
            {
                badgePrdListHeader = SW_CustomBadge.init(string: "\(currentBadgeValue)", withStringColor: UIColor.whiteColor(), withInsetColor: UIColor.init(red: 240.0/255.0, green: 64.0/255.0, blue: 61.0/255.0, alpha: 0.9), withBadgeFrame: false, withBadgeFrameColor: UIColor.whiteColor(), withScale: 1.0, withShining: false)
                
                badgePrdListHeader.tag = btn!.tag + 10
                badgePrdListHeader.frame = CGRectMake(btn!.frame.size.width - 10, 2.5, badgePrdListHeader.frame.size.width, badgePrdListHeader.frame.size.height)
                //self.addBounceAnim (badgePrdListHeader)
                badgePrdListHeader.userInteractionEnabled = false
                badgePrdListHeader.exclusiveTouch = false
                btn!.addSubview(badgePrdListHeader)
                
                let badgePrdListHeaderLabel: UILabel = UILabel()
                badgePrdListHeaderLabel.frame = CGRectMake(btn!.frame.size.width - 4, 2, badgePrdListHeader.frame.size.width/2, badgePrdListHeader.frame.size.height)
                badgePrdListHeaderLabel.text = "\(currentBadgeValue)"
                badgePrdListHeaderLabel.textAlignment = NSTextAlignment.Center
                badgePrdListHeaderLabel.textColor = UIColor.whiteColor()
                badgePrdListHeaderLabel.backgroundColor = UIColor.clearColor()
                btn!.addSubview(badgePrdListHeaderLabel)
            }
            
        }
        
        currentBadgeValue = 0
        
        if ((NSUserDefaults.standardUserDefaults().valueForKey("Badge_Gas")?.intValue) > 0)
        {
            btn = self.view.viewWithTag(1023) as? UIButton
            
            currentBadgeValue = (NSUserDefaults.standardUserDefaults().valueForKey("Badge_Gas")?.intValue)!
            
            if ((btn!.viewWithTag(btn!.tag+10) as? SW_CustomBadge) != nil)
            {
                (btn!.viewWithTag(btn!.tag+10) as? SW_CustomBadge)!.removeFromSuperview()
            }
            if btn != nil || currentBadgeValue != 0
            {
                badgePrdListHeader = SW_CustomBadge.init(string: "\(currentBadgeValue)", withStringColor: UIColor.whiteColor(), withInsetColor: UIColor.init(red: 240.0/255.0, green: 64.0/255.0, blue: 61.0/255.0, alpha: 0.9), withBadgeFrame: false, withBadgeFrameColor: UIColor.whiteColor(), withScale: 1.0, withShining: false)
                
                badgePrdListHeader.tag = btn!.tag + 10
                badgePrdListHeader.frame = CGRectMake(btn!.frame.size.width - 15, -11, badgePrdListHeader.frame.size.width, badgePrdListHeader.frame.size.height)
                //self.addBounceAnim (badgePrdListHeader)
                badgePrdListHeader.userInteractionEnabled = false
                badgePrdListHeader.exclusiveTouch = false
                btn!.addSubview(badgePrdListHeader)
                
                let badgePrdListHeaderLabel: UILabel = UILabel()
                badgePrdListHeaderLabel.frame = CGRectMake(btn!.frame.size.width - 9, -11, badgePrdListHeader.frame.size.width/2, badgePrdListHeader.frame.size.height)
                badgePrdListHeaderLabel.text = "\(currentBadgeValue)"
                badgePrdListHeaderLabel.textAlignment = NSTextAlignment.Center
                badgePrdListHeaderLabel.textColor = UIColor.whiteColor()
                badgePrdListHeaderLabel.backgroundColor = UIColor.clearColor()
                btn!.addSubview(badgePrdListHeaderLabel)
                
                
            }
            
        }
        
        currentBadgeValue = 0
        
        
        if NSUserDefaults.standardUserDefaults().valueForKey("Badge_Temp")!.intValue == 0
        {
            if ((self.view.viewWithTag(1021 + 10) as? SW_CustomBadge) != nil)
            {
                (self.view.viewWithTag(1021+10) as? SW_CustomBadge)!.removeFromSuperview()
            }
        }
        if NSUserDefaults.standardUserDefaults().valueForKey("Badge_Motion")!.intValue == 0
        {
            if ((self.view.viewWithTag(1025+10) as? SW_CustomBadge) != nil)
            {
                (self.view.viewWithTag(1025+10) as? SW_CustomBadge)!.removeFromSuperview()
            }
        }
        if NSUserDefaults.standardUserDefaults().valueForKey("Badge_Flame")!.intValue == 0
        {
            if ((self.view.viewWithTag(1024+10) as? SW_CustomBadge) != nil)
            {
                (self.view.viewWithTag(1024+10) as? SW_CustomBadge)!.removeFromSuperview()
            }
        }
        if NSUserDefaults.standardUserDefaults().valueForKey("Badge_Humidity")!.intValue == 0
        {
            if ((self.view.viewWithTag(1022 + 10) as? SW_CustomBadge) != nil)
            {
                (self.view.viewWithTag(1022+10) as? SW_CustomBadge)!.removeFromSuperview()
            }
        }
        if NSUserDefaults.standardUserDefaults().valueForKey("Badge_Gas")!.intValue == 0
        {
            if ((self.view.viewWithTag(1023+10) as? SW_CustomBadge) != nil)
            {
                (self.view.viewWithTag(1023+10) as? SW_CustomBadge)!.removeFromSuperview()
            }
        }
        
        for var sbView: UIView in self.view.subviews {
            print("\(sbView)")
        }
        
    }
    
    
    //Tableview datasource and delegate methods
    
    func numberOfSectionsInTableView (tableView: UITableView) -> NSInteger {
        
        return 1
    }
    
    func tableView (tableView: UITableView, numberOfRowsInSection section: NSInteger) -> NSInteger{
        
        return mutArrAlertList.count
    }
    
    func tableView (tableView: UITableView, heightForRowIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 80
    }
    
    func tableView (tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier: String = "Cell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! ListCell
        
        //if cell == nil
        //{
            //let nib: NSArray = NSBundle.mainBundle().loadNibNamed("ListCell", owner: self, options: nil)
            //cell = (nib.objectAtIndex(0) as? ListCell)!
            
        //}
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        
        print("")
        print("This is cell: \(mutArrAlertList.objectAtIndex(indexPath.row) as! [NSObject : AnyObject])")
        
        //cell.displayAlertData(mutArrAlertList.objectAtIndex(indexPath.row) as!  [NSObject : AnyObject])
        cell.displayAlertDataWithCell(mutArrAlertList.objectAtIndex(indexPath.row) as!  [NSObject : AnyObject], celltype: cell)
        
        
        
        if indexPath.row == mutArrAlertList.count-1
        {
            if ApplicationDelegate.intPage > mutArrAlertList.count
            {
                //do nothing
            }
            else
            {
                ApplicationDelegate.intPage = ApplicationDelegate.intPage + 10
                self.reloadDataFromdb()
                
            }
        }
        
        return cell
    }
    
    func tableView (tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return true
    }
    
    func tableView (tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) -> Void {
        
        cell.backgroundColor = UIColor.clearColor()
    }
    
    func tableView (tableView: UITableViewCell, didSelectRowAtIndexPath indexPath: NSIndexPath) -> Void {
        
        self.performSegueWithIdentifier("DetailVC", sender: mutArrAlertList.objectAtIndex(indexPath.row))
    }
    
    func tableView (tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) -> Void {
        
        print("Data of Delete : \(mutArrAlertList.objectAtIndex(indexPath.row).objectForKey("id"))")
        
        let strqUERY: String = "Delete from SensorDetail where id=\(mutArrAlertList.objectAtIndex(indexPath.row).objectForKey("id")!)"
        
        print("String Of Delete : \(strqUERY)")
        Database.shareDatabase().Delete(strqUERY)
        mutArrAlertList.removeObjectAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
    }
    
    func reloadDataFromdb () {
        
        print("This is the count \(mutArrAlertList.count)")
        
        if mutArrAlertList.count > 0
        {
            mutArrAlertList.removeAllObjects()
        }
        
        tblListView.tableFooterView = UIView.init(frame: CGRectZero)
        
        let aStrQuery: String = "select * from SensorDetail order by sensorDate DESC limit \(ApplicationDelegate.intPage)"
        
        
        
        mutArrAlertList = Database.shareDatabase().SelectAllFromTable(aStrQuery)
       
        
        print("This is the mutual Array which equals: \(mutArrAlertList)")
        
        self.displayTableAsPerData()
        self.SetTheBadgeIconOnGrid()
    }
    
    func updateInternetConnectionLabel (internetInteger: Int) {
        if internetConnection == 0
        {
            noIntenretConnectionString.hidden = true
        }
        else
        {
            noIntenretConnectionString.alpha = 0
            
            let animationClosure = {() -> Void in
                self.noIntenretConnectionString.alpha = 1
            }
            
            UIView.animateWithDuration(3, animations: animationClosure)
            
            noIntenretConnectionString.hidden = false
            
        }

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"updateInternetConnectionLabel:" , name: noConnectionStringNotification, object: nil)
        
        
        self.navigationController!.navigationBarHidden = false
        
        let textAttributes: [String : AnyObject] = [
            NSForegroundColorAttributeName : UIColor(red: 147.0 / 255.0, green: 149.0 / 255.0, blue: 151.0 / 255.0, alpha: 1.0),
            NSBackgroundColorAttributeName : UIColor(red: 147.0 / 255.0, green: 149.0 / 255.0, blue: 151.0 / 255.0, alpha: 1.0)
        ]
        
        self.navigationController!.navigationBar.titleTextAttributes = textAttributes
        
        //self.title = "Alerts"
        
        mutArrAlertList = NSMutableArray()
        
        let button: UIButton = UIButton.init(type: UIButtonType.Custom)
        button.tag = 1030
        button.setImage(UIImage.init(named: "List_icon.png"), forState: UIControlState.Normal)
        button.addTarget(self, action: Selector("buttonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
        button.frame = CGRectMake(0, 0, 40, 40)
        
        let barButton: UIBarButtonItem = UIBarButtonItem.init(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        
        //    [[((UIButton *)[self.view viewWithTag:1021]) layer] setBorderColor:[[UIColor grayColor] CGColor]];
        //    [[((UIButton *)[self.view viewWithTag:1021]) layer] setBorderWidth:2.0f];
        //    [[((UIButton *)[self.view viewWithTag:1021]) layer] setCornerRadius:4.0f];
        //
        //    [[((UIButton *)[self.view viewWithTag:1022]) layer] setBorderColor:[[UIColor grayColor] CGColor]];
        //    [[((UIButton *)[self.view viewWithTag:1022]) layer] setBorderWidth:2.0f];
        //    [[((UIButton *)[self.view viewWithTag:1022]) layer] setCornerRadius:4.0f];
        //
        //    [[((UIButton *)[self.view viewWithTag:1023]) layer] setBorderColor:[[UIColor grayColor] CGColor]];
        //    [[((UIButton *)[self.view viewWithTag:1023]) layer] setBorderWidth:2.0f];
        //    [[((UIButton *)[self.view viewWithTag:1023]) layer] setCornerRadius:4.0f];
        //
        //    [[((UIButton *)[self.view viewWithTag:1024]) layer] setBorderColor:[[UIColor grayColor] CGColor]];
        //    [[((UIButton *)[self.view viewWithTag:1024]) layer] setBorderWidth:2.0f];
        //    [[((UIButton *)[self.view viewWithTag:1024]) layer] setCornerRadius:4.0f];
        //
        //    [[((UIButton *)[self.view viewWithTag:1025]) layer] setBorderColor:[[UIColor grayColor] CGColor]];
        //    [[((UIButton *)[self.view viewWithTag:1025]) layer] setBorderWidth:2.0f];
        //    [[((UIButton *)[self.view viewWithTag:1025]) layer] setCornerRadius:4.0f];
        
        // Do any additional setup after loading the view, typically from a nib
        
        
        self.tblListView.registerClass(ListCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.reloadDataFromdb()
        
        
        
        
        /*let networkReachability: Reachability = Reachability.reachabilityForInternetConnection()
        let networkStatus: NetworkStatus = networkReachability.currentReachabilityStatus()
        
        if networkStatus == NotReachable
        {
            noIntenretConnectionString.alpha = 0
            
            let animationClosure = {() -> Void in
            self.noIntenretConnectionString.alpha = 1
            }
            
            UIView.animateWithDuration(3, animations: animationClosure)
            
            noIntenretConnectionString.hidden = false
            
        }
        else
        {
            noIntenretConnectionString.hidden = true
        } */
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.navigationItem.backBarButtonItem!.title = ""
        
        self.navigationController!.navigationBar.tintColor = UIColor.init(red: 147.0/255.0, green: 149.0/255.0, blue: 151.0/255.0, alpha: 1.0)
        
        
        if (self.view.viewWithTag(1030) as? UIButton)?.selected == true
        {
            if segue.identifier == "DetailVC"
            {
                let detailVC: DetailVC = segue.destinationViewController as! DetailVC
                detailVC.alertDict = sender as! NSDictionary
                
                
            }
        }
        else
        {
            if segue.identifier == "DetailVC"
            {
                let detailVC: DetailVC = segue.destinationViewController as! DetailVC
                detailVC.alertDict = sender as! NSDictionary
            }
        }
            
    }
    
    
}
