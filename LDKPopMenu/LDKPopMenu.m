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
        _width = 100.0;
        _rowHeight = 30.0;
        _cornerRadius = 4;
        _arrowWidth = 15.0;
        _arrowHeight = 10.0;
        _maxRow = 0;
        _hasArrow = NO;
        _positionType = LDKPopMenuPositionTypeTopCenter;
        _isAnimated = YES;
        _tableView = [[UITableView alloc] init];
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        self.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
    }
    
    return self;
}

- (instancetype)initWithItems:(NSArray<NSDictionary *> *__nullable)items origin:(CGPoint)origin action:(void(^__nullable)(NSUInteger index))action {
    if (self = [self init]) {
        _items = items;
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
    [self setupTableView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    if (_isAnimated) {
        CGFloat tableHeight = _items.count ? _items.count * _rowHeight : _rowHeight;
        _tableView.frame = CGRectMake(self.origin.x - self.width/2,  self.origin.y + self.arrowHeight, _width, 0);
//        _tableView.transform = CGAffineTransformMakeScale(0.2, 0.2);
        [UIView animateWithDuration:0.2 animations:^{
//            self.tableView.transform = CGAffineTransformIdentity;
            self.tableView.frame = CGRectMake(self.origin.x - self.width/2, self.origin.y + self.arrowHeight, self.width, tableHeight);
            self.tableView.alpha = 1.0;
            self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        } completion:nil];
    }else{
        self.tableView.alpha = 1.0;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    }
}

#pragma mark - setup ui

- (void)setupTableView {
    _tableView.rowHeight = _rowHeight;
    _tableView.layer.cornerRadius = _cornerRadius;
    CGFloat tableHeight = _items.count ? _items.count * _rowHeight : _rowHeight;
    _tableView.frame = CGRectMake(0, 0, _width, tableHeight);
    
    switch (_positionType) {
        case LDKPopMenuPositionTypeTopCenter:
        {
            _tableView.layer.anchorPoint = CGPointMake(0.5, 0);
            
            if (_hasArrow) {
                _tableView.layer.position = CGPointMake(_origin.x, _origin.y + _arrowHeight);
                
                CGPoint peak = _origin;
                CGPoint start = CGPointMake(peak.x - _arrowWidth/2, peak.y + _arrowHeight);
                CGPoint end = CGPointMake(start.x + _arrowWidth, start.y);
                [self p_drawArrow:peak start:start end:end];
            }
            else {
                _tableView.layer.position = CGPointMake(_origin.x, _origin.y);
            }
        }
            break;
            
        default:
            break;
    }
    
    [self addSubview:_tableView];
}

#pragma mark - private methods
- (void)p_addArrow {
    switch (_positionType) {
        case LDKPopMenuPositionTypeTopCenter:
        {
            CGPoint peak = _origin;
            CGPoint start = CGPointMake(peak.x - _arrowWidth/2, peak.y + _arrowHeight);
            CGPoint end = CGPointMake(start.x + _arrowWidth, start.y);
            [self p_drawArrow:peak start:start end:end];
        }
            break;
            
        default:
            break;
    }
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
