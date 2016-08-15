//
//  DetailsViewController.m
//  authenticator
//
//  Created by Serge Golubenko on 15.08.16.
//  Copyright © 2016 Serge Golubenko. All rights reserved.
//

#import "DetailsViewController.h"
#import "AuthAPIManager.h"
#import "ProgressHUD.h"
#import "UIImageView+AFNetworking.h"
#import "UserProfile.h"

@interface DetailsViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = NSLocalizedString(@"User Detail", nil);

    self.profileImage.layer.cornerRadius = 10.0f;
    self.profileImage.layer.borderWidth = 2.0;
    self.profileImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.profileImage.clipsToBounds = YES;

    [self loadUserData];
}

- (void)loadUserData {
    [ProgressHUD show:NSLocalizedString(@"Loading data", nil) Interaction:NO];

    [[AuthAPIManager shared] loadUserDataSuccess:^(id responseObject) {
      [ProgressHUD showSuccess:NSLocalizedString(@"Success", nil)];
      [self updateUserData];
    }
        failure:^(NSError *error) {
          [ProgressHUD dismiss];
          UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"User Query Error", nil) message:NSLocalizedString(error.localizedDescription, nil) preferredStyle:UIAlertControllerStyleAlert];
          [self presentViewController:alert animated:YES completion:nil];
        }];
}

- (void)updateUserData {

    if ([AuthAPIManager shared].userProfile.profileImageURL.length) {
        [self.profileImage setImageWithURL:[NSURL URLWithString:[AuthAPIManager shared].userProfile.profileImageURL] placeholderImage:[UIImage imageNamed:@"avatar"]];
    }

    [self.tableView reloadData];
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([AuthAPIManager shared].userProfile) {
        return 3;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([AuthAPIManager shared].userProfile) {
        if (section == 0) {
            return 3;
        }
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 22.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGRect headerViewRect = CGRectMake(0, 0, tableView.frame.size.width, [self tableView:tableView heightForHeaderInSection:section]);
    UIView *headerView = [[UIView alloc] initWithFrame:headerViewRect];
    headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    UILabel *hText = [[UILabel alloc] initWithFrame:CGRectInset(headerView.bounds, 10, 4)];
    hText.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    hText.numberOfLines = 0;
    hText.textAlignment = NSTextAlignmentCenter;
    hText.backgroundColor = [UIColor clearColor];
    hText.font = [UIFont systemFontOfSize:17.0];
    hText.adjustsFontSizeToFitWidth = YES;
    hText.minimumScaleFactor = 0.5f;

    switch (section) {
        case 0:
            hText.text = NSLocalizedString(@"Personal", nil);
            break;
        case 1:
            hText.text = NSLocalizedString(@"Address", nil);
            break;
        case 2:
            hText.text = NSLocalizedString(@"Company", nil);
            break;

        default:
            break;
    }

    [headerView addSubview:hText];

    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"DetailCell"];
    }

    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = NSLocalizedString(@"E-Mail", nil);
                    cell.detailTextLabel.text = [AuthAPIManager shared].userProfile.eMail;
                    break;

                case 1:
                    cell.textLabel.text = NSLocalizedString(@"First Name", nil);
                    cell.detailTextLabel.text = [AuthAPIManager shared].userProfile.firstName;
                    break;

                case 2:
                    cell.textLabel.text = NSLocalizedString(@"Last Name", nil);
                    cell.detailTextLabel.text = [AuthAPIManager shared].userProfile.lastName;
                    break;

                default:
                    break;
            }
            break;

        case 1:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = NSLocalizedString(@"Country", nil);
                    cell.detailTextLabel.text = [[NSLocale systemLocale] displayNameForKey:NSLocaleCountryCode value:[AuthAPIManager shared].userProfile.countryCode];
                    break;

                case 1:
                    cell.textLabel.text = NSLocalizedString(@"First Name", nil);
                    cell.detailTextLabel.text = [AuthAPIManager shared].userProfile.firstName;
                    break;

                case 2:
                    cell.textLabel.text = NSLocalizedString(@"Last Name", nil);
                    cell.detailTextLabel.text = [AuthAPIManager shared].userProfile.lastName;
                    break;

                default:
                    break;
            }
            break;

        default:
            cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.section];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
            break;
    }

    return cell;
}

@end
