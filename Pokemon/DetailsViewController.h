//
//  DetailsViewController.h
//  Pokemon
//
//  Created by SMMC on 05/09/2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController

@property NSString* name;
@property NSString* imageUrl;
@property (nonatomic, copy) NSArray* stats;
@property (nonatomic, copy) NSArray* types;

@end

NS_ASSUME_NONNULL_END
