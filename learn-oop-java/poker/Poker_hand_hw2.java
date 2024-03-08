/* Homework 2 - CS2 Spring 2024
 * Pham Lan Phuong - 210120
 * note: hinh nhu thay assume A = 14 :) 
 */

package com.gradescope.cs201;
import java.util.ArrayList;
import java.util.Collections; 
import java.util.Comparator; 


public class Poker_hand_hw2{
    private String[] cardHand = new String[5]; // ABSOLUTELY DO NOT MODIFY IN ANY WAY 
    private ArrayList<Pair> cardPair = new ArrayList<Pair>();
    private int[] rankCount = new int[15]; // ignore index 0 :) 
    private boolean aceInHand = false; 
    private int n; //cardPair size 


    class Pair{
        int rank;
        String suit; 

        Pair(int rank, String suit){
            this.rank = rank; 
            this.suit = suit; 
        }
    }
    
    // create a class for each poker hand category
    class StraightFlush{
        public int sfRank;
        StraightFlush(Poker_hand_hw2 hand){
            sfRank = hand.cardPair.get(hand.n-1).rank; 
        }
    }

    class FourOfAKind{
        public int quadRank;
        public int kickerRank; 

        FourOfAKind(Poker_hand_hw2 hand){
            for (int i = 0; i < hand.n; i++){
                Pair currentCard = hand.cardPair.get(i);
                int currentRank = currentCard.rank;
                if (hand.rankCount[currentRank]==4) {
                    quadRank = currentRank; 
                }
                else kickerRank = currentRank; 
            }
        }
    }

    class FullHouse{
        public int tripRank; 
        public int pairRank; 

        FullHouse(Poker_hand_hw2 hand){
            for (int i = 0; i < hand.n; i++){
                Pair currentCard = hand.cardPair.get(i);
                int currentRank = currentCard.rank;
                if (hand.rankCount[currentRank]==3) {
                    tripRank = currentRank; 
                }
                else {
                    pairRank = currentRank; 
                }
            }
        }
    }   

    class Flush{
        public ArrayList<Integer> flushRank = new ArrayList<Integer>(); 

        Flush(Poker_hand_hw2 hand){
            for (int i = 0; i < hand.n; i++){
                flushRank.add(hand.cardPair.get(i).rank);
            }
        }
    }

    class Straight{
        public int straightRank; 
        Straight(Poker_hand_hw2 hand){
                       
            if (hand.aceInHand){
                /* brute force, because coming up with new logic is  
                * more computationally expensive
                * J-Q-K-A-2 -> 1 2 11 12 13 14 
                * Q-K-A-2-3 -> 1 2 3  12 13 14
                * K-A-2-3-4 -> 1 2 3 4 12 14
                * 10-J-Q-K-A -> 1 10 11 12 13 14
                * A-2-3-4-5 -> 1 2 3 4 5 14
                */ 
                int[] normal1 = {2, 3, 4, 5, 14}; 
                int[] normal2 = {10, 11, 12, 13, 14};
                int[] weird1 = {2, 11, 12, 13, 14}; 
                int[] weird2 = {2, 3, 12, 13, 14}; 
                int[] weird3 = {2, 3, 4, 12, 14}; 

                if (matches(normal1, hand)) straightRank = 5; 
                else if (matches(normal2, hand)) straightRank = 14; 
                else if (matches(weird1, hand)) straightRank = -666; // christian hell telefone 
                else if (matches(weird2, hand)) straightRank = -444; // china's hell telefone
                else if (matches(weird3, hand)) straightRank = -222; // im no longer creative
            }
            else {
                straightRank = hand.cardPair.get(hand.n-1).rank; 
            }
        }
    }

    class ThreeOfAKind{
        int tripRank; 
        int highKicker; 
        int lowKicker; 
        ArrayList<Integer> kickerRank = new ArrayList<Integer>(); 

        ThreeOfAKind(Poker_hand_hw2 hand){
            for (int i = 0; i < hand.n; i++){
                Pair currentCard = hand.cardPair.get(i);
                int currentRank = currentCard.rank;
                if (hand.rankCount[currentRank] == 3){
                    tripRank = currentRank;
                }
                else kickerRank.add(currentRank);
            }
            highKicker = Collections.max(kickerRank);
            lowKicker = Collections.min(kickerRank); 
        }
    }

    class TwoPair{
        public int highPairRank; 
        public int lowPairRank; 
        public int kickerRank; 
        ArrayList<Integer> pairRank = new ArrayList<Integer>();

