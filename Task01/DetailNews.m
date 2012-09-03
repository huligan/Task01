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

        [newsTitle setFrame: CGRectMake(10, 20, labelSize.width, labelSize.height)];
        float lastY = 20.0f + labelSize.height;
        newsTitle.text = [data objectForKey:@"title"];
        newsTitle.textAlignment = UITextAlignmentCenter;
        
        [img setFrame:CGRectMake(20.0f, lastY, 280.0f, 189.0f)];
        lastY += 140.0f ;
        
        [description setFrame:CGRectMake(20.0f, lastY, 280.0f, 189.0f)];
        description.text = [data objectForKey:@"description"];
        
        // image
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *imgPath = [data objectForKey:@"img2"];
            NSLog(@"%@", imgPath);
            NSURL * imageURL = [NSURL URLWithString:imgPath];
            NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                [img setImage:[UIImage imageWithData:imageData]];
            });
        });
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
