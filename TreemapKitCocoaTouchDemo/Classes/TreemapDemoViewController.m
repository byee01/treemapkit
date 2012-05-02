#import "TreemapDemoViewController.h"
#import "TreemapView.h"
#import "TreemapNode.h"
//#import "JSONKit.h"

@implementation TreemapDemoViewController
@synthesize scrollView, data, sortedKeys, categoryData, sortedCategoryKeys, topLevelTreemap;

#pragma mark -

- (void)updateCell:(TreemapViewCell *)cell forIndex:(NSInteger)index {
	NSString *key = [self.sortedKeys objectAtIndex:index];
	TreemapNode *val = [self.data objectForKey:key];
	cell.textLabel.text = key;

    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    cell.valueLabel.text = [NSString stringWithFormat:@"%@", [formatter stringFromNumber:[NSNumber numberWithFloat:[val score]]]];
    cell.backgroundColor = [UIColor colorWithHue: (float)index / (self.sortedKeys.count)
									  saturation:1 brightness:0.75 alpha:1];
}

#pragma mark -
#pragma mark TreemapView delegate

- (void)treemapView:(TreemapView *)treemapView tapped:(NSInteger)index {
	NSString *key = [self.sortedKeys objectAtIndex:index];
    TreemapNode *tappedNode = [self.data objectForKey:key];
//    TreemapView *categoryView = [[topLevelTreemap subviews] objectAtIndex:index];
    if ([tappedNode.childNodes count] > 0) {
        
        [scrollView setMinimumZoomScale:0.5];
        self.scrollView.zoomScale = 0.5;
        NSLog(@"Replace the data now.");
        NSLog(@"Data used to be %@", self.data);
        self.data = tappedNode.childNodes;
        NSLog(@"Data is now %@", self.data);
        self.sortedKeys = [NSMutableArray arrayWithArray:[self.data keysSortedByValueUsingSelector:@selector(compareName:)]];
    } else {
        self.scrollView.zoomScale = 2.0;
        self.data = self.categoryData;
        self.sortedKeys = self.sortedCategoryKeys;
    }

    [UIView beginAnimations:@"Highlight change" context:NULL];
    [UIView setAnimationDuration:0.25];
    
    self.scrollView.zoomScale = 1.0;
    [scrollView setMinimumZoomScale:1.0];
    [treemapView reloadData];
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
//	TreemapView *tree = (TreemapView *)self.view;
	[topLevelTreemap setNeedsLayout];
//    [tree setNeedsLayout];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
	[super viewDidLoad];
    
    // Set up scrollViews
    scrollView.clipsToBounds = YES;
    scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    [scrollView setContentSize:self.view.frame.size];
    [scrollView setScrollEnabled:YES];
	[scrollView setBackgroundColor:[UIColor blackColor]];
    [scrollView setDelegate:self];
    [scrollView setMaximumZoomScale:5.0];
    [scrollView setMinimumZoomScale:1.0];

    // Add gesture recognizers
//    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(doPinch:)];
//    [self.view addGestureRecognizer:pinch];
    


    NSString *path = [[NSBundle mainBundle] pathForResource:@"internet_usage" ofType:@"csv"];
    NSLog( @"filePath: %@", path );
//    /afs/andrew.cmu.edu/usr8/byee/Library/Application Support/iPhone Simulator/5.0/Applications/8F31AAD8-3600-477A-B55D-F9CB45D56333/TreemapDemo.app/military_spending.csv
//    /afs/andrew.cmu.edu/usr8/byee/Library/Application Support/iPhone Simulator/5.0/Applications/8F31AAD8-3600-477A-B55D-F9CB45D56333/TreemapDemo.app/internet_usage.csv
    
    self.data = [[NSMutableDictionary alloc] init];    
    NSError*  error;
    NSString* rawData = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error ];

    NSArray* allLinedStrings = [rawData componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
    
    NSMutableArray *rawCategories = [[NSMutableArray alloc] init];

    NSMutableDictionary *tempData = [[NSMutableDictionary alloc] init];
    for(NSString *dataString in allLinedStrings) {
        NSArray *dataLine = [dataString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
        
        // Pull first two (name and category) and then add the rest of the data as an array.
        TreemapNode *newNode = [[TreemapNode alloc] initWithData:[dataLine objectAtIndex:0] Category:[dataLine objectAtIndex:1] ValA:[[dataLine objectAtIndex:2] floatValue]];
        
        NSLog( @"%@ is in the category %@ with the value %f", newNode.name, newNode.category, newNode.valueA);
        [tempData setValue:newNode forKey:newNode.name];
        [rawCategories addObject:[dataLine objectAtIndex:1]];
    }
    
    // First, add high-level categories
    for(NSString *category in rawCategories) {
        TreemapNode *catNode = [[TreemapNode alloc] initWithData:category Category:nil ValA:0];
        NSArray * matchingItems = [[tempData allValues] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@" category MATCHES[cd] %@ ", category]];
        [catNode addChildNodes:matchingItems];
        [self.data setValue:catNode forKey:catNode.name];
    }

    NSLog(@"\nself.data\n%@\nself.data\n", self.data);
    
    for(TreemapNode *testNode in [self.data allValues] ) {
        NSLog(@"Node: %@, %f, and has %@ children.", testNode.name, testNode.score, testNode.childNodes);
    }

    self.sortedKeys = nil;
    self.sortedKeys = [NSMutableArray arrayWithArray:[self.data keysSortedByValueUsingSelector:@selector(compareName:)]];
    NSLog(@"\nself.sortedKeys:%@\nself.sortedKeys\n\n", self.sortedKeys);

    self.categoryData = self.data;
    self.sortedCategoryKeys = self.sortedKeys;
    
    self.topLevelTreemap = [[TreemapView alloc] initWithFrame:self.view.frame];
    self.topLevelTreemap.delegate = self;
    self.topLevelTreemap.dataSource = self;

    // Set up scale/zooming
    [scrollView addSubview:self.topLevelTreemap];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return topLevelTreemap;
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {

}

- (void)viewDidUnload {
	[super viewDidUnload];
	
	self.sortedKeys = nil;
	self.data = nil;
}

- (void)dealloc {
	self.data = nil;
	self.sortedKeys = nil;

    [scrollView release];
	[super dealloc];
}

@end
