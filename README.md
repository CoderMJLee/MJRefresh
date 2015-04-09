## MJRefresh
* The easiest way to use pull-to-refresh
* 用法最简单的下拉刷新框架：一行代码搞定

## 支持哪些控件的刷新
* `UIScrollView`、`UITableView`、`UICollectionView`、`UIWebView`

## 如何使用MJRefresh
* cocoapods导入：`pod 'MJRefresh'`
* 手动导入：
    * 将`MJRefreshExample/MJRefreshExample/MJRefresh`文件夹中的所有文件拽入项目中
    * 导入主头文件：`#import "MJRefresh.h"`
```objc
MJRefresh.bundle
MJRefresh.h
MJRefreshComponent.h        MJRefreshComponent.m
MJRefreshConst.h            MJRefreshConst.m
MJRefreshFooter.h           MJRefreshFooter.m
MJRefreshGifFooter.h        MJRefreshGifFooter.m
MJRefreshGifHeader.h        MJRefreshGifHeader.m
MJRefreshHeader.h           MJRefreshHeader.m
MJRefreshLegendFooter.h     MJRefreshLegendFooter.m
MJRefreshLegendHeader.h     MJRefreshLegendHeader.m
UIScrollView+MJExtension.h  UIScrollView+MJExtension.m
UIScrollView+MJRefresh.h    UIScrollView+MJRefresh.m
UIView+MJExtension.h        UIView+MJExtension.m
```

