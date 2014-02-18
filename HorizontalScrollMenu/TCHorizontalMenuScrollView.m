//
//  TCHorizontalMenuScrollView.m
//  HorizontalScrollMenu
//
//  Created by Toni Chau on 2/18/14.
//  Copyright (c) 2014 Toni Chau. All rights reserved.
//

#import "TCHorizontalMenuScrollView.h"

@interface TCHorizontalMenuScrollView()

@property(nonatomic ,assign) UIButton *selectedBtn;

@end

@implementation TCHorizontalMenuScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        [self setBackgroundColor:[UIColor darkGrayColor]];
        
        // Set centers on select
        self.centersOnSelect = YES;
    }
    return self;
}

- (void)dealloc
{
    self.items = nil;
    [_selectedBtn release];
    
    [super dealloc];
}

- (void)setItems:(NSArray *)items
{
    if (_items == items) {
        return;
    }
    [_items release];
    _items = [items retain];
    
    // Setup some variables
    CGFloat topMargin = 15.0f;
    CGFloat paddingX = 10.0f;
    CGFloat originX = 0.0f;
    int index = 0;
    
    for (NSString *item in items) {
        // Create button
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setContentEdgeInsets:UIEdgeInsetsMake(topMargin, paddingX/2.0f, 0.0f, paddingX/2.0f)];
        [btn setFrame:CGRectMake(originX, 0.0f, 0.0f, self.bounds.size.width)];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [btn setTitle:item forState:UIControlStateNormal];
        [btn sizeToFit];
        [btn addTarget:self action:@selector(itemSelected:) forControlEvents:UIControlEventTouchUpInside];
        
        originX += btn.bounds.size.width;
        
        [self addSubview:btn];
        
        // Set selected button initially to index 0
        if (index == 0) {
            _selectedBtn = btn;
            btn.selected = YES;
        }
        
        [btn setTag:index++];
    }
    
    [self setContentSize:CGSizeMake(originX, self.bounds.size.height)];
    
}

- (void)itemSelected:(UIButton *)sender
{
    if (sender != _selectedBtn) {
        _selectedBtn.selected = NO;
        sender.selected = YES;
        _selectedBtn = sender;
        
        [UIView animateWithDuration:0.4 animations:^{
            _selectedBtn.transform = CGAffineTransformMakeScale(1.5f, 1.5f);
            _selectedBtn.titleLabel.alpha = 0.2f;
            
        } completion:^(BOOL finished) {
            _selectedBtn.transform = CGAffineTransformIdentity;
            _selectedBtn.titleLabel.alpha = 1.0f;
            
            // Center selected item
            if (self.centersOnSelect) {
                CGFloat screenW = CGRectGetWidth(self.bounds);
                CGFloat x = _selectedBtn.frame.origin.x - screenW/2.0f + CGRectGetWidth(_selectedBtn.frame)/2.0f;
                
                // Check limits of x
                CGFloat max = self.contentSize.width - _selectedBtn.frame.origin.x/2.0f;
                if (x < 0) {
                    x = 0.0f;
                }
                else if (_selectedBtn.frame.origin.x >= max) {
                    x = self.contentSize.width - CGRectGetWidth(self.bounds);
                }
                
                [self setContentOffset:CGPointMake(x, 0) animated:YES];
                
            }
        }];
        
        // Notify the delegate
        if (self.myDelegate && [self.myDelegate respondsToSelector:@selector(menuScrollView:didSelectIndex:)]) {
            [self.myDelegate menuScrollView:self didSelectIndex:sender.tag];
        }
        
    }
}


- (void)setSelectedItem:(NSInteger)selectedItem
{
    UIButton *btn  =(UIButton *)[self viewWithTag:selectedItem];
//    [self scrollRectToVisible:[btn convertRect:btn.bounds toView:self] animated:YES];
    _selectedBtn.selected = NO;
    [btn setSelected:YES];
    _selectedBtn = btn;
    
}


@end
