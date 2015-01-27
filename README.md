## MJRefresh
The easiest way to use pull-to-refresh

![(52326ce26803fabc46000000_18)](http://code4app.qiniudn.com/photo/52326ce26803fabc46000000_18.gif)

### 添加头部控件
```objc
[self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
```
或者
```objc
[self.tableView addHeaderWithCallback:^{ }];
```
 
### 添加尾部控件
```objc
[self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
```
或者
```objc
[self.tableView addFooterWithCallback:^{ }];
```

### 自动进入刷新状态
```objc
[self.tableView headerBeginRefreshing];
[self.tableView footerBeginRefreshing];
```
 
### 结束刷新
```objc
[self.tableView headerEndRefreshing];
[self.tableView footerEndRefreshing];
```

### 其他
* 可以在MJRefreshConst.h和MJRefreshConst.m文件中自定义显示的文字内容和文字颜色
* 本框架兼容的系统>=iOS6.0，iPhone\iPad横竖屏
