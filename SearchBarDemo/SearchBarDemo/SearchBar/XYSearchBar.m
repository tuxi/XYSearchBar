//
//  XYSearchBar.m
//  SearchBarDemo
//
//  Created by Ossey on 17/3/24.
//  Copyright © 2016年 xiaoyuan. All rights reserved.
//

#import "XYSearchBar.h"
#import "Masonry.h"

static const CGFloat SIZE_ICON_TOP_SEARCHBAR = 8.0f;
static const CGFloat SIZE_TF_TOP_SEARCHBAR = 4.0f;
static const CGFloat SIZE_PLACE_LEFT_SEARCHBAR = 30.0;
static const CGFloat SIZE_PLACE_RIGHT_SEARCHBAR = 16.0;
static const CGFloat SIZE_TF_RIGHT_SEARCHBAR = 6.0;

@interface XYSearchBar () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIImageView *searchIcon;
@property (nonatomic, strong) UIImageView *backgroundView;
@property (nonatomic, strong) UILabel *placeHolderLabel;
@property (nonatomic, strong) NSNumber *numCount;
@end

@implementation XYSearchBar

@synthesize textFont = _textFont;

#pragma mark - 初始化
+ (instancetype)searchBarWithFrame:(CGRect)frame placeHodle:(NSString *)placeHodle {
    XYSearchBar *searchBar = [[XYSearchBar alloc] initWithFrame:frame];
    [searchBar setPlaceholderText:placeHodle];
    return searchBar;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [self addSubview:self.textField];
    [self addSubview:self.searchIcon];
    [self addSubview:self.placeHolderLabel];
    [self addSubview:self.backgroundView];
    [self makeConstraints];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.textField.delegate = self;
}

#pragma mark - 布局子控件
- (void)makeConstraints {
    
    [self.searchIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.equalTo(self);
        make.top.equalTo(self).mas_offset(SIZE_ICON_TOP_SEARCHBAR);
        make.bottom.equalTo(self).mas_offset(-SIZE_ICON_TOP_SEARCHBAR);
        make.width.equalTo(self.searchIcon.mas_height);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(SIZE_PLACE_LEFT_SEARCHBAR);
        make.top.equalTo(self).mas_offset(SIZE_TF_TOP_SEARCHBAR);
        make.bottom.equalTo(self).mas_offset(-SIZE_TF_TOP_SEARCHBAR);
        make.right.equalTo(self).mas_offset(-SIZE_TF_RIGHT_SEARCHBAR);
    }];
    
    [self.placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textField);
        make.right.equalTo(self.textField).offset(-SIZE_PLACE_RIGHT_SEARCHBAR);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    MASAttachKeys(_searchIcon, _textField, _placeHolderLabel, _backgroundView);
    //    CGFloat margin = 7.0;
    //    NSDictionary *views = NSDictionaryOfVariableBindings(_textField, _iconView, _centerView, _cancelBtn);
    //    NSDictionary *metrics = @{@"tfLeftMargin": @(margin), @"tfTopMargin": @(margin), @"tfRightMargin": @(margin), @"tfHeight": @30, @"cancelBtnRight": @60, @"cancelBtnTop": @(margin), @"cancelBtnW": @60, @"cancelBtnH": @30};
    //    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_iconView]-[_textField]-tfRightMargin-[_cancelBtn(cancelBtnW)]|" options:kNilOptions metrics:metrics views:views]];
    //    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-tfTopMargin-[_textField]-tfTopMargin-|" options:kNilOptions metrics:metrics views:views]];
    //    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_iconView]-|" options:kNilOptions metrics:metrics views:views]];
    //    [self addConstraint:[NSLayoutConstraint constraintWithItem:_cancelBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:kNilOptions multiplier:0 constant:30]];
    //    [self.cancelBtn addConstraint:[NSLayoutConstraint constraintWithItem:self.cancelBtn attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    //    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.iconView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.iconView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
}



#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarShouldBeginEditing:)]) {
        return [self.delegate searchBarShouldBeginEditing:self];
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarTextDidBeginEditing:)]) {
        [self.delegate searchBarTextDidBeginEditing:self];
    }
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {

    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarShouldEndEditing:)])
    {
        return [self.delegate searchBarShouldEndEditing:self];
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarTextDidEndEditing:)]) {
        [self.delegate searchBarTextDidEndEditing:self];
    }
}
-(void)textFieldDidChange:(UITextField *)textField {
    [self placeholderHiddenWithEditor:NO];
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBar:textDidChange:)])
    {
        [self.delegate searchBar:self textDidChange:[self replacingNullStr:textField.text]];
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBar:shouldChangeTextInRange:replacementText:)]) {
        return [self.delegate searchBar:self shouldChangeTextInRange:range replacementText:string];
    }
    [self placeholderHiddenWithEditor:YES];
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBar:textDidChange:)])
    {
        [self.delegate searchBar:self textDidChange:@""];
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_textField resignFirstResponder];
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarSearchButtonClicked:)])
    {
        [self.delegate searchBarSearchButtonClicked:self];
    }
    return YES;
}


