//
//  TreemapNode.m
//  TreemapDemo
//
//  Created by Brian Alexander Yee on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TreemapNode.h"

@implementation TreemapNode

@synthesize name, category, valueA, score, childNodes;

-(id)initWithData:(NSString *)newName
         Category:(NSString *)newCategory
           ValA:(float)newValA {
    self.name = newName;
    self.category = newCategory;
    self.valueA = newValA;
    self.score = newValA;
    self.childNodes = [[NSMutableDictionary alloc] init];
    return self;
}
//
//- (void)setCategoryIndex:(NSNumber *)index {
//    NSLog(@"Set %@ category to %@ for %@", self.name, index, self.category);
//    self.categoryIndex = index;
//}

- (void)addChildNodes:(NSArray *)newChildNodes {
    for(TreemapNode *tmpTN in newChildNodes) {
        self.score += tmpTN.valueA;
        [self.childNodes setValue:tmpTN forKey:tmpTN.name];
    }
}

- (void)addChildNode:(TreemapNode *)newChildNode {
    self.score += newChildNode.valueA;
    [self.childNodes setValue:newChildNode forKey:newChildNode.name];
}

- (NSComparisonResult)compareName:(TreemapNode *)otherObject {
    return [self.name caseInsensitiveCompare:otherObject.name];
}

- (NSComparisonResult)compareCategory:(TreemapNode *)otherObject {
    return [self.category caseInsensitiveCompare:otherObject.category];
}

@end
