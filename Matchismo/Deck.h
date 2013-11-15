//
//  Deck.h
//  Matchismo
//
//  Created by GTS Team on 11/6/13.
//  Copyright (c) 2013 ShaMealz. All rights reserved.
//

#import "Card.h"
#import <Foundation/Foundation.h>

@interface Deck : NSObject

- (void)addCard:(Card*)card atTop:(BOOL)atTop;
- (void)addCard:(Card*)card;

-(Card *)drawRandomCard;

@end
