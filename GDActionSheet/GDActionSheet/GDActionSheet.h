//
//  GDActionSheet.h
//  GDActionSheet
//
//  Created by 高东 on 2018/1/18.
//  Copyright © 2018年 gaodong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GDActionSheetBlock)(void);

@interface GDActionSheet : UIView<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>{
    UILabel *titlelabel;
    UITableView *tableview;
    NSMutableArray *listData;
    NSString *titlestr;
    NSMutableDictionary *actionsPerIndexDic;
    GDActionSheetBlock _cancelBlock;
}
@property(nonatomic,strong)UILabel *titlelabel;
@property(nonatomic,strong)NSString *titlestr;
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *listData;
@property(nonatomic,strong)NSMutableDictionary *actionsPerIndexDic;

-(id)initWithTitle:(NSString*)title withTitleColor:(UIColor *)title_color withFont:(UIFont *)font withTitleheight:(float)title_height;

-(void)addButtonWithTitle:(NSString *)sectiontitle withRowheight:(float)rowheight withTitleColor:(UIColor*)color withExtra:(NSString*)extra_title withExtraColor:(UIColor*)extra_color  withIcon:(UIImage*)image withHighIcon:(UIImage*)highImage block:(GDActionSheetBlock)block;

-(void)addCancelButtonWithTitle:(NSString *)canceltitle withRowheight:(float)rowheight withTitleColor:(UIColor*)color withblock:(GDActionSheetBlock)block;

- (void)showInView:(UIViewController *)Sview;
@end
