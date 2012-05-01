#import <UIKit/UIKit.h>

@class TreemapDemoViewController;

@interface TreemapDemoAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    IBOutlet TreemapDemoViewController *treemapViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet TreemapDemoViewController *treemapViewController;

@end

