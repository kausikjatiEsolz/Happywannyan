//
//  CardView.h
//  YSLDraggingCardContainerDemo
//
//  Created by yamaguchi on 2015/11/09.
//  Copyright © 2015年 h.yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSLCardView.h"

@interface CardView : YSLCardView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UILabel *subname_label;
@property (nonatomic, strong) UIImageView *location_img;
@property (nonatomic, strong) UILabel *location_label;
@property (nonatomic, strong) UILabel *review_label;
@property (nonatomic, strong) UILabel *amount_label;
@property (nonatomic, strong) UILabel *time_label;
@property (nonatomic, strong) UIView *selectedView;
@property (nonatomic, strong) UIImageView *heart_image;
@property (nonatomic, strong) UILabel *service_name_all;


-(void)setView:(NSDictionary *)dic;

@end
