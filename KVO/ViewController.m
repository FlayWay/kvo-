//
//  ViewController.m
//  KVO
//
//  Created by ljkj on 2018/4/27.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "ViewController.h"
#import "Persion.h"
#import "NSObject+MYKOV.h"

@interface ViewController ()

@property (nonatomic, strong) Persion *p;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.p = [[Persion alloc]init];
//    [self.p addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    [self.p MY_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [_p willChangeValueForKey:@"name"];
    static  int a = 0;
    _p.name = [NSString stringWithFormat:@"%d",a++];
//    [_p didChangeValueForKey:@"name"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"%@监听到%@属性的改变为%@",object,keyPath,change);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
