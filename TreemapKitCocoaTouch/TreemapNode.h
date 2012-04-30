//
//  TreemapNode.h
//  TreemapDemo
//
//  Created by Brian Alexander Yee on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TreemapNode : NSObject {
    NSString *name;
    NSString *category;
    float valueA;
    float valueB;
    float score;
    NSMutableDictionary *childNodes;
}

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *category;
@property float valueA;
@property float valueB;
@property float score;
@property (strong, nonatomic) NSMutableDictionary *childNodes;

-(id)initWithData:(NSString *) newName
         Category:(NSString *) newCategory
             ValA:(float) valueA
             ValB:(float) valueB;

//- (void)setCategoryIndex:(NSNumber *)categoryIndex;

- (void)addChildNodes:(NSArray *)newChildNodes;
- (void)addChildNode:(TreemapNode *)newChildNode;

- (NSComparisonResult)compareName:(TreemapNode *)otherObject;
- (NSComparisonResult)compareCategory:(TreemapNode *)otherObject;


@end
