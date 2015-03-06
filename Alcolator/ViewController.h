//
//  ViewController.h
//  Alcolator
//
//  Created by Dorian Kusznir on 3/3/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) UITextField *beerPercentTextField;
@property (weak, nonatomic) UILabel *resultLabel;
@property (weak, nonatomic) UISlider *beerCountSlider;
@property (weak, nonatomic) UILabel *numberOfBeersSelected;

- (void)buttonPressed:(UIButton *)sender;
- (CGFloat)calculateNonBeer:(float)ounces withPercentage:(float)percentage;
- (void)calculateBeerToNonBeerWithOunces:(float)ounces withPercentage:(float)percentage for:(NSString *)typeOfNonBeer;
- (void)sliderValueDidChange:(UISlider *)sender;



@end

