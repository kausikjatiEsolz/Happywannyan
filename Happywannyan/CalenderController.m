//
//  CalenderController.m
//  Happywannyan
//
//  Created by Rahul Singha Roy on 22/05/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import "CalenderController.h"

#import "DSLCalendarMonthSelectorView.h"
#import "Search_ViewController.h"
#import "Language_class.h"
//#import "FBShimmeringView.h"

@interface CalenderController ()<DSLCalendarViewDelegate>
{
    
    NSDictionary *user_info;
    float y;
    
    IBOutlet UIImageView *loadingImageView;
}

@end

@implementation CalenderController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    user_info=[[Language_class new]language];
    
    //_calender.frame = CGRectMake(0, 70, 375, 400);
    
    self.calender_view.delegate = self;
    
    calender_lbl.text=[user_info valueForKey:@"calender"];
    //date_lable.text=[user_info valueForKey:@"date_lbl"];
    
    [cancel_btn setTitle:[user_info valueForKey:@"cancel"] forState:UIControlStateNormal];
    [ok_btn setTitle:[user_info valueForKey:@"ok"] forState:UIControlStateNormal];
    
 
    
    
    for (UIView *view in _calender_view.subviews)
    {
 
        view.frame = CGRectMake(self.view.frame.size.width/2- view.frame.size.width/2, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
        
        y = view.frame.origin.x;
        
       
       
        
        
        
            
        
        
        
        
    }
    
    //DSLCalendarMonthSelectorView
    
    for (UIView *view in _calender_view.subviews)
    {
            if ([view isKindOfClass:[DSLCalendarMonthSelectorView class]])
               {
        view.frame = CGRectMake(y, view.frame.origin.y, 320, view.frame.size.height);
                   
                   
                   
         }
        
        
    }

    
    //NSLog(@"view--->%@",_calender_view.subviews);
    
//    
//    [_calender_view addSubview:view_obj.view];
    
     [self imgae_tutorial];
    
    dismissBtn.clipsToBounds = YES;
    dismissBtn.layer.cornerRadius = 5;
    
    
    tutorilashow_never.clipsToBounds = YES;
    tutorilashow_never.layer.cornerRadius = 5;
    
    
    if([[[NSUserDefaults standardUserDefaults]valueForKey:@"tutorial"] intValue]==0)
        
    {
    
        _tutorial_view.hidden = NO;
        loadingImageView.hidden = NO;
        
        
        
        
    }
    
    
    
    else
        
    {
    _tutorial_view.hidden = YES;
    loadingImageView.hidden = YES;
    
   
    
    
        
    }
    
    
    
}


