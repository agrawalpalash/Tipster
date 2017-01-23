//
//  ViewController.m
//  tipster
//
//  Created by  Palash Agrawal on 1/22/17.
//  Copyright © 2017  Palash Agrawal. All rights reserved.
//

#import "TipViewController.h"
#define FBOX(x) [NSNumber numberWithFloat:x]

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipPercent;

@property float minTipValue;
@property float midTipValue;
@property float maxTipValue;

@end

@implementation TipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Tip Calculator";
    [self initializeMinTipValue:15 andMaxTipValue:25];
    [self updateValues];
}

- (void)viewDidAppear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _minTipValue = [defaults integerForKey:@"minTipValue"];
    _maxTipValue = [defaults integerForKey:@"maxTipValue"];
    _midTipValue = (_minTipValue + _maxTipValue)/2;
    [_tipPercent setTitle:[NSString stringWithFormat:@"%.f%%", _minTipValue] forSegmentAtIndex:0];
    [_tipPercent setTitle:[NSString stringWithFormat:@"%.f%%", _midTipValue] forSegmentAtIndex:1];
    [_tipPercent setTitle:[NSString stringWithFormat:@"%.f%%", _maxTipValue] forSegmentAtIndex:2];
    [self updateValues];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (IBAction)onTipPercentChange:(UISegmentedControl *)sender {
    [self updateValues];
}


- (void)updateValues {
    NSArray *tipValues = @[@(_minTipValue),@(_midTipValue),@(_maxTipValue)];
    float billAmount = [self.billTextField.text floatValue];
    
    float tipAmount = [tipValues[self.tipPercent.selectedSegmentIndex] floatValue]/100 * billAmount;
    float totalAmount = billAmount + tipAmount;
    
    self.tipAmountLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalAmountLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
}

- (void) initializeMinTipValue:(int)minTipValue andMaxTipValue:(int)maxTipValue {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:minTipValue forKey:@"minTipValue"];
    [defaults setInteger:maxTipValue forKey:@"maxTipValue"];
    [defaults synchronize];
}

@end
