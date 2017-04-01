//
//  DetailViewController.m
//  CircleZoomView
//
//  Created by zlwl001 on 2017/4/1.
//  Copyright © 2017年 manman. All rights reserved.
//

#import "DetailViewController.h"
#import "PingInvertTransition.h"
@interface DetailViewController ()<UINavigationControllerDelegate>
{
    
    UIPercentDrivenInteractiveTransition *percentTransition;
}
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *imageview =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Device_Width, Device_Width)];
    imageview.image =[UIImage imageNamed:@"2"];
    [self.view addSubview:imageview];
    self.view.backgroundColor =[UIColor whiteColor];
   
    
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(popClick:)];
    
    self.button =[LxButton LXButtonWithTitle:@"" titleFont:nil Image:nil backgroundImage:nil backgroundColor:[UIColor clearColor] titleColor:nil frame:CGRectMake(Device_Width -90, Device_Height -160, 60, 60)];
    [self.view addSubview:self.button];
    self.button.layer.masksToBounds = YES;
    self.button.layer.cornerRadius = 30;
    
    UIScreenEdgePanGestureRecognizer *edgeGes = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(edgePan:)];
    edgeGes.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:edgeGes];
    
    self.view.backgroundColor =[UIColor whiteColor];
    
    
    UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(30, Device_Width +10, Device_Width - 60, Device_Height - Device_Width - 20)];
    label.text = @"这几天工作太忙人都累蒙了，去幼儿园接儿子刚下车把车门锁住了，钥匙也落车里。车内五岁的儿子还在睡觉。我用力拍车窗把儿子叫醒，";
    label.textColor = [UIColor colorWithRed:77/256.0 green:148.0/256.0 blue:192.0/256.0 alpha:1];
    label.numberOfLines = 0;
    [self.view addSubview:label];
}
-(void)popClick:(UIBarButtonItem *)item
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.delegate = self;
}
- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    return percentTransition;
}-(void)edgePan:(UIPanGestureRecognizer *)recognizer{
    CGFloat per = [recognizer translationInView:self.view].x / (self.view.bounds.size.width);
    per = MIN(1.0,(MAX(0.0, per)));
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        percentTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (recognizer.state == UIGestureRecognizerStateChanged){
        [percentTransition updateInteractiveTransition:per];
    }else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled){
        if (per > 0.3) {
            [percentTransition finishInteractiveTransition];
        }else{
            [percentTransition cancelInteractiveTransition];
        }
        percentTransition = nil;
    }
}


- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPop) {
        PingInvertTransition *pingInvert = [PingInvertTransition new];
        return pingInvert;
    }else{
        return nil;
    }
}


@end