#pragma mark - lazy

- (UITextField *)textField {
    if (_textField == nil) {
        UITextField *textField = [UITextField new];
        textField.delegate = self;
        textField.borderStyle = UITextBorderStyleNone;
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textField.returnKeyType = UIReturnKeySearch;
        textField.enablesReturnKeyAutomatically = YES;
        textField.font = self.textFont;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        textField.backgroundColor = [UIColor clearColor];
        _textField = textField;
        
    }
    return _textField;
}

- (UIImageView *)searchIcon {
    if (_searchIcon == nil) {
        _searchIcon = [UIImageView new];
        _searchIcon.image = [UIImage imageNamed:@"icon_search"];
    }
    return _searchIcon;
}

- (UIImageView *)backgroundView {
    if (_backgroundView == nil) {
        _backgroundView = [UIImageView new];
        _backgroundView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _backgroundView;
}

- (UILabel *)placeHolderLabel {
    if (_placeHolderLabel == nil) {
        UILabel *placeLabel = [[UILabel alloc] init];
        placeLabel.backgroundColor = [UIColor clearColor];
        placeLabel.textAlignment = NSTextAlignmentLeft;
        placeLabel.textColor = [UIColor colorWithWhite:.5 alpha:.5];
        placeLabel.font = [UIFont systemFontOfSize:14];
        placeLabel.tag = 123456789;
        placeLabel.text = self.placeholderText;
        _placeHolderLabel = placeLabel;
    }
    return _placeHolderLabel;
}


#pragma mark - 属性设置

-(NSString *)text {
    return [self replacingNullStr:_textField.text];
}

-(void)setText:(NSString *)text{
    _textField.text = text ?: @"";
}

- (UIFont *)textFont {
    return _textFont ?: [UIFont systemFontOfSize:14.0f];
}

-(void)setTextFont:(UIFont *)textFont{
    _textFont = textFont;
    [_textField setFont:_textFont];
}

-(void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    [_textField setTextColor:_textColor];
}
-(void)setIconImage:(UIImage *)iconImage{
    _iconImage = iconImage;
    ((UIImageView*)_textField.leftView).image = _iconImage;
}

- (void)setPlaceholderText:(NSString *)placeholderText {
    _placeholderText = placeholderText;
    self.placeHolderLabel.text = placeholderText;

}

-(void)setBackgroundImage:(UIImage *)backgroundImage{
    _backgroundImage = backgroundImage;
    self.backgroundView.image = backgroundImage;
}
- (void)setTextBorderStyle:(UITextBorderStyle)textBorderStyle{
    _textBorderStyle = textBorderStyle;
    _textField.borderStyle = textBorderStyle;
}


-(void)setKeyboardType:(UIKeyboardType)keyboardType{
    _keyboardType = keyboardType;
    _textField.keyboardType = _keyboardType;
}
-(void)setInputView:(UIView *)inputView{
    _inputView = inputView;
    _textField.inputView = _inputView;
}

-(void)setInputAccessoryView:(UIView *)inputAccessoryView{
    _inputAccessoryView = inputAccessoryView;
    _textField.inputAccessoryView = _inputAccessoryView;
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    NSAssert(_placeholderText, @"请先设置占位文字");
    self.placeHolderLabel.textColor = placeholderColor;
}


- (BOOL)isEditing {
    return _textField.isEditing;
}


-(BOOL)resignFirstResponder {
    return [_textField resignFirstResponder];
}

- (BOOL)becomeFirstResponder {
    return [_textField becomeFirstResponder];
}

- (BOOL)canBecomeFirstResponder {
    return [_textField canBecomeFirstResponder];
}

- (BOOL)canResignFirstResponder {
    return [_textField canBecomeFirstResponder];
}

- (BOOL)isFirstResponder {
    return [_textField isFirstResponder];
}

- (void)placeholderHiddenWithEditor:(BOOL)editor {
    
    if(editor) {
        NSInteger textCount = [self.numCount integerValue];
        
        if ([self.text isEqualToString:@""]) {
            textCount--;
        } else {
            textCount++;
        }
        
        self.placeHolderLabel.hidden = textCount == 0 ? NO : YES;
        self.numCount = [NSNumber numberWithInteger:textCount];
    } else {
        if (self.text) self.placeHolderLabel.hidden = self.text.length > 0 ? YES : NO;
    }
}
- (BOOL)isPinyin {
    return [[self textInputMode].primaryLanguage isEqualToString:@"zh-Hans"];
}

- (NSString *)replacingNullStr:(NSString *)str {
    if ([self isPinyin]) {
        // 注意左边空字符并非空字符，恶心死, 为了动态搜索时不去拿空格搜索
        if ([str containsString:@" "]) {
            str = [[str stringByReplacingOccurrencesOfString:@" " withString:@""] mutableCopy];
        } else if ([str containsString:@" "]) {
            str = [[str stringByReplacingOccurrencesOfString:@" " withString:@""] mutableCopy];
        }
        
    }
    return str;
}

@end
