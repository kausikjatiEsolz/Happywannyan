//
//  Json_Class.h
//  Swish Marketing
//
//  Created by Rahul Singha Roy on 06/04/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RS_ios_customBlock.h"
#import "RS_PCH.pch"
#import "AFNetworking.h"

@interface Json_Class : NSObject<NSURLSessionDelegate>



-(void)GlobalDict:(NSMutableURLRequest *)parameter Globalstr:(NSString *)parametercheck lodaer:(BOOL)loader  Withblock:(Urlresponceblock)responce;

-(void)post_dataWithImage:(NSString *)url Post_data:(NSDictionary *)parameters image:(NSData *)image_Data paramNameForImage:(NSString *)paramNameForImage Withblock:(Urlresponceblock)responce;




@end
