//
//  TreemapKitDemoViewController.m
//  TreemapKitDemo
//
//  Created by Lee Lundrigan on 5/28/11.
//  Copyright 2011 Blazing Cloud, Inc. All rights reserved.
//

#import "TreemapKitDemoViewController.h"


@implementation TreemapKitDemoViewController

@synthesize data, sortedKeys;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

#pragma mark -

- (void)updateCell:(TreemapViewCell *)cell forIndex:(NSInteger)index {
	NSString *key = [self.sortedKeys objectAtIndex:index];
	NSNumber *val = [self.data valueForKey:key];
	[cell.textLabel setStringValue: key];
	[cell.valueLabel setStringValue: [val stringValue]];
}

#pragma mark -
#pragma mark TreemapView delegate

//- (void)treemapView:(TreemapView *)treemapView tapped:(NSInteger)index {
//    //	NSLog(@"%f %f %f %f", treemapView.bounds.origin.x, treemapView.bounds.origin.y, treemapView.bounds.size.width, treemapView.bounds.size.height);
//	/*
//	 * change the value
//	 */
//	NSString *key = [self.sortedKeys objectAtIndex:index];
//	NSInteger num = [[self.data valueForKey:key] integerValue] + 300;
//	NSNumber *newNum = [NSNumber numberWithInteger:num];
//	[self.data setValue:newNum forKey:key];
//    
//	/*
//	 * resize rectangles with animation
//	 */
//	[NSView beginAnimations:@"reload" context:nil];
//	[NSView setAnimationDuration:0.5];
//    
//	[(TreemapView *)self.view reloadData];
//    
//	[NSView commitAnimations];
//    
//	/*
//	 * highlight the background
//	 */
//	[NSView beginAnimations:@"highlight" context:nil];
//	[NSView setAnimationDuration:1.0];
//    
//	TreemapViewCell *cell = (TreemapViewCell *)[self.view.subviews objectAtIndex:index];
//	NSColor *color = cell.backgroundColor;
//	[cell setBackgroundColor:[NSColor whiteColor]];
//	[cell setBackgroundColor:color];
//    
//	[NSView commitAnimations];
//}

#pragma mark -
#pragma mark TreemapView data source

- (NSArray *)valuesForTreemapView:(TreemapView *)treemapView {
	NSMutableArray *values = [NSMutableArray arrayWithCapacity:self.sortedKeys.count];
	for (NSString *key in self.sortedKeys) {
		[values addObject:[self.data valueForKey:key]];
	}
	return values;
}

- (TreemapViewCell *)treemapView:(TreemapView *)treemapView cellForIndex:(NSInteger)index forRect:(CGRect)rect {
	TreemapViewCell *cell = [[TreemapViewCell alloc] initWithFrame:rect];
	[self updateCell:cell forIndex:index];
	return cell;
}

- (void)treemapView:(TreemapView *)treemapView updateCell:(TreemapViewCell *)cell forIndex:(NSInteger)index forRect:(CGRect)rect {
	[self updateCell:cell forIndex:index];
}

- (void)awakeFromNib {

	NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
	self.data = [NSMutableDictionary dictionaryWithContentsOfFile:path];
	
	/*	This is actually where I got the sample data.
     NSError *error = nil;
     NSString *path = [NSString stringWithFormat:@"http://openstates.sunlightlabs.com/api/v1/subject_counts/tx/82/upper/?apikey=%@", apiKey];
     NSURL *url = [NSURL URLWithString:path];
     NSData *jsonData = [NSData dataWithContentsOfURL:url];
     self.data = [jsonData mutableObjectFromJSONDataWithParseOptions:JKParseOptionLooseUnicode error:&error];
	 */
	
	self.sortedKeys = [[self.data allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

@end
