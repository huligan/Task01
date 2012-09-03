//
//  RSSLoader.m
//  Task01
//
//  Created by Evgeniy Shuliak on 30.08.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RSSLoader.h"
#import "GDataXMLNode.h"

@implementation RSSLoader
{
    NSString *url;
}

@synthesize delegate;
@synthesize loaded;

-(void) load:(NSString*)_url;
{
    url = _url;
    self.loaded = NO;
    [self dispatchLoadingOperation];
}

-(void) dispatchLoadingOperation
{
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(fetchRSS) object:nil];
    [queue addOperation:operation];
    
    [operation release];
    [queue autorelease];
}

-(void) fetchRSS
{
    NSURL *xmlURL = [NSURL URLWithString:url];
    NSData *xmlData = [[NSMutableData alloc] initWithContentsOfURL:xmlURL];
    NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:&error];
    
    if (doc != nil)
    {
        self.loaded = YES;
        GDataXMLNode *title = [[[doc rootElement] nodesForXPath:@"channel/title" error:&error] objectAtIndex:0];
        [self.delegate updatedFeedTitle:[title stringValue]];
        
        NSArray *items = [[doc rootElement] nodesForXPath:@"channel/item" error:&error];
        NSMutableArray *rssItems = [NSMutableArray arrayWithCapacity:[items count]];
        
        for (GDataXMLElement *xmlItem in items)
        {
            [rssItems addObject:[self getItemFromXmlElement:xmlItem]];
        }
        
        [self.delegate performSelectorOnMainThread:@selector(updatedFeedWithRSS:) withObject:rssItems waitUntilDone:YES];
    } 
    else 
    {
        [self.delegate performSelectorOnMainThread:@selector(failedFeedUpdateWithError:) withObject:error waitUntilDone:YES];
    }
    
    [doc autorelease];
    [xmlData release];
}

-(NSDictionary*)getItemFromXmlElement:(GDataXMLElement*)xmlItem
{
    //NSLog(@"------------------------------");
    //NSLog(@"%@", [xmlItem XMLString]);
    NSArray *img = [xmlItem elementsForName:@"media:thumbnail"];
    
    NSString *imgURL1, *imgURL2;
    if (img.count >= 1)
        imgURL1 = [[[img objectAtIndex:0] attributeForName:@"url"] stringValue];
    else 
        imgURL1 = @"";
    if (img.count >= 2)
        imgURL2 = [[[img objectAtIndex:1] attributeForName:@"url"] stringValue];
    else 
        imgURL2 = @"";
    
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [[[xmlItem elementsForName:@"title"] objectAtIndex:0] stringValue], @"title",
            [[[xmlItem elementsForName:@"link"] objectAtIndex:0] stringValue], @"link",
            [[[xmlItem elementsForName:@"description"] objectAtIndex:0] stringValue], @"description",
            [[[xmlItem elementsForName:@"pubDate"] objectAtIndex:0] stringValue], @"pubDate",
            imgURL1, @"img1",
            imgURL2, @"img2",
            nil];
}

@end
