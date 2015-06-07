//
//  APImageCreater.m
//  testAP
//
//  Created by Sterch on 06.06.15.
//  Copyright (c) 2015 YauheniHindzin. All rights reserved.
//

#import "APImageCreater.h"
#import "AFHTTPRequestOperationManager.h"
#import <Realm/Realm.h>
#import "APAlbum.h"
@interface APImageCreater()

@end
@implementation APImageCreater

-(void)createDataAlbum:(NSString*)url name:(NSString*)name{
    RLMRealm *realm  = [RLMRealm defaultRealm];
   
    APAlbum * album = [[APAlbum alloc]init];
    //[realm beginWriteTransaction];
    album.ts = [[NSDate date] timeIntervalSince1970];
    album.title = name;
   [realm transactionWithBlock:^{
       [realm addObject:album];
   }];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_apply(50, queue, ^(size_t index) {
        [self startLoadingData:url inAlbum:name];
    });
}

-(void)startLoadingData:(NSString*) url inAlbum:(NSString *)albumName{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    AFImageResponseSerializer *serializer = [[AFImageResponseSerializer alloc] init];
    serializer.acceptableContentTypes = [serializer.acceptableContentTypes setByAddingObject:@"image/pjpeg"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = serializer;
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        UIImage *image = (UIImage*)responseObject;
        RLMRealm *realm = [RLMRealm defaultRealm];
       
        RLMResults *result = [[APAlbum allObjects] objectsWithPredicate:
                              [NSPredicate predicateWithFormat:
                               @"title = %@", albumName]];
        
        APAlbum *albumModel = [result lastObject];
        if (!albumModel) {
            return;
        }
        APImage *imgModel = [[APImage alloc]init];
         [realm beginWriteTransaction];
        imgModel.imageData = UIImageJPEGRepresentation(image, 0.f);
        imgModel.ts = [[NSDate date] timeIntervalSince1970];
        [albumModel.allImage addObject:imgModel];
        [realm commitWriteTransaction];
        
        NSLog(@"Album:%@ have %lu image", albumModel.title, (unsigned long)albumModel.allImage.count);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
    [operation start];
}
@end
