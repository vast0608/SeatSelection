//
//  NumberCell.h
//  SeatSelectionDemo
//
//  Created by 李晓璐 on 2018/11/3.
//  Copyright © 2018 LANEHUB. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectNumberDelegate <NSObject>

- (void)selectNumberWidthValue:(NSString *)value index:(NSInteger)index;

@end

@interface NumberCell : UITableViewCell

@property(nonatomic,weak)id<SelectNumberDelegate>   delegate;

@end

