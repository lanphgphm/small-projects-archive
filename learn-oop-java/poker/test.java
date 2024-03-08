public class test{
    // use PokerHandGenerator to generate test cases
    // then, test it on Poker_hand_hw2, print input and output
    public static void main(String[] args) {
        // PokerHandGenerator test = new PokerHandGenerator();
        // Poker_hand_hw2 hand1 = test.generateHand();
        // Poker_hand_hw2 hand2 = test.generateHand();

        // test cases
        String[] cards1 = {"2H", "JH", "8H", "9H", "10H"};
        String[] cards2 = {"8S", "4S", "5S", "9S", "10S"};
        
        Poker_hand_hw2 hand1 = new Poker_hand_hw2(cards1);
        Poker_hand_hw2 hand2 = new Poker_hand_hw2(cards2);

        // run Poker_hand_hw2 methods on hand
        System.out.println("Input: Hand1 ");
        hand1.printCards();
        System.out.println("Output: Hand1 is a " + hand1.get_category());

        System.out.println();
        System.out.println("Input: Hand2 ");
        hand2.printCards();
        System.out.println("Output: Hand2 is a " + hand2.get_category());

        System.out.println();
        System.out.println("Hand1 beats Hand2? " + hand1.compare_to(hand2));

    }    
}
