//
//  CardView.m
//  YSLDraggingCardContainerDemo
//
//  Created by Kausik on 2015/11/09.
//  Copyright © 2015年 h.yamaguchi. All rights reserved.
//

#import "CardView.h"

@implementation CardView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    _imageView = [[UIImageView alloc]init];
    _imageView.backgroundColor = [UIColor orangeColor];
    _imageView.image=[UIImage imageNamed:@"images-2"];
    _imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/1.5 );
    [self addSubview:_imageView];
    
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:_imageView.bounds  byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                           cornerRadii:CGSizeMake(7.0, 7.0)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _imageView.bounds;
    maskLayer.path = maskPath.CGPath;
    _imageView.layer.mask = maskLayer;
    
    //    _selectedView = [[UIView alloc]init];
    //    _selectedView.frame = _imageView.frame;
    //    _heart_image = [UIImageView new];
    //
    //    UIView *white_view = [UIView new];
    //
    //    white_view.frame = CGRectMake(_selectedView.frame.size.width/2-50, _selectedView.frame.size.height/2-50, 100, 100);
    //
    //    white_view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.4f];
    //
    //    white_view.clipsToBounds = YES;
    //    white_view.layer.cornerRadius = white_view.frame.size.height/2;
    //
    //    _heart_image.frame = CGRectMake(white_view.frame.size.width/2-25, white_view.frame.size.height/2-25, 50, 50);
    //
    //
    //
    //    _heart_image.backgroundColor = [UIColor clearColor];
    //
    //    [white_view addSubview:_heart_image];
    //
    //    [_selectedView addSubview:white_view];
    //
    //    _selectedView.backgroundColor = [UIColor clearColor];
    //    _selectedView.alpha = 0.0;
    //    [_imageView addSubview:_selectedView];
    //
    
    
    _heart_image = [[UIImageView alloc]initWithFrame:CGRectMake(_imageView.frame.size.width-70, _imageView.frame.size.height-70, 50, 45)];
    
    _heart_image.image = [UIImage imageNamed:@"blue_heart"];
    
    [self addSubview:_heart_image];
    
    
    _label = [[UILabel alloc]init];
    //_label.backgroundColor = [UIColor blueColor];
    
    _label.frame = CGRectMake(10, _imageView.frame.size.height+10, self.frame.size.width/2-10.5, 21);
    _label.font = [UIFont fontWithName:@"PingFang SC" size:14];
    [self addSubview:_label];
    
    //_label.backgroundColor = [UIColor redColor];
    
    _subname_label = [[UILabel alloc]init];
    _subname_label.frame = CGRectMake(10, _label.frame.origin.y+_label.frame.size.height+3, self.frame.size.width/2-10.5, 21);
    
    _subname_label.font = [UIFont fontWithName:@"PingFang SC" size:12];
    [self addSubview:_subname_label];
    
    //_subname_label.backgroundColor = [UIColor greenColor];
    
    _location_img=[[UIImageView alloc]init];
    _location_img.frame = CGRectMake(10, _subname_label.frame.origin.y+_subname_label.frame.size.height+10, 12, 17);
    _location_img.image=[UIImage imageNamed:@"placeholder"];
    [self addSubview:_location_img];
    
    _location_label = [[UILabel alloc]init];
    _location_label.frame = CGRectMake(_location_img.frame.size.width+10+3, _location_img.frame.origin.y, self.frame.size.width/2-20, 21);
    //_location_label.text=@"Tuoh,Ciba,Japan";
    _location_label.font = [UIFont fontWithName:@"PingFang SC" size:12];
    [self addSubview:_location_label];
    
    //_location_label.backgroundColor = [UIColor yellowColor];
    
    _review_label = [[UILabel alloc]init];
    _review_label.frame = CGRectMake(_subname_label.frame.size.width+10+5, _subname_label.frame.origin.y, _subname_label.frame.size.width-5, _subname_label.frame.size.height);
    _review_label.text=@"257 Reviews";
    _review_label.textAlignment=NSTextAlignmentRight;
    _review_label.font = [UIFont fontWithName:@"PingFang SC" size:12];
    _review_label.textColor=[UIColor darkGrayColor];
    [self addSubview:_review_label];
    
    //_review_label.backgroundColor = [UIColor orangeColor];
    
    _amount_label = [[UILabel alloc]init];
    _amount_label.frame = CGRectMake(_location_label.frame.size.width+_location_label.frame.origin.x+10, _location_label.frame.origin.y,_location_label.frame.size.width-7,_location_label.frame.size.height);
    
    _amount_label.textAlignment=NSTextAlignmentRight;
    _amount_label.font = [UIFont fontWithName:@"PingFang SC" size:14];
    [self addSubview:_amount_label];
    
    //_amount_label.backgroundColor = [UIColor purpleColor];
    
    
    _time_label = [[UILabel alloc]init];
    _time_label.frame = CGRectMake(_amount_label.frame.origin.x, _amount_label.frame.size.height+_amount_label.frame.origin.y, _amount_label.frame.size.width, _amount_label.frame.size.height);
    _time_label.text=@"(30 Minutes)";
    _time_label.textAlignment=NSTextAlignmentRight;
    _time_label.font = [UIFont fontWithName:@"PingFang SC" size:11];
    _time_label.textColor=[UIColor darkGrayColor];
    [self addSubview:_time_label];
    //_time_label.backgroundColor = [UIColor darkGrayColor];
    
    
    
    
    
    _service_name_all = [[UILabel alloc]initWithFrame:CGRectMake(10, _time_label.frame.origin.y+_time_label.frame.size.height+5, self.frame.size.width-20, 21)];
    
    //_service_name_all.backgroundColor = [UIColor blackColor];
    
    _service_name_all.textAlignment = NSTextAlignmentCenter;
    
    _service_name_all.font = [UIFont fontWithName:@"PingFang SC" size:12.0f];
    
    
    
    [self addSubview:_service_name_all];
    
}

-(void)setView:(NSDictionary *)dic
{
    _amount_label.text=[NSString stringWithFormat:@"¥ %@",[dic valueForKey:@"price_one"]];
    
    _location_label.text = [dic valueForKey:@"whole_address"];
    _service_name_all.text = [dic valueForKey:@"service_name_all"];
    
    _review_label.text = [NSString stringWithFormat:@"%@ Reviews",[dic valueForKey:@"num_rvw"]];
    
    _subname_label.text=[dic valueForKey:@"sitter_name"];
    
    
    int x=self.frame.size.width-20-1.5;
    
    
    for (int i=5; i>0; i--) {
        
        UIImageView *star=[[UIImageView alloc]init];
        star.frame=CGRectMake(x, _label.frame.origin.y+_label.frame.size.height/2-6, 12, 12);
        
        if (i<=[[dic valueForKey:@"ave_rating"] intValue])
        {
            star.image = [UIImage imageNamed:@"favorite"];
        }
        else
        {
            star.image = [UIImage imageNamed:@"star"];
        }
        //star.image=[UIImage imageNamed:@"favorite"];
        
        [self addSubview:star];
        
        
        x=x-12-3;
    }
}

@end
