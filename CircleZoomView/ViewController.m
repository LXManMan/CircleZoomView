//
//  ViewController.m
//  CircleZoomView
//
//  Created by zlwl001 on 2017/4/1.
//  Copyright © 2017年 manman. All rights reserved.
//

#import "ViewController.h"
#import "MyCell.h"
#import "DetailViewController.h"
#import "PingTransition.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *data;

@end

@implementation ViewController
{
    CGFloat oldY;
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.delegate = self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tableview];
    self.data =[NSMutableArray arrayWithObjects:@"悟空和唐僧一起上某卫视非诚勿扰,悟空上台,24盏灯全灭。理由:1.没房没车只有一根破棍. ",@"下班回家路上，从一巷子经过，突然窜出一个持刀匪徒：抢劫！拿5000块钱！望着明晃晃的刀子，我实在不敢轻举妄动，于是掏出钱包扔给了他，他点了点头：好，上道！",@"这几天工作太忙人都累蒙了，去幼儿园接儿子刚下车把车门锁住了，钥匙也落车里。车内五岁的儿子还在睡觉。我用力拍车窗把儿子叫醒，",@"一个男人真正爱上你时，你会发现，咦，多了一个爸爸，假的爱上你时，你会发现，卧槽，多了一个儿子！", nil];
    
    self.button =[LxButton LXButtonWithTitle:@"" titleFont:nil Image:nil backgroundImage:nil backgroundColor:[UIColor colorWithRed:0.47 green:0.83 blue:0.98 alpha:1] titleColor:nil frame:CGRectMake(Device_Width -90, Device_Height -160, 60, 60)];
    [self.view addSubview:self.button];
    self.button.layer.masksToBounds = YES;
    self.button.layer.cornerRadius = 30;
    self.title = @"自定义转场";
    __weak ViewController *weakSelf =self;
    
    [self.button addClickBlock:^(UIButton *button) {
        
        DetailViewController *detailVc =[[DetailViewController alloc]init];
        [weakSelf.navigationController pushViewController:detailVc animated:YES];
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 130;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell) {
         cell = [[NSBundle mainBundle]loadNibNamed:@"MyCell" owner:self options:nil][0];
    }
    cell.label.text = self.data[arc4random()%4];

    cell.label.verticalAlignment = arc4random()%3;

    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *detailVc =[[DetailViewController alloc]init];
    [self.navigationController pushViewController:detailVc animated:YES];
}
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview =[[UITableView alloc]initWithFrame:CGRectMake(0, 0,Device_Width, Device_Height) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource  = self;
        
        [_tableview registerClass:[MyCell class] forCellReuseIdentifier:@"cell"];
        _tableview.tableFooterView =[UIView new];
    }
    return _tableview;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    oldY = scrollView.contentOffset.y;
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView.contentOffset.y > oldY) {
        
        
        [UIView animateWithDuration:0.3 animations:^{
            self.navigationController.navigationBar.transform =
            CGAffineTransformMakeTranslation(0, -64);
            
        }];
        
        ;
        
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.navigationController.navigationBar.transform =
            CGAffineTransformIdentity;
            
        }];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.transform = CGAffineTransformIdentity;
    
}

#pragma mark - UINavigationControllerDelegate
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
        
        PingTransition *ping = [PingTransition new];
        return ping;
    }else{
        return nil;
    }
}
@end
