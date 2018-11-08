//
//  RadioBoxFun.h
//  RadioBoxDemo
//
//  Created by 李晓璐 on 2017/12/28.
//  Copyright © 2017年 onmmc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RadioBoxFun : NSObject

-(UIButton *)creatButton:(CGRect)fram title:(NSString *)title;

-(void)radioBoxButtons:(NSArray *)buttonArray superView:(UIView *)superView defultSelectedInde:(NSInteger)index callBack:(void (^)(NSInteger selectIndex ,NSString *title))callBack;

@end
