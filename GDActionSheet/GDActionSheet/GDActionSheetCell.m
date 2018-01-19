//
//  GDActionSheetCell.m
//  GDActionSheet
//
//  Created by 高东 on 2018/1/18.
//  Copyright © 2018年 gaodong. All rights reserved.
//

#import "GDActionSheetCell.h"

#define GD_KScreenHeight [[UIScreen mainScreen] bounds].size.height
#define GD_KScreenWidth [[UIScreen mainScreen] bounds].size.width

@implementation GDActionSheetCell
@synthesize leftView;
@synthesize InfoLabel;
@synthesize extra_label;
@synthesize lineimage;
@synthesize backgroundView;
@synthesize cellData;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor whiteColor];
        
        // 创建需要的毛玻璃特效类型
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        effectView.alpha = 0.6f;
        effectView.frame = self.bounds;
        [self addSubview:effectView];
        
        
        cellData=[[GDActionSheetModel alloc]init];
        
        leftView = [[UIImageView alloc]init];
        leftView.backgroundColor=[UIColor clearColor];
        
        InfoLabel = [[UILabel alloc]init];
        InfoLabel.backgroundColor = [UIColor clearColor];
        InfoLabel.textAlignment=NSTextAlignmentCenter;
        InfoLabel.font=[UIFont systemFontOfSize:18];
        InfoLabel.textColor=[UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
        [self addSubview:leftView];
        [self addSubview:InfoLabel];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        extra_label=[[UILabel alloc]init];
        extra_label.backgroundColor=[UIColor clearColor];
        extra_label.textAlignment=NSTextAlignmentCenter;
        extra_label.font=[UIFont systemFontOfSize:10];
        extra_label.textColor=[UIColor colorWithRed:151.0/255 green:151.0/255 blue:151.0/255 alpha:1.0];
        extra_label.hidden=YES;
        [self addSubview:extra_label];
        
        lineimage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 0.5)];
        lineimage.backgroundColor=[UIColor colorWithRed:204.0/255 green:204.0/255 blue:204.0/255 alpha:1.0];
        [self addSubview:lineimage];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    frame.size.width = GD_KScreenWidth;
    [super setFrame:frame];
}

-(void)setData:(GDActionSheetModel *)dicdata{
    
    cellData = dicdata;
    
    self.InfoLabel.textColor=dicdata.title_color;
    self.extra_label.textColor=dicdata.extra_title_color;
    
    NSMutableDictionary *attributesDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:InfoLabel.font,NSFontAttributeName,nil];
    CGSize size =[dicdata.title boundingRectWithSize:CGSizeMake(GD_KScreenWidth-80, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributesDic context:nil].size;
    if(dicdata.hasicon){
        leftView.hidden=NO;
        leftView.image = cellData.iconimage;
        InfoLabel.text = cellData.title;
        leftView.frame=CGRectMake(GD_KScreenWidth/2-(size.width+10)/2-cellData.iconimage.size.width, (dicdata.rowheight-cellData.iconimage.size.height)/2, cellData.iconimage.size.width, cellData.iconimage.size.height);
        InfoLabel.frame=CGRectMake(leftView.frame.origin.x+leftView.frame.size.width, (dicdata.rowheight-20)/2, size.width+10, 20);
    }else{
        leftView.image = nil;
        leftView.hidden=YES;
        leftView.frame=CGRectMake(GD_KScreenWidth/2-size.width/2, (dicdata.rowheight-20)/2, 0, 0);
        InfoLabel.text = cellData.title;
        InfoLabel.frame=CGRectMake(GD_KScreenWidth/2-size.width/2-10, (dicdata.rowheight-20)/2, size.width+20, 20);
    }
    
    if(dicdata.extra_title&&![dicdata.extra_title isEqualToString:@""]){
        
        leftView.frame=CGRectMake(leftView.frame.origin.x, leftView.frame.origin.y-5, leftView.frame.size.width, leftView.frame.size.height);
        InfoLabel.frame=CGRectMake(InfoLabel.frame.origin.x, InfoLabel.frame.origin.y-5, InfoLabel.frame.size.width, InfoLabel.frame.size.height);
        
        extra_label.text=dicdata.extra_title;
        extra_label.hidden=NO;
        extra_label.frame=CGRectMake(15, InfoLabel.frame.origin.y+InfoLabel.frame.size.height+2, GD_KScreenWidth-30, 15);
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if(selected){
        self.backgroundColor =[UIColor colorWithRed:233.0/255 green:233.0/255 blue:233.0/255 alpha:1.0];
        if(cellData.hasicon){
            leftView.image = cellData.highiconimage;
        }
        
    }else{
        self.backgroundColor = [UIColor whiteColor];
        if(cellData.hasicon){
            leftView.image = cellData.iconimage;
        }
    }
    
}

@end