        TwoPair(Poker_hand_hw2 hand){
            for (int i = 0; i < hand.n; i++){
                Pair currentCard = hand.cardPair.get(i); // !!!
                int currentRank = currentCard.rank;
                if (hand.rankCount[currentRank] == 2){
                    pairRank.add(currentRank);
                }
                else kickerRank = currentRank;
            }
            lowPairRank = Collections.min(pairRank);
            highPairRank = Collections.max(pairRank);
        }
    }

    class OnePair{
        public int pairRank; 
        public int highKicker;
        public int midKicker;
        public int lowKicker;
        ArrayList<Integer> kickerRank = new ArrayList<Integer>();

        OnePair(Poker_hand_hw2 hand){
            for (int i = 0; i < hand.n; i++){
                Pair currentCard = hand.cardPair.get(i);
                int currentRank = currentCard.rank;
                if (hand.rankCount[currentRank] == 2){
                    pairRank = currentRank;
                }
                else kickerRank.add(currentRank);
            }
            lowKicker = Collections.min(kickerRank); 
            highKicker = Collections.max(kickerRank); // AS 2S 2C 7D 10H, A = 1 or 14? 
            for (int i = 0; i < kickerRank.size(); i++){
                if (kickerRank.get(i) != lowKicker && kickerRank.get(i) != highKicker){
                    midKicker = kickerRank.get(i); 
                }
            }
        }
    }

    class HighCard{
        public ArrayList<Integer> highCardRank = new ArrayList<Integer>(); 

        HighCard(Poker_hand_hw2 hand){
            for (int i = 0; i < hand.n; i++){
                highCardRank.add(hand.cardPair.get(i).rank);
            }
        }
    }

    boolean matches(int[] a, Poker_hand_hw2 hand){
        for (int i = 0; i < hand.n; i++){
            if (a[i] != hand.cardPair.get(i).rank) return false; 
        }
        return true; 
    }

    Pair makePair(int rank, String suit){
        return new Pair(rank, suit); 
    }

    int getNumericalRank(String rank){
        if (rank.equals("J")) return 11; 
        else if (rank.equals("Q")) return 12; 
        else if (rank.equals("K")) return 13; 
        else if (rank.equals("A")) return 14; 
        else if (rank.equals("A1")) return 1; 
        else return Integer.parseInt(rank); 
    }

    boolean checkDuplicateCards(String[] cards){
        for (int i = 0; i < cards.length; i++){
            for (int j = i+1; j < cards.length; j++){
                if (cards[i].equals(cards[j])) return true;
            }
        }
        return false;
    }

    // constructor 
    public Poker_hand_hw2(String[] cards){
        if (cards.length != 5){
            throw new IllegalArgumentException("Invalid number of cards: require 5, got " + cards.length);
        }

        if (checkDuplicateCards(cards)){
            throw new IllegalArgumentException("Invalid card hand: duplicate cards");
        }

        for (int i = 0; i < cards.length; i++){
            String currentCard = cards[i];
            if (!currentCard.matches("([2-9JQKA]|10)[HDCS]")){
                throw new IllegalArgumentException("Invalid card: " + currentCard);
            }
            else{
                cardHand[i] = currentCard; 

                int m = currentCard.length(); 
                String rank = currentCard.substring(0, m-1); 
                int numRank = getNumericalRank(rank); 
                String suit = currentCard.substring(m-1, m); 

                Pair currentCardPair = makePair(numRank, suit);
                cardPair.add(currentCardPair); 

                // add an extra card if Ace, because Ace can be 14 and 1 
                if (rank.equals("A")){
                    aceInHand = true; 
                    // int tmpAceNum = 1;
                    // Pair tmpCardPair = makePair(tmpAceNum, suit); 
                    // cardPair.add(tmpCardPair); 
                }  
            }
        }
        
        n = cardPair.size(); 
        sortArrayPair();
        getRankCount();  
    }

    boolean isInSequentialRank(){
        /* this function assumes the cardPair array is ALREADY SORTED */
        for (int i = 0; i < n-1; i++){
            if (cardPair.get(i).rank != cardPair.get(i+1).rank - 1) return false; 
        }
        return true;
    }

    boolean isSameSuit(){
        String firstSuit = cardPair.get(0).suit; 
        for (int i = 1; i < n; i++){
            String currentCardSuit = cardPair.get(i).suit;
            if (!currentCardSuit.equals(firstSuit)) return false;
        }
        return true; 
    }

    int pairCount(){
        int pairCount = 0; 
        for (int i = 0; i < 15; i++){
            if (rankCount[i]==2) pairCount++; 
        }
        return pairCount; 
    }

