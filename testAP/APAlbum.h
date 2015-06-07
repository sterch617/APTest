//
//  APAlbum.h
//  testAP
//
//  Created by Sterch on 07.06.15.
//  Copyright (c) 2015 YauheniHindzin. All rights reserved.
//

#import <Realm/Realm.h>
#import "APImage.h"
@interface APAlbum : RLMObject
@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) BOOL isSelected;
@property (assign, nonatomic) double ts;
@property RLMArray <APImage> *allImage;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<APAlbum>
RLM_ARRAY_TYPE(APAlbum)
