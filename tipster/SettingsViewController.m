//
//  SettingsViewController.m
//  Tipster
//
//  Created by  Palash Agrawal on 1/22/17.
//  Copyright © 2017  Palash Agrawal. All rights reserved.
//

#import "SettingsViewController.h"
#import "math.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISlider *minTipSlider;
@property (weak, nonatomic) IBOutlet UISlider *maxTipSlider;
@property (weak, nonatomic) IBOutlet UILabel *minTipLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxTipLabel;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Settings";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    float minTipValue = [defaults integerForKey:@"minTipValue"];
    float maxTipValue = [defaults integerForKey:@"maxTipValue"];
    self.minTipSlider.value = minTipValue;
    self.maxTipSlider.value = maxTipValue;
    self.minTipLabel.text = [NSString stringWithFormat:@"%.f%%", minTipValue];
    self.maxTipLabel.text = [NSString stringWithFormat:@"%.f%%", maxTipValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onMinTipChange:(UISlider *)sender {
    float minTipValue = MIN(self.maxTipSlider.value, self.minTipSlider.value);
    self.minTipSlider.value = minTipValue;
    self.minTipLabel.text = [NSString stringWithFormat:@"%.f%%", minTipValue];
    [self saveMinTipValue:minTipValue];
}

- (IBAction)onMaxTipChange:(UISlider *)sender {
    float maxTipValue = MAX(self.maxTipSlider.value, self.minTipSlider.value);
    self.maxTipSlider.value = maxTipValue;
    self.maxTipLabel.text = [NSString stringWithFormat:@"%.f%%", maxTipValue];
    [self saveMaxTipValue:maxTipValue];
}

- (void)saveMinTipValue:(int)minTipValue {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:minTipValue forKey:@"minTipValue"];
    [defaults synchronize];
}

- (void)saveMaxTipValue:(int)maxTipValue {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:maxTipValue forKey:@"maxTipValue"];
    [defaults synchronize];
}

@end
