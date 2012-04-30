#import <UIKit/UIKit.h>
#import "TreemapView.h"

@interface TreemapDemoViewController : UIViewController <TreemapViewDelegate, TreemapViewDataSource> {
	NSMutableArray *sortedKeys;
	NSMutableDictionary *data;
    
	NSMutableArray *sortedCategoryKeys;
	NSMutableDictionary *categoryData;
}

@property (strong, nonatomic) NSMutableArray *sortedKeys;
@property (strong, nonatomic) NSMutableDictionary *data;

@property (strong, nonatomic) NSMutableArray *sortedCategoryKeys;
@property (strong, nonatomic) NSMutableDictionary *categoryData;

@end

