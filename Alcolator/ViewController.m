//
//  ViewController.m
//  Alcolator
//
//  Created by Dorian Kusznir on 3/3/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "ViewController.h"
#import <sys/utsname.h>

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define LANDSCAPE (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
#define PORTRAIT (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation))

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) UIButton *calculateButton;
@property (weak, nonatomic) UITapGestureRecognizer *hideKeyboardTapGestureRecognizer;

@end

@implementation ViewController

- (instancetype) init
{
    self = [super init];
    
    if (self)
    {
        self.title = NSLocalizedString(@"Wine", @"Wine");
        [self.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -18)];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIColor *niceDarkBlueColor = [UIColor colorWithRed:51.0/255.0 green:125.0/255.0 blue:199.0/255.0 alpha:1.0];
    UIColor *minimumTintForSlider = [UIColor colorWithRed:200.0/255.0 green:225.0/255.0 blue:200.0/255.0 alpha:1.0];
    UIColor *backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    self.view.backgroundColor = backgroundColor;
    
    //Setting up beer text field:
    self.beerPercentTextField.delegate = self;
    self.beerPercentTextField.backgroundColor = backgroundColor;
    self.beerPercentTextField.textColor = niceDarkBlueColor;
    self.beerPercentTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.beerPercentTextField.font = [UIFont fontWithName:@"Helvetica Neue" size:20];

    
    self.beerPercentTextField.placeholder = NSLocalizedString(@"% Alcohol Content Per Beer", @"Beer percent placeholder text");
    
    //Setting up beer count slider:
    [self.beerCountSlider addTarget:self action:@selector(sliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
    self.beerCountSlider.minimumTrackTintColor = niceDarkBlueColor;
    self.beerCountSlider.maximumTrackTintColor = minimumTintForSlider;
    [self.beerCountSlider setThumbTintColor:niceDarkBlueColor];
    
    self.beerCountSlider.minimumValue = 1;
    self.beerCountSlider.maximumValue = 10;
    
    //Setting up number of beers selected:
    self.numberOfBeersSelected.textColor = niceDarkBlueColor;
    self.numberOfBeersSelected.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
    self.numberOfBeersSelected.textAlignment = NSTextAlignmentCenter;
    
    //Setting up result label:
    self.resultLabel.textColor = niceDarkBlueColor;
    self.resultLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    self.resultLabel.textAlignment = NSTextAlignmentCenter;
    
    
    //Setting up 'Calculate' button:
    [self.calculateButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.calculateButton setTitle:NSLocalizedString(@"Calculate!", @"Calculate command") forState:UIControlStateNormal];
    self.calculateButton.backgroundColor = niceDarkBlueColor;
    self.calculateButton.layer.cornerRadius = 10;
    self.calculateButton.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:30];
    [self.calculateButton setTitleColor: backgroundColor forState:UIControlStateNormal];
    
    //Setting up tap gesture:
    [self.hideKeyboardTapGestureRecognizer addTarget:self action:@selector(tapGestureDidFire:)];
    
    self.resultLabel.numberOfLines = 0;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    self.view = [[UIView alloc] init];
    
    UITextField *textField = [[UITextField alloc] init];
    UISlider *slider = [[UISlider alloc] init];
    UILabel *beersSelectedLabel = [[UILabel alloc] init];
    UILabel *label = [[UILabel alloc] init];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    
    [self.view addSubview:textField];
    [self.view addSubview:slider];
    [self.view addSubview:beersSelectedLabel];
    [self.view addSubview:label];
    [self.view addSubview:button];
    [self.view addGestureRecognizer:tap];
    
    self.beerPercentTextField = textField;
    self.beerCountSlider = slider;
    self.numberOfBeersSelected = beersSelectedLabel;
    self.resultLabel = label;
    self.calculateButton = button;
    self.hideKeyboardTapGestureRecognizer = tap;
    
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return ( UIInterfaceOrientationMaskAll );
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
     
    if (IS_IPHONE_6)
    {
        
        if (PORTRAIT)
        {
            
            [self makeUIElements:375 withPadding:20 withItemHeight:44];
            
        }
        
        else if (LANDSCAPE)
        {
            
            [self makeUIElements:667 withPadding:15 withItemHeight:40];
            
        }
    }

    else if (IS_IPHONE_6P)
    {
        if (PORTRAIT)
        {
            
            [self makeUIElements:414 withPadding:20 withItemHeight:44];
            
        }
        
        else if (LANDSCAPE)
        {
            
            [self makeUIElements:736 withPadding:20 withItemHeight:40];
            
        }
    }

    else if (IS_IPHONE_5)
    {
        if (PORTRAIT)
        {
            
            [self makeUIElements:320 withPadding:20 withItemHeight:44];
            
        }
        
        else if (LANDSCAPE)
        {
            
            [self makeUIElements:568 withPadding:10 withItemHeight:40];
            
        }
    }
    
    else if (IS_IPHONE_4_OR_LESS)
    {
        if (PORTRAIT)
        {
            
            [self makeUIElements:320 withPadding:20 withItemHeight:44];
        
        }
        
        else if (LANDSCAPE)
        {
            
            [self makeUIElements:480 withPadding:10 withItemHeight:40];
        
        }
    }
    
    
    else if (IS_RETINA)
    {
        if (PORTRAIT)
        {
            
            [self makeUIElements:768 withPadding:20 withItemHeight:44];
        
        }
        
        else if (LANDSCAPE)
        {
            
            [self makeUIElements:1024 withPadding:20 withItemHeight:40];
        
        }
    }
    
    else if (IS_IPAD)
    {
        if (PORTRAIT)
        {
            
            [self makeUIElements:768 withPadding:20 withItemHeight:44];
        
        }
        
        else if (LANDSCAPE)
        {
            
            [self makeUIElements:1024 withPadding:20 withItemHeight:40];
        
        }
    }

}

- (void)makeUIElements:(CGFloat)enterViewWidth withPadding:(CGFloat)enterPadding withItemHeight:(CGFloat)enterItemHeight
{
    CGFloat viewWidth = enterViewWidth;
    CGFloat padding = enterPadding;
    CGFloat itemHeight = enterItemHeight;
    CGFloat itemWidth = viewWidth - padding - padding;
    
    self.beerPercentTextField.frame = CGRectMake(padding, (padding + padding + padding + padding), itemWidth, itemHeight);
    
    CGFloat bottomOfTextField = CGRectGetMaxY(self.beerPercentTextField.frame);
    self.beerCountSlider.frame = CGRectMake(padding, (bottomOfTextField + padding), itemWidth, itemHeight);
    
    CGFloat bottomOfSlider = CGRectGetMaxY(self.beerCountSlider.frame);
    self.numberOfBeersSelected.frame = CGRectMake(padding, (bottomOfSlider + padding), itemWidth, itemHeight);
    
    CGFloat bottomOfNumberOfBeersSelected = CGRectGetMaxY(self.numberOfBeersSelected.frame);
    self.resultLabel.frame = CGRectMake(padding, (bottomOfNumberOfBeersSelected + padding), itemWidth, itemHeight);
    
    CGFloat bottomOfLabel = CGRectGetMaxY(self.resultLabel.frame);
    self.calculateButton.frame = CGRectMake(padding, (bottomOfLabel + padding), itemWidth, itemHeight);
}

- (void)textFieldDidChange:(UITextField *)sender
{
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    
    if (enteredNumber == 0)
    {
        sender.text = nil;
    }
}

- (void)sliderValueDidChange:(UISlider *)sender
{
    NSLog(@"Slider value changed to %f", sender.value);
    
    float numberOfBeersFloat = sender.value;
    int numberOfBeersInt = (int) numberOfBeersFloat;
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"Number of Beers: %d", nil), numberOfBeersInt];
    self.numberOfBeersSelected.text = resultText;
    
    float nonBeerEquivalent = [self calculateNonBeer:5 withPercentage:0.13];
    
    NSString *titleText;
    
    if (nonBeerEquivalent == 1)
    {
        titleText = @"glass";
    }
    
    else
    {
        titleText = @"glasses";
    }
    
    self.title = [NSString stringWithFormat:NSLocalizedString(@"Wine (%.02f %@)", nil), nonBeerEquivalent, titleText];
    
    //[self.beerPercentTextField resignFirstResponder];
    
    [self.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d", (int)sender.value]];
}

