//
//  DetailNews.h
//  Task01
//
//  Created by Evgeniy Shuliak on 30.08.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailNews : UIViewController
{
    NSDictionary *data;
}

-(id) initWithDictionary:(NSDictionary*)dict;
@property(retain, nonatomic) NSDictionary *data;

@property(retain, nonatomic) IBOutlet UILabel *newsTitle;
@property(retain, nonatomic) IBOutlet UIImageView *img;
@property(retain, nonatomic) IBOutlet UITextView *description;

-(IBAction)showDetails:(id)sender;

@end
