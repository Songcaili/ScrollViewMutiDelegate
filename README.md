# ScrollViewMutiDelegate

通过方法交换的方式，扩展scrollView为多代理。
使任意的多个对象只要拿到View指针，便可以同时监听UIScrollView/UITableView/UICollectionView的代理事件，比如：
* scrollViewDidScroll:
* scrollViewDidEndDecelerating:
* tableView:willDisplayCell:forRowAtIndexPath:
