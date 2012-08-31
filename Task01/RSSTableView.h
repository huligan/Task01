//
//  NewsListTableView.h
//  Task01
//
//  Created by Evgeniy Shuliak on 29.08.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSLoader.h"

@interface RSSTableView : UITableViewController <RSSLoaderDelegate>
{
    //NSMutableData *rssData;
    
    UIActivityIndicatorView * activityIndicator; 
    
    RSSLoader *rss;
    NSMutableArray *rssItems;
}

@property(retain, nonatomic) NSString *url;

-(id) initWithURL:(NSString*)_url;

@end




