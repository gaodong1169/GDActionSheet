//
//  GDActionSheet.m
//  GDActionSheet
//
//  Created by 高东 on 2018/1/18.
//  Copyright © 2018年 gaodong. All rights reserved.
//

#import "GDActionSheet.h"
#import "GDActionSheetCell.h"
#import "GDActionSheetModel.h"

#define GD_KScreenHeight [[UIScreen mainScreen] bounds].size.height
#define GD_KScreenWidth [[UIScreen mainScreen] bounds].size.width

@implementation GDActionSheet
@synthesize titlelabel;
@synthesize tableview;
@synthesize listData;
@synthesize titlestr;
@synthesize actionsPerIndexDic;


-(id)initWithTitle:(NSString*)title withTitleColor:(UIColor *)title_color withFont:(UIFont *)font withTitleheight:(float)title_height{
    self = [super init];
    if(self){
        
        self.frame = CGRectMake(0, 0, GD_KScreenWidth, GD_KScreenHeight);
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        
        actionsPerIndexDic=[[NSMutableDictionary alloc]initWithCapacity:0];
        listData=[[NSMutableArray alloc]initWithCapacity:0];
        

        titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, GD_KScreenHeight, GD_KScreenWidth, 0)];
        if(title&&![title isEqualToString:@""]){
            self.titlestr=title;
            
            titlelabel.frame=CGRectMake(0, GD_KScreenHeight, GD_KScreenWidth, title_height);
            titlelabel.backgroundColor=[UIColor whiteColor];
            titlelabel.textColor=title_color;
            titlelabel.font=font;
            titlelabel.textAlignment=NSTextAlignmentCenter;
            titlelabel.text=self.titlestr;
        }
        [self addSubview:titlelabel];
        
        
        tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, GD_KScreenHeight+titlelabel.frame.size.height, GD_KScreenWidth,0) style:UITableViewStylePlain];
        tableview.backgroundColor=[UIColor clearColor];
        tableview.dataSource = self;
        tableview.delegate = self;
        tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
        tableview.scrollEnabled = NO;
        [self addSubview:tableview];
    }
    return self;
}


-(void)addButtonWithTitle:(NSString *)sectiontitle withRowheight:(float)rowheight withTitleColor:(UIColor*)color withExtra:(NSString*)extra_title withExtraColor:(UIColor*)extra_color  withIcon:(UIImage*)image withHighIcon:(UIImage*)highImage block:(GDActionSheetBlock)block{
    
    GDActionSheetModel *model = [[GDActionSheetModel alloc]init];
    model.title = sectiontitle;
    model.rowheight=rowheight;
    model.extra_title=extra_title;
    model.iconimage=image;
    model.highiconimage=highImage;
    
    if(color){
        model.title_color=color;
    }else{
        model.title_color=[UIColor colorWithRed:37.0/255 green:48.0/255 blue:50.0/255 alpha:1.0];
    }
    
    if(extra_color){
        model.extra_title_color=extra_color;
    }else{
        model.extra_title_color=[UIColor colorWithRed:151.0/255 green:151.0/255 blue:151.0/255 alpha:1.0];
    }
    
    if(image||highImage){
        model.hasicon=YES;
    }
    [listData addObject:model];
    
    if(block){
        [self.actionsPerIndexDic setObject:[block copy] forKey:model.title];
    }
    
    float newtableheight=0;
    for(GDActionSheetModel *tmpmodel in listData){
        newtableheight=newtableheight+tmpmodel.rowheight;
    }
    tableview.frame=CGRectMake(tableview.frame.origin.x, tableview.frame.origin.y, tableview.frame.size.width, newtableheight);
    [self.tableview reloadData];
    
}

-(void)addCancelButtonWithTitle:(NSString *)canceltitle withRowheight:(float)rowheight withTitleColor:(UIColor*)color withblock:(GDActionSheetBlock)block{
    _cancelBlock=block;
    [self addButtonWithTitle:canceltitle withRowheight:rowheight withTitleColor:color withExtra:nil withExtraColor:nil withIcon:nil withHighIcon:nil block:block];
}

#pragma mark 动画效果
 -(void)animeData{
     UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
     tapGesture.delegate = self;
     [self addGestureRecognizer:tapGesture];
     
     [UIView animateWithDuration:0.15 animations:^{
         self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
         [UIView animateWithDuration:0.15 animations:^{
            CGRect tmprect=tableview.frame;
            [tableview setFrame:CGRectMake(tmprect.origin.x, GD_KScreenHeight-tmprect.size.height, tmprect.size.width, tmprect.size.height)];
            titlelabel.frame=CGRectMake(titlelabel.frame.origin.x, tableview.frame.origin.y-titlelabel.frame.size.height, titlelabel.frame.size.width, titlelabel.frame.size.height);
        }];
     }completion:^(BOOL finished){
         
     }];
 }


 - (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
     if([touch.view isKindOfClass:[self class]]){
         return YES;
     }
     return NO;
 }


 -(void)tappedCancel{
     [UIView animateWithDuration:0.15 animations:^{
         
         titlelabel.frame=CGRectMake(titlelabel.frame.origin.x, GD_KScreenHeight, titlelabel.frame.size.width, titlelabel.frame.size.height);
         [tableview setFrame:CGRectMake(tableview.frame.origin.x, GD_KScreenHeight+titlelabel.frame.size.height, tableview.frame.size.width, tableview.frame.size.height)];
         self.alpha = 0;
     }completion:^(BOOL finished) {
         if(finished){
             if(_cancelBlock!=nil) {
                 _cancelBlock();
             }
             [self removeFromSuperview];
         }
     }];
 }


- (void)showInView:(UIViewController *)Sview{
    [self animeData];
    if(Sview==nil){
        [[UIApplication sharedApplication].delegate.window addSubview:self];
        [[UIApplication sharedApplication].delegate.window bringSubviewToFront:self];
    }else{
        [Sview.view addSubview:self];
        [Sview.view bringSubviewToFront:self];
    }
}


#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [listData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row<[listData count]){
        GDActionSheetModel *model=(GDActionSheetModel*)[listData objectAtIndex:indexPath.row];
        if(model.rowheight>0){
            return model.rowheight;
        }
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    GDActionSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell==nil){
        cell = [[GDActionSheetCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.InfoLabel.text=nil;
    cell.leftView.image=nil;
    cell.lineimage.hidden=NO;
    if(listData&&[listData count]>1&&indexPath.row==0){
        if(self.titlestr&&![self.titlestr isEqualToString:@""]){
            cell.lineimage.hidden=NO;
        }else{
            cell.lineimage.hidden=YES;
        }
    }
    
    GDActionSheetModel *model=(GDActionSheetModel*)[listData objectAtIndex:indexPath.row];
    [cell setData:model];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self tappedCancel];
    
    GDActionSheetModel *model=[listData objectAtIndex:indexPath.row];
    for(NSString *keystr in self.actionsPerIndexDic){
        if([keystr isEqualToString:model.title]){
            GDActionSheetBlock block = [self.actionsPerIndexDic objectForKey:keystr];
            if (block){
                block();
            }
            break;
        }
    }
}

@end
