//
//  LDKPopMenu.h
//  LDKPopMenu
//
//  Created by Jerery on 2019/7/1.
//  Copyright © 2019 Jerery. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, LDKPopMenuPositionVertical) {
    LDKPopMenuPositionVerticalTop = 1 << 4,
    LDKPopMenuPositionVerticalBottom = 1 << 3
};

typedef NS_ENUM(NSInteger, LDKPopMenuPositionHorizon) {
    LDKPopMenuPositionHorizonLeft = 1 << 2,
    LDKPopMenuPositionHorizonCenter = 1 << 1,
    LDKPopMenuPositionHorizonRight = 1
};

typedef NS_ENUM(NSInteger, LDKPopMenuPositionType) {
    LDKPopMenuPositionTypeNone = 0, // 没有箭头
    LDKPopMenuPositionTypeTopLeft = LDKPopMenuPositionVerticalTop | LDKPopMenuPositionHorizonLeft,
    LDKPopMenuPositionTypeTopCenter = LDKPopMenuPositionVerticalTop | LDKPopMenuPositionHorizonCenter,
    LDKPopMenuPositionTypeTopRight = LDKPopMenuPositionVerticalTop | LDKPopMenuPositionHorizonRight,
    LDKPopMenuPositionTypeBottomLeft = LDKPopMenuPositionVerticalBottom | LDKPopMenuPositionHorizonLeft,
    LDKPopMenuPositionTypeBottomCenter = LDKPopMenuPositionVerticalBottom | LDKPopMenuPositionHorizonCenter,
    LDKPopMenuPositionTypeBottomRight = LDKPopMenuPositionVerticalBottom | LDKPopMenuPositionHorizonRight
};

typedef NS_ENUM(NSInteger, LDKPopMenuAnimatedType) {
    LDKPopMenuAnimatedTypeHeight,
    LDKPopMenuAnimatedTypeScale
};

@interface LDKPopMenu : UIView

@property (nonatomic, copy, readonly) NSArray *items;

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
 箭头距离边缘的距离 default 10
 
 当 positonType = LDKPopMenuPositionTypeTopLeft 或 LDKPopMenuPositionTypeBottomLeft 时，指距离左边缘的距离
 当 positonType = LDKPopMenuPositionTypeTopRight 或 LDKPopMenuPositionTypeBottomRight 时，指距离左边缘的距离
 */
@property (nonatomic, assign) CGFloat arrowDistance;

/**
 显示的最大行数 default 0 即无限大
 
 当 tableView 的行数比 maxRow 大的时候，tableView 可以滑动
 当 tableView 的行数比 maxRow 小的时候，tableView 不可以滑动
 */
@property (nonatomic, assign) int maxRow;

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

/**
 @param hasArrow 是否有箭头
 @param items tableView显示的内容
 @param positionType origin 的位置
 @param origin 有箭头时是箭头的位置，没有箭头的时候是 anchorPoint 的位置
 @param action 点击菜单每一项的回掉
 */
- (instancetype)initPopMenuWithArrow:(BOOL)hasArrow items:(NSArray<NSDictionary *> *__nullable)items positionType:(LDKPopMenuPositionType)positionType origin:(CGPoint)origin action:(void(^__nullable)(NSUInteger index))action;

- (void)show;

- (instancetype) init __attribute__((unavailable("call initPopMenuWithArrow:items:positionType:origin:action: instead")));

- (instancetype)initWithFrame:(CGRect)frame __attribute__((unavailable("call initPopMenuWithArrow:items:positionType:origin:action: instead")));

@end

NS_ASSUME_NONNULL_END
