# Poker Hands

In the card game poker, a hand consists of five cards and are ranked, from lowest to highest, in the following way:

1. High Card: Highest value card.
1. One Pair: Two cards of the same value.
1. Two Pairs: Two different pairs.
1. Three of a Kind: Three cards of the same value.
1. Straight: All cards are consecutive values.
1. Flush: All cards of the same suit.
1. Full House: Three of a kind and a pair.
1. Four of a Kind: Four cards of the same value.
1. Straight Flush: All cards are consecutive values of same suit.
1. Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.

The cards are valued in the order:
2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace.

If two players have the same ranked hands then the rank made up of the highest value wins; for example, a pair of eights beats a pair of fives (see example 1 below). But if two ranks tie, for example, both players have a pair of queens, then highest cards in each hand are compared (see example 4 below); if the highest cards tie then the next highest cards are compared, and so on.

Consider the following two hands dealt to two players:


| Hand	 |	Player 1	| 	Player 2	| 	Winner |
| ------ |------------- | ------------- | -------- |
| 1	 |	5H 5C 6S 7S KD | 2C 3S 8S 8D TD | Player 2 |
|     | Pair of Fives   | Pair of Eights |          |
| 2	  |	5D 8C 9S JS AC   | 2C 5C 7D 8S QH | Player 1 |
| | Highest card Ace | Highest card Queen | |
 	
The file, poker.txt, contains one-thousand random hands dealt to two players. Each line of the file contains ten cards (separated by a single space): the first five are Player 1's cards and the last five are Player 2's cards. You can assume that all hands are valid (no invalid characters or repeated cards), each player's hand is in no specific order, and in each hand there is a clear winner.

How many hands does Player 1 win?

_____________________

## Initial thoughts

This should be a rails app to take advantage of a PostgreSQL database and the ActiveRecord ORM. Extensibility was one of the suggested criteria, and this seems like it would allow for easier creation of statistics, analysis of hands, additional players, etc. Ideally you could make a full on poker website with this backend (once some endpoints were created.)

The best way to get the data from the text file into the Postgres database is most likely through a custom rake task since it is a one-off thing. 

There can also be a rake task to get the number of wins player one had. 

### To do 
- [x] Create migrations and models

- [x] Create relationships

- [x] Write a custom rake task to seed the DB with the hands, cards, hands, etc.

- [ ] Create model methods to compare hands

- [ ] Create runner file

## Finding a winner

The next task is finding the most efficient way to traverse the possible win conditions. You could check in order from a royal flush to high card on every hand, but a royal flush will almost never happen and you'll be checking every time. As a matter of fact, it doesn't make sense to have ANY special checks for a royal flush, since straight flushes are won based on the highest card anyways - a royal flush is just a straight flush with an Ace high card.

There are four basic winning hands you could have: 
- 'flush' type: Has the word flush in the name 
- 'straight' type: Rank is sequential
- 'duplicate' type: pairs and three-of-a-kinds, there will be more than one of each rank of card in the hand
- High card

It seems that you need to separate this into a tree where the statistically most likely outcomes (high card, pair) require traversing the fewest nodes possible. Here's a basic diagram of what I'm thinking:
```
                            Is it a flush?
                             /      \
                            no        yes
                            |           \
                            |           straight?
                            |              / \
                            |             no   yes
                            |             /       \
                            |          Flush      Straight flush
                            |
                    Highest # of duplicates:
        4               3                 2                         1
       /                |                   \                        \ 
Four of a kind     Is there a pair?         Another pair?            Is it a straight?
                      /   \                         / \                    /  \ 
                    yes    no                     No   Yes               yes   no  
                   /         \                    |      \               /       \
              Full house    Three of a kind      Pair    Two pair     Straight    High card wins
```

To be thorough, each of these endpoints is going to need also going to need a tiebreaker. Luckily only full house, three of a kind, and pair need special treatment, for all other outcomes the highest card wins.

### Tied hands

Each hand will need to have a hand rank, then a tiebreaker condition. So to find a winner, first the rank of the hand will be compared, then the tiebreaker condition.

| Hand	 |	Tiebreaker condition	| 	Explanation	| 
| ------ |------------- | ------------- | 
| Straight flush |	High card | Since cards are consecutive, only one card is needed for the tiebreaker |
| Four of a kind |	Value of one of the four | Since there are only four in the deck, this can't be a tie |
| Full house | Value of one of the three | See above explanation |
| Flush | All cards, high to low | Any cards could make up a flush |
| Straight| High card | See straight flush |
| Three of a kind | Value of one of the three | See above explanation |
| Two pair | Value of high pair, value of low pair, value of remaining card| |
| Pair | Value of pair, value of remaining cards | |
| High card | Same as a flush | |
