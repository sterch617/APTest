//
//  APHeaderCollectoinView.m
//  testAP
//
//  Created by Sterch on 07.06.15.
//  Copyright (c) 2015 YauheniHindzin. All rights reserved.
//

#import "APHeaderCollectoinView.h"
#import <Realm/Realm.h>
@implementation APHeaderCollectoinView
- (IBAction)albumSelect:(id)sender {
    
    //сохраняем выбор пользователя по открытым альбомам, при перезапуске прилодения, выбор сохраниться
     [[RLMRealm defaultRealm] beginWriteTransaction];
    if (!self.album.isSelected) {
        self.album.isSelected = YES;
    } else {
        self.album.isSelected = NO;
    }
    [[RLMRealm defaultRealm]commitWriteTransaction];
    if (self.delegate) {
        [self.delegate didSelectAlbum];
    }
}
@end
