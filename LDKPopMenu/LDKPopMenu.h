//
//  LDKPopMenu.h
//  LDKPopMenu
//
//  Created by Jerery on 2019/7/1.
//  Copyright © 2019 Jerery. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, LDKPopMenuPositionType) {
    LDKPopMenuPositionTypeTopLeft,
    LDKPopMenuPositionTypeTopCenter,
    LDKPopMenuPositionTypeTopRight,
    LDKPopMenuPositionTypeBottomLeft,
    LDKPopMenuPositionTypeBottomRight
};

typedef NS_ENUM(NSInteger, LDKPopMenuAnimatedType) {
    LDKPopMenuAnimatedTypeHeight,
    LDKPopMenuAnimatedTypeScale
};

@interface LDKPopMenu : UIView

@property (nonatomic, copy, readonly) NSArray *items;

/**
 当 hasArrow = 1 时，表示箭头的位置，即 origin 点相对位于左上，中上还是右上等...
 当 hasArrow = 0 时，表示 origin 点的位置，与 hasArrow = 1 类是。
 
 default LDKPopMenuPositionTypeTopLeft
 */
@property (nonatomic, assign) LDKPopMenuPositionType positionType;

@property (nonatomic, assign) CGPoint origin;

// tableView 的宽度 default 150
@property (nonatomic, assign) CGFloat width;

// tableView 的行高 default 50
@property (nonatomic, assign) CGFloat rowHeight;

// tableView 的圆角 default 4
@property (nonatomic, assign) CGFloat cornerRadius;

// 箭头的宽度 default 20
@property (nonatomic, assign) CGFloat arrowWidth;

// 箭头的高度 default 8
@property (nonatomic, assign) CGFloat arrowHeight;

/**
 箭头距离边缘的距离
 
 当 positonType = LDKPopMenuPositionTypeTopLeft 或 LDKPopMenuPositionTypeBottomLeft 时，指距离左边缘的距离
 当 positonType = LDKPopMenuPositionTypeTopRight 或 LDKPopMenuPositionTypeBottomRight 时，指距离左边缘的距离
 default = 10
 */
@property (nonatomic, assign) CGFloat arrowDistance;

@property (nonatomic, assign) int maxRow;

// 是否有箭头 default YES
@property (nonatomic, assign) BOOL hasArrow;

// tableView 的背景颜色包括 cell 的颜色 default white
@property (nonatomic, strong, nullable) UIColor *menuColor;

// tableView 里字体的颜色 default white
@property (nonatomic, strong, nullable) UIColor *fontColor;

@property (nonatomic, assign) BOOL isAnimated;

// 动画类型 default LDKPopMenuAnimatedTypeHeigth
@property (nonatomic, assign) LDKPopMenuAnimatedType animatedType;

// 是否有蒙版 default NO
@property (nonatomic, assign) BOOL isShade;

@property (nonatomic, copy) void (^action)(NSUInteger index);

@property (nonatomic, strong, nullable) UITableView *tableView;

- (instancetype)initWithItems:(NSArray<NSDictionary *> *__nullable)items positionType:(LDKPopMenuPositionType)positionType origin:(CGPoint)origin action:( void(^__nullable)(NSUInteger index))action;

- (void)show;

@end

NS_ASSUME_NONNULL_END
