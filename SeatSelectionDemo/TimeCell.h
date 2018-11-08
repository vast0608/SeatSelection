//
//  TimeCell.h
//  SeatSelectionDemo
//
//  Created by 李晓璐 on 2018/11/3.
//  Copyright © 2018 LANEHUB. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectTimeDelegate <NSObject>

- (void)selectIndexArr:(NSArray *)indexArr;

@end

@interface TimeCell : UITableViewCell

@property (nonatomic, strong) NSMutableArray *selectMuArr;

@property(nonatomic,weak)id<SelectTimeDelegate>   delegate;


-(void)updateButtonStstusWidthIsDefaultSelect:(BOOL)defaultSelect unSelectIndexArr:(NSArray *)unSelectIndexArr;

@end

