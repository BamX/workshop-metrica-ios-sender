//
//  Copyright (c) 2015 Yandex. All rights reserved.
//

#import "WMViewController.h"
#import "WMWellDoneViewController.h"

#import <YandexMobileMetrica/YandexMobileMetrica.h>

static NSString *const kWMEventName = @"user_info";
static NSString *const kWMSuccessButtonTag = @"success";

@implementation WMViewController

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        [self configureForm];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = NSLocalizedString(@"AppTitle", nil);
}

- (void)configureForm
{
    XLFormDescriptor *form = [XLFormDescriptor formDescriptor];
    XLFormSectionDescriptor *section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];

    [section addFormRow:[self rowForKey:@"age"
                                 values:@[ @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25" ]]];
    [section addFormRow:[self rowForKey:@"gender"
                                 values:@[ @"Male", @"Female" ]]];
    [section addFormRow:[self rowForKey:@"education"
                                 values:@[ @"Course1", @"Course2", @"Course3", @"Course4", @"Course5", @"Master" ]]];
    [section addFormRow:[self rowForKey:@"work"
                                 values:@[ @"SearchingFor", @"WorkingOk", @"WorkingBad" ]]];
    [section addFormRow:[self rowForKey:@"absence"
                                 values:@[ @"Working", @"Personal", @"Lazy", @"NotAbsence" ]]];
    [section addFormRow:[self rowForKey:@"rating"
                                 values:@[ @"Good", @"Some", @"Bad", @"WhereAmI" ]]];

    [form addFormSection:[self successButtonSection]];

    self.form = form;
}

- (XLFormRowDescriptor *)rowForKey:(NSString *)key values:(NSArray *)values
{
    XLFormRowDescriptor *row =
        [XLFormRowDescriptor formRowDescriptorWithTag:key
                                              rowType:XLFormRowDescriptorTypeSelectorAlertView
                                                title:NSLocalizedString(key, nil)];

    NSMutableArray *options = [NSMutableArray array];
    for (NSString *value in values) {
        [options addObject:NSLocalizedString(value, nil)];
    }
    row.selectorOptions = [options copy];
    row.value = options.firstObject;
    
    return row;
}

- (XLFormSectionDescriptor *)successButtonSection
{
    XLFormSectionDescriptor *section = [XLFormSectionDescriptor formSection];
    XLFormRowDescriptor *row =
        [XLFormRowDescriptor formRowDescriptorWithTag:kWMSuccessButtonTag
                                              rowType:XLFormRowDescriptorTypeButton
                                                title:NSLocalizedString(@"Send", nil)];
    row.action.formSelector = @selector(didTouchSuccessButton:);
    [section addFormRow:row];
    
    return section;
}

- (void)didTouchSuccessButton:(XLFormRowDescriptor *)sender
{
    NSMutableDictionary *data = [self.form.formValues mutableCopy];
    [data removeObjectForKey:kWMSuccessButtonTag];

    [YMMYandexMetrica reportEvent:kWMEventName parameters:data onFailure:nil];
    [YMMYandexMetrica sendEventsBuffer];

    UIViewController *nextViewController = [[WMWellDoneViewController alloc] init];
    [self presentViewController:nextViewController animated:YES completion:nil];
}

@end
