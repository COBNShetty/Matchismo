//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by GTS Team on 11/12/13.
//  Copyright (c) 2013 ShaMealz. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) Deck *deck;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@property (nonatomic, strong) NSMutableArray *chosenCards;
@end

@implementation CardMatchingGame
static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 0;
int cardsToMatch = 0;


- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray *)chosenCards
{
    if (!_chosenCards) _chosenCards = [[NSMutableArray alloc] init];
    return _chosenCards;
}

- (void)changeGameMode:(NSString *)gameMode
{
    if ([gameMode isEqualToString:@"Two Card"]) {
        cardsToMatch = 1;
    } else if ([gameMode isEqualToString:@"Three Card"]) {
        cardsToMatch = 2;
    }
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self.deck = deck;
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];

            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index<[self.cards count]) ? self.cards[index] : nil;
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
    BOOL matched = false;
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
            [self.chosenCards removeObjectIdenticalTo:card];
        } else {
            for (Card *otherCard in self.cards)
            {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    if ([self.chosenCards count] == cardsToMatch) {
                        int matchScore = [card match:self.chosenCards];
                        if (matchScore) {
                            self.score += matchScore * MATCH_BONUS;
                            card.matched = YES;
                            matched = true;
                            for (Card *chosenCard in self.chosenCards) {
                                chosenCard.matched = YES;
                            }
                            [self.chosenCards removeAllObjects];

                        } else {
                            self.score -= MISMATCH_PENALTY;
                            for (Card *chosenCard in self.chosenCards) {
                                chosenCard.chosen = NO;
                            }
                            card.chosen = NO;
                        }
                        _chosenCards = nil;
                        break; //can only choose 3 cards for now
                        
                    }

                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
            if (!matched) {
                [self.chosenCards addObject:card];
            }
            
            
        }
    }
}

@end
