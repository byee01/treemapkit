
#import <Cocoa/Cocoa.h>

@protocol TreemapViewCellDelegate;

@interface TreemapViewCell : NSControl {
	NSTextField *valueLabel;
	NSTextField *textLabel;

	NSInteger index;

	id <TreemapViewCellDelegate> delegate;
}

@property (nonatomic, retain) NSTextField *valueLabel;
@property (nonatomic, retain) NSTextField *textLabel;

@property NSInteger index;

@property (nonatomic, retain) id <TreemapViewCellDelegate> delegate;

- (id)initWithFrame:(CGRect)frame;
- (CGColorRef)CGColorFromColor:(NSColor*)color;

@end

@protocol TreemapViewCellDelegate <NSObject>

@optional

- (void)treemapViewCell:(TreemapViewCell *)treemapViewCell tapped:(NSInteger)index;

@end
