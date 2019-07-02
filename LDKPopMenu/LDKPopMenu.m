//
//  LDKPopMenu.m
//  LDKPopMenu
//
//  Created by Jerery on 2019/7/1.
//  Copyright © 2019 Jerery. All rights reserved.
//

#import "LDKPopMenu.h"

@implementation LDKPopMenu

- (instancetype)init {
    if (self = [super init]) {
        _origin = CGPointZero;
        _width = 150.0;
        _rowHeight = 50.0;
        _cornerRadius = 4;
        _arrowWidth = 20.0;
        _arrowHeight = 8.0;
        _arrowDistance = 10.0;
        _maxRow = 0;
        _hasArrow = YES;
        _positionType = LDKPopMenuPositionTypeTopLeft;
        _animatedType = LDKPopMenuAnimatedTypeScale;
        _isAnimated = YES;
        _isShade = NO;
        _tableView = [[UITableView alloc] init];
        
        self.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
    }
    
    return self;
}

- (instancetype)initWithItems:(NSArray<NSDictionary *> *__nullable)items positionType:(LDKPopMenuPositionType)positionType origin:(CGPoint)origin action:(void(^__nullable)(NSUInteger index))action {
    if (self = [self init]) {
        _items = items;
        _positionType = positionType;
        _origin = origin;
        _action = action;
    }
    
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_isAnimated) {
        [UIView animateWithDuration:0.15 animations:^{
            self.tableView.transform = CGAffineTransformMakeScale(0.3, 0.3);
            self.tableView.alpha = 0.0;
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
    [self setupTableView];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    if (_isAnimated) {
        if (_animatedType == LDKPopMenuAnimatedTypeScale) {
            _tableView.transform = CGAffineTransformMakeScale(0, 0);
        }
        else {
            _tableView.transform = CGAffineTransformMakeScale(1, 0);
        }
        
        [UIView animateWithDuration:0.1 animations:^{
            self.tableView.transform = CGAffineTransformIdentity;
        } completion:nil];
    }
}

#pragma mark - setup ui

- (void)setupView {
    if (_isShade)
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    else
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
}

- (void)setupTableView {
    _tableView.rowHeight = _rowHeight;
    _tableView.layer.cornerRadius = _cornerRadius;
    _tableView.backgroundColor = _menuColor;
    
    CGFloat tableHeight = _items.count ? _items.count * _rowHeight : _rowHeight;
    _tableView.frame = CGRectMake(0, 0, _width, tableHeight);
    
    if (_hasArrow) {
        [self p_addArrow];
    }
    else {
        _tableView.layer.position = CGPointMake(_origin.x, _origin.y);
    }
        
    switch (_positionType) {
        case LDKPopMenuPositionTypeTopLeft:
        {
            _tableView.layer.anchorPoint = CGPointMake(0, 0);
                
            if (_hasArrow)
                _tableView.layer.position = CGPointMake(_origin.x - _arrowWidth/2 - _arrowDistance, _origin.y + _arrowHeight);
        }
            break;
                
        case LDKPopMenuPositionTypeTopCenter:
        {
            _tableView.layer.anchorPoint = CGPointMake(0.5, 0);
                
            if (_hasArrow)
                _tableView.layer.position = CGPointMake(_origin.x, _origin.y + _arrowHeight);
        }
            break;
                
        default:
            break;
    }

    [self addSubview:_tableView];
}

#pragma mark - private methods
- (void)p_addArrow {
    CGPoint peak = _origin;
    CGPoint start = CGPointZero;
    CGPoint end = CGPointZero;
    
    if (_positionType == LDKPopMenuPositionTypeTopLeft ||
        _positionType == LDKPopMenuPositionTypeTopCenter ||
        _positionType == LDKPopMenuPositionTypeTopRight) {
        start = CGPointMake(peak.x - _arrowWidth/2, peak.y + _arrowHeight);
        end = CGPointMake(start.x + _arrowWidth, start.y);
    }
    else {
        
    }
    
    [self p_drawArrow:peak start:start end:end];
}

- (void)p_drawArrow:(CGPoint)peak start:(CGPoint)start end:(CGPoint)end {
    CAShapeLayer *arrowLayer = [[CAShapeLayer alloc] init];
    UIBezierPath *path = [[UIBezierPath alloc] init];
    arrowLayer.fillColor = self.tableView.backgroundColor.CGColor;
    
    //path移动到开始画图的位置
    [path moveToPoint:start];
    [path addLineToPoint:peak];
    [path addLineToPoint:end];
    arrowLayer.path = [path CGPath];
    
    //关闭path
    [path closePath];
    [self.layer addSublayer:arrowLayer];
}


@end
