//
//  XYSearchBar.h
//  SearchBarDemo
//
//  Created by Ossey on 17/3/24.
//  Copyright © 2016年 xiaoyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class XYSearchBar;

@protocol XYSearchBarDelegate <NSObject>
@optional
- (BOOL)searchBarShouldBeginEditing:(XYSearchBar *)searchBar;
- (void)searchBarTextDidBeginEditing:(XYSearchBar *)searchBar;
- (BOOL)searchBarShouldEndEditing:(XYSearchBar *)searchBar;
- (void)searchBarTextDidEndEditing:(XYSearchBar *)searchBar;
- (void)searchBar:(XYSearchBar *)searchBar textDidChange:(NSString *)searchText;
- (BOOL)searchBar:(XYSearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
- (void)searchBarSearchButtonClicked:(XYSearchBar *)searchBar;
- (void)searchBarCancelButtonClicked:(XYSearchBar *)searchBar;
@end

@interface XYSearchBar : UIView

@property (nonatomic, copy)   NSString *text;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, copy)   NSString *placeholderText;
@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic, strong) UIImage *iconImage;
@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, assign) UITextBorderStyle textBorderStyle;
@property (nonatomic, assign) UIKeyboardType keyboardType;
@property (nonatomic, strong) UIView *inputAccessoryView;
@property (nonatomic, strong) UIView *inputView;
@property (nonatomic, readonly) BOOL isEditing;

@property (nonatomic, weak) id<XYSearchBarDelegate> delegate;

+ (instancetype)searchBarWithFrame:(CGRect)frame placeHodle:(NSString *)placeHodle;


@end

NS_ASSUME_NONNULL_END
