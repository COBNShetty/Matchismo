//
//  PlayingCard.h
//  Matchismo
//
//  Created by GTS Team on 11/6/13.
//  Copyright (c) 2013 ShaMealz. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
