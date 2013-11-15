//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by GTS Team on 11/12/13.
//  Copyright (c) 2013 ShaMealz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (void)changeGameMode:(NSString *)gameMode;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic)BOOL gameStarted;

@end
