//
//  RSSLoader.h
//  Task01
//
//  Created by Evgeniy Shuliak on 30.08.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RSSLoaderDelegate <NSObject>

-(void) updatedFeedWithRSS:(NSArray*)items;
-(void) failedFeedUpdateWithError:(NSError*)error;
-(void) updatedFeedTitle:(NSString*)title;

@end

//====================================================

@interface RSSLoader : NSObject
{
    UIViewController<RSSLoaderDelegate> *delegate;
    BOOL loaded;
}

@property(retain, nonatomic) UIViewController<RSSLoaderDelegate> *delegate;
@property(assign, nonatomic) BOOL loaded;

-(void) load:(NSString*)_url;

@end
