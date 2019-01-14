//
//  ViewController.m
//  sphtech
//
//  Created by Michael Ugale on 1/14/19.
//  Copyright © 2019 Michael Ugale. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:@"10" forKey:@"limit"];
    
    [[ServerManager sharedManager] getDataList:dictionary
                                       success:^(NSDictionary *responseObject) {
                                           SPLOG_DEBUG(@"DATA LIST: %@",responseObject);
        
                                       } failure:^(NSError *error) {
                                           SPLOG_DEBUG(@"DATA LIST: %@",error);
                                       }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
