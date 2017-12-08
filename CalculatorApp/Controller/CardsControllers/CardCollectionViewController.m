//
//  CardCollectionViewController.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 12/8/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "CardCollectionViewController.h"
#import "CardCollectionViewCell.h"
#import "Character.h"
#import "CharacterDataSource.h"

@interface CardCollectionViewController ()

@property (nonatomic, strong) NSMutableArray<Character *> *characters;
@property (weak, nonatomic) IBOutlet UISwitch *gridSwitcher;

@end

@implementation CardCollectionViewController

+ (instancetype)instantiateFromStoryboard {
    UIStoryboard *card = [UIStoryboard storyboardWithName:@"Cards" bundle:nil];
    CardCollectionViewController *controller = [card instantiateViewControllerWithIdentifier:NSStringFromClass([CardCollectionViewController class])];
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([CardCollectionViewCell class])];
    
    // Do any additional setup after loading the view.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.characters.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CardCollectionViewCell class]) forIndexPath:indexPath];
    Character *character = self.characters[indexPath.row];
    
    cell.characterNameLabel.text = character.name;
    cell.characterImageView.image = [UIImage imageNamed:character.name];
    cell.characterDescriptionLabel.text = character.info;
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

#pragma mark - Lazy Load

- (NSMutableArray<Character *> *)characters {
    if (!_characters) {
        _characters = [[CharacterDataSource characters] mutableCopy];
    }
    return _characters;
}

@end
