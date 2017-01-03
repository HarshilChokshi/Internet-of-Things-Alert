//
//  ListCell.m
//  IOT Alert
//
//  Created by Pooja Jalan on 03/07/15.
//  Copyright (c) 2015 Pooja Jalan. All rights reserved.
//

#import "ListCell.h"
#import "IOTAlert.pch"

@implementation ListCell

@synthesize lblInfo,lblSensType;
@synthesize imgSensor;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
}

-(void) displayAlertDataWithCell: (NSDictionary *) aAlertDict celltype: (ListCell *) cell {
    
    if ([[aAlertDict valueForKey:kSENSORTYPE] isEqualToString:kSensorTemp])
    {
    
        UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(85, 0, 163, 22)];
        [myLabel setBackgroundColor:[UIColor whiteColor]];
        [myLabel setText:@"Temperature Sensor"];
        [myLabel setTextColor:[UIColor colorWithRed:128/255.0f green:128/255.0f blue:128/255.0f alpha:1.0f]];
        //[myLabel setTextAlignment:NSTextAlignmentCenter];
        myLabel.font = [UIFont boldSystemFontOfSize:13];
        [cell addSubview:myLabel];
        
        UILabel *dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(85, 35, 200, 22)];
        [dateLabel setBackgroundColor:[UIColor whiteColor]];
        [dateLabel setText:[aAlertDict valueForKey:kSensorDate]];
        [dateLabel setTextColor:[UIColor colorWithRed:128/255.0f green:128/255.0f blue:128/255.0f alpha:1.0f]];
        dateLabel.font = [UIFont systemFontOfSize:12];
        [cell addSubview:dateLabel];
        
        
        UILabel *infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(85, 17, 200, 22)];
        [infoLabel setBackgroundColor:[UIColor whiteColor]];
        [infoLabel setText:[aAlertDict valueForKey:kALERT]];
        [infoLabel setTextColor:[UIColor colorWithRed:128/255.0f green:128/255.0f blue:128/255.0f alpha:1.0f]];
        infoLabel.font = [UIFont systemFontOfSize:12];
        [cell addSubview:infoLabel];
        
        if ([[aAlertDict valueForKey:kisChecked] isEqualToString:@"True"])
        {
        
            UIImageView *sensorImage = [[UIImageView alloc] initWithFrame:CGRectMake(2, 3, 75, 57)];
            sensorImage.image = [UIImage imageNamed:@"temp_icon_gray"];
            sensorImage.contentMode = UIViewContentModeScaleAspectFit;
            [cell addSubview:sensorImage];
        }
        
        else
        {
            UIImageView *sensorImage = [[UIImageView alloc] initWithFrame:CGRectMake(2, 3, 75, 57)];
            sensorImage.image = [UIImage imageNamed:@"temp_icon"];
            sensorImage.contentMode = UIViewContentModeScaleAspectFit;
            [cell addSubview:sensorImage];
        }
    }
    
    else if ([[aAlertDict valueForKey:kSENSORTYPE] isEqualToString:kSensorHumidity])
    {
        
        UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(85, 0, 163, 22)];
        [myLabel setBackgroundColor:[UIColor whiteColor]];
        [myLabel setText:@"Humidity Sensor"];
        [myLabel setTextColor:[UIColor colorWithRed:128/255.0f green:128/255.0f blue:128/255.0f alpha:1.0f]];
        //[myLabel setTextAlignment:NSTextAlignmentCenter];
        myLabel.font = [UIFont boldSystemFontOfSize:13];
        [cell addSubview:myLabel];
        
        UILabel *dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(85, 35, 200, 22)];
        [dateLabel setBackgroundColor:[UIColor whiteColor]];
        [dateLabel setText:[aAlertDict valueForKey:kSensorDate]];
        [dateLabel setTextColor:[UIColor colorWithRed:128/255.0f green:128/255.0f blue:128/255.0f alpha:1.0f]];
        dateLabel.font = [UIFont systemFontOfSize:12];
        [cell addSubview:dateLabel];
        
        
        UILabel *infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(85, 17, 200, 22)];
        [infoLabel setBackgroundColor:[UIColor whiteColor]];
        [infoLabel setText:[aAlertDict valueForKey:kALERT]];
        [infoLabel setTextColor:[UIColor colorWithRed:128/255.0f green:128/255.0f blue:128/255.0f alpha:1.0f]];
        infoLabel.font = [UIFont systemFontOfSize:12];
        [cell addSubview:infoLabel];
        
        if ([[aAlertDict valueForKey:kisChecked] isEqualToString:@"True"])
        {
            
            UIImageView *sensorImage = [[UIImageView alloc] initWithFrame:CGRectMake(2, 3, 75, 57)];
            sensorImage.image = [UIImage imageNamed:@"humi_icon_gray"];
            sensorImage.contentMode = UIViewContentModeScaleAspectFit;
            [cell addSubview:sensorImage];
        }
        
        else
        {
            UIImageView *sensorImage = [[UIImageView alloc] initWithFrame:CGRectMake(2, 3, 75, 57)];
            sensorImage.image = [UIImage imageNamed:@"humi_icon"];
            sensorImage.contentMode = UIViewContentModeScaleAspectFit;
            [cell addSubview:sensorImage];
        }
        
    }
    
    else if ([[aAlertDict valueForKey:kSENSORTYPE] isEqualToString:kSensorMotion])
    {
        
        UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(85, 0, 163, 22)];
        [myLabel setBackgroundColor:[UIColor whiteColor]];
        [myLabel setText:@"Motion Sensor"];
        [myLabel setTextColor:[UIColor colorWithRed:128/255.0f green:128/255.0f blue:128/255.0f alpha:1.0f]];
        //[myLabel setTextAlignment:NSTextAlignmentCenter];
        myLabel.font = [UIFont boldSystemFontOfSize:13];
        [cell addSubview:myLabel];
        
        UILabel *dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(85, 35, 200, 22)];
        [dateLabel setBackgroundColor:[UIColor whiteColor]];
        [dateLabel setText:[aAlertDict valueForKey:kSensorDate]];
        [dateLabel setTextColor:[UIColor colorWithRed:128/255.0f green:128/255.0f blue:128/255.0f alpha:1.0f]];
        dateLabel.font = [UIFont systemFontOfSize:12];
        [cell addSubview:dateLabel];
        
        
        UILabel *infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(85, 17, 200, 22)];
        [infoLabel setBackgroundColor:[UIColor whiteColor]];
        [infoLabel setText:[aAlertDict valueForKey:kALERT]];
        [infoLabel setTextColor:[UIColor colorWithRed:128/255.0f green:128/255.0f blue:128/255.0f alpha:1.0f]];
        infoLabel.font = [UIFont systemFontOfSize:12];
        [cell addSubview:infoLabel];
        
        if ([[aAlertDict valueForKey:kisChecked] isEqualToString:@"True"])
        {
            
            UIImageView *sensorImage = [[UIImageView alloc] initWithFrame:CGRectMake(2, 3, 75, 57)];
            sensorImage.image = [UIImage imageNamed:@"motion_icon_gray"];
            sensorImage.contentMode = UIViewContentModeScaleAspectFit;
            [cell addSubview:sensorImage];
        }
        
        else
        {
            UIImageView *sensorImage = [[UIImageView alloc] initWithFrame:CGRectMake(2, 3, 75, 57)];
            sensorImage.image = [UIImage imageNamed:@"motion_icon"];
            sensorImage.contentMode = UIViewContentModeScaleAspectFit;
            [cell addSubview:sensorImage];
        }
        
    }
    
    else if ([[aAlertDict valueForKey:kSENSORTYPE] isEqualToString:kSensorGas])
    {
        
        UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(85, 0, 163, 22)];
        [myLabel setBackgroundColor:[UIColor whiteColor]];
        [myLabel setText:@"Gas Sensor"];
        [myLabel setTextColor:[UIColor colorWithRed:128/255.0f green:128/255.0f blue:128/255.0f alpha:1.0f]];
        //[myLabel setTextAlignment:NSTextAlignmentCenter];
        myLabel.font = [UIFont boldSystemFontOfSize:13];
        [cell addSubview:myLabel];
        
        UILabel *dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(85, 35, 200, 22)];
        [dateLabel setBackgroundColor:[UIColor whiteColor]];
        [dateLabel setText:[aAlertDict valueForKey:kSensorDate]];
        [dateLabel setTextColor:[UIColor colorWithRed:128/255.0f green:128/255.0f blue:128/255.0f alpha:1.0f]];
        dateLabel.font = [UIFont systemFontOfSize:12];
        [cell addSubview:dateLabel];
        
        
        UILabel *infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(85, 17, 200, 22)];
        [infoLabel setBackgroundColor:[UIColor whiteColor]];
        [infoLabel setText:[aAlertDict valueForKey:kALERT]];
        [infoLabel setTextColor:[UIColor colorWithRed:128/255.0f green:128/255.0f blue:128/255.0f alpha:1.0f]];
        infoLabel.font = [UIFont systemFontOfSize:12];
        [cell addSubview:infoLabel];
        
        if ([[aAlertDict valueForKey:kisChecked] isEqualToString:@"True"])
        {
            
            UIImageView *sensorImage = [[UIImageView alloc] initWithFrame:CGRectMake(2, 3, 75, 57)];
            sensorImage.image = [UIImage imageNamed:@"gas_icon_gray"];
            sensorImage.contentMode = UIViewContentModeScaleAspectFit;
            [cell addSubview:sensorImage];
        }
        
        else
        {
            UIImageView *sensorImage = [[UIImageView alloc] initWithFrame:CGRectMake(2, 3, 75, 57)];
            sensorImage.image = [UIImage imageNamed:@"gas_icon"];
            sensorImage.contentMode = UIViewContentModeScaleAspectFit;
            [cell addSubview:sensorImage];
        }
        
    }
    
    else if ([[aAlertDict valueForKey:kSENSORTYPE] isEqualToString:kSensorFlame])
    {
        
        UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(85, 0, 163, 22)];
        [myLabel setBackgroundColor:[UIColor whiteColor]];
        [myLabel setText:@"Fire Sensor"];
        [myLabel setTextColor:[UIColor colorWithRed:128/255.0f green:128/255.0f blue:128/255.0f alpha:1.0f]];
        //[myLabel setTextAlignment:NSTextAlignmentCenter];
        myLabel.font = [UIFont boldSystemFontOfSize:13];
        [cell addSubview:myLabel];
        
        UILabel *dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(85, 35, 200, 22)];
        [dateLabel setBackgroundColor:[UIColor whiteColor]];
        [dateLabel setText:[aAlertDict valueForKey:kSensorDate]];
        [dateLabel setTextColor:[UIColor colorWithRed:128/255.0f green:128/255.0f blue:128/255.0f alpha:1.0f]];
        dateLabel.font = [UIFont systemFontOfSize:12];
        [cell addSubview:dateLabel];
        
        
        UILabel *infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(85, 17, 200, 22)];
        [infoLabel setBackgroundColor:[UIColor whiteColor]];
        [infoLabel setText:[aAlertDict valueForKey:kALERT]];
        [infoLabel setTextColor:[UIColor colorWithRed:128/255.0f green:128/255.0f blue:128/255.0f alpha:1.0f]];
        infoLabel.font = [UIFont systemFontOfSize:12];
        [cell addSubview:infoLabel];
        
        if ([[aAlertDict valueForKey:kisChecked] isEqualToString:@"True"])
        {
            
            UIImageView *sensorImage = [[UIImageView alloc] initWithFrame:CGRectMake(2, 3, 75, 57)];
            sensorImage.image = [UIImage imageNamed:@"fire_icon_gray"];
            sensorImage.contentMode = UIViewContentModeScaleAspectFit;
            [cell addSubview:sensorImage];
        }
        
        else
        {
            UIImageView *sensorImage = [[UIImageView alloc] initWithFrame:CGRectMake(2, 3, 75, 57)];
            sensorImage.image = [UIImage imageNamed:@"fire_icon"];
            sensorImage.contentMode = UIViewContentModeScaleAspectFit;
            [cell addSubview:sensorImage];
        }
    }
    
    
}


