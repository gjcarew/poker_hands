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

This should be a rails app to take advantage of a PostgreSQL database and the ActiveRecord ORM. Extensibility was one of the suggested criteria, and this seems like it would allow for easier creation of statistics, analysis of hands, additional players, etc. 

Initial thoughts are to have all 'belongs to' relationships: A card belongs to a hand, and hand belongs to a player, there are two hands per round. 

The best way to get the data from the text file into the Postgres database is most likely through a custom rake task since it is a one-off thing. 

For the time being, I would use a runner file to find the final solution for how many wins player one has. 