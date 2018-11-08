//
//  ViewController.m
//  SeatSelectionDemo
//
//  Created by 李晓璐 on 2018/11/3.
//  Copyright © 2018 LANEHUB. All rights reserved.
//

#import "ViewController.h"
#import "StationVC.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)aaaa:(id)sender {
    StationVC *sVC = [StationVC new];
    [self.navigationController pushViewController:sVC animated:YES];
    
    /*
    NSArray *array = @[@(0),@(1),@(2)];
    if ([self isContinuous:array]==YES) {
        NSLog(@"连续");
    }else{
        NSLog(@"不连续");
    }
    */
}




-(BOOL)isContinuous:(NSArray  *)array{//判断数组下标是否连续
    NSArray *result = [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {//数组元素升序
        return [obj1 compare:obj2];
    }];
    NSMutableArray *tempArr = [NSMutableArray array];
    for (int i = 1; i < result.count; i ++) {
        if ([result[i] integerValue] > [result[i - 1] integerValue] ) {
            NSInteger max = [result[i] integerValue];
            NSInteger min = [result[i - 1] integerValue];
            if (max - min == 1) {
                [tempArr addObject:@""];
            }
        }
    }
    if (tempArr.count == array.count-1) {
        return YES;
    }else{
        return NO;
    }
}


@end
