//
//  DetailNews.m
//  Task01
//
//  Created by Evgeniy Shuliak on 30.08.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailNews.h"

@interface DetailNews ()

@end

@implementation DetailNews

@synthesize data;
@synthesize newsTitle;
@synthesize img;
@synthesize description;

/*- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}*/

-(id) initWithDictionary:(NSDictionary*)dict
{
    self = [super initWithNibName:@"DetailNews" bundle:nil];
    if (self) {
        // Custom initialization
        data = dict;
        [data retain];
    }
    return self;
}

-(IBAction)showDetails:(id)sender
{
    NSURL *url = [NSURL URLWithString:[data objectForKey:@"link"]];
    [[UIApplication sharedApplication] openURL:url];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (data)
    {
        NSString *cellText = [data objectForKey:@"title"];
        
        CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
        
        CGSize labelSize = [cellText sizeWithFont:newsTitle.font 
                                constrainedToSize:constraintSize 
                                    lineBreakMode:UILineBreakModeWordWrap];

        [newsTitle setFrame: CGRectMake(20, 20, labelSize.width, labelSize.height)];
        //float lastY = 20.0f + labelSize.height;
        newsTitle.text = [data objectForKey:@"title"];
        
        //UIImage *image = [UIImage imageNamed:@"bakteria1.png"];
        //[img setImage:image];
        description.text = [data objectForKey:@"description"];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [data release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
