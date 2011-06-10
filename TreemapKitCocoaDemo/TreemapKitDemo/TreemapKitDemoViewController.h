//
//  TreemapKitDemoViewController.h
//  TreemapKitDemo
//
//  Created by Lee Lundrigan on 5/28/11.
//  Copyright 2011 Blazing Cloud, Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TreemapView.h"

@interface TreemapKitDemoViewController : NSViewController <TreemapViewDelegate, TreemapViewDataSource> {
@private
    IBOutlet NSArray *sortedKeys;
	IBOutlet NSMutableDictionary *data;
}

@property (nonatomic, copy) NSArray *sortedKeys;
@property (nonatomic, retain) NSMutableDictionary *data;

@end
