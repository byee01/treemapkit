#import "TreemapDemoViewController.h"
#import "TreemapView.h"
//#import "JSONKit.h"

@implementation TreemapDemoViewController

@synthesize data, sortedKeys;

#pragma mark -

- (void)updateCell:(TreemapViewCell *)cell forIndex:(NSInteger)index {
	NSString *key = [self.sortedKeys objectAtIndex:index];
	NSNumber *val = [self.data valueForKey:key];
	cell.textLabel.text = key;
	cell.valueLabel.text = [val stringValue];
	cell.backgroundColor = [UIColor colorWithHue:(float)index / (self.sortedKeys.count + 3)
									  saturation:1 brightness:0.75 alpha:1];
}

#pragma mark -
#pragma mark TreemapView delegate

- (void)treemapView:(TreemapView *)treemapView tapped:(NSInteger)index {
//	NSLog(@"%f %f %f %f", treemapView.bounds.origin.x, treemapView.bounds.origin.y, treemapView.bounds.size.width, treemapView.bounds.size.height);
	/*
	 * change the value
	 */
	NSString *key = [self.sortedKeys objectAtIndex:index];
	NSInteger num = [[self.data valueForKey:key] integerValue] + 300;
	NSNumber *newNum = [NSNumber numberWithInteger:num];
	[self.data setValue:newNum forKey:key];

	/*
	 * resize rectangles with animation
	 */
	[UIView beginAnimations:@"reload" context:nil];
	[UIView setAnimationDuration:0.5];

	[(TreemapView *)self.view reloadData];

	[UIView commitAnimations];

	/*
	 * highlight the background
	 */
	[UIView beginAnimations:@"highlight" context:nil];
	[UIView setAnimationDuration:1.0];

	TreemapViewCell *cell = (TreemapViewCell *)[self.view.subviews objectAtIndex:index];
	UIColor *color = cell.backgroundColor;
	[cell setBackgroundColor:[UIColor whiteColor]];
	[cell setBackgroundColor:color];

	[UIView commitAnimations];
}

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

#pragma mark -

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	return YES;
}

//- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation 
- (void)willAnimateSecondHalfOfRotationFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation duration:(NSTimeInterval)duration 
	// A this point, our view orientation is set to the new orientation.
{
	TreemapView *tree = (TreemapView *)self.view;
	[tree reloadData];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
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

- (void)viewDidUnload {
	[super viewDidUnload];
	
	self.sortedKeys = nil;
	self.data = nil;
}

- (void)dealloc {
	self.data = nil;
	self.sortedKeys = nil;
	
	[super dealloc];
}

@end
