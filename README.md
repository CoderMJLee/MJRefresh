## MJRefresh
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
![podversion](https://img.shields.io/cocoapods/v/MJRefresh.svg)

* An easy way to use pull-to-refresh

[📜✍🏻**Release Notes**: more details](https://github.com/CoderMJLee/MJRefresh/releases)

## Contents
* Getting Started
    * [Features【Support what kinds of controls to refresh】](#Support_what_kinds_of_controls_to_refresh)
    * [Installation【How to use MJRefresh】](#How_to_use_MJRefresh)
    * [Who's using【More than hundreds of Apps are using MJRefresh】](#More_than_hundreds_of_Apps_are_using_MJRefresh)
    * [Classes【The Class Structure Chart of MJRefresh】](#The_Class_Structure_Chart_of_MJRefresh)
* Comment API
	* [MJRefreshComponent.h](#MJRefreshComponent.h)
	* [MJRefreshHeader.h](#MJRefreshHeader.h)
	* [MJRefreshFooter.h](#MJRefreshFooter.h)
	* [MJRefreshAutoFooter.h](#MJRefreshAutoFooter.h)
* Examples
    * [Reference](#Reference)
    * [The drop-down refresh 01-Default](#The_drop-down_refresh_01-Default)
    * [The drop-down refresh 02-Animation image](#The_drop-down_refresh_02-Animation_image)
    * [The drop-down refresh 03-Hide the time](#The_drop-down_refresh_03-Hide_the_time)
    * [The drop-down refresh 04-Hide status and time](#The_drop-down_refresh_04-Hide_status_and_time)
    * [The drop-down refresh 05-DIY title](#The_drop-down_refresh_05-DIY_title)
    * [The drop-down refresh 06-DIY the control of refresh](#The_drop-down_refresh_06-DIY_the_control_of_refresh)
    * [The pull to refresh 01-Default](#The_pull_to_refresh_01-Default)
    * [The pull to refresh 02-Animation image](#The_pull_to_refresh_02-Animation_image)
    * [The pull to refresh 03-Hide the title of refresh status](#The_pull_to_refresh_03-Hide_the_title_of_refresh_status)
    * [The pull to refresh 04-All loaded](#The_pull_to_refresh_04-All_loaded)
    * [The pull to refresh 05-DIY title](#The_pull_to_refresh_05-DIY_title)
    * [The pull to refresh 06-Hidden After loaded](#The_pull_to_refresh_06-Hidden_After_loaded)
    * [The pull to refresh 07-Automatic back of the pull01](#The_pull_to_refresh_07-Automatic_back_of_the_pull01)
    * [The pull to refresh 08-Automatic back of the pull02](#The_pull_to_refresh_08-Automatic_back_of_the_pull02)
    * [The pull to refresh 09-DIY the control of refresh(Automatic refresh)](#The_pull_to_refresh_09-DIY_the_control_of_refresh(Automatic_refresh))
    * [The pull to refresh 10-DIY the control of refresh(Automatic back)](#The_pull_to_refresh_10-DIY_the_control_of_refresh(Automatic_back))
    * [UICollectionView01-The pull and drop-down refresh](#UICollectionView01-The_pull_and_drop-down_refresh)
    * [WKWebView01-The drop-down refresh](#WKWebView01-The_drop-down_refresh)
* [Hope](#Hope)

## <a id="Support_what_kinds_of_controls_to_refresh"></a>Support what kinds of controls to refresh
* `UIScrollView`、`UITableView`、`UICollectionView`、`WKWebView`

## <a id="How_to_use_MJRefresh"></a>How to use MJRefresh
* Installation with CocoaPods：`pod 'MJRefresh'`
* Installation with [Carthage](https://github.com/Carthage/Carthage)：`github "CoderMJLee/MJRefresh"`
* Manual import：
    * Drag All files in the `MJRefresh` folder to project
    * Import the main file：`#import "MJRefresh.h"`

```objc
Base                        Custom
MJRefresh.bundle            MJRefresh.h
MJRefreshConst.h            MJRefreshConst.m
UIScrollView+MJExtension.h  UIScrollView+MJExtension.m
UIScrollView+MJRefresh.h    UIScrollView+MJRefresh.m
UIView+MJExtension.h        UIView+MJExtension.m
```

## <a id="More_than_hundreds_of_Apps_are_using_MJRefresh"></a>More than hundreds of Apps are using MJRefresh
<img src="http://images0.cnblogs.com/blog2015/497279/201506/141212365041650.png" width="200" height="300">
* More information of App can focus on：[M了个J-博客园](http://www.cnblogs.com/mjios/p/4409853.html)

## <a id="The_Class_Structure_Chart_of_MJRefresh"></a>The Class Structure Chart of MJRefresh
![](http://images0.cnblogs.com/blog2015/497279/201506/132232456139177.png)
- `The class of red text` in the chart：You can use them directly
    - The drop-down refresh control types
        - Normal：`MJRefreshNormalHeader`
        - Gif：`MJRefreshGifHeader`
    - The pull to refresh control types
        - Auto refresh
            - Normal：`MJRefreshAutoNormalFooter`
            - Gif：`MJRefreshAutoGifFooter`
        - Auto Back
            - Normal：`MJRefreshBackNormalFooter`
            - Gif：`MJRefreshBackGifFooter`
- `The class of non-red text` in the chart：For inheritance，to use DIY the control of refresh
- About how to DIY the control of refresh，You can refer the Class in below Chart<br>
<img src="http://images0.cnblogs.com/blog2015/497279/201506/141358159107893.png" width="30%" height="30%">

## <a id="MJRefreshComponent.h"></a>MJRefreshComponent.h
```objc
/** The Base Class of refresh control */
@interface MJRefreshComponent : UIView
#pragma mark -  Control the state of Refresh 

/** BeginRefreshing */
- (void)beginRefreshing;
/** EndRefreshing */
- (void)endRefreshing; 
/** IsRefreshing */
- (BOOL)isRefreshing;

#pragma mark - Other
/** According to the drag ratio to change alpha automatically */
@property (assign, nonatomic, getter=isAutomaticallyChangeAlpha) BOOL automaticallyChangeAlpha;
@end
```

## <a id="MJRefreshHeader.h"></a>MJRefreshHeader.h
```objc
@interface MJRefreshHeader : MJRefreshComponent
/** Creat header */
+ (instancetype)headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;
/** Creat header */
+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

/** This key is used to storage the time that the last time of drown-down successfully */
@property (copy, nonatomic) NSString *lastUpdatedTimeKey;
/** The last time of drown-down successfully */
@property (strong, nonatomic, readonly) NSDate *lastUpdatedTime;

/** Ignored scrollView contentInset top */
@property (assign, nonatomic) CGFloat ignoredScrollViewContentInsetTop;
@end
```

## <a id="MJRefreshFooter.h"></a>MJRefreshFooter.h
```objc
@interface MJRefreshFooter : MJRefreshComponent
/** Creat footer */
+ (instancetype)footerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;
/** Creat footer */
+ (instancetype)footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

/** NoticeNoMoreData */
- (void)noticeNoMoreData;
/** ResetNoMoreData（Clear the status of NoMoreData ） */
- (void)resetNoMoreData;

/** Ignored scrollView contentInset bottom */
@property (assign, nonatomic) CGFloat ignoredScrollViewContentInsetBottom;
@end
```

## <a id="MJRefreshAutoFooter.h"></a>MJRefreshAutoFooter.h
```objc
@interface MJRefreshAutoFooter : MJRefreshFooter
/** Is Automatically Refresh(Default is Yes) */
@property (assign, nonatomic, getter=isAutomaticallyRefresh) BOOL automaticallyRefresh;

/** When there is much at the bottom of the control is automatically refresh(Default is 1.0，Is at the bottom of the control appears in full, will refresh automatically) */
@property (assign, nonatomic) CGFloat triggerAutomaticallyRefreshPercent;
@end
```

## <a id="Reference"></a>Reference
```objc
* Due to there are more functions of this framework，Don't write specific text describe its usage
* You can directly reference examples MJTableViewController、MJCollectionViewController、MJWebViewController，More intuitive and fast.
```
<img src="http://images0.cnblogs.com/blog2015/497279/201506/141345470048120.png" width="30%" height="30%">

## <a id="The_drop-down_refresh_01-Default"></a>The drop-down refresh 01-Default

```objc
self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
   //Call this Block When enter the refresh status automatically 
}];
或
// Set the callback（Once you enter the refresh status，then call the action of target，that is call [self loadNewData]）
self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];

// Enter the refresh status immediately
[self.tableView.mj_header beginRefreshing];
```
![(下拉刷新01-普通)](http://images0.cnblogs.com/blog2015/497279/201506/141204343486151.gif)

## <a id="The_drop-down_refresh_02-Animation_image"></a>The drop-down refresh 02-Animation image
```objc
// Set the callback（一Once you enter the refresh status，then call the action of target，that is call [self loadNewData]）
MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
// Set the ordinary state of animated images
[header setImages:idleImages forState:MJRefreshStateIdle];
// Set the pulling state of animated images（Enter the status of refreshing as soon as loosen）
[header setImages:pullingImages forState:MJRefreshStatePulling];
// Set the refreshing state of animated images
[header setImages:refreshingImages forState:MJRefreshStateRefreshing];
// Set header
self.tableView.mj_header = header;
```
![(下拉刷新02-动画图片)](http://images0.cnblogs.com/blog2015/497279/201506/141204402238389.gif)

## <a id="The_drop-down_refresh_03-Hide_the_time"></a>The drop-down refresh 03-Hide the time
```objc
// Hide the time
header.lastUpdatedTimeLabel.hidden = YES;
```
![(下拉刷新03-隐藏时间)](http://images0.cnblogs.com/blog2015/497279/201506/141204456132944.gif)

## <a id="The_drop-down_refresh_04-Hide_status_and_time"></a>The drop-down refresh 04-Hide status and time
```objc
// Hide the time
header.lastUpdatedTimeLabel.hidden = YES;

// Hide the status
header.stateLabel.hidden = YES;
```
![(下拉刷新04-隐藏状态和时间0)](http://images0.cnblogs.com/blog2015/497279/201506/141204508639539.gif)

## <a id="The_drop-down_refresh_05-DIY_title"></a>The drop-down refresh 05-DIY title
```objc
// Set title
[header setTitle:@"Pull down to refresh" forState:MJRefreshStateIdle];
[header setTitle:@"Release to refresh" forState:MJRefreshStatePulling];
[header setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];

// Set font
header.stateLabel.font = [UIFont systemFontOfSize:15];
header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];

// Set textColor
header.stateLabel.textColor = [UIColor redColor];
header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
```
![(下拉刷新05-自定义文字)](http://images0.cnblogs.com/blog2015/497279/201506/141204563633593.gif)

## <a id="The_drop-down_refresh_06-DIY_the_control_of_refresh"></a>The drop-down refresh 06-DIY the control of refresh
```objc
self.tableView.mj_header = [MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
// Implementation reference to MJDIYHeader.h和MJDIYHeader.m
```
![(下拉刷新06-自定义刷新控件)](http://images0.cnblogs.com/blog2015/497279/201506/141205019261159.gif)

## <a id="The_pull_to_refresh_01-Default"></a>The pull to refresh 01-Default
```objc
self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
    //Call this Block When enter the refresh status automatically
}];
或
// Set the callback（Once you enter the refresh status，then call the action of target，that is call [self loadMoreData]）
self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
```
![(上拉刷新01-默认)](http://images0.cnblogs.com/blog2015/497279/201506/141205090047696.gif)

## <a id="The_pull_to_refresh_02-Animation_image"></a>The pull to refresh 02-Animation image
```objc
// Set the callback（Once you enter the refresh status，then call the action of target，that is call [self loadMoreData]）
MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

// Set the refresh image
[footer setImages:refreshingImages forState:MJRefreshStateRefreshing];

// Set footer
self.tableView.mj_footer = footer;
```
![(上拉刷新02-动画图片)](http://images0.cnblogs.com/blog2015/497279/201506/141205141445793.gif)

## <a id="The_pull_to_refresh_03-Hide_the_title_of_refresh_status"></a>The pull to refresh 03-Hide the title of refresh status
```objc
// Hide the title of refresh status
footer.refreshingTitleHidden = YES;
// If does have not above method，then use footer.stateLabel.hidden = YES;
```
![(上拉刷新03-隐藏刷新状态的文字)](http://images0.cnblogs.com/blog2015/497279/201506/141205200985774.gif)

## <a id="The_pull_to_refresh_04-All_loaded"></a>The pull to refresh 04-All loaded
```objc
//Become the status of NoMoreData
[footer noticeNoMoreData];
```
![(上拉刷新04-全部加载完毕)](http://images0.cnblogs.com/blog2015/497279/201506/141205248634686.gif)

## <a id="The_pull_to_refresh_05-DIY_title"></a>The pull to refresh 05-DIY title
```objc
// Set title
[footer setTitle:@"Click or drag up to refresh" forState:MJRefreshStateIdle];
[footer setTitle:@"Loading more ..." forState:MJRefreshStateRefreshing];
[footer setTitle:@"No more data" forState:MJRefreshStateNoMoreData];

// Set font
footer.stateLabel.font = [UIFont systemFontOfSize:17];

// Set textColor
footer.stateLabel.textColor = [UIColor blueColor];
```
![(上拉刷新05-自定义文字)](http://images0.cnblogs.com/blog2015/497279/201506/141205295511153.gif)

## <a id="The_pull_to_refresh_06-Hidden_After_loaded"></a>The pull to refresh 06-Hidden After loaded
```objc
//Hidden current control of the pull to refresh
self.tableView.mj_footer.hidden = YES;
```
![(上拉刷新06-加载后隐藏)](http://images0.cnblogs.com/blog2015/497279/201506/141205343481821.gif)

## <a id="The_pull_to_refresh_07-Automatic_back_of_the_pull01"></a>The pull to refresh 07-Automatic back of the pull01
```objc
self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
```
![(上拉刷新07-自动回弹的上拉01)](http://images0.cnblogs.com/blog2015/497279/201506/141205392239231.gif)

## <a id="The_pull_to_refresh_08-Automatic_back_of_the_pull02"></a>The pull to refresh 08-Automatic back of the pull02
```objc
MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

// Set the normal state of the animated image
[footer setImages:idleImages forState:MJRefreshStateIdle];
//  Set the pulling state of animated images（Enter the status of refreshing as soon as loosen）
[footer setImages:pullingImages forState:MJRefreshStatePulling];
// Set the refreshing state of animated images
[footer setImages:refreshingImages forState:MJRefreshStateRefreshing];

// Set footer
self.tableView.mj_footer = footer;
```
![(上拉刷新07-自动回弹的上拉02)](http://images0.cnblogs.com/blog2015/497279/201506/141205441443628.gif)

## <a id="The_pull_to_refresh_09-DIY_the_control_of_refresh(Automatic_refresh)"></a>The pull to refresh 09-DIY the control of refresh(Automatic refresh)
```objc
self.tableView.mj_footer = [MJDIYAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
// Implementation reference to MJDIYAutoFooter.h和MJDIYAutoFooter.m
```
![(上拉刷新09-自定义刷新控件(自动刷新))](http://images0.cnblogs.com/blog2015/497279/201506/141205500195866.gif)

## <a id="The_pull_to_refresh_10-DIY_the_control_of_refresh(Automatic_back)"></a>The pull to refresh 10-DIY the control of refresh(Automatic back)
```objc
self.tableView.mj_footer = [MJDIYBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
// Implementation reference to MJDIYBackFooter.h和MJDIYBackFooter.m
```
![(上拉刷新10-自定义刷新控件(自动回弹))](http://images0.cnblogs.com/blog2015/497279/201506/141205560666819.gif)

## <a id="UICollectionView01-The_pull_and_drop-down_refresh"></a>UICollectionView01-The pull and drop-down refresh
```objc
// The drop-down refresh
self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
   //Call this Block When enter the refresh status automatically 
}];

// The pull to refresh
self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
   //Call this Block When enter the refresh status automatically
}];
```
![(UICollectionView01-上下拉刷新)](http://images0.cnblogs.com/blog2015/497279/201506/141206021603758.gif)

## <a id="WKWebView01-The_drop-down_refresh"></a>WKWebView01-The drop-down refresh
```objc
//Add the control of The drop-down refresh
self.webView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
   //Call this Block When enter the refresh status automatically
}];
```
![(UICollectionView01-上下拉刷新)](http://images0.cnblogs.com/blog2015/497279/201506/141206080514524.gif)

## Remind
* ARC
* iOS>=8.0
* iPhone \ iPad screen anyway

## 寻求志同道合的小伙伴

- 因本人工作忙，没有太多时间去维护MJRefresh，在此向广大框架使用者说声：非常抱歉！😞
- 现寻求志同道合的小伙伴一起维护此框架，有兴趣的小伙伴可以[发邮件](mailto:richermj123go@vip.qq.com)给我，非常感谢😊
- 如果一切OK，我将开放框架维护权限（github、pod等）
- 目前已经找到3位小伙伴(＾－＾)V
