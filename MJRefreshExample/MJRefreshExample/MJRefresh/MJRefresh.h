
#import "UIScrollView+MJRefresh.h"

/**
 MJ友情提示：
 1. 添加头部控件的方法
 [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
 或者
 [self.tableView addHeaderWithCallback:^{ }];
 
 2. 添加尾部控件的方法
 [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
 或者
 [self.tableView addFooterWithCallback:^{ }];
 
 3. 可以在MJRefreshConst.h和MJRefreshConst.m文件中自定义显示的文字内容和文字颜色
 
 4. 本框架兼容iOS6\iOS7，iPhone\iPad横竖屏
 
 5.自动进入刷新状态
 1> [self.tableView headerBeginRefreshing];
 2> [self.tableView footerBeginRefreshing];
 
 6.结束刷新
 1> [self.tableView headerEndRefreshing];
 2> [self.tableView footerEndRefreshing];
*/