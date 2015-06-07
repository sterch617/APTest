//
//  ViewController.m
//  testAP
//
//  Created by Sterch on 06.06.15.
//  Copyright (c) 2015 YauheniHindzin. All rights reserved.
//

#import "APImageSelectorVC.h"
#import <Realm/Realm.h>
#import "APAlbum.h"
#import "APImageCell.h"
#import "APHeaderCollectoinView.h"
#import "APFooterCollectionView.h"


@interface APImageSelectorVC () <UICollectionViewDataSource, UICollectionViewDelegate, APHeaderCollectoinViewDeleate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *selectedItems;

@property (strong, nonatomic) RLMResults *albums;

@end

@implementation APImageSelectorVC

- (void)viewDidLoad {
    [super viewDidLoad];
      self.albums = [APAlbum allObjects];
    self.selectedItems = [NSMutableArray array];
    self.collectionView.delegate = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"APImageCell" bundle:nil] forCellWithReuseIdentifier:@"APImageCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewDidLayoutSubviews {
    UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(0, 0, 20, 0);
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectedItems.count <= 20) {
        APAlbum *album = [self.albums objectAtIndex:indexPath.section];
        [self.selectedItems addObject:[album.allImage objectAtIndex:indexPath.row]];
        NSNumber *count = @(self.selectedItems.count);
        [[NSNotificationCenter defaultCenter]postNotificationName:@"cellSelecter" object:nil
                                                         userInfo:@{@"count": count}];
        
    }
    
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.albums.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
     UICollectionReusableView *vMain = nil;
   
    if (kind == UICollectionElementKindSectionHeader) {
         APAlbum *mainAlbum = [self.albums objectAtIndex:indexPath.section];
        APHeaderCollectoinView *view = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"cellHeader" forIndexPath:indexPath];
        
        [view.btnTitle setTitle:mainAlbum.title forState:UIControlStateNormal];
        view.album = mainAlbum;
        view.delegate = self;
        vMain = view;
    }
    
    return vMain;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    APAlbum *album = [self.albums objectAtIndex:section];
    if (!album.isSelected) {
        return 0;
    }
    return album.allImage.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    APImageCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"APImageCell" forIndexPath:indexPath];
    APAlbum *album = [self.albums objectAtIndex:indexPath.section];
    APImage *img = [album.allImage objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageWithData:img.imageData];
    
    return cell;
}

-(void)didSelectAlbum {
    self.albums = [APAlbum allObjects];
    [self.collectionView reloadData];
}

@end