    boolean isStraightFlush(){
        /* 5 cards in sequential rank, all same suit */
        boolean isSameSuit = isSameSuit(); 
        boolean isInSequentialRank = isInSequentialRank(); 
        if (isSameSuit && isInSequentialRank){
            return true;
        }
        else return false; 
    }

    boolean isFourOfAKind(){
        for (int i = 0; i < 15; i++){
            if (rankCount[i]==4) return true; 
        }
        return false; 
    }

    boolean isFullHouse(){
        boolean trip = false; 
        boolean pair = false; 
        for (int i = 0; i < 15; i++){
            if (rankCount[i] == 2) pair = true; 
            if (rankCount[i] == 3) trip = true; 
        }

        if (trip && pair) return true; 
        else return false; 
    }

    boolean isFlush(){
        /* 5 cards not in sequential rank, all same suit */
        boolean isSameSuit = isSameSuit(); 
        boolean isInSequentialRank = isInSequentialRank(); 
        if (isSameSuit && !isInSequentialRank){
            return true;
        }
        else return false; 
    }

    boolean isStraight(){
        /* 5 cards in sequential rank, not al same suit */
        boolean isSameSuit = isSameSuit(); 
        boolean isInSequentialRank = isInSequentialRank(); 
        if (!isSameSuit && isInSequentialRank){
            return true;
        }
        else return false;  
    }

    boolean isThreeOfAKind(){
        boolean isFullHouse = isFullHouse(); 

        if (isFullHouse) return false; 
        else {
            boolean trip = false;
            for (int i = 0; i < 15; i++)
                if (rankCount[i] == 3) trip = true; 

            if (trip) return true; 
            return false; 
        }
        
    }

    boolean isTwoPair(){
        int pairCount = pairCount(); 
        if (pairCount==2) return true; 
        else return false; 
    }

    boolean isOnePair(){
        int pairCount = pairCount(); 
        if (pairCount==1) return true; 
        else return false; 
    }

    void sortArrayPair(){
        Comparator<Pair> sortingCriteria = new Comparator<Pair>(){
            public int compare(Pair card1, Pair card2){
                return Integer.compare(card1.rank, card2.rank); 
            }
        };

        Collections.sort(cardPair, sortingCriteria);
    }

    void getRankCount(){
        for (int i = 0; i < n; i++){
            int idx = cardPair.get(i).rank;
            rankCount[idx]++; 
        }
    }

    public int get_category(){

        boolean isStraightFlush = isStraightFlush(); 
        boolean isFourOfAKind = isFourOfAKind();
        boolean isFullHouse = isFullHouse();
        boolean isFlush = isFlush();
        boolean isStraight = isStraight();
        boolean isThreeOfAKind = isThreeOfAKind();
        boolean isTwoPair = isTwoPair();
        boolean isOnePair = isOnePair();

        if (isStraightFlush) return 9; 
        else if (isFourOfAKind) return 8; 
        else if (isFullHouse) return 7; 
        else if (isFlush) return 6; 
        else if (isStraight) return 5; 
        else if (isThreeOfAKind) return 4; 
        else if (isTwoPair) return 3; 
        else if (isOnePair) return 2; 
        else return 1; 
    }


    
    int compareStraightFlush(Poker_hand_hw2 thishand, Poker_hand_hw2 otherhand){ 
        StraightFlush sf1 = new StraightFlush(thishand); 
        StraightFlush sf2 = new StraightFlush(otherhand); 
        return Integer.compare(sf1.sfRank, sf2.sfRank);
    }
    
    int compareFourOfAKind(Poker_hand_hw2 thishand, Poker_hand_hw2 otherhand){ 
        FourOfAKind quad1 = new FourOfAKind(thishand); 
        FourOfAKind quad2 = new FourOfAKind(otherhand); 
        if (quad1.quadRank != quad2.quadRank)
            return Integer.compare(quad1.quadRank, quad2.quadRank); 
        else return Integer.compare(quad1.kickerRank, quad2.kickerRank); 
    }
    
    int compareFullhouse(Poker_hand_hw2 thishand, Poker_hand_hw2 otherhand){
        FullHouse fh1 = new FullHouse(thishand); 
        FullHouse fh2 = new FullHouse(otherhand);
        if (fh1.tripRank != fh2.tripRank)
            return Integer.compare(fh1.tripRank, fh2.tripRank); 
        else return Integer.compare(fh1.pairRank, fh2.pairRank); 
    }

