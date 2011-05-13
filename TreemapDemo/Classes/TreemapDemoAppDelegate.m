#import "TreemapDemoAppDelegate.h"

@implementation TreemapDemoAppDelegate

@synthesize window;
@synthesize navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[window addSubview:[navigationController view]];
	[window makeKeyAndVisible];

	return YES;
}

- (void)dealloc {
	[navigationController release];
	[window release];

    [super dealloc];
}

@end
