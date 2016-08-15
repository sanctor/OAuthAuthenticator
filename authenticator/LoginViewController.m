//
//  ViewController.m
//  authenticator
//
//  Created by Serge Golubenko on 15.08.16.
//  Copyright © 2016 Serge Golubenko. All rights reserved.
//

#import "LoginViewController.h"
#import "AuthAPIManager.h"
#import "DetailsViewController.h"
#import "Utils.h"

@interface LoginViewController () <UIWebViewDelegate>
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = NSLocalizedString(@"Login", nil);

    if (![AuthAPIManager shared].authenticated) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[AuthAPIManager shared].loginURL]];
    } else {
        [self navigateToDetail];
    }
}

- (void)navigateToDetail {
    DetailsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];

    [self.navigationController setViewControllers:@[ vc ] animated:YES];

    //    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://accounts.matrix42.com/my/#/account"]]];
}

- (void)authWithCode:(NSString *)authCode {
    [[AuthAPIManager shared] authenticateWithCode:authCode
        success:^(id responseObject) {
          if ([AuthAPIManager shared].authenticated) {
              [self navigateToDetail];
          }
        }
        failure:^(NSError *error) {
          UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Login Error", nil) message:NSLocalizedString(error.localizedDescription, nil) preferredStyle:UIAlertControllerStyleAlert];
          [self presentViewController:alert animated:YES completion:nil];
        }];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *reqURL = request.URL;

    NSLog(@"Request URL: %@", reqURL.absoluteString);
    if ([reqURL.scheme isEqualToString:@"sgauth"]) {
        NSDictionary *params = [Utils parametersFromQueryString:reqURL.query];
        if (params) {
            NSString *code = params[@"code"];

            if (code.length) {
                [self authWithCode:code];
            }
        }

        return NO;
    }

    return YES;
}

- (void)dealloc {
    self.webView = nil;
}

@end
