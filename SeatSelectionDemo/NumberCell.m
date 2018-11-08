//
//  NumberCell.m
//  SeatSelectionDemo
//
//  Created by 李晓璐 on 2018/11/3.
//  Copyright © 2018 LANEHUB. All rights reserved.
//

#import "NumberCell.h"
#import "RadioBoxFun.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width

#define BUTTON_WIDTH (WIDTH-35)/4
#define BUTTON_HEIGHT (WIDTH-35)*2/17

@interface NumberCell()

@property(nonatomic,strong)NSArray *buttonArr;

@end

@implementation NumberCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupContent];
        
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return self;
}
-(void)setupContent{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, 50, 17)];
    titleLabel.text = @"人数";
    [self.contentView addSubview:titleLabel];
    
    NSArray *dateArr = @[@"1人",@"2人",@"3人",@"4人"];
    //单选布局
    RadioBoxFun *radioBox = [RadioBoxFun new];
    UIButton *btn0 =  [radioBox creatButton:CGRectMake(10, CGRectGetMaxY(titleLabel.frame)+15, BUTTON_WIDTH, BUTTON_HEIGHT) title:dateArr[0]];
    UIButton *btn1 =  [radioBox creatButton:CGRectMake(15+BUTTON_WIDTH, CGRectGetMaxY(titleLabel.frame)+15, BUTTON_WIDTH, BUTTON_HEIGHT) title:dateArr[1]];
    UIButton *btn2 =  [radioBox creatButton:CGRectMake(20+BUTTON_WIDTH*2, CGRectGetMaxY(titleLabel.frame)+15, BUTTON_WIDTH, BUTTON_HEIGHT) title:dateArr[2]];
    UIButton *btn3 =  [radioBox creatButton:CGRectMake(25+BUTTON_WIDTH*3, CGRectGetMaxY(titleLabel.frame)+15, BUTTON_WIDTH, BUTTON_HEIGHT) title:dateArr[3]];
    
    self.buttonArr = @[btn0,btn1,btn2,btn3];
    [radioBox radioBoxButtons:self.buttonArr  superView:self defultSelectedInde:0 callBack:^(NSInteger selectIndex, NSString *title) {
        [self.delegate selectNumberWidthValue:title index:selectIndex];
    }];
}

@end