-(IBAction)tutorial_show_never:(UIButton *)sender
{
    
    [UIView animateWithDuration:.3f animations:^{
        
        
        _tutorial_view.alpha=0;
        loadingImageView.alpha = 0;
        
    }completion:^(BOOL finished) {
        
        
        _tutorial_view.hidden = YES;
        loadingImageView.hidden = YES;
        
        _tutorial_view.alpha=1;
        loadingImageView.alpha = 1;
        
        
    }];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"tutorial"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark - DSLCalendarViewDelegate methods

- (void)calendarView:(DSLCalendarView *)calendarView didSelectRange:(DSLCalendarRange *)range {
    if (range != nil) {
        NSLog( @"Selected %ld/%ld - %ld/%ld", (long)range.startDay.day, (long)range.startDay.month, (long)range.endDay.day, (long)range.endDay.month);
        
        NSString *day=@"";
        NSString *month=@"";
        
        if (range.startDay.day<10)
        {
            day = [NSString stringWithFormat:@"0%ld",(long)range.startDay.day];
        }
        else
        {
             day = [NSString stringWithFormat:@"%ld",(long)range.startDay.day];
        }
        if ((long)range.startDay.month<10)
        {
            month = [NSString stringWithFormat:@"0%ld",(long)range.startDay.month];
        }
        else
        {
            month = [NSString stringWithFormat:@"%ld",(long)range.startDay.month];
        }
        
        NSString *endday=@"";
        NSString *endmonth = @"";
        
        if (range.endDay.day<10)
        {
            endday = [NSString stringWithFormat:@"0%ld",(long)range.endDay.day];
        }
        else
        {
            endday = [NSString stringWithFormat:@"%ld",(long)range.endDay.day];
        }
        if ((long)range.endDay.month<10)
        {
            endmonth = [NSString stringWithFormat:@"0%ld",(long)range.endDay.month];
        }
        else
        {
            endmonth = [NSString stringWithFormat:@"%ld",(long)range.endDay.month];
        }
        
        date_lable.text =[NSString stringWithFormat:@"%@-%@-%ld To %@-%@-%ld",day,month,(long)range.startDay.year,endday,endmonth,(long)range.endDay.year];
        
    }
    else {
        NSLog( @"No selection" );
    }
}


- (DSLCalendarRange*)calendarView:(DSLCalendarView *)calendarView didDragToDay:(NSDateComponents *)day selectingRange:(DSLCalendarRange *)range {
    if (NO) { // Only select a single day
        return [[DSLCalendarRange alloc] initWithStartDay:day endDay:day];
    }
    else if (/* DISABLES CODE */ (NO)) { // Don't allow selections before today
        NSDateComponents *today = [[NSDate date] dslCalendarView_dayWithCalendar:calendarView.visibleMonth.calendar];
        
        NSDateComponents *startDate = range.startDay;
        NSDateComponents *endDate = range.endDay;
        
        if ([self day:startDate isBeforeDay:today] && [self day:endDate isBeforeDay:today]) {
            return nil;
        }
        else {
            if ([self day:startDate isBeforeDay:today]) {
                startDate = [today copy];
            }
            if ([self day:endDate isBeforeDay:today]) {
                endDate = [today copy];
            }
            
            return [[DSLCalendarRange alloc] initWithStartDay:startDate endDay:endDate];
        }
    }
    
    return range;
}

- (void)calendarView:(DSLCalendarView *)calendarView willChangeToVisibleMonth:(NSDateComponents *)month duration:(NSTimeInterval)duration {
    
    
    NSLog(@"Will show %@ in %.3f seconds", month, duration);
}

- (void)calendarView:(DSLCalendarView *)calendarView didChangeToVisibleMonth:(NSDateComponents *)month {
    NSLog(@"Now showing %@", month);
}

- (BOOL)day:(NSDateComponents*)day1 isBeforeDay:(NSDateComponents*)day2 {
    
    return ([day1.date compare:day2.date] == NSOrderedAscending);
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)back:(UIButton *)sender {
    
    
//    NSLog(@"obj-->%@",self.navigationController.viewControllers);
//    
    //Search_ViewController *obj= [Search_ViewController new];
    
    //[_date_button setTitle:@"Choose date" forState:UIControlStateNormal];
    
    
    
    NSLog(@"obj.date_btn--->%@",_date_button.titleLabel.text);
    
    //[self dismissViewControllerAnimated:YES completion:nil];
    
    [UIView animateWithDuration:.3 animations:^{
        
        self.view.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        
    }completion:^(BOOL finished) {
        
        self.view.hidden =YES;
    }];
    
    
    
    
}



-(void)imgae_tutorial
{
    //loadingImageView = [[UIImageView alloc] init];
    loadingImageView.clipsToBounds =YES;
    //loadingImageView.contentMode = UIViewContentModeCenter;
    
    
    
    //loadingImageView.frame = CGRectMake(0, 0, 220, 220);
    loadingImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    loadingImageView.layer.zPosition = MAXFLOAT;
    loadingImageView.animationImages = [self imagesForAnimating];
    loadingImageView.animationDuration = 1.5;
    loadingImageView.animationRepeatCount = 0;
    [self.view addSubview:loadingImageView];
    
    
    [loadingImageView startAnimating];
    
    
    //loadingImageView.backgroundColor = [UIColor redColor];
    
}


- (NSArray *)imagesForAnimating
{
    NSMutableArray *retVal = [NSMutableArray array];
    
    for(int i = 0; i < 7; i++)
    {
        [retVal addObject:[UIImage imageNamed:[NSString stringWithFormat:@"frame_%d", i]]];
    }
    
    
    return retVal;
}

- (IBAction)OK:(UIButton *)sender {
    
    if (date_lable.text.length>0)
    {
        [_date_button setTitle:date_lable.text forState:UIControlStateNormal];
        //[self dismissViewControllerAnimated:YES completion:nil];
        
        
        [[NSUserDefaults standardUserDefaults]setObject:date_lable.text forKey:@"selectdate"];
        
        if ([_date_button.titleLabel.text isEqualToString:date_lable.text]) {
            
            _clr_calender.hidden=NO;
            
        }
        else
        {
            _clr_calender.hidden=YES;
        }
    }
    
    
    
    
    [UIView animateWithDuration:.3 animations:^{
        
        self.view.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        
    }completion:^(BOOL finished) {
        
        self.view.hidden =YES;
    }];
    _clr_calender.hidden=NO;
}
- (IBAction)dismissAction:(UIButton *)sender {
    
    
    [UIView animateWithDuration:.3f animations:^{
       
        
        _tutorial_view.alpha=0;
        loadingImageView.alpha = 0;
        
    }completion:^(BOOL finished) {
        
        
        _tutorial_view.hidden = YES;
        loadingImageView.hidden = YES;
        
        _tutorial_view.alpha=1;
        loadingImageView.alpha = 1;
        
        
    }];
    
    
    
    
}

- (IBAction)tutorial_show:(UIButton *)sender {
    
    
    _tutorial_view.alpha=0;
    loadingImageView.alpha = 0;
    
    _tutorial_view.hidden = NO;
    loadingImageView.hidden = NO;
    
    [UIView animateWithDuration:.3f animations:^{
        
        
        _tutorial_view.alpha=1;
        loadingImageView.alpha = 1;
        
    }completion:^(BOOL finished) {
        
        
       
        
       
        
        
    }];

    
    
}


-(void)showtutorial
{
    _tutorial_view.alpha=0;
    loadingImageView.alpha = 0;
    
    _tutorial_view.hidden = NO;
    loadingImageView.hidden = NO;
    
    [UIView animateWithDuration:.3f animations:^{
        
        
        _tutorial_view.alpha=1;
        loadingImageView.alpha = 1;
        
    }completion:^(BOOL finished) {
        
        
        
        
        
        
        
    }];
}


@end