    int compareFlush(Poker_hand_hw2 thishand, Poker_hand_hw2 otherhand){
        Flush f1 = new Flush(thishand); 
        Flush f2 = new Flush(otherhand); 
        for (int i = f1.flushRank.size()-1; i >= 0 ; i++){
            int rank1 = f1.flushRank.get(i); 
            int rank2 = f2.flushRank.get(i);
            if (rank1 < rank2) return -1; 
            else if (rank1 > rank2) return 1;
        }
        return 0; 
    }
    
    int compareStraight(Poker_hand_hw2 thishand, Poker_hand_hw2 otherhand){
        Straight s1 = new Straight(thishand); 
        Straight s2 = new Straight(otherhand); 
        return Integer.compare(s1.straightRank, s2.straightRank); 
    }
    
    int compareThreeOfAKind(Poker_hand_hw2 thishand, Poker_hand_hw2 otherhand){
        ThreeOfAKind trip1 = new ThreeOfAKind(thishand); 
        ThreeOfAKind trip2 = new ThreeOfAKind(otherhand); 
        if (trip1.tripRank != trip2.tripRank)
            return Integer.compare(trip1.tripRank, trip2.tripRank); 
        else if (trip1.highKicker != trip2.highKicker)
            return Integer.compare(trip1.highKicker, trip2.highKicker); 
        else return Integer.compare(trip1.lowKicker, trip2.lowKicker);
    }
    
    int compareTwoPair(Poker_hand_hw2 thishand, Poker_hand_hw2 otherhand){
        TwoPair pp1 = new TwoPair(thishand); 
        TwoPair pp2 = new TwoPair(otherhand); 

        if (pp1.highPairRank != pp2.highPairRank)
            return Integer.compare(pp1.highPairRank, pp2.highPairRank); 
        else if (pp1.lowPairRank != pp2.lowPairRank)
            return Integer.compare(pp1.lowPairRank, pp2.lowPairRank); 
        else return Integer.compare(pp1.kickerRank, pp2.kickerRank); 
    }
    
    int compareOnePair(Poker_hand_hw2 thishand, Poker_hand_hw2 otherhand){
        OnePair p1 = new OnePair(thishand); 
        OnePair p2 = new OnePair(otherhand); 
        if (p1.pairRank != p2.pairRank)
            return Integer.compare(p1.pairRank, p2.pairRank); 
        else if (p1.highKicker != p1.highKicker)
            return Integer.compare(p1.highKicker, p2.highKicker); 
        else if (p1.midKicker != p2.midKicker)
            return Integer.compare(p1.midKicker, p2.midKicker); 
        else return Integer.compare(p1.lowKicker, p2.lowKicker); 
    }
    
    int compareHighCard(Poker_hand_hw2 thishand, Poker_hand_hw2 otherhand){
        /* currently assuming ace is 1 */
        HighCard hc1 = new HighCard(thishand); 
        HighCard hc2 = new HighCard(otherhand); 
        int size1 = hc1.highCardRank.size();
        int size2 = hc2.highCardRank.size();

        for (int i = 0; i < Math.min(size1, size2); i++){
            int rank1 = hc1.highCardRank.get(i);
            int rank2 = hc2.highCardRank.get(i);
            if (rank1 < rank2) return -1; 
            else if (rank1 > rank2) return 1;
        }
        return 0;
    }
    
    

    public int compare_to(Poker_hand_hw2 hand2){
        int categoryHand1 = this.get_category();
        int categoryHand2 = hand2.get_category();

        if (categoryHand1 > categoryHand2) return 1; 
        else if (categoryHand1 < categoryHand2) return -1; 
        else{
            if (categoryHand1 == 9) return compareStraightFlush(this, hand2); 
            else if (categoryHand1 == 8) return compareFourOfAKind(this, hand2); 
            else if (categoryHand1 == 7) return compareFullhouse(this, hand2);
            else if (categoryHand1 == 6) return compareFlush(this, hand2); 
            else if (categoryHand1 == 5) return compareStraight(this, hand2); 
            else if (categoryHand1 == 4) return compareThreeOfAKind(this, hand2); 
            else if (categoryHand1 == 3) return compareTwoPair(this, hand2); 
            else if (categoryHand1 == 2) return compareOnePair(this, hand2);
            else return compareHighCard(this, hand2);
        }
    }

    public void printCards(){
        for (int i = 0; i < n; i++){
            System.out.printf("%d%s ", cardPair.get(i).rank, cardPair.get(i).suit);
        }
        System.out.println();
    }

    void printRankCount(){
        for (int i = 0; i < 15; i++){
            System.out.printf("%d ", rankCount[i]);
        }
        System.out.println();
    }

}