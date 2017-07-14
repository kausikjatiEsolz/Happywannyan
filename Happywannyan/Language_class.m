//
//  Language_class.m
//  Happywannyan
//
//  Created by Rahul Singha Roy on 18/05/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import "Language_class.h"

@implementation Language_class

-(NSDictionary *)language
{
    
    NSUserDefaults *user_default = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *user_info = [user_default valueForKey:@"language"];
    
    return user_info;
}

@end
