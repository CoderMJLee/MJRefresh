
#import "MJRefreshFooterView.h"
#import "MJRefreshHeaderView.h"

/**
 MJ友情提示：
 1. 添加头部控件的方法
 MJRefreshHeaderView *header = [MJRefreshHeaderView header];
 header.scrollView = self.collectionView; // 或者tableView
 
 2. 添加尾部控件的方法
 MJRefreshFooterView *footer = [MJRefreshFooterView footer];
 footer.scrollView = self.collectionView; // 或者tableView
 
 3. 监听刷新控件的状态有2种方式：
 * 设置delegate，通过代理方法监听(参考MJCollectionViewController.m)
 * 设置block，通过block回调监听(参考MJTableViewController.m)
 
 4. 可以在MJRefreshConst.h和MJRefreshConst.m文件中自定义显示的文字内容和文字颜色
 
 5. 本框架兼容iOS6\iOS7，iPhone\iPad横竖屏
 
 6.为了保证内部不泄露，最好在控制器的dealloc中释放占用的内存
    - (void)dealloc
    {
        [_header free];
        [_footer free];
    }
 
 7.自动刷新：调用beginRefreshing可以自动进入下拉刷新状态
 
 8.结束刷新
 1> endRefreshing
*/