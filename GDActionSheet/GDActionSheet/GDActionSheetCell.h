//
//  GDActionSheetCell.h
//  GDActionSheet
//
//  Created by 高东 on 2018/1/18.
//  Copyright © 2018年 gaodong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDActionSheetModel.h"
@interface GDActionSheetCell : UITableViewCell{
    UIImageView *leftView;
    UILabel *InfoLabel;
    UILabel *extra_label;
    GDActionSheetModel *cellData;
    UIView *backgroundView;
    UIImageView *lineimage;
}
@property(nonatomic,strong)UIImageView *leftView;
@property(nonatomic,strong)UILabel *InfoLabel;
@property(nonatomic,strong)UILabel *extra_label;
@property(nonatomic,strong)GDActionSheetModel *cellData;
@property(nonatomic,strong)UIView *backgroundView;
@property(nonatomic,strong)UIImageView *lineimage;

-(void)setData:(GDActionSheetModel *)dicdata;
@end
