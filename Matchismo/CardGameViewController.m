//
//  CardGameViewController.m
//  Matchismo
//
//  Created by GTS Team on 11/6/13.
//  Copyright (c) 2013 ShaMealz. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"
#import "Deck.h"
#import "Card.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *gameActionLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeControl;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

int gameScore;

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]];
    return _game;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    int choosenButtonIndex = [self.cardButtons indexOfObject:sender];
    gameScore = _game.score;
    [self.game chooseCardAtIndex:choosenButtonIndex];
    NSLog(@"Game.Score: %d", _game.score);
    [_game setGameStarted:YES];
    [self changeGameActionLabelWithCard:[self.game cardAtIndex:choosenButtonIndex]];
    [self updateUI];
}

- (void)changeGameActionLabelWithCard:(Card *)card
{
    int scoreDifference = _game.score - gameScore;
    if (card.isChosen) {
        self.gameActionLabel.text = [NSString stringWithFormat:@"%@ was chosen!", card.contents];
    } else if (!card.isChosen){
        self.gameActionLabel.text = [NSString stringWithFormat:@"%@ was unchosen!", card.contents];
    }
    
    NSLog(@"GameScore: %d", gameScore);
    if (card.otherCards.count == 1) {
        Card *otherCard = [card.otherCards firstObject];
        if (scoreDifference > 0) {
            self.gameActionLabel.text = [NSString stringWithFormat:@"%@%@ matched for %d points!", card.contents, otherCard.contents, scoreDifference];
        } else if (scoreDifference < 0){
            self.gameActionLabel.text = [NSString stringWithFormat:@"%@%@ didn't match for %d points!", card.contents, otherCard.contents, scoreDifference];
        } else if (scoreDifference == 0) {
            if (card.isChosen) {
                self.gameActionLabel.text = [NSString stringWithFormat:@"%@ was chosen!", card.contents];
            } else if (!card.isChosen){
                self.gameActionLabel.text = [NSString stringWithFormat:@"%@ was unchosen!", card.contents];
            }
        }
    }
    else if (card.otherCards.count == 2) {
        Card *otherCardOne = card.otherCards[0];
        Card *otherCardTwo = card.otherCards[1];
        if (scoreDifference > 0) {
            self.gameActionLabel.text = [NSString stringWithFormat:@"%@%@%@ matched for %d points!", card.contents, otherCardOne.contents, otherCardTwo.contents, scoreDifference];
        } else if (scoreDifference < 0){
            self.gameActionLabel.text = [NSString stringWithFormat:@"%@%@%@ didn't match for %d points!", card.contents, otherCardOne.contents, otherCardTwo.contents, scoreDifference];
            
        } else if (scoreDifference == 0){
            if (card.isChosen) {
                self.gameActionLabel.text = [NSString stringWithFormat:@"%@ was chosen!", card.contents];
            } else if (!card.isChosen){
                self.gameActionLabel.text = [NSString stringWithFormat:@"%@ was unchosen!", card.contents];
            }
        }
    }
    
    
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;

    }
    
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    if (_game.gameStarted) {
        [self turnOnUISegmentedControl:self.gameModeControl BOOL:NO];
    }
}
- (IBAction)reDealGame:(id)sender {
    _game = nil;
    [self game];
    _game.gameStarted = false;
    [self turnOnUISegmentedControl:self.gameModeControl BOOL:YES];
    [self updateUI];
    
}

- (IBAction)switchGameMode:(UISegmentedControl *)sender {
    if (!_game) {
        [self game];
    }
    if (sender.selectedSegmentIndex == 0) {
        [_game changeGameMode:@"Two Card"];
    } else if (sender.selectedSegmentIndex == 1){
        [_game changeGameMode:@"Three Card"];
    }
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents :@"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardFront" : @"cardBack"];
}

- (void)turnOnUISegmentedControl:(UISegmentedControl *)segmentedControl BOOL:(BOOL)flag
{
    if (flag) {
        for (int i = 0; i < segmentedControl.numberOfSegments; i++) {
            [segmentedControl setEnabled:YES forSegmentAtIndex:i];
        }
    } else {
        for (int i = 0; i < segmentedControl.numberOfSegments; i++) {
            if (self.gameModeControl.selectedSegmentIndex != i) {
                [self.gameModeControl setEnabled:FALSE forSegmentAtIndex:i];
            }
        }
    }
    
}

- (void)viewDidLoad
{
    [self game];
    [_game changeGameMode:@"Two Card"];
}



@end
