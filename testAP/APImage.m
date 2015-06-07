//
//  APImage.m
//  testAP
//
//  Created by Sterch on 07.06.15.
//  Copyright (c) 2015 YauheniHindzin. All rights reserved.
//

#import "APImage.h"

@implementation APImage
- (NSArray *)owners {
    return [self linkingObjectsOfClass:@"APAlbum" forProperty:@"allImage"];
}
@end
