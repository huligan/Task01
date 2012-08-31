//
//  NewsListTableView.m
//  Task01
//
//  Created by Evgeniy Shuliak on 29.08.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RSSTableView.h"
#import "DetailNews.h"

@interface RSSTableView ()
{
    UIFont *cellFont;
}

@end

@implementation RSSTableView

@synthesize url;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        url = nil;
    }
    return self;
}

-(id) initWithURL:(NSString*)_url
{
    self = [super initWithNibName:@"RSSTableView" bundle:nil];
    if (self) {
        // Custom initialization
        url = _url;
        [url retain];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    cellFont = [UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
    [cellFont retain];
    rssItems = nil;
    rss = nil;
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (rss == nil)
    {
        rss = [[RSSLoader alloc] init];
        rss.delegate = self;
        //NSString *path = @"http://feeds.feedburner.com/TheAppleBlog";
        [rss load:url];
    }
}

#pragma mark -
#pragma mark RSSLoaderDelegate
-(void)updatedFeedWithRSS:(NSMutableArray*)items
{
    rssItems = [items retain];
    [self.tableView reloadData];
}

-(void)failedFeedUpdateWithError:(NSError *)error
{
    //
}

-(void)updatedFeedTitle:(NSString*)rssTitle
{
    //
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    if (url)
        [url release];
    [cellFont release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (rss.loaded == YES) 
    {
        return [rssItems count];//*2;
    } 
    else 
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (rss.loaded == NO) 
    {
        return [self getLoadingTableCellWithTableView:tableView];
    }
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.textLabel.font = cellFont;
        cell.textLabel.numberOfLines = 0;
        cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0f];
    }
    
    //UIView *backView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    //backView.backgroundColor = [UIColor clearColor];
    //cell.backgroundView = backView;
    
    NSDictionary* item = [rssItems objectAtIndex: indexPath.row];
    cell.textLabel.text = [item objectForKey:@"title"];
    
    NSDateFormatter *dateFormatterStr = [[NSDateFormatter new] autorelease];
    [dateFormatterStr setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [dateFormatterStr setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss ZZZ"];
    NSDate *dateFromStr = [dateFormatterStr dateFromString:[item objectForKey:@"pubDate"]];
    [dateFormatterStr setDateFormat:@"dd.MM.yyyy"];
    cell.detailTextLabel.text = [dateFormatterStr stringFromDate:dateFromStr];
    
    return cell;
}

- (UITableViewCell *)getLoadingTableCellWithTableView:(UITableView *)tableView
{
    static NSString *LoadingCellIdentifier = @"LoadingCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LoadingCellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LoadingCellIdentifier] autorelease];
    }
    
    cell.textLabel.text = @"Loading...";
    
    UIActivityIndicatorView* activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activity startAnimating];
    [cell setAccessoryView: activity];
    [activity release];
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!rss.loaded)
        return 40.0f;
    
    NSDictionary* item = [rssItems objectAtIndex: indexPath.row];
    NSString *cellText = [item objectForKey:@"title"];
    
    CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
    
    CGSize labelSize = [cellText sizeWithFont:cellFont 
                            constrainedToSize:constraintSize 
                                lineBreakMode:UILineBreakModeWordWrap];
    
    
    return labelSize.height + 25.0f;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    if (!rss.loaded)
        return;
    
     DetailNews *detailViewController = [[DetailNews alloc] initWithDictionary:[rssItems objectAtIndex:indexPath.row]];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
    //NSDictionary* item = [rssItems objectAtIndex: indexPath.row];///2];
    //cell.textLabel.text = [item objectForKey:@"title"];

     [detailViewController release];
}

@end
