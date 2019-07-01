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
    LDKPopMenuPositionTypeTopCenter
};

@interface LDKPopMenu : UIView

@property (nonatomic, copy, readonly) NSArray *items;

@property (nonatomic, assign) CGPoint origin;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat rowHeight;

@property (nonatomic, assign) CGFloat cornerRadius;

@property (nonatomic, assign) CGFloat arrowWidth;

@property (nonatomic, assign) CGFloat arrowHeight;

@property (nonatomic, assign) int maxRow;

@property (nonatomic, assign) BOOL hasArrow;

@property (nonatomic, assign) LDKPopMenuPositionType positionType;

@property (nonatomic, assign) BOOL isAnimated;

@property (nonatomic, copy) void (^action)(NSUInteger index);

@property (nonatomic, strong, nullable) UITableView *tableView;

- (instancetype)initWithItems:(NSArray<NSDictionary *> *__nullable)items origin:(CGPoint)origin action:( void(^__nullable)(NSUInteger index))action;

- (void)show;

@end

NS_ASSUME_NONNULL_END
