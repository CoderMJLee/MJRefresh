## MJRefresh
The easiest way to use pull-to-refresh

![(52326ce26803fabc46000000_18)](http://code4app.qiniudn.com/photo/52326ce26803fabc46000000_18.gif)

### 如何使用MJRefresh
---
* cocoapods导入：`pod 'MJRefresh'`
* 手动导入：
    * 将`MJRefreshExample/MJRefreshExample/MJRefresh`文件夹中的所有文件拽入项目中
    * 导入主头文件：`#import "MJRefresh.h"`
```objc
MJRefresh.bundle
MJRefresh.h
MJRefreshBaseView.h         MJRefreshBaseView.m
MJRefreshConst.h            MJRefreshConst.m
MJRefreshFooterView.h       MJRefreshFooterView.m
MJRefreshHeaderView.h       MJRefreshHeaderView.m
UIScrollView+MJExtension.h  UIScrollView+MJExtension.m
UIScrollView+MJRefresh.h    UIScrollView+MJRefresh.m
UIView+MJExtension.h        UIView+MJExtension.m
```

### 添加头部控件
---
```objc
[self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
```
或者
```objc
[self.tableView addHeaderWithCallback:^{ }];
```
 
### 添加尾部控件
---
```objc
[self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
```
或者
```objc
[self.tableView addFooterWithCallback:^{ }];
```

### 自动进入刷新状态
---
```objc
[self.tableView headerBeginRefreshing];
[self.tableView footerBeginRefreshing];
```
 
### 结束刷新
---
```objc
[self.tableView headerEndRefreshing];
[self.tableView footerEndRefreshing];
```

### 提醒
---
* 可以在MJRefreshConst.h和MJRefreshConst.m文件中自定义显示的文字内容和文字颜色
* 本框架兼容的系统>=iOS6.0，iPhone\iPad横竖屏

### 期待
---
* 如果在使用过程中遇到BUG，希望你能Issues我，谢谢
* 如果在使用过程中发现功能不够用，希望你能Issues我，我非常想为这个框架增加更多好用的功能，谢谢
* 如果你想为MJRefresh输出代码，请拼命Pull Requests我
