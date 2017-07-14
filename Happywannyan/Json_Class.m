//
//  Json_Class.m
//  Swish Marketing
//
//  Created by Rahul Singha Roy on 06/04/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import "Json_Class.h"
#import "YXSpritesLoadingView.h"


@implementation Json_Class
{
    Urlresponceblock _responce;
    NSString *check;
    NSURLSessionDataTask *uploadTask;
}



-(void)GlobalDict:(NSMutableURLRequest *)parameter Globalstr:(NSString *)parametercheck lodaer:(BOOL)loader  Withblock:(Urlresponceblock)responce
{
    
    if (loader)
    {
        [YXSpritesLoadingView show];
    }
    
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    uploadTask = [session dataTaskWithRequest:parameter completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // Process the response
        _responce=[responce copy];
        
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [YXSpritesLoadingView dismiss];
            
            if(!error)
            {
                
                
                check=parametercheck;
                
                if([check isEqualToString:@"array"])
                {
                    
                    
                    
                    id result=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                    
                                       
                    _responce(result,nil);
                }
                if ([check isEqualToString:@"string"])
                {
                    id  result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    
                    _responce(result,nil);
                }
                
                
                
            }
            else
            {
                _responce(nil,error);
                
                
                NSLog(@"error--->%@",error.localizedDescription);
                
                
                [YXSpritesLoadingView errorInfo:error.localizedDescription];
                
                //[[NSNotificationCenter defaultCenter] postNotificationName:@"nointernet" object:nil];
                
                
            }
            
            
            
            
        });
        
        
        
        
        
    }];
    [uploadTask resume];
    
}

-(void)post_dataWithImage:(NSString *)url Post_data:(NSDictionary *)parameters image:(NSData *)image_Data paramNameForImage:(NSString *)paramNameForImage Withblock:(Urlresponceblock)responce
{
    
      [YXSpritesLoadingView show];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
    {
        
        
        [formData appendPartWithFileData:image_Data name:paramNameForImage fileName:@"photo.png" mimeType:@"image/png"];
        
        
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
   // manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    // manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    

    
    NSURLSessionUploadTask  *uploadTaskAF = [manager uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      // This is not called back on the main queue.
                      // You are responsible for dispatching to the main queue for UI updates
                      dispatch_async(dispatch_get_main_queue(), ^{
                          //Update the progress view
                         // [progressView setProgress:uploadProgress.fractionCompleted];
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      
                       [YXSpritesLoadingView dismiss];
                      
                      if (error) {
                          
                          
                          NSLog(@"Error: %@", error);
                          
                           [YXSpritesLoadingView errorInfo:error.localizedDescription];
                          
                          
                      } else {
                          
                          
                           _responce=[responce copy];
                          
                          
//                          id result=[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
                          
                          _responce(responseObject,nil);
                          
                          
                          NSLog(@"%@ %@", response, responseObject);
                          
                          
                         // [self dealloc];
                          
                          
                          
                      }
                  }];
    
    [uploadTaskAF resume];
}






@end
