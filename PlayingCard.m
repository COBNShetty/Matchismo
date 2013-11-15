//
//  PlayingCard.m
//  Matchismo
//
//  Created by GTS Team on 11/6/13.
//  Copyright (c) 2013 ShaMealz. All rights reserved.
//


#import "PlayingCard.h"

@implementation PlayingCard : Card

static const int RANK_SCORE_MULTIPLIER = 4;
static const int SUIT_SCORE_MULTIPLIER = 2;

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;
+ (NSArray *)validSuits
{
    return @[@"♥", @"♠", @"♦", @"♣"];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
            _suit = suit;
    }
}

- (int)match:(NSArray *)otherCards
{
    int rankScore = 0;
    int rankMultiplier = 0;
    int suitScore = 0;
    int suitMultiplier = 0;
    self.otherCards = [[NSArray alloc] initWithArray:otherCards];
    
    
    //NEED TO CHECK CARD AGAINST EACH OTHER
    if ([otherCards count]) {
        for (PlayingCard *otherCard in otherCards)
        {
            if (self.rank == otherCard.rank) {
                rankScore += 4;
                rankMultiplier++;
            }
            
            if ([self.suit isEqualToString:otherCard.suit]) {
                suitScore += 1;
                suitMultiplier++;
            }
            
        }
        
        if (otherCards.count == 2) {
            PlayingCard *otherCardOne = otherCards[0];
            PlayingCard *otherCardTwo = otherCards[1];
            
            if (otherCardOne.rank == otherCardTwo.rank) {
                rankScore += 4;
                rankMultiplier++;
            }
            
            if ([otherCardOne.suit isEqualToString:otherCardTwo.suit]) {
                suitScore += 1;
                suitMultiplier++;
            }
        }
    }
    
    return (rankScore * RANK_SCORE_MULTIPLIER) + (suitScore * SUIT_SCORE_MULTIPLIER);
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank {return [[self rankStrings] count] - 1;}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}



@end