- (void) displayAlertData:(NSDictionary *) aAlertDict {
    
    self.lblInfo.text = @"Microsoft Conference Room MPR2";
    
    NSArray *timeInfo = [[aAlertDict valueForKey:kALERT] componentsSeparatedByString:@"Time:"];
    
    
    NSString *aImgName = nil;
    
    if ([[aAlertDict valueForKey:kSENSORTYPE] isEqualToString:kSensorMotion]) {
        self.lblSensType.text = @"Motion Sensor";
        //        self.lblDate.text = [self monthNameFromDate:[timeInfo objectAtIndex:1]];
        
        if ([[aAlertDict valueForKey:kisChecked] isEqualToString:@"True"]) {
            
            aImgName = [[NSBundle mainBundle] pathForResource:@"motion_icon_gray" ofType:@"png"];
        }
        else {
            
            aImgName = [[NSBundle mainBundle] pathForResource:@"motion_icon" ofType:@"png"];
        }
        
        //        self.imgSensor.image=[UIImage imageNamed:@"motion_icon.png"];
    }else if ([[aAlertDict valueForKey:kSENSORTYPE] isEqualToString:kSensorTemp]) {
        self.lblSensType.text = @"Temp Sensor";
        self.lblSensType.textColor = [UIColor blackColor];
        //        self.lblDate.text = [self monthNameFromDate:[timeInfo objectAtIndex:1]];
        
        if ([[aAlertDict valueForKey:kisChecked] isEqualToString:@"True"]) {
            
            aImgName = [[NSBundle mainBundle] pathForResource:@"temp_icon_gray" ofType:@"png"];
        }
        else {
            
            aImgName = [[NSBundle mainBundle] pathForResource:@"temp_icon" ofType:@"png"];
        }
        
        //        self.imgSensor.image=[UIImage imageNamed:@"temp_icon.png"];
    }else if ([[aAlertDict valueForKey:kSENSORTYPE] isEqualToString:kSensorFlame]) {
        self.lblSensType.text = @"Flame Sensor";
        //        self.lblDate.text = [self monthNameFromDate:[timeInfo objectAtIndex:1]];
        
        if ([[aAlertDict valueForKey:kisChecked] isEqualToString:@"True"]) {
            
            aImgName = [[NSBundle mainBundle] pathForResource:@"fire_icon_gray" ofType:@"png"];
        }
        else {
            
            aImgName = [[NSBundle mainBundle] pathForResource:@"fire_icon" ofType:@"png"];
        }
        
        //        self.imgSensor.image=[UIImage imageNamed:@"fire_icon.png"];
    }else if ([[aAlertDict valueForKey:kSENSORTYPE] isEqualToString:kSensorGas]) {
        self.lblSensType.text = @"Gas Sensor";
        //        self.lblDate.text = [self monthNameFromDate:[timeInfo objectAtIndex:1]];
        
        if ([[aAlertDict valueForKey:kisChecked] isEqualToString:@"True"]) {
            
            aImgName = [[NSBundle mainBundle] pathForResource:@"gas_icon_gray" ofType:@"png"];
        }
        else {
            
            aImgName = [[NSBundle mainBundle] pathForResource:@"gas_icon" ofType:@"png"];
        }
        //        self.imgSensor.image=[UIImage imageNamed:@"gas_icon.png"];
    }else if([[aAlertDict valueForKey:kSENSORTYPE] isEqualToString:kSensorHumidity]){
        self.lblSensType.text = @"Humidity Sensor";
        //        self.lblDate.text = [self monthNameFromDate:[timeInfo objectAtIndex:1]];
        
        if ([[aAlertDict valueForKey:kisChecked] isEqualToString:@"True"]) {
            
            aImgName = [[NSBundle mainBundle] pathForResource:@"humi_icon_gray" ofType:@"png"];
        }
        else {
            
            aImgName = [[NSBundle mainBundle] pathForResource:@"humi_icon" ofType:@"png"];
        }
        //        self.imgSensor.image=[UIImage imageNamed:@"humi_icon.png"];
    }
    
    self.lblDate.text = [self _ConvertUTCTimeToLocalTimeWithFormat:[timeInfo objectAtIndex:1] LanguageCode:@"" CountryCode:@"" Formated:YES];
    
    __weak typeof(self.imgSensor) weakCellImg = self.imgSensor;
    
    
    if (aImgName != nil) {
        NSURL *file = [NSURL fileURLWithPath:aImgName];
        if (file) {
            
            [weakCellImg sd_setImageWithURL:file placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)  {
                weakCellImg.image=image ;
            }];
            
        }else {
            //        [self.actIndicator stopAnimating];
        }
        
    }else {
        
    }
}

