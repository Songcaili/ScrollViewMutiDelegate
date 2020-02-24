//
//  KKADScrollViewDelegateDispatcher.h
//  tableViewDemo
//
//  Created by scl on 2020/2/20.
//  Copyright © 2020 scl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKScrollViewEventInterceptor : NSObject <UIScrollViewDelegate, UITableViewDelegate, UICollectionViewDelegate>

@property (nonatomic, weak) id delegate;

- (void)addScrollListener:(id)listener;

- (void)removeScrollListener:(id)listener;

@end

NS_ASSUME_NONNULL_END
