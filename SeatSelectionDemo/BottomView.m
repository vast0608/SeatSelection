//
//  BottomView.m
//  SeatSelectionDemo
//
//  Created by 李晓璐 on 2018/11/5.
//  Copyright © 2018 LANEHUB. All rights reserved.
//

#import "BottomView.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width


#pragma mark--------提示按钮-------------

@implementation TipsView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self creatView];
    }
    return self;
}
-(void)creatView{
    //提示按钮
    _tipButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
    _tipButton.backgroundColor = [UIColor whiteColor];
    [_tipButton setTitleColor:[UIColor redColor] forState:0];
    _tipButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
    _tipButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_tipButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    [self addSubview:_tipButton];
    [_tipButton addTarget:self action:@selector(tipButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 0.77)];
    lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:lineView];
}
-(void)tipButtonClick{
    [self.delegate bottomButtonSelectTypt:BottomTipButton callbackStr:nil];
}
@end




#pragma mark--------确认按钮-------------
@interface ConfirmView()

@property(nonatomic ,strong)NSArray *timeSelectArr;//确认按钮

@end
@implementation ConfirmView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self creatView];
    }
    return self;
}

-(void)creatView{
    //确定按钮
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 54)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomView];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, -1, WIDTH, 1)];
    lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [bottomView addSubview:lineView];
    
    _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 7, WIDTH-30, 40)];
    _confirmButton.layer.masksToBounds = YES;
    _confirmButton.layer.cornerRadius = 20;
    _confirmButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    [bottomView addSubview:_confirmButton];
    [_confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //提示按钮
    __weak __typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakSelf.tipButtonView = [self.superview viewWithTag:10001];
        weakSelf.tipButtonView.hidden = YES;
    });
}

//计算积分
-(void)calculatePointsWithUserPoints:(NSInteger)userPoints freezePoints:(NSInteger)freezePoints numberIndex:(NSInteger)numberIndex timeSelectArr:(NSArray *)timeSelectArr{
    
    self.timeSelectArr = timeSelectArr;
    
    NSInteger availablePoints = userPoints - freezePoints;//可用积分
    NSInteger calculatePoints = (numberIndex + 1) * timeSelectArr.count * 100;//计算的积分
    
    
    self.tipButtonView.hidden = YES;
    self.tipButtonView.tipButton.enabled = NO;
    if (availablePoints<100) {
        //提示语
        self.tipButtonView.hidden = NO;
        self.tipButtonView.tipButton.enabled = YES;
        [self.tipButtonView.tipButton setTitle:@"当前积分不足，点击查看如何赚取积分" forState:0];
        //确认按钮展示状态
        [_confirmButton setTitle:@"积分不足" forState:0];
        _confirmButton.backgroundColor = [UIColor lightGrayColor];
        _confirmButton.enabled = NO;
    }else{
        
        //-----提示语
        if (calculatePoints>availablePoints) {
            self.tipButtonView.hidden = NO;
            self.tipButtonView.tipButton.enabled = NO;
            if (freezePoints>0) {//有冻结积分
                [self.tipButtonView.tipButton setTitle:[NSString stringWithFormat:@"当前积分不足（已冻结 %ld 积分），请重新选择",(long)freezePoints] forState:0];
            }else{//无冻结积分
                [self.tipButtonView.tipButton setTitle:@"当前积分不足，请重新选择" forState:0];
            }
            
        }
        
        
        //----确认按钮展示状态
        if (timeSelectArr.count==0) {//一个时间段都不选
            [_confirmButton setTitle:@"开始预订" forState:0];
            _confirmButton.backgroundColor = [UIColor lightGrayColor];
            _confirmButton.enabled = NO;
        }
        else if (calculatePoints>availablePoints) {//选择的积分大于自身的积分
            [_confirmButton setTitle:@"积分不足" forState:0];
            _confirmButton.backgroundColor = [UIColor lightGrayColor];
            _confirmButton.enabled = NO;
        }
        else{//自身的积分多于已选的积分
            [_confirmButton setTitle:[NSString stringWithFormat:@"%ld 积分预定",(long)calculatePoints] forState:0];
            _confirmButton.backgroundColor = [UIColor blueColor];
            _confirmButton.enabled = YES;
        }
    }
    
}

//确认按钮的代理
-(void)confirmButtonClick{
    //数组元素升序
    NSArray *resultArr = [self.timeSelectArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    //判断
    if ([self suibian:resultArr]==YES) {
        [self.delegate bottomButtonSelectTypt:BottomConfirmButton callbackStr:[self timepPeriod:resultArr]];
    }else{
        NSLog(@"----数组不连续----");
    }
}
//判断数组元素是否连续
-(BOOL)suibian:(NSArray  *)arr{
    NSMutableArray *tempArr = [NSMutableArray array];
    for (int i = 1; i < arr.count; i ++) {
        if ([arr[i] integerValue] > [arr[i - 1] integerValue] ) {
            NSInteger max = [arr[i] integerValue];
            NSInteger min = [arr[i - 1] integerValue];
            if (max - min == 1) {
                [tempArr addObject:@""];
            }
        }
    }
    if (tempArr.count == arr.count-1) {
        return YES;//连续
    }else{
        return NO;//不连续
    }
}
//判断选择的连续时间
-(NSString *)timepPeriod:(NSArray *)timeSelectArr{
    NSArray *timeArr = @[
                     @[@"10:00",@"11:00"],
                     @[@"11:00",@"12:00"],
                     @[@"12:00",@"13:00"],
                     @[@"13:00",@"14:00"],
                     @[@"14:00",@"15:00"],
                     @[@"15:00",@"16:00"],
                     @[@"16:00",@"17:00"],
                     @[@"17:00",@"18:00"],
                     @[@"18:00",@"19:00"],
                     @[@"19:00",@"20:00"],
                     @[@"20:00",@"21:00"],
                     @[@"21:00",@"22:00"],
                     ];
    NSMutableArray *muArr = [NSMutableArray new];
    for (int i=0; i<timeSelectArr.count; i++) {
        for (int j=0; j<timeArr.count; j++) {
            if ([timeSelectArr[i] integerValue]==j) {
                [muArr addObjectsFromArray:timeArr[j]];
            }
        }
    }
    NSString *timeSrt = [NSString stringWithFormat:@"确定要预定 %@-%@\n时间段的工位吗？",muArr[0],muArr[muArr.count-1]];
    return timeSrt;
}

@end



