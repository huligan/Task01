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
    RSSLoader *rss;
    NSMutableArray *rssItems;
}

@property(retain, nonatomic) NSString *url;
@property (nonatomic,retain) UIActivityIndicatorView *activityIndicator;
//@property (nonatomic,retain) UIView *loadView;

-(id) initWithURL:(NSString*)_url;

@end