-(NSString *)_ConvertUTCTimeToLocalTimeWithFormat:rfc3339DateTimeString LanguageCode:(NSString *)lgc CountryCode:(NSString *)ctc Formated:(BOOL) formated
{
    NSDateFormatter *sUserVisibleDateFormatter = nil;
    NSDateFormatter *sRFC3339DateFormatter = nil;
    
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    
    if (sRFC3339DateFormatter == nil)
    {
        sRFC3339DateFormatter = [[NSDateFormatter alloc] init];
        
        NSLocale *myPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:[NSString stringWithFormat:@"%@", timeZone]];
        
        [sRFC3339DateFormatter setLocale:myPOSIXLocale];
        //        [sRFC3339DateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
        [sRFC3339DateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
        [sRFC3339DateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    }
    
    // Convert the RFC 3339 date time string to an NSDate.
    NSDate *date = [sRFC3339DateFormatter dateFromString:rfc3339DateTimeString];
    
    if (formated == YES)
    {
        NSString *userVisibleDateTimeString;
        
        if (date != nil)
        {
            if (sUserVisibleDateFormatter == nil)
            {
                sUserVisibleDateFormatter = [[NSDateFormatter alloc] init];
                [sUserVisibleDateFormatter setDateStyle:NSDateFormatterMediumStyle];
                [sUserVisibleDateFormatter setTimeStyle:NSDateFormatterShortStyle];
                sUserVisibleDateFormatter.doesRelativeDateFormatting = YES;
            }
            
            // Convert the date object to a user-visible date string.
            userVisibleDateTimeString = [sUserVisibleDateFormatter stringFromDate:date];
            
            return userVisibleDateTimeString;
        }
    }
    
    return nil;
}

-(NSString *)monthNameFromDate:(NSString *)StrDate {
    
    if (!StrDate) return @"n/a";
    
    NSDateFormatter *sRFC3339DateFormatter = nil;
    
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    
    if (sRFC3339DateFormatter == nil)
    {
        sRFC3339DateFormatter = [[NSDateFormatter alloc] init];
        
        NSLocale *myPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:[NSString stringWithFormat:@"%@", timeZone]];
        
        [sRFC3339DateFormatter setLocale:myPOSIXLocale];
        //        [sRFC3339DateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
        [sRFC3339DateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [sRFC3339DateFormatter setTimeStyle:NSDateFormatterShortStyle];
        [sRFC3339DateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    }
    
    NSDate *aDate = [sRFC3339DateFormatter dateFromString:StrDate];
    
    //    format.timeStyle = NSDateFormatterMediumStyle;
    //    format.dateStyle = NSDateFormatterShortStyle;
    //    [format setDateFormat:@"MMM dd"];
    sRFC3339DateFormatter.doesRelativeDateFormatting = YES;
    NSString *createdDateStr = [sRFC3339DateFormatter stringFromDate:aDate];
    return createdDateStr;
}

@end
