#import <UIKit/UIKit.h>
#import "TreemapView.h"

@interface TreemapDemoViewController : UIViewController <TreemapViewDelegate, TreemapViewDataSource, UIScrollViewDelegate> {
    IBOutlet UIScrollView *scrollView;
	NSMutableArray *sortedKeys;
	NSMutableDictionary *data;
    
	NSMutableArray *sortedCategoryKeys;
	NSMutableDictionary *categoryData;
    
    TreemapView *topLevelTreemap;
}
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) NSMutableArray *sortedKeys;
@property (strong, nonatomic) NSMutableDictionary *data;

@property (strong, nonatomic) NSMutableArray *sortedCategoryKeys;
@property (strong, nonatomic) NSMutableDictionary *categoryData;

@property (strong, nonatomic) TreemapView *topLevelTreemap;

@end

