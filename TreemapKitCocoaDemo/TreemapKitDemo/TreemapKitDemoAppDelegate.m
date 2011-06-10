//
//  TreemapKitDemoAppDelegate.m
//  TreemapKitDemo
//
//  Created by Lee Lundrigan on 5/28/11.
//  Copyright 2011 Blazing Cloud, Inc. All rights reserved.
//

#import "TreemapKitDemoAppDelegate.h"

@implementation TreemapKitDemoAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    [window setContentView:[treemapKitDemoViewController view]];
}

@end
