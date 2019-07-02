//
//  LDKPopMenu.m
//  LDKPopMenu
//
//  Created by Jerery on 2019/7/1.
//  Copyright © 2019 Jerery. All rights reserved.
//

#import "LDKPopMenu.h"

@interface LDKPopMenu()

@property (nonatomic, strong, nonnull) UIView *menuView;

@end

@implementation LDKPopMenu {
    
    BOOL _hasArrow;
    
    /**
     当 hasArrow = 1 时，表示箭头的位置，即 origin 点相对位于左上，中上还是右上等。default LDKPopMenuArrowPositionTypeTopCenter
     当 hasArrow = 0 时，表示 origin 点的位置。default LDKPopMenuArrowPositionTypeNone
     */
    LDKPopMenuArrowPositionType _arrowPositionType;
    
//    UIView *_menuView;
}

- (instancetype)initPopMenuWithArrow:(BOOL)hasArrow items:(NSArray<NSDictionary *> *__nullable)items positionType:(LDKPopMenuArrowPositionType)arrowPositionType origin:(CGPoint)origin action:(void(^__nullable)(NSUInteger index))action {
    if (self = [super init]) {
        // init
        _origin = CGPointZero;
        _width = 150.0;
        _rowHeight = 50.0;
        _cornerRadius = 4;
        _arrowWidth = 20.0;
        _arrowHeight = 8.0;
        _arrowDistance = 10.0;
        _maxRow = 0;
        _animatedType = LDKPopMenuAnimatedTypeScale;
        _isAnimated = YES;
        _isShade = NO;
        _tableView = [[UITableView alloc] init];
        
        _menuView = [[UIView alloc] init];
        _menuView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
        
        self.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
        
        // custom
        _hasArrow = hasArrow;
        _items = items;
        _origin = origin;
        _action = action;
        _arrowPositionType = arrowPositionType;
    }
    
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_isAnimated) {
        [UIView animateWithDuration:0.3 animations:^{
            self.menuView.transform = CGAffineTransformMakeScale(0, 0);
            self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }else{
        [self removeFromSuperview];
    }
}

#pragma mark - api
- (void)show {
    [self setupView];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    if (_isAnimated) {
        if (_animatedType == LDKPopMenuAnimatedTypeScale) {
            _menuView.transform = CGAffineTransformMakeScale(0, 0);
        }
        else {
            _menuView.transform = CGAffineTransformMakeScale(1, 0);
        }
        
        [UIView animateWithDuration:0.1 animations:^{
            self.menuView.transform = CGAffineTransformIdentity;
        } completion:nil];
    }
}

#pragma mark - setup ui

- (void)setupView {
    if (_isShade)
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    else
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    
    [self setupMenuView];
    [self setupTableView];
}

- (void)setupMenuView {
    _menuView.layer.cornerRadius = 4;
    _menuView.layer.masksToBounds = YES;
    
    CGFloat tableHeight = _items.count ? _items.count * _rowHeight : _rowHeight;
    
    if (_hasArrow) {
        _menuView.frame = CGRectMake(0, 0, _width, tableHeight + _arrowHeight);
        [self p_addArrowToMenuView];
    }
    else {
        _menuView.frame = CGRectMake(0, 0, _width, tableHeight);
        _menuView.layer.position = CGPointMake(_origin.x, _origin.y);
    }
    
    switch (_arrowPositionType) {
        case LDKPopMenuArrowPositionTypeTopLeft:
        {
            _menuView.layer.anchorPoint = CGPointMake(0, 0);
            
            if (_hasArrow)
                _menuView.layer.position = CGPointMake(_origin.x - _arrowWidth/2 - _arrowDistance, _origin.y);
        }
            break;
            
        case LDKPopMenuArrowPositionTypeTopCenter:
        {
            _menuView.layer.anchorPoint = CGPointMake(0.5, 0);
            
            if (_hasArrow)
                _menuView.layer.position = CGPointMake(_origin.x, _origin.y);
        }
            break;
            
        case LDKPopMenuArrowPositionTypeTopRight:
        {
            _menuView.layer.anchorPoint = CGPointMake(1, 0);
            
            if (_hasArrow)
                _menuView.layer.position = CGPointMake(_origin.x + _arrowWidth/2 + _arrowDistance, _origin.y);
        }
            break;
            
        case LDKPopMenuArrowPositionTypeBottomLeft:
        {
            _menuView.layer.anchorPoint = CGPointMake(0, 1);
            
            if (_hasArrow)
                _menuView.layer.position = CGPointMake(_origin.x - _arrowWidth/2 - _arrowDistance, _origin.y);
        }
            break;
            
        case LDKPopMenuArrowPositionTypeBottomCenter:
        {
            _menuView.layer.anchorPoint = CGPointMake(0.5, 1);
            
            if (_hasArrow)
                _menuView.layer.position = CGPointMake(_origin.x, _origin.y);
        }
            break;
            
        case LDKPopMenuArrowPositionTypeBottomRight:
        {
            _menuView.layer.anchorPoint = CGPointMake(1, 1);
            
            if (_hasArrow)
                _menuView.layer.position = CGPointMake(_origin.x + _arrowWidth/2 + _arrowDistance, _origin.y);
        }
            break;
            
        default:
            break;
    }
    
    [self addSubview:_menuView];
}

- (void)setupTableView {
    _tableView.rowHeight = _rowHeight;
    _tableView.layer.cornerRadius = _cornerRadius;
    _tableView.backgroundColor = _menuColor;
    
    CGFloat tableHeight = _items.count ? _items.count * _rowHeight : _rowHeight;
    
    if (_arrowPositionType & LDKPopMenuArrowPositionVerticalTop) {
        if (_hasArrow)
            _tableView.frame = CGRectMake(0, _arrowHeight, _width, tableHeight);
        else
            _tableView.frame = CGRectMake(0, 0, _width, tableHeight);
    }
    else
        _tableView.frame = CGRectMake(0, 0, _width, tableHeight);

    [_menuView addSubview:_tableView];
}

#pragma mark - private methods
- (void)p_addArrowToMenuView {
    CGFloat tableHeight = _items.count ? _items.count * _rowHeight : _rowHeight;
    CGFloat menuHeight = tableHeight + _arrowHeight;
    
    CGPoint peak = CGPointZero;
    CGPoint start = CGPointZero;
    CGPoint end = CGPointZero;
    
    switch (_arrowPositionType) {
        case LDKPopMenuArrowPositionTypeTopLeft:
        {
            peak = CGPointMake(_arrowDistance + _arrowWidth/2, 0);
        }
            break;
            
        case LDKPopMenuArrowPositionTypeTopCenter:
        {
            peak = CGPointMake(_width/2, 0);
        }
            break;
            
        case LDKPopMenuArrowPositionTypeTopRight:
        {
            peak = CGPointMake(_width - _arrowDistance - _arrowWidth/2, 0);
        }
            break;
            
        case LDKPopMenuArrowPositionTypeBottomLeft:
        {
            peak = CGPointMake(_arrowDistance + _arrowWidth/2, menuHeight);
        }
            break;
            
        case LDKPopMenuArrowPositionTypeBottomCenter:
        {
            peak = CGPointMake(_width/2, menuHeight);
        }
            break;
            
        case LDKPopMenuArrowPositionTypeBottomRight:
        {
            peak = CGPointMake(_width - _arrowDistance - _arrowWidth/2, menuHeight);
        }
            break;
            
        default:
            break;
    }
    
    if (_arrowPositionType & LDKPopMenuArrowPositionVerticalTop) {
        start = CGPointMake(peak.x - _arrowWidth/2, _arrowHeight);
        end = CGPointMake(start.x + _arrowWidth, _arrowHeight);
    }
    else {
        start = CGPointMake(peak.x - _arrowWidth/2, peak.y - _arrowHeight);
        end = CGPointMake(start.x + _arrowWidth, peak.y - _arrowHeight);
    }
    
    [self p_drawArrowOnView:_menuView peak:peak start:start end:end];
}

- (void)p_drawArrowOnView:(UIView *)view peak:(CGPoint)peak start:(CGPoint)start end:(CGPoint)end {
    CAShapeLayer *arrowLayer = [[CAShapeLayer alloc] init];
    UIBezierPath *path = [[UIBezierPath alloc] init];
    arrowLayer.fillColor = _menuColor.CGColor;
    
    //path移动到开始画图的位置
    [path moveToPoint:start];
    [path addLineToPoint:peak];
    [path addLineToPoint:end];
    arrowLayer.path = [path CGPath];
    
    //关闭path
    [path closePath];
    [view.layer addSublayer:arrowLayer];
}


@end
