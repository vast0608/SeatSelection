//
//  DataCell.h
//  SeatSelectionDemo
//
//  Created by 李晓璐 on 2018/11/3.
//  Copyright © 2018 LANEHUB. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectDateDelegate <NSObject>

- (void)selectDateWidthValue:(NSString *)value index:(NSInteger)index;

@end

@interface DateCell : UITableViewCell

@property(nonatomic,weak)id<SelectDateDelegate>   delegate;

-(void)setDefaultSelect:(NSInteger)index;//默认选择的

@end

