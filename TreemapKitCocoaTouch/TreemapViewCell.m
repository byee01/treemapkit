#import "TreemapView.h"
#import "TreemapViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation TreemapViewCell

@synthesize valueLabel;
@synthesize textLabel;
@synthesize index;
@synthesize delegate;

#pragma mark -

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		self.opaque = YES;
		self.layer.borderWidth = 1.0;
		self.layer.borderColor = [[UIColor darkGrayColor] CGColor];

		self.textLabel = [[[UILabel alloc] initWithFrame:CGRectIntegral(CGRectMake(0, 0, frame.size.width - 4, 20))] autorelease];
		textLabel.font = [UIFont boldSystemFontOfSize:20];
		textLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
		textLabel.textAlignment = UITextAlignmentCenter;
		textLabel.textColor = [UIColor whiteColor];
		textLabel.backgroundColor = [UIColor clearColor];
		textLabel.lineBreakMode = UILineBreakModeCharacterWrap;
		textLabel.adjustsFontSizeToFitWidth = YES;
		[self addSubview:textLabel];

		self.valueLabel = [[[UILabel alloc] initWithFrame:CGRectIntegral(CGRectMake(0, 0, frame.size.width - 4, 20))] autorelease];
		valueLabel.font = [UIFont boldSystemFontOfSize:14];
		valueLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
		valueLabel.textAlignment = UITextAlignmentCenter;
		valueLabel.textColor = [UIColor whiteColor];
		valueLabel.backgroundColor = [UIColor clearColor];
		valueLabel.lineBreakMode = UILineBreakModeCharacterWrap;
		valueLabel.adjustsFontSizeToFitWidth = YES;

		[self addSubview:valueLabel];
	}
	return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];

    
	textLabel.frame = CGRectIntegral(CGRectMake(0, self.frame.size.height / 2 - 10, self.frame.size.width, 20));
	valueLabel.frame = CGRectIntegral(CGRectMake(0, self.frame.size.height / 2 + 10, self.frame.size.width, 20));
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	if ([delegate respondsToSelector:@selector(treemapViewCell:tapped:)])
		[delegate treemapViewCell:self tapped:index];
}
//
//- (void)dealloc {
//	[valueLabel release];
//	[textLabel release];
//	[delegate release];
//
//	[super dealloc];
//}

@end
