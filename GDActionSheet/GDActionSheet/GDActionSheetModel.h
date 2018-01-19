//
//  GDActionSheetModel.h
//  GDActionSheet
//
//  Created by 高东 on 2018/1/18.
//  Copyright © 2018年 gaodong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface GDActionSheetModel : NSObject{
    UIImage *iconimage;
    UIImage *highiconimage;
    
    NSString *title;
    UIColor *title_color;
    
    NSString *extra_title;
    UIColor *extra_title_color;
    
    float rowheight;
    BOOL hasicon;
    
}

@property(nonatomic,strong)UIImage *iconimage;;
@property(nonatomic,strong)UIImage *highiconimage;
@property(nonatomic,assign)float rowheight;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)UIColor *title_color;
@property(nonatomic,strong)NSString *extra_title;
@property(nonatomic,strong)UIColor *extra_title_color;
@property(nonatomic,assign)BOOL hasicon;

@end
