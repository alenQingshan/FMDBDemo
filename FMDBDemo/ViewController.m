//
//  ViewController.m
//  FMDBDemo
//
//  Created by 刘青山 on 16/5/18.
//  Copyright © 2016年 刘青山. All rights reserved.
//

#import "ViewController.h"
#import "DBManager.h"
#import "DetailModel.h"
@interface ViewController ()
{
    DetailModel *_detailModel;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //增
    [[DBManager shareManager] insertDataWithDetailModel:_detailModel];
    //改
    [[DBManager shareManager] updateDataWithModel:_detailModel];
    //查
    [[DBManager shareManager] searchDataWithDetailModel:_detailModel];
    //删
    [[DBManager shareManager] deleteDataWithDetailModel:_detailModel];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
