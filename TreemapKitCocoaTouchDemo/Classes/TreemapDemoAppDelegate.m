#import "TreemapDemoViewController.h"
#import "TreemapDemoAppDelegate.h"

@implementation TreemapDemoAppDelegate

@synthesize window, treemapViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[window addSubview:[treemapViewController view]];
	[window makeKeyAndVisible];

	return YES;
}

- (void)dealloc {
	[treemapViewController release];
	[window release];

    [treemapViewController release];
    [treemapViewController release];
    [super dealloc];
}

@end
