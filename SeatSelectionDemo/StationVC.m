//
//  StationVC.m
//  SeatSelectionDemo
//
//  Created by 李晓璐 on 2018/11/3.
//  Copyright © 2018 LANEHUB. All rights reserved.
//

#import "StationVC.h"
#import "DateCell.h"//日期cell
#import "NumberCell.h"//人数cell
#import "TimeCell.h"//时间cell
#import "TipsViewCell.h"//提示的cell
#import "BottomView.h"//底部按钮
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#define Key(A, B) [NSString stringWithFormat:@"A%ld_B%ld",(long)A,(long)B]
@interface StationVC ()<UITableViewDelegate,UITableViewDataSource,SelectDateDelegate,SelectNumberDelegate,SelectTimeDelegate,BottomButtonDelegate>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)TimeCell  *timeCell;

@property(nonatomic ,strong)TipsView *tipView;//提示按钮
@property(nonatomic ,strong)ConfirmView *confirmView;//确认按钮

@property(nonatomic ,assign)NSInteger dateSelectIndex;//选择日期
@property(nonatomic ,assign)NSInteger numberSelectIndex;//选择人数
@property(nonatomic ,assign)NSInteger userPoints;//用户总积分
@property(nonatomic ,assign)NSInteger freezePoints;//冻结积分
@end

@implementation StationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预定享座";
    self.view.backgroundColor = [UIColor whiteColor];
    //创建tableview
    [self creatTableview];
    //创建底部按钮
    [self creatBottomView];
    
    self.dateSelectIndex = 2;
    self.numberSelectIndex = 0;
    self.userPoints = 400;
    self.freezePoints = 0;
}

#pragma mark----底部按钮的创建方法
-(void)creatBottomView{
    //提示按钮
    _tipView = [[TipsView alloc]initWithFrame:CGRectMake(0, HEIGHT-95, WIDTH, 40)];
    _tipView.tag = 10001;
    _tipView.delegate = self;
    [self.view addSubview:_tipView];
    
    //确定按钮
    _confirmView = [[ConfirmView alloc]initWithFrame:CGRectMake(0, HEIGHT-54, WIDTH, 54)];
    [self.view addSubview:_confirmView];
    _confirmView.delegate = self;
    [_confirmView.confirmButton setTitle:@"积分不足" forState:0];
    
    __weak __typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.12 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //积分按钮的状态
        [weakSelf.confirmView calculatePointsWithUserPoints:self.userPoints freezePoints:self.freezePoints numberIndex:self.numberSelectIndex timeSelectArr:weakSelf.timeCell.selectMuArr];
    });
    
}

#pragma mark----tableview的代理
-(void)creatTableview{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-54)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[DateCell class] forCellReuseIdentifier:@"DateCell"];
    [self.tableView registerClass:[NumberCell class] forCellReuseIdentifier:@"NumberCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TipsViewCell" bundle:nil] forCellReuseIdentifier:@"TipsViewCell"];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        DateCell  *cell = (DateCell *)[tableView dequeueReusableCellWithIdentifier:@"DateCell"];
        if (cell == nil) {
            cell = [[DateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DateCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        [cell setDefaultSelect:self.dateSelectIndex];
        return cell;
    }else if (indexPath.row==1){
        NumberCell  *cell = (NumberCell *)[tableView dequeueReusableCellWithIdentifier:@"NumberCell"];
        if (cell == nil) {
            cell = [[NumberCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NumberCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }else if (indexPath.row==2){
        _timeCell = (TimeCell *)[tableView dequeueReusableCellWithIdentifier:@"TimeCell"];
        if (_timeCell == nil) {
            _timeCell = [[TimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TimeCell"];
        }
        _timeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _timeCell.delegate = self;
        return _timeCell;
    }
    TipsViewCell  *cell = (TipsViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TipsViewCell"];
    if (cell == nil) {
        cell = [[TipsViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TipsViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return (WIDTH-35)*4/17 + 67;
    }else if (indexPath.row==1){
        return (WIDTH-35)*2/17 + 52;
    }else if (indexPath.row==2){
        return (WIDTH-35)*6/17 + 102;
    }
    return 175;
}

#pragma mark---celld按钮点击的代理方法
//选择日期的代理方法
-(void)selectDateWidthValue:(NSString *)value index:(NSInteger)index{
    //更新时间按钮的状态
    [_timeCell updateButtonStstusWidthIsDefaultSelect:NO unSelectIndexArr:@[@(index)]];
    //积分按钮的状态
    self.dateSelectIndex = index;
    [_confirmView calculatePointsWithUserPoints:self.userPoints freezePoints:self.freezePoints numberIndex:self.numberSelectIndex timeSelectArr:self.timeCell.selectMuArr];
}
//选择人数的代理方法
-(void)selectNumberWidthValue:(NSString *)value index:(NSInteger)index{
    //更新时间按钮的状态
    [_timeCell updateButtonStstusWidthIsDefaultSelect:NO unSelectIndexArr:@[@(index)]];
    //积分按钮的状态
    self.numberSelectIndex = index;
    [_confirmView calculatePointsWithUserPoints:self.userPoints freezePoints:self.freezePoints numberIndex:self.numberSelectIndex timeSelectArr:self.timeCell.selectMuArr];
}
//选择时间的代理方法
-(void)selectIndexArr:(NSArray *)indexArr{
    //积分按钮的状态
    [_confirmView calculatePointsWithUserPoints:self.userPoints freezePoints:self.freezePoints numberIndex:self.numberSelectIndex timeSelectArr:self.timeCell.selectMuArr];
}
//底部按钮的点击事件代理
-(void)bottomButtonSelectTypt:(BottomButtonType)type callbackStr:(NSString *)str{
    if (type == BottomTipButton) {//提示按钮
        NSLog(@"-----%@",@"跳转积分说明");
    }else if (type == BottomConfirmButton){//确认按钮
        NSLog(@"-----%@",str);
    }
}

@end
