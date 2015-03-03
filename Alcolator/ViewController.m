//
//  ViewController.m
//  Alcolator
//
//  Created by Dorian Kusznir on 3/3/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *beerPercentTextField;
@property (weak, nonatomic) IBOutlet UISlider *beerCountSlider;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfBeersSelected;

- (void)calculateBeerToWine;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)textFieldDidChange:(UITextField *)sender
{
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    
    if (enteredNumber == 0)
    {
        sender.text = nil;
    }
}

- (IBAction)sliderValueDidChange:(UISlider *)sender
{
    NSLog(@"Slider value changed to %f", sender.value);
    
    float numberOfBeersFloat = sender.value;
    int numberOfBeersInt = (int) numberOfBeersFloat;
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"Number of Beers: %d", nil), numberOfBeersInt];
    self.numberOfBeersSelected.text = resultText;
    
    [self calculateBeerToWine];
    
    [self.beerPercentTextField resignFirstResponder];
}

- (IBAction)buttonPressed:(UIButton *)sender
{
    [self.beerPercentTextField resignFirstResponder];
    [self calculateBeerToWine];
}

- (IBAction)tapGestureDidFire:(UITapGestureRecognizer *)sender
{
    [self.beerPercentTextField resignFirstResponder];
}

- (void)calculateBeerToWine
{
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12;
    
    //Calculate alcohol content in beer:
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    //Calculate equivalent amount per wine:
    float ouncesInOneWineGlass = 5;
    float alcoholPercentageOfWine = 0.13;
    
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    float numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass;
    
    NSString *beerText;
    
    if (numberOfBeers == 1)
    {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    }
    
    else
    {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    NSString *wineText;
    
    if (numberOfWineGlassesForEquivalentAlcoholAmount == 1)
    {
        wineText = NSLocalizedString(@"glass", @"singular glass");
    }
    
    else
    {
        wineText = NSLocalizedString(@"glasses", @"plural of glass");
    }
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.02f %@ of wine", nil), numberOfBeers, beerText, numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
    
    self.resultLabel.text = resultText;
}


@end
