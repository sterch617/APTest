//
//  APHeaderCollectoinView.h
//  testAP
//
//  Created by Sterch on 07.06.15.
//  Copyright (c) 2015 YauheniHindzin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APAlbum.h"
@class APHeaderCollectoinView;
@protocol APHeaderCollectoinViewDeleate  <NSObject>
-(void)didSelectAlbum;
@end

@interface APHeaderCollectoinView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIButton *btnTitle;
@property (strong, nonatomic) APAlbum *album;
@property (weak, nonatomic) NSObject <APHeaderCollectoinViewDeleate> *delegate;
@end
