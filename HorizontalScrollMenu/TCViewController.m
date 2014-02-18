//
//  TCViewController.m
//  HorizontalScrollMenu
//
//  Created by Toni Chau on 2/18/14.
//  Copyright (c) 2014 Toni Chau. All rights reserved.
//

#import "TCViewController.h"

@interface TCViewController ()

@end

@implementation TCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    TCHorizontalMenuScrollView *menu = [[TCHorizontalMenuScrollView alloc] initWithFrame:CGRectMake(0.0f, 50.0f, self.view.bounds.size.width, 50.0f)];
    
    NSMutableArray *arrayItems = [[NSMutableArray alloc] init];
    
    for (int i=0; i<10; i++) {
        [arrayItems addObject:[NSString stringWithFormat:@"Title%d ", i]];
    }
    
    [menu setItems:arrayItems];
    [self.view addSubview:menu];
    [menu release];
}

-(void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
