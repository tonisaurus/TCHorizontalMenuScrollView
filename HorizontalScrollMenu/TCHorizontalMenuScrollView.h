//
//  TCHorizontalMenuScrollView.h
//  HorizontalScrollMenu
//
//  Created by Toni Chau on 2/18/14.
//  Copyright (c) 2014 Toni Chau. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TCHorizontalMenuScrollView;

@protocol TCHorizontalMenuScrollViewDelegate <NSObject>

@optional
- (void)menuScrollView:(TCHorizontalMenuScrollView *)menu didSelectIndex:(NSInteger)index;

@end

@interface TCHorizontalMenuScrollView : UIScrollView

@property(nonatomic, retain) NSArray *items;
@property(nonatomic, assign) id<TCHorizontalMenuScrollViewDelegate> myDelegate;
@property(nonatomic) BOOL centersOnSelect;

- (void)setSelectedItem:(NSInteger)selectedItem;

@end
