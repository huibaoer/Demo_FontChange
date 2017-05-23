//
//  RootViewController.m
//  Font_change
//
//  Created by zhanght on 15/7/31.
//  Copyright (c) 2015年 haitao. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *familyNames;
@property (strong, nonatomic) NSArray *oldFamilyNames;
@property (strong, nonatomic) NSMutableArray *addedFamilyNames;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _familyNames = [UIFont familyNames];
    _addedFamilyNames = [NSMutableArray array];
    
    //use logFamilyNamesArray to log current familyNames for changing the _oldFamilyNames array
    [self logFamilyNamesArray];
    _oldFamilyNames = @[@"Marion", @"Copperplate", @"Heiti SC", @"Iowan Old Style", @"Courier New", @"Apple SD Gothic Neo", @"Heiti TC", @"Gill Sans", @"Marker Felt", @"Thonburi", @"Avenir Next Condensed", @"Tamil Sangam MN", @"Helvetica Neue", @"Gurmukhi MN", @"Times New Roman", @"Georgia", @"Apple Color Emoji", @"Arial Rounded MT Bold", @"Kailasa", @"Kohinoor Devanagari", @"Sinhala Sangam MN", @"Chalkboard SE", @"Superclarendon", @"Gujarati Sangam MN", @"Damascus", @"Noteworthy", @"Geeza Pro", @"Avenir", @"Academy Engraved LET", @"Mishafi", @"Futura", @"Farah", @"Kannada Sangam MN", @"Arial Hebrew", @"Arial", @"Party LET", @"Chalkduster", @"Hiragino Kaku Gothic ProN", @"Hoefler Text", @"Optima", @"Palatino", @"Malayalam Sangam MN", @"Lao Sangam MN", @"Al Nile", @"Bradley Hand", @"Hiragino Mincho ProN", @"Trebuchet MS", @"Helvetica", @"Courier", @"Cochin", @"Devanagari Sangam MN", @"Oriya Sangam MN", @"Snell Roundhand", @"Zapf Dingbats", @"Bodoni 72", @"Verdana", @"American Typewriter", @"Avenir Next", @"Baskerville", @"Khmer Sangam MN", @"Didot", @"Savoye LET", @"Bodoni Ornaments", @"Symbol", @"Menlo", @"Bodoni 72 Smallcaps", @"DIN Alternate", @"Papyrus", @"Euphemia UCAS", @"Telugu Sangam MN", @"Bangla Sangam MN", @"Zapfino", @"Bodoni 72 Oldstyle", @"DIN Condensed"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)buttonAction:(id)sender {
    
    self.addedFamilyNames = [NSMutableArray array];
    for (NSString *name in self.familyNames) {
        BOOL isNew = YES;
        for (NSString *oldName in self.oldFamilyNames) {
            if ([name isEqualToString:oldName]) {
                isNew = NO;
                break;
            }
        }
        if (isNew) {
            [self.addedFamilyNames addObject:name];
        }
    }
    if (self.addedFamilyNames.count > 0) {
        NSMutableString *resultStr = [NSMutableString string];
        for (int i = 0; i < self.addedFamilyNames.count; i++) {
            [resultStr appendFormat:@"%d.%@\n", i+1, [self.addedFamilyNames objectAtIndex:i]];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"发现新字体,已标为红色!" message:resultStr delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [self.tableView reloadData];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"没有发现新字体" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)logFamilyNamesArray {
    NSMutableString *resultStr = [NSMutableString stringWithFormat:@"@["];
    for (NSString *familyName in self.familyNames) {
        [resultStr appendFormat:@"@\"%@\", ", familyName];
    }
    [resultStr replaceCharactersInRange:NSMakeRange(resultStr.length-2, 2) withString:@"]"];
    NSLog(@"familyNames : %@", resultStr);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.familyNames.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *familyName = [self.familyNames objectAtIndex:section];
    return [UIFont fontNamesForFamilyName:familyName].count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
    UILabel *label = [[UILabel alloc] initWithFrame:headerView.frame];
    [headerView addSubview:label];
    NSString *familyName = [self.familyNames objectAtIndex:section];
    label.text = familyName;
    headerView.backgroundColor = [UIColor grayColor];
    for (NSString *name in self.addedFamilyNames) {
        if ([familyName isEqualToString:name]) {
            headerView.backgroundColor = [UIColor redColor];
        }
    }
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    NSString *familyName = [self.familyNames objectAtIndex:indexPath.section];
    NSString *fontName = [[UIFont fontNamesForFamilyName:familyName] objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:fontName size:16];
    cell.textLabel.text = fontName;
    return cell;
}

@end
