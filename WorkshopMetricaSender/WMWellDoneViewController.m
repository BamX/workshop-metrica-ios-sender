//
//  Copyright (c) 2015 Yandex. All rights reserved.
//

#import "WMWellDoneViewController.h"

static NSInteger const kWMLinesCount = 3;
static CGFloat const kWMFontSize = 24.0f;
static CGSize const kWMAgainButtonSize = { 100.0f, 30.0f };

@implementation WMWellDoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    CGRect labelFrame = { CGPointZero, { CGRectGetWidth(self.view.bounds), kWMFontSize } };
    UILabel *wellDoneLabel = [[UILabel alloc] initWithFrame:labelFrame];
    wellDoneLabel.numberOfLines = kWMLinesCount;
    wellDoneLabel.text = NSLocalizedString(@"WellDone", nil);
    wellDoneLabel.textAlignment = NSTextAlignmentCenter;
    wellDoneLabel.font = [UIFont systemFontOfSize:kWMFontSize];
    [wellDoneLabel sizeToFit];
    wellDoneLabel.center = self.view.center;
    [self.view addSubview:wellDoneLabel];

    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    doneButton.frame = (CGRect){ CGPointZero, kWMAgainButtonSize };
    doneButton.center = self.view.center;
    doneButton.frame =
        CGRectOffset(doneButton.frame, 0.0f, kWMAgainButtonSize.height + CGRectGetHeight(wellDoneLabel.frame));
    [doneButton setTitle:NSLocalizedString(@"Again", nil) forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(againButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:doneButton];
}

- (void)againButtonPressed
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
