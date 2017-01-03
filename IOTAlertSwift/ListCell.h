//
//  ListCell.h
//  IOT Alert
//
//  Created by Pooja Jalan on 03/07/15.
//  Copyright (c) 2015 Pooja Jalan. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ListCell : UITableViewCell{
    
}
@property (nonatomic,retain) IBOutlet UILabel *lblSensType;
@property (nonatomic,retain) IBOutlet UILabel *lblInfo;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (nonatomic,retain) IBOutlet UIImageView *imgSensor;

- (void) displayAlertData:(NSDictionary *) aAlertDict;
-(void) displayAlertDataWithCell: (NSDictionary *) aAlertDict celltype: (ListCell *) cell;

@end

