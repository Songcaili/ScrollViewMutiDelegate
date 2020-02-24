//
//  KKScrollEventProtocol.h
//  tableViewDemo
//
//  Created by scl on 2020/2/24.
//  Copyright © 2020 scl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 可以随用随扩展
@protocol KKScrollViewEventProtocol <NSObject>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
