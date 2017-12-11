//
//  CardCollectionViewController.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 12/8/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "CardCollectionViewController.h"
#import "CardCell.h"
#import "Character.h"
#import "CharacterDataSource.h"
#import "LineViewLayout.h"
#import "GridViewLayout.h"
#import <AVFoundation/AVFoundation.h>

@interface CardCollectionViewController () <GridViewLayoutDelegate>

@property (nonatomic, strong) NSMutableArray<Character *> *characters;
@property (weak, nonatomic) IBOutlet UISwitch *gridSwitcher;

@end

@implementation CardCollectionViewController

+ (instancetype)instantiateFromStoryboard {
    UIStoryboard *card = [UIStoryboard storyboardWithName:@"Cards" bundle:nil];
    CardCollectionViewController *controller = [card instantiateViewControllerWithIdentifier:@"CardNavigationView"];
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.gridSwitcher addTarget:self action:@selector(changeCollectionLayout) forControlEvents:UIControlEventValueChanged];
    
    if ([self.collectionViewLayout isKindOfClass:[LineViewLayout class]]) {
        LineViewLayout *layout = self.collectionViewLayout;
        layout.minimumLineSpacing = - (layout.itemSize.width * 0.5);
    } else if ([self.collectionViewLayout isKindOfClass:[GridViewLayout class]]) {
        GridViewLayout *gridLayout = self.collectionViewLayout;
        gridLayout.numberOfColums = 2;
        gridLayout.delegate = self;
        self.collectionView.contentInset = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
        gridLayout.padding = 5.0;
    }
    
}

- (void)changeCollectionLayout {
    if ([self.collectionViewLayout isKindOfClass:[LineViewLayout class]]) {
        GridViewLayout *gridLayout = [[GridViewLayout alloc] init];
        gridLayout.numberOfColums = 2;
        gridLayout.delegate = self;
        self.collectionView.contentInset = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
        gridLayout.padding = 5.0;
        [self.collectionView setCollectionViewLayout:gridLayout animated:YES];
    } else {
        LineViewLayout *lineLayout = [[LineViewLayout alloc] init];
        lineLayout.minimumLineSpacing = - (lineLayout.itemSize.width * 0.5);
        [self.collectionView setCollectionViewLayout:lineLayout animated:YES];
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.characters.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CardCell class]) forIndexPath:indexPath];
    Character *character = self.characters[indexPath.row];
    
    cell.characterNameLabel.text = character.name;
    cell.characterImageView.image = [UIImage imageNamed:character.name];
    cell.characterInfoLabel.text = character.info;
    return cell;
}

#pragma mark - Lazy Load

- (NSMutableArray<Character *> *)characters {
    if (!_characters) {
        _characters = [[CharacterDataSource characters] mutableCopy];
    }
    return _characters;
}

#pragma mark - CustomViewControllerDelegate

- (CGFloat)collectionView:(UICollectionView *)collectionView heightForImageAtIndexPath:(NSIndexPath *)indexPath withWidth:(CGFloat)width {
    
    Character *character = self.characters[indexPath.row];
    UIImage *image = [UIImage imageNamed:character.name];
    CGRect boundingRect = CGRectMake(0.0, 0.0, width, CGFLOAT_MAX);
    CGRect resultRect = AVMakeRectWithAspectRatioInsideRect(image.size, boundingRect);
    
    return resultRect.size.height;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView heightForDescriptionAtIndexPath:(NSIndexPath *)indexPath withWidth:(CGFloat)width {
    
    Character *character = self.characters[indexPath.row];
    CGFloat descriptionHeight = [self heightForText:character.info withWidth:width-24];
    CGFloat height = 30 + 20 + descriptionHeight;
    
    return height;
}

- (CGFloat) heightForText:(NSString *)text withWidth: (CGFloat) width {
    UIFont *font = [UIFont systemFontOfSize:13];
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    
    return rect.size.height;
}

@end
