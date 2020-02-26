//
//  TableViewController.m
//  Chuck Norris
//
//  Created by Matheus Rodrigues Araujo on 24/01/20.
//  Copyright © 2020 Maria Luiza Carvalho Sperotto. All rights reserved.

#import "TableViewController.h"
#import "Chuck_Norris-Swift.h"

@interface TableViewController () 

@end

@implementation TableViewController
{
    NSMutableArray *categories;
    NSArray *aux;
    NSString *selectedCategorie;
    DetailViewController *controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Choose a category";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    NSString *url = @"https://api.chucknorris.io/jokes/categories";
    aux = [self parse : url];

    categories = [NSMutableArray arrayWithArray:aux];

}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [categories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Category" forIndexPath:indexPath];
    cell.textLabel.text = [ categories objectAtIndex:indexPath.row ];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedCategorie = [ categories objectAtIndex:indexPath.row ];
    [self performSegueWithIdentifier:@"Detail" sender: nil];
}

#pragma mark - Navigation

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier  isEqual: @"Detail"]){
        DetailViewController *controller = [segue destinationViewController];
        controller.selectedCategory = selectedCategorie;
    }
}

#pragma mark - Actions

- (IBAction)shuffle:(id)sender {
    NSUInteger counter = [categories count];
    for (NSUInteger i = 0; i < counter; i++){
        int random1 = arc4random() % counter;
        int random2 = arc4random() % counter;
        [categories exchangeObjectAtIndex:random1 withObjectAtIndex:random2];
    }
    [self.tableView reloadData ];
}

- (IBAction)refresh:(id)sender {
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:nil ascending:true ];
    aux = [categories sortedArrayUsingDescriptors:@[sort]];
    categories = [NSMutableArray arrayWithArray:aux];
    [self.tableView reloadData ];
}
#pragma mark - Methods

- (NSArray*)parse:(NSString*)url{
    
    NSURLRequest *Request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLResponse *resp = nil;
    NSError *erro = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:Request returningResponse:&resp error:&erro ];
    NSArray *json = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:nil];
    return json;
}

@end
