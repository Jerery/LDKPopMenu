//
//  LDKPopMenu.h
//  LDKPopMenu
//
//  Created by Jerery on 2019/7/1.
//  Copyright © 2019 Jerery. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, LDKPopMenuArrowPositionVertical) {
    LDKPopMenuArrowPositionVerticalTop = 1 << 4,
    LDKPopMenuArrowPositionVerticalBottom = 1 << 3
};

typedef NS_ENUM(NSInteger, LDKPopMenuArrowPositionHorizon) {
    LDKPopMenuArrowPositionHorizonLeft = 1 << 2,
    LDKPopMenuArrowPositionHorizonCenter = 1 << 1,
    LDKPopMenuArrowPositionHorizonRight = 1
};

typedef NS_ENUM(NSInteger, LDKPopMenuArrowPositionType) {
    LDKPopMenuArrowPositionTypeNone = 0, // 没有箭头
    LDKPopMenuArrowPositionTypeTopLeft = LDKPopMenuArrowPositionVerticalTop | LDKPopMenuArrowPositionHorizonLeft,
    LDKPopMenuArrowPositionTypeTopCenter = LDKPopMenuArrowPositionVerticalTop | LDKPopMenuArrowPositionHorizonCenter,
    LDKPopMenuArrowPositionTypeTopRight = LDKPopMenuArrowPositionVerticalTop | LDKPopMenuArrowPositionHorizonRight,
    LDKPopMenuArrowPositionTypeBottomLeft = LDKPopMenuArrowPositionVerticalBottom | LDKPopMenuArrowPositionHorizonLeft,
    LDKPopMenuArrowPositionTypeBottomCenter = LDKPopMenuArrowPositionVerticalBottom | LDKPopMenuArrowPositionHorizonCenter,
    LDKPopMenuArrowPositionTypeBottomRight = LDKPopMenuArrowPositionVerticalBottom | LDKPopMenuArrowPositionHorizonRight
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
 箭头距离边缘的距离
 
 当 positonType = LDKPopMenuArrowPositionTypeTopLeft 或 LDKPopMenuArrowPositionTypeBottomLeft 时，指距离左边缘的距离
 当 positonType = LDKPopMenuArrowPositionTypeTopRight 或 LDKPopMenuArrowPositionTypeBottomRight 时，指距离左边缘的距离
 default = 10
 */
@property (nonatomic, assign) CGFloat arrowDistance;

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

- (instancetype)initPopMenuWithArrow:(BOOL)hasArrow items:(NSArray<NSDictionary *> *__nullable)items positionType:(LDKPopMenuArrowPositionType)arrowPositionType origin:(CGPoint)origin action:(void(^__nullable)(NSUInteger index))action;

- (void)show;

- (instancetype) init __attribute__((unavailable("call initPopMenuWithArrow:items:positionType:origin:action: instead")));

- (instancetype)initWithFrame:(CGRect)frame __attribute__((unavailable("call initPopMenuWithArrow:items:positionType:origin:action: instead")));

@end

NS_ASSUME_NONNULL_END
