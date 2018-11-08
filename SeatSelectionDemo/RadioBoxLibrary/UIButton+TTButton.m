//
//  UIButton+TTButton.m
//  RadioBoxDemo
//
//  Created by 李晓璐 on 2018/2/2.
//  Copyright © 2018年 onmmc. All rights reserved.
//

#import "UIButton+TTButton.h"
#import<objc/runtime.h>
@implementation UIButton (TTButton)

-(void)setBlock:(void(^)(UIButton*))block
{
    objc_setAssociatedObject(self,@selector(block), block,OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(click:)forControlEvents:UIControlEventTouchUpInside];
}

-(void(^)(UIButton*))block
{
    return objc_getAssociatedObject(self,@selector(block));
}

-(void)addTapBlock:(void(^)(UIButton*))block
{
    self.block= block;
    [self addTarget:self action:@selector(click:)forControlEvents:UIControlEventTouchUpInside];
}

-(void)click:(UIButton*)btn
{
    if(self.block) {
        self.block(btn);
    }
}

@end
