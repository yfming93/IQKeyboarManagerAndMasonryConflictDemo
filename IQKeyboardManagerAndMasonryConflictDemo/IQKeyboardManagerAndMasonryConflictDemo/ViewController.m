//
//  ViewController.m
//  IQKeyboardManagerAndMasonryConflictDemo
//
//  Created by Mingo on 17/4/6.
//  Copyright © 2017年 Mingo. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>


@interface ViewController ()

@end

@implementation ViewController

#pragma mark - step 01
-(void)loadView { //不将 self.view 替换成 scrollView 会在点击底部输入框时 导航栏也一起往上跑。
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [scrollView setBackgroundColor:[UIColor grayColor]];
    self.view = scrollView;
}

/**  
 1.重写 loadView 方法 。把 self.view 替换成 scrollView。
 
 2.背景容器视图（back）必须设置。而且对 back 约束时 要附带 make.width.mas_equalTo(self.view);【不写导致 textField 布局的 make.right 失效】
 
 3.子控件要直接放在self.view 上。不能放在背景容器视图（back）上面。【放在 back上时会无法点击，无法成为第一响应】
 
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我是导航栏";

#pragma mark - step 02
    UIView  *back = [[UIView alloc] init];
    [self.view addSubview:back];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.edges.mas_equalTo(self.view);
        make.width.mas_equalTo(self.view); //此处必填 - 【关键点】 。不写导致 textField 布局的 make.right 失效。（但是布局textField 时使用 make.width不受这句话限制。）
    }];
    
    
    for (int i = 0 ; i < 30 ; i++) {
       
        UITextField *textField = [[UITextField alloc] init];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.placeholder =  [NSString stringWithFormat:@"%d请输入文字",i];
        
#pragma mark - step 03
        [self.view addSubview:textField];
//        [back addSubview:textField];       // textField 放在 back上时会无法点击，无法成为第一响应。
        
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.with.offset(20);
            make.right.with.offset(-20);
//            make.width.mas_equalTo(300);
            make.height.mas_equalTo(30);
            make.top.mas_equalTo(i *40+5);
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
