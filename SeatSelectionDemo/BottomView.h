//
//  BottomView.h
//  SeatSelectionDemo
//
//  Created by 李晓璐 on 2018/11/5.
//  Copyright © 2018 LANEHUB. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    BottomTipButton,//瓴里亲友点击弹窗
    BottomConfirmButton,//签到点击弹窗
}BottomButtonType;

@protocol BottomButtonDelegate <NSObject>

- (void)bottomButtonSelectTypt:(BottomButtonType)type callbackStr:(NSString *)str;

@end


#pragma mark--------提示按钮-------------

@interface TipsView : UIView

@property(nonatomic ,strong)UIButton *tipButton;//提示按钮

@property(nonatomic,weak)id<BottomButtonDelegate>   delegate;

@end




#pragma mark--------确认按钮-------------

@interface ConfirmView : UIView

@property(nonatomic ,strong)UIButton *confirmButton;//确认按钮
@property(nonatomic ,strong)TipsView *tipButtonView;//提示按钮

@property(nonatomic,weak)id<BottomButtonDelegate>   delegate;

//计算积分
-(void)calculatePointsWithUserPoints:(NSInteger)userPoints freezePoints:(NSInteger)freezePoints numberIndex:(NSInteger)numberIndex timeSelectArr:(NSArray *)timeSelectArr;

@end





