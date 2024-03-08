import java.util.Random;

public class PokerHandGenerator {

    public PokerHandGenerator() {
        Poker_hand_hw2 hand = generateHand();
    }

    public Poker_hand_hw2 generateHand() {
        String[] suits = {"H", "D", "C", "S"};
        String[] ranks = {"2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"};
        Random rand = new Random();
    
        String[] cards = new String[5];
        for (int j = 0; j < 5; j++) {
            String rank = ranks[rand.nextInt(ranks.length)];
            String suit = suits[rand.nextInt(suits.length)];
            cards[j] = rank + suit;
        }
        Poker_hand_hw2 handd = new Poker_hand_hw2(cards);

        return handd;
        }
    }

