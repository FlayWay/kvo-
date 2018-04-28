//
//  NSObject+MYKOV.m
//  KVO
//
//  Created by ljkj on 2018/4/28.
//  Copyright © 2018年 ljkj. All rights reserved.
//

#import "NSObject+MYKOV.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (MYKOV)


- (void)MY_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context
{
    //1.自定义一个NSCCKVO_XXX子类
    //2.重写父类的setter,在内部恢复子类的做法,通知观察者
    //3.修改self的指针,指向新创建的NSCCKVO_XXX子类*
    //动态生成一个类
    NSString *oldClassName = NSStringFromClass([self class]);
    NSString *newClassName = [@"MY_" stringByAppendingString:oldClassName];
    const char *newName = newClassName.UTF8String;
    //定义一个类//参数1:继承的那个类 参数2:类名称
    Class myClass = objc_allocateClassPair([self class], newName, 0);
    //子类添加setter方法, 以setName为例  haha方法名
    class_addMethod(myClass, @selector(setName:),(IMP)haha, "v@:i");
    //注册这个类
    objc_registerClassPair(myClass);
    //修改self的isa指针
    object_setClass(self, myClass);

    //绑定observer到self对象中,将观察者绑定当前对象
    objc_setAssociatedObject(self, (__bridge const void *)@"objc", observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

void haha(id self, SEL _cmd, NSString *name){
    
    NSLog(@"test");
    //调用父类的sett方法
    Class class = [self class];
    //改变isa指针。为父类,调用set方法
    object_setClass(self, class_getSuperclass([self class]));

    objc_msgSend(self,@selector(setName:),name);

   id objc = objc_getAssociatedObject(self, (__bridge const void *)@"objc");
//通知观察者
    objc_msgSend(objc, @selector(observeValueForKeyPath:ofObject:change:context:),@"name",self,name,nil);
//改回子类类型
    object_setClass(self, class);
    
}



@end
