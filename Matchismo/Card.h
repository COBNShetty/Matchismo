//
//  Card.h
//  Matchismo
//
//  Created by GTS Team on 11/6/13.
//  Copyright (c) 2013 ShaMealz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;
@property (nonatomic, strong) NSArray *otherCards;

- (int)match:(NSArray *)otherCards;

@end
