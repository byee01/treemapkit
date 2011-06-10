#import "TreemapView.h"
#import "TreemapViewCell.h"
#import <QuartzCore/QuartzCore.h>

#define BORDER_OFFSET 3

@implementation TreemapViewCell

@synthesize valueLabel;
@synthesize textLabel;
@synthesize index;
@synthesize delegate;

#pragma mark -

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
        
		self.textLabel = [[NSTextField alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height/2.0)];
        
        [textLabel setEditable:NO];
        [textLabel setBordered:NO];
        [textLabel setAlignment:NSCenterTextAlignment];
		textLabel.textColor = [NSColor whiteColor];
		textLabel.backgroundColor = [NSColor clearColor];
		[self addSubview:textLabel];        
	}
	return self;
}

- (CGColorRef)CGColorFromColor:(NSColor*)color {
    CGColorRef someCGColor = NULL;
    CGColorSpaceRef genericRGBSpace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
    
    NSColor *deviceColor = [color colorUsingColorSpaceName:NSDeviceRGBColorSpace];
    
    if (genericRGBSpace != NULL) {
        CGFloat components[4];
        [deviceColor getRed: &components[0] green: &components[1] blue:&components[2] alpha: &components[3]];
        
        someCGColor = CGColorCreate(genericRGBSpace, components);
        CGColorSpaceRelease(genericRGBSpace);
    }
    return someCGColor;
}

- (void)awakeFromNib {

	textLabel.frame = CGRectMake(0, self.frame.size.height / 2 - 10, self.frame.size.width, 20);
	valueLabel.frame = CGRectMake(0, self.frame.size.height / 2 + 10, self.frame.size.width, 20);
}

- (void)drawRect:(NSRect)dirtyRect {
    
    [NSGraphicsContext saveGraphicsState];

    CGFloat left = BORDER_OFFSET;
    CGFloat top = BORDER_OFFSET;
    CGFloat width = [self frame].size.width - BORDER_OFFSET;
    CGFloat height = [self frame].size.height - BORDER_OFFSET;
    
    NSRect borderRect = NSMakeRect(left,
                                   top,
                                   width,
                                   height);
    
    NSBezierPath *borderPath = [NSBezierPath bezierPathWithRoundedRect:borderRect
                                                               xRadius:0
                                                               yRadius:0];
    
    NSColor *borderColor = [NSColor darkGrayColor];
    
    NSColor *fillColor = [NSColor colorWithCalibratedHue:(float)index / (arc4random() % 32)
                                              saturation:1 brightness:0.75 alpha:1];
    
    // do the drawing
    [borderColor set];
    [borderPath stroke];
    [fillColor set];
    [borderPath fill];
    
    [NSGraphicsContext restoreGraphicsState];
}

//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//	if ([delegate respondsToSelector:@selector(treemapViewCell:tapped:)])
//		[delegate treemapViewCell:self tapped:index];
//}

- (void)dealloc {
	[valueLabel release];
	[textLabel release];
	[delegate release];

	[super dealloc];
}

@end
