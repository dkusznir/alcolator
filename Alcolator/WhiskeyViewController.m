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

- (void)buttonPressed:(UIButton *)sender
{
    [self.beerPercentTextField resignFirstResponder];
    [self calculateBeerToNonBeerWithOunces:1 withPercentage:0.4 for:@"whiskey"];
    
}

@end
