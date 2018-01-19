//
//  ViewController.m
//  GDActionSheet
//
//  Created by 高东 on 2018/1/18.
//  Copyright © 2018年 gaodong. All rights reserved.
//

#import "ViewController.h"
#import "GDActionSheet.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)button1Click:(id)sender{
    GDActionSheet *sheet=[[GDActionSheet alloc]initWithTitle:@"提示" withTitleColor:[UIColor blackColor] withFont:[UIFont systemFontOfSize:17] withTitleheight:50];
    [sheet addButtonWithTitle:@"第一个" withRowheight:60 withTitleColor:[UIColor redColor] withExtra:@"这是副标题" withExtraColor:nil withIcon:[UIImage imageNamed:@"user_verify.png"] withHighIcon:nil block:^(void){
        
    }];
    [sheet addCancelButtonWithTitle:@"取消" withRowheight:45 withTitleColor:[UIColor blueColor] withblock:nil];
    [sheet showInView:nil];
    
}
-(IBAction)button2Click:(id)sender{
    
    
}
-(IBAction)button3Click:(id)sender{
    
    
}
-(IBAction)button4Click:(id)sender{
    
    
}
@end
