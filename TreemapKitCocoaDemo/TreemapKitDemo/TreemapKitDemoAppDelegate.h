//
//  TreemapKitDemoAppDelegate.h
//  TreemapKitDemo
//
//  Created by Lee Lundrigan on 5/28/11.
//  Copyright 2011 Blazing Cloud, Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TreemapKitDemoAppDelegate : NSObject <NSApplicationDelegate> {
@private
    NSWindow *window;
    
    IBOutlet NSViewController *treemapKitDemoViewController;
}

@property (assign) IBOutlet NSWindow *window;

@end
