//
//  WhiskeyViewController.m
//  Alcolator
//
//  Created by Dorian Kusznir on 3/4/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "WhiskeyViewController.h"

@interface WhiskeyViewController ()

@end

@implementation WhiskeyViewController

- (instancetype) init
{
    self = [super init];
    
    if (self)
    {
        self.title = NSLocalizedString(@"Whiskey", @"Whiskey");
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)buttonPressed:(UIButton *)sender
{
    [self.beerPercentTextField resignFirstResponder];
    [self calculateBeerToNonBeerWithOunces:1 withPercentage:0.4 for:@"whiskey"];
}

- (void)sliderValueDidChange:(UISlider *)sender
{
    [super sliderValueDidChange:sender];
    float nonBeerEquivalent = [self calculateNonBeer:1 withPercentage:0.4];
    
    NSString *titleText;
    
    if (nonBeerEquivalent == 1)
    {
        titleText = @"shot";
    }
    
    else
    {
        titleText = @"shots";
    }
    
    self.title = [NSString stringWithFormat:NSLocalizedString(@"Whiskey (%.02f %@)", nil), nonBeerEquivalent, titleText];

}


@end
