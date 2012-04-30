#import "TreemapDemoViewController.h"
#import "TreemapView.h"
#import "TreemapNode.h"
//#import "JSONKit.h"

@implementation TreemapDemoViewController

@synthesize data, sortedKeys, categoryData, sortedCategoryKeys;

#pragma mark -

- (void)updateCell:(TreemapViewCell *)cell forIndex:(NSInteger)index {
	NSString *key = [self.sortedKeys objectAtIndex:index];
	TreemapNode *val = [self.data objectForKey:key];
	cell.textLabel.text = key;
    cell.valueLabel.text = [val category];
//    NSLog(@"%f", ((float) [val categoryIndex] + 1.0) / [self.categories count] );
//	float rando = (float)((arc4random() % 10)/100.0) + 1.0;
    // (float) ([val categoryIndex] + 1.0)  / [self.categories count]
    cell.backgroundColor = [UIColor colorWithHue: (float)index / (self.sortedKeys.count)
									  saturation:1 brightness:0.75 alpha:1];
}

#pragma mark -
#pragma mark TreemapView delegate

- (void)treemapView:(TreemapView *)treemapView tapped:(NSInteger)index {
//	NSLog(@"%f %f %f %f", treemapView.bounds.origin.x, treemapView.bounds.origin.y, treemapView.bounds.size.width, treemapView.bounds.size.height);
	/*
	 * change the value
     * Original version
	NSString *key = [self.sortedKeys objectAtIndex:index];
	NSInteger num = [[self.data objectForKey:key] integerValue] + 300;
	NSNumber *newNum = [NSNumber numberWithInteger:num];
	[self.data setValue:newNum forKey:key];
     
	 */
    
//    // This is for removing. Just a test.    
//    NSString *key = [self.sortedKeys objectAtIndex:index];
//    NSLog(@"%@ key is for %@ and sorted keys is at count %d/%d", key, [self.data objectForKey:key], [self.sortedKeys count], [[self.data allKeys] count]);
//    [self.sortedKeys removeObjectAtIndex:index];
//    [self.data removeObjectForKey:key];
//    NSLog(@"%@ removed and now sorted keys is at count %d/%d", key, [self.sortedKeys count], [[self.data allKeys] count]);

    NSString *key = [self.sortedKeys objectAtIndex:index];
    NSLog(@"%@ key is for %@ and sorted keys is at count %d/%d", key, [self.data objectForKey:key], [self.sortedKeys count], [[self.data allKeys] count]);
    NSLog(@"\n\nThe original data and keys:\n%@\n\n", self.data);
    if([[[self.data objectForKey:key] childNodes] count] > 0) {
        NSLog(@"Ha! You have %d children.", [[[self.data objectForKey:key] childNodes] count]);
        NSMutableDictionary *tmpDict = [[self.data objectForKey:key] childNodes];
        self.data = nil;
        self.sortedKeys = nil;

        self.data = [[NSMutableDictionary alloc] initWithDictionary:tmpDict];
        self.sortedKeys = [[NSMutableArray alloc] initWithArray:[self.data keysSortedByValueUsingSelector:@selector(compareName:)]];
//        self.sortedKeys = [NSMutableArray arrayWithArray:[self.data keysSortedByValueUsingSelector:@selector(compareName:)]];
    }
    NSLog(@"\n\nThe new data and keys:\n%@\n\n", self.data);


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
    
//    [cell removeFromSuperview]

	[UIView commitAnimations];
}

#pragma mark -
#pragma mark TreemapView data source

- (NSArray *)valuesForTreemapView:(TreemapView *)treemapView {
	NSMutableArray *values = [NSMutableArray arrayWithCapacity:self.sortedKeys.count];
	for (NSString *key in self.sortedKeys) {
		[values addObject:[self.data objectForKey:key]];
	}
	return values;
}

- (TreemapViewCell *)treemapView:(TreemapView *)treemapView cellForIndex:(NSInteger)index forRect:(CGRect)rect {
	TreemapViewCell *cell = [[[TreemapViewCell alloc] initWithFrame:rect] autorelease];
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

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation 
	// A this point, our view orientation is set to the new orientation.
{
	TreemapView *tree = (TreemapView *)self.view;
	[tree setNeedsLayout];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
	[super viewDidLoad];
    
    
    self.navigationItem.title = @"Brian Yee's Treemapper";
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"internet_usage" ofType:@"csv"];
    NSLog( @"filePath: %@", path );
    
    self.data = [[NSMutableDictionary alloc] init];    
    NSError*  error;
    NSString* rawData = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error ];
    NSArray* allLinedStrings = [rawData componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
    
    NSMutableArray *rawCategories = [[NSMutableArray alloc] init];

    NSMutableDictionary *tempData = [[NSMutableDictionary alloc] init];
    for(NSString *dataString in allLinedStrings) {
        NSArray *dataLine = [dataString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
        
        // Pull first two (name and category) and then add the rest of the data as an array.
        TreemapNode *newNode = [[TreemapNode alloc] initWithData:[dataLine objectAtIndex:0] Category:[dataLine objectAtIndex:1] ValA:[[dataLine objectAtIndex:2] floatValue] ValB:[[dataLine objectAtIndex:3] floatValue]];
        
        NSLog( @"%@ is in the category %@ with the value %f and %f", newNode.name, newNode.category, newNode.valueA, newNode.valueB);
        [tempData setValue:newNode forKey:newNode.name];
        [rawCategories addObject:[dataLine objectAtIndex:1]];
    }
    
    // First, add high-level categories
    for(NSString *category in rawCategories) {
        TreemapNode *catNode = [[TreemapNode alloc] initWithData:category Category:nil ValA:0 ValB:0];
        NSArray * matchingItems = [[tempData allValues] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@" category MATCHES[cd] %@ ", category]];
//        NSLog(@"All nodes that match %@", category);
        [catNode addChildNodes:matchingItems];
        [self.data setValue:catNode forKey:catNode.name];
    }

    NSLog(@"\nself.data\n%@\nself.data\n", self.data);
    
    for(TreemapNode *testNode in [self.data allValues] ) {
        NSLog(@"Node: %@, %f, and has %@ children.", testNode.name, testNode.score, testNode.childNodes);
    }
    
    NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:[self.data keysSortedByValueUsingSelector:@selector(compareName:)]];
    
    NSLog(@"%@ AHHHHHHHHHHHHHHHHHHHHHHH", NSStringFromClass( [tmpArr class] ));
    self.sortedKeys = nil;
    self.sortedKeys = [NSMutableArray arrayWithArray:[self.data keysSortedByValueUsingSelector:@selector(compareName:)]];
    //    self.sortedKeys = [[self.data keysSortedByValueUsingSelector:@selector(compareName:)] mutableCopy];
    NSLog(@"%@ AHHHHHHHHHHHHHHHHHHHHHHH", NSStringFromClass( [self.sortedKeys class] ));
    NSLog(@"\nself.sortedKeys:%@\nself.sortedKeys\n\n", self.sortedKeys);

    self.categoryData = self.data;
    self.sortedCategoryKeys = self.sortedKeys;
//    self.categoryData = [[NSMutableDictionary alloc] initWithDictionary:self.data copyItems:true];
//    self.sortedCategoryKeys = [[NSMutableArray alloc] initWithArray:self.sortedKeys copyItems:true];
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
