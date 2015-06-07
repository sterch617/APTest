//
//  APImage.h
//  testAP
//
//  Created by Sterch on 07.06.15.
//  Copyright (c) 2015 YauheniHindzin. All rights reserved.
//

#import <Realm/Realm.h>

@interface APImage : RLMObject
@property (strong, nonatomic) NSData *imageData;
@property (assign, nonatomic) double ts;
@end

RLM_ARRAY_TYPE(APImage)
