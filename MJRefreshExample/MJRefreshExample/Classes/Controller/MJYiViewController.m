//
//  MJYiViewController.m
//  MJRefreshExample
//
//  Created by Ying Yi on 14-7-11.
//  Copyright (c) 2014年 itcast. All rights reserved.
//  Email 517576002@qq.com

#import "MJYiViewController.h"
#import "MJYiDataSource.h"
#import "MJRefresh.h"
@interface MJYiViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *YiTable;
}
@property MJYiDataSource *DsOfPageListObject;

@end

@implementation MJYiViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.DsOfPageListObject = [[MJYiDataSource alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
    
    YiTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64) style:UITableViewStylePlain];
    [self.view addSubview:YiTable];
    YiTable.dataSource=self;
    YiTable.delegate=self;
    
    [self setupRefresh];
    
}
- (void)setupRefresh
{
    [YiTable addHeaderWithTarget:self action:@selector(headerRereshing)];
    [YiTable headerBeginRefreshing];
    
    [YiTable addFooterWithTarget:self action:@selector(footerRereshing)];
}

- (void)headerRereshing
{

    //    获得下一页的页码，请求的下一页的数据,如果是header刷新则重置
    [self.DsOfPageListObject reset];
    [self.DsOfPageListObject addPage];
    //刷新数据源，这里可以加入网络请求的代码，假如传入page参数，则请求服务器上第page页数据
    [self.DsOfPageListObject.dsArray addObjectsFromArray:[self getArrayFromNetwork:self.DsOfPageListObject.pageStruct.page]];
    //    停止刷新
    [YiTable headerEndRefreshing];
    [YiTable reloadData];
}

- (void)footerRereshing
{

    [self.DsOfPageListObject addPage];
    [self.DsOfPageListObject.dsArray addObjectsFromArray:[self getArrayFromNetwork:self.DsOfPageListObject.pageStruct.page]];
    [YiTable footerEndRefreshing];
    [YiTable reloadData];
}


//刷新数据源，这里可以加入网络请求的代码，假如传入page参数，则请求服务器上第page页数据
-(NSArray *)getArrayFromNetwork:(int)page{
    //    制造假数据
    NSMutableArray *arrayFromNetwork=[NSMutableArray arrayWithCapacity:1];
    for (int i = 0; i<10; i++) {
        [arrayFromNetwork addObject:[NSString stringWithFormat:@"这是第%d页的第%d条数据",page,i]];
    }

    return arrayFromNetwork;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.DsOfPageListObject.dsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentify = @"YiCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentify];
      
    }
    cell.textLabel.text=[self.DsOfPageListObject.dsArray objectAtIndex:indexPath.row];
    return cell;

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
