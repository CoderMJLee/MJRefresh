MJRefresh
=========

The easiest way to use pull-to-refresh

![(52326ce26803fabc46000000_18)](http://code4app.qiniudn.com/photo/52326ce26803fabc46000000_18.gif)

MJ友情提示
-----------
### 1.添加头部控件的方法
     [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
     或者
     [self.tableView addHeaderWithCallback:^{ }];
 
### 2.添加尾部控件的方法
     [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
     或者
     [self.tableView addFooterWithCallback:^{ }];
 
### 3.可以在MJRefreshConst.h和MJRefreshConst.m文件中自定义显示的文字内容和文字颜色
 
### 4.本框架兼容iOS6\iOS7，iPhone\iPad横竖屏
 
### 5.自动进入刷新状态
    [self.tableView headerBeginRefreshing];
    [self.tableView footerBeginRefreshing];
 
### 8.结束刷新
    [self.tableView headerEndRefreshing];
    [self.tableView footerEndRefreshing];
