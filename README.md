## MJRefresh
The easiest way to use pull-to-refresh

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

## 具体用法
```objc
* 由于这个框架的功能较多，就不写具体文字描述其用法
* 大家可以直接参考示例中的JTableViewController和MJCollectionViewController，更为直观快速
```
 
## 下拉刷新01-传统
![(下拉刷新01-传统)](http://images.cnitblog.com/blog2015/497279/201503/061058415392353.gif)
 
## 下拉刷新02-动画图片
![(下拉刷新02-动画图片)](http://images.cnitblog.com/blog2015/497279/201503/061058471802342.gif)
 
## 下拉刷新03-隐藏时间
![(下拉刷新03-隐藏时间)](http://images.cnitblog.com/blog2015/497279/201503/061058524778760.gif)
 
## 下拉刷新04-隐藏状态和时间01
![(下拉刷新04-隐藏状态和时间01)](http://images.cnitblog.com/blog2015/497279/201503/061058576024893.gif)
 
## 下拉刷新05-隐藏状态和时间02
![(下拉刷新05-隐藏状态和时间02)](http://images.cnitblog.com/blog2015/497279/201503/061059030865069.gif)
 
## 下拉刷新06-自定义文字
![(下拉刷新06-自定义文字)](http://images.cnitblog.com/blog2015/497279/201503/061059084149730.gif)
 
## 上拉刷新01-传统
![(上拉刷新01-传统)](http://images.cnitblog.com/blog2015/497279/201503/061101472745361.gif)
 
## 上拉刷新02-动画图片
![(上拉刷新02-动画图片)](http://images.cnitblog.com/blog2015/497279/201503/061056372743988.gif)
 
## 上拉刷新03-隐藏状态01
![(上拉刷新03-隐藏状态01)](http://images.cnitblog.com/blog2015/497279/201503/061102028365517.gif)
 
## 上拉刷新04-隐藏状态02
![(上拉刷新04-隐藏状态02)](http://images.cnitblog.com/blog2015/497279/201503/061058093525085.gif)
 
## 上拉刷新05-全部加载完毕
![(上拉刷新05-全部加载完毕)](http://images.cnitblog.com/blog2015/497279/201503/061058172117420.gif)
 
## 上拉刷新06-禁止自动加载
![(上拉刷新06-禁止自动加载)](http://images.cnitblog.com/blog2015/497279/201503/061058237119539.gif)
 
## 上拉刷新07-自定义文字
![(上拉刷新07-自定义文字)](http://images.cnitblog.com/blog2015/497279/201503/061058299618115.gif)
 
## 上拉刷新08-加载后隐藏
![(上拉刷新08-加载后隐藏)](http://images.cnitblog.com/blog2015/497279/201503/061058360395406.gif)
 
## UICollectionView01-上下拉刷新
![(UICollectionView01-上下拉刷新)](http://images.cnitblog.com/blog2015/497279/201503/061103282897223.gif)


## 提醒
* 本框架兼容的系统>=iOS6.0，iPhone\iPad横竖屏

## 期待
* 如果在使用过程中遇到BUG，希望你能Issues我，谢谢
* 如果在使用过程中发现功能不够用，希望你能Issues我，我非常想为这个框架增加更多好用的功能，谢谢
* 如果你想为MJRefresh输出代码，请拼命Pull Requests我
