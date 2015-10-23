//
//  ViewController.m
//  输入栏自适应键盘高度
//
//  Created by liulianqi on 15/10/21.
//  Copyright © 2015年 sunxianglong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UITextField *_textField;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _textField = [[UITextField alloc] init];
    _textField.frame = CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width, 40);
    _textField.backgroundColor = [UIColor orangeColor];
    _textField.placeholder = @"   测试 测试 测试 测试 测试 测试";
    [self.view addSubview:_textField];
    
    [self ListeningKeyboard ];
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark --注册监听键盘的通知
- (void)ListeningKeyboard{
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    

}
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    CGRect rect =   _textField.frame;
    rect.origin.y = rect.origin.y - height;
    _textField.frame = rect;
    
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    _textField.frame = CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width, 40);
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [_textField resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
