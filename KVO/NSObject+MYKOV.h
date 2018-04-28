//
//  NSObject+MYKOV.h
//  KVO
//
//  Created by ljkj on 2018/4/28.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MYKOV)

- (void)MY_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;

@end
