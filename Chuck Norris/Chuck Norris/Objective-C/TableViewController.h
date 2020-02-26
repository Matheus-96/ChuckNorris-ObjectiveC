//
//  TableViewController.h
//  Chuck Norris
//
//  Created by Matheus Rodrigues Araujo on 24/01/20.
//  Copyright © 2020 Maria Luiza Carvalho Sperotto. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewController :  UIViewController < UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)shuffle:(id)sender;
- (IBAction)refresh:(id)sender;

- (NSArray*)parse:(NSString*)url;

@end

NS_ASSUME_NONNULL_END