- (void)buttonPressed:(UIButton *)sender
{
    [self.beerPercentTextField resignFirstResponder];
    [self calculateBeerToNonBeerWithOunces:5 withPercentage:0.13 for:@"wine"];
}

- (void)tapGestureDidFire:(UITapGestureRecognizer *)sender
{
    [self.beerPercentTextField resignFirstResponder];
}

- (CGFloat)calculateNonBeer:(float)ounces withPercentage:(float)percentage
{
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12;
    float ouncesInNonBeer = ounces;
    float percentageAlcoholInNonBeer = percentage;
    
    //Calculate alcohol content in beer:
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    float ouncesOfAlcoholPerNonBeer = ouncesInNonBeer * percentageAlcoholInNonBeer;
    float numberOfNonBeerForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerNonBeer;
    
    return numberOfNonBeerForEquivalentAlcoholAmount;
}

- (void)calculateBeerToNonBeerWithOunces:(float)ounces withPercentage:(float)percentage for:(NSString *)typeOfNonBeer
{
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12;
    float ouncesInNonBeer = ounces;
    float percentageAlcoholInNonBeer = percentage;
    
    //Calculate alcohol content in beer:
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    float ouncesOfAlcoholPerNonBeer = ouncesInNonBeer * percentageAlcoholInNonBeer;
    float numberOfNonBeerForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerNonBeer;
    
    NSString *beerText;
    
    if (numberOfBeers == 1)
    {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    }
    
    else
    {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    NSString *nonBeerText;
    
    if ([typeOfNonBeer isEqualToString:@"wine"])
    {
    
        if (numberOfNonBeerForEquivalentAlcoholAmount == 1)
        {
            nonBeerText = NSLocalizedString(@"glass", @"singular glass");
        }
    
        else
        {
            nonBeerText = NSLocalizedString(@"glasses", @"plural of glass");
        }
    
        NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.02f %@ of %@.", nil), numberOfBeers, beerText, numberOfNonBeerForEquivalentAlcoholAmount, nonBeerText, typeOfNonBeer];
    
        self.resultLabel.text = resultText;
    }
    
    else if ([typeOfNonBeer isEqualToString:@"whiskey"])
    {
        if (numberOfNonBeerForEquivalentAlcoholAmount == 1)
        {
            nonBeerText = NSLocalizedString(@"shot", @"singular shot");
        }
        
        else
        {
            nonBeerText = NSLocalizedString(@"shots", @"shots");
        }
        
        NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.02f %@ of %@.", nil), numberOfBeers, beerText, numberOfNonBeerForEquivalentAlcoholAmount, nonBeerText, typeOfNonBeer];
        
        self.resultLabel.text = resultText;
    }
}

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    textField.placeholder = NSLocalizedString(@"% Alcohol Content Per Beer", @"Beer percent placeholder text");
    //Notice that this works (when user taps anywhere outside textField, the textField content changes accordingly":
    //textField.placeholder = NSLocalizedString(@"% Alcohol Content Per Beer", @"Beer percent placeholder text");
}

@end