## 有哪些App正在使用MJRefresh
![(App01)](http://images.cnitblog.com/blog2015/497279/201504/091535245558276.png)
![(App02)](http://images.cnitblog.com/blog2015/497279/201504/091535380555952.png)
![(App03)](http://images.cnitblog.com/blog2015/497279/201504/091535439466718.png)
* 其他可以关注：[M了个J-博客园](http://www.cnblogs.com/mjios/p/4409853.html)

## 具体用法
```objc
* 由于这个框架的功能较多，就不写具体文字描述其用法
* 大家可以直接参考示例中的MJTableViewController和MJCollectionViewController，更为直观快速
```
 
## 下拉刷新01-传统
![(下拉刷新01-传统)](http://images.cnitblog.com/blog2015/497279/201503/061058415392353.gif)
```objc
// 添加传统的下拉刷新
[self.tableView addLegendHeaderWithRefreshingBlock:^{
   // 进入刷新状态后会自动调用这个block
}];
或
// 添加传统的下拉刷新
// 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
[self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];

// 马上进入刷新状态
[self.tableView.header beginRefreshing];
```
 
## 下拉刷新02-动画图片
![(下拉刷新02-动画图片)](http://images.cnitblog.com/blog2015/497279/201503/061058471802342.gif)
```objc
// 添加动画图片的下拉刷新
// 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
[self.tableView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
// 设置普通状态的动画图片
[self.tableView.gifHeader setImages:idleImages forState:MJRefreshHeaderStateIdle];
// 设置即将刷新状态的动画图片（一松开就会刷新的状态）
[self.tableView.gifHeader setImages:pullingImages forState:MJRefreshHeaderStatePulling];
// 设置正在刷新状态的动画图片
[self.tableView.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStateRefreshing];
```
 
## 下拉刷新03-隐藏时间
![(下拉刷新03-隐藏时间)](http://images.cnitblog.com/blog2015/497279/201503/061058524778760.gif)
```objc
// 隐藏时间
self.tableView.header.updatedTimeHidden = YES;
```
 
## 下拉刷新04-隐藏状态和时间01
![(下拉刷新04-隐藏状态和时间01)](http://images.cnitblog.com/blog2015/497279/201503/061058576024893.gif)
```objc
// 隐藏时间
self.tableView.header.updatedTimeHidden = YES;
// 隐藏状态
self.tableView.header.stateHidden = YES;
```
 
## 下拉刷新05-隐藏状态和时间02
![(下拉刷新05-隐藏状态和时间02)](http://images.cnitblog.com/blog2015/497279/201503/061059030865069.gif)
 
## 下拉刷新06-自定义文字
![(下拉刷新06-自定义文字)](http://images.cnitblog.com/blog2015/497279/201503/081014254613179.gif)
```objc
// 设置文字
[self.tableView.header setTitle:@"Pull down to refresh" forState:MJRefreshHeaderStateIdle];
[self.tableView.header setTitle:@"Release to refresh" forState:MJRefreshHeaderStatePulling];
[self.tableView.header setTitle:@"Loading ..." forState:MJRefreshHeaderStateRefreshing];

// 设置字体
self.tableView.header.font = [UIFont systemFontOfSize:15];

// 设置颜色
self.tableView.header.textColor = [UIColor redColor];
```
 
## 上拉刷新01-传统
![(上拉刷新01-传统)](http://images.cnitblog.com/blog2015/497279/201503/061101472745361.gif)
```objc
// 添加传统的上拉刷新
[self.tableView addLegendFooterWithRefreshingBlock:^{
   // 进入刷新状态后会自动调用这个block
}];
或
// 添加传统的上拉刷新
// 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
[self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
```
 
## 上拉刷新02-动画图片
![(上拉刷新02-动画图片)](http://images.cnitblog.com/blog2015/497279/201503/061056372743988.gif)
```objc
// 添加动画图片的上拉刷新
// 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
[self.tableView addGifFooterWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

// 设置正在刷新状态的动画图片
self.tableView.gifFooter.refreshingImages = refreshingImages;
```
 
## 上拉刷新03-隐藏状态01
![(上拉刷新03-隐藏状态01)](http://images.cnitblog.com/blog2015/497279/201503/061102028365517.gif)
```objc
// 隐藏状态
self.tableView.footer.stateHidden = YES;
```
 
## 上拉刷新04-隐藏状态02
![(上拉刷新04-隐藏状态02)](http://images.cnitblog.com/blog2015/497279/201503/061058093525085.gif)
 
## 上拉刷新05-全部加载完毕
![(上拉刷新05-全部加载完毕)](http://images.cnitblog.com/blog2015/497279/201503/061058172117420.gif)
```objc
// 变为没有更多数据的状态
[self.tableView.footer noticeNoMoreData];
```

## 上拉刷新06-禁止自动加载
![(上拉刷新06-禁止自动加载)](http://images.cnitblog.com/blog2015/497279/201503/061058237119539.gif)
```objc
// 禁止自动加载
self.tableView.footer.automaticallyRefresh = NO;
```
 
## 上拉刷新07-自定义文字
![(上拉刷新07-自定义文字)](http://images.cnitblog.com/blog2015/497279/201503/081014395552618.gif)
```objc
// 设置文字
[self.tableView.footer setTitle:@"Click or drag up to refresh" forState:MJRefreshFooterStateIdle];
[self.tableView.footer setTitle:@"Loading more ..." forState:MJRefreshFooterStateRefreshing];
[self.tableView.footer setTitle:@"No more data" forState:MJRefreshFooterStateNoMoreData];

// 设置字体
self.tableView.footer.font = [UIFont systemFontOfSize:17];

// 设置颜色
self.tableView.footer.textColor = [UIColor blueColor];
```
 
## 上拉刷新08-加载后隐藏
![(上拉刷新08-加载后隐藏)](http://images.cnitblog.com/blog2015/497279/201503/061058360395406.gif)
```objc
// 隐藏当前的上拉刷新控件
self.tableView.footer.hidden = YES;
```
 
## UICollectionView01-上下拉刷新
![(UICollectionView01-上下拉刷新)](http://images.cnitblog.com/blog2015/497279/201503/061103282897223.gif)
```objc
// 添加传统的下拉刷新
[self.collectionView addLegendHeaderWithRefreshingBlock:^{
   // 进入刷新状态后会自动调用这个block
}];
// 添加传统的上拉刷新
[self.collectionView addLegendFooterWithRefreshingBlock:^{
   // 进入刷新状态后会自动调用这个block
}];
```

## UIWebView01-下拉刷新
![(UIWebView01-下拉刷新)](http://ww1.sinaimg.cn/mw1024/800cdf9cjw1eq2zjzu78ng208w0fy4qp.gif)
```objc
// 添加下拉刷新控件
[self.webView.scrollView addLegendHeaderWithRefreshingBlock:^{
    // 进入刷新状态后会自动调用这个block
}];
```

## 提醒
* 本框架纯ARC，兼容的系统>=iOS6.0、iPhone\iPad横竖屏

## 期待
* 如果在使用过程中遇到BUG，希望你能Issues我，谢谢（或者尝试下载最新的框架代码看看BUG修复没有）
* 如果在使用过程中发现功能不够用，希望你能Issues我，我非常想为这个框架增加更多好用的功能，谢谢
* 如果你想为MJRefresh输出代码，请拼命Pull Requests我
* 一起携手打造天朝乃至世界最好用的刷新框架，做天朝程序员的骄傲
* 如果你开发的应用中用到了MJRefresh，希望你能到[CocoaControls](https://www.cocoacontrols.com/controls/mjrefresh)添加你应用的iTunes路径，我将会安装使用你的应用，并且根据众多应用的使用情况，对MJRefresh进行一个更好的设计和完善，提供更多好用的功能，谢谢
   * 步骤01（微信是举个例子，百度“你的应用名称 itunes”）
![(step01)](http://ww4.sinaimg.cn/mw1024/800cdf9ctw1eq0viiv5rsj20sm0ea41t.jpg)
   * 步骤02
![(step02)](http://ww2.sinaimg.cn/mw1024/800cdf9ctw1eq0vilejxlj20tu0me7a0.jpg)
   * 步骤03
![(step03)](http://ww1.sinaimg.cn/mw1024/800cdf9ctw1eq0viocpo5j20wc0dc0un.jpg)
   * 步骤04
![(step04)](http://ww3.sinaimg.cn/mw1024/800cdf9ctw1eq0vir137xj20si0gewgu.jpg)
