#import <UIKit/UIKit.h>
#import "TreemapView.h"

@interface TreemapDemoViewController : UIViewController <TreemapViewDelegate, TreemapViewDataSource> {
	NSArray *sortedKeys;
	NSMutableDictionary *data;
}

@property (nonatomic, copy) NSArray *sortedKeys;
@property (nonatomic, retain) NSMutableDictionary *data;

@end

