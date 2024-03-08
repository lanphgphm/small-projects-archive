// import java.util.ArrayList;
// import java.util.Collections; 
// import java.util.Comparator; 

// class Cards{ 
//     static ArrayList<Pair> cardPair; 

//     static class Pair{
//         int rank;
//         String suit; 

//         Pair(int rank, String suit){
//             this.rank = rank; 
//             this.suit = suit; 
//         }
//     }

//     static Pair makePair(int rank, String suit){
//         return new Pair(rank, suit); 
//     }

//     static int getNumericalRank(String rank){
//         if (rank.equals("J")) return 11; 
//         else if (rank.equals("Q")) return 12; 
//         else if (rank.equals("K")) return 13; 
//         else if (rank.equals("A")) return 14; 
//         else if (rank.equals("A1")) return 1; 
//         else return Integer.parseInt(rank); 
//     }

//     static boolean checkDuplicateCards(String[] cards){
//         for (int i = 0; i < cards.length; i++){
//             for (int j = i+1; j < cards.length; j++){
//                 if (cards[i].equals(cards[j])) return true; 
//             }
//         }
//         return false;
//     }

//     public Cards(String[] cards, ArrayList<Pair> cardPair, int[] rankCount){
//         if (cards.length != 5){
//             throw new IllegalArgumentException("Invalid number of cards: require 5, got " + cards.length);
//         }

//         if (checkDuplicateCards(cards)){
//             throw new IllegalArgumentException("Invalid card hand: duplicate cards");
//         }

//         for (int i = 0; i < cards.length; i++){
//             String currentCard = cards[i];
//             if (!currentCard.matches("([2-9JQKA]|10)[HDCS]")){
//                 throw new IllegalArgumentException("Invalid card: " + currentCard);
//             }
//             else{
//                 int n = currentCard.length(); 
//                 String rank = currentCard.substring(0, n-1); 
//                 int numRank = getNumericalRank(rank); 
//                 String suit = currentCard.substring(n-1, n); 

//                 Pair currentCardPair = makePair(numRank, suit);
//                 this.cardPair.add(currentCardPair); 

//                 // add an extra card if Ace, because Ace can be 14 and 1 
//                 if (rank.equals("A")){
//                     int tmpAceNum = 1;
//                     Pair tmpCardPair = makePair(tmpAceNum, suit); 
//                     this.cardPair.add(tmpCardPair); 
//                 }  
//             }
//         }
        
//     }

//     static boolean isInSequentialRank(){
//         /* this function assumes the cardPair array is ALREADY SORTED */
//         for (int i = 0; i < cardPair.size()-1; i++){
//             if (cardPair.get(i).rank != cardPair.get(i+1).rank - 1) return false; 
//         }
//         return true;
//     }

//     static boolean isSameSuit(){
//         String firstSuit = cardPair.get(0).suit; 
//         for (int i = 1; i < cardPair.size(); i++){
//             String currentCardSuit = cardPair.get(i).suit;
//             if (!currentCardSuit.equals(firstSuit)) return false;
//         }
//         return true; 
//     }

//     static int pairCount(){
//         int pairCount = 0; 
//         for (int i = 0; i < 15; i++){
//             if (rankCount[i]==2) pairCount++; 
//         }
//         return pairCount; 
//     }

//     boolean isStraightFlush(){
//         /* 5 cards in sequential rank, all same suit */
//         boolean isSameSuit = isSameSuit(); 
//         boolean isInSequentialRank = isInSequentialRank(); 
//         if (isSameSuit && isInSequentialRank){
//             return true;
//         }
//         else return false; 
//     }

//     boolean isFourOfAKind(){
//         for (int i = 0; i < 15; i++){
//             if (rankCount[i]==4) return true; 
//         }
//         return false; 
//     }

//     boolean isFullHouse(){
//         boolean trip = false; 
//         boolean pair = false; 
//         for (int i = 0; i < 15; i++){
//             if (rankCount[i] == 2) pair = true; 
//             if (rankCount[i] == 3) trip = true; 
//         }

//         if (trip && pair) return true; 
//         else return false; 
//     }

//     boolean isFlush(){
//         /* 5 cards not in sequential rank, all same suit */
//         boolean isSameSuit = isSameSuit(); 
//         boolean isInSequentialRank = isInSequentialRank(); 
//         if (isSameSuit && !isInSequentialRank){
//             return true;
//         }
//         else return false; 
//     }

//     boolean isStraight(){
//         /* 5 cards in sequential rank, not al same suit */
//         boolean isSameSuit = isSameSuit(); 
//         boolean isInSequentialRank = isInSequentialRank(); 
//         if (!isSameSuit && isInSequentialRank){
//             return true;
//         }
//         else return false;  
//     }

//     boolean isThreeOfAKind(){
//         boolean isFullHouse = isFullHouse(); 

//         if (isFullHouse) return false; 
//         else {
//             boolean trip = false;
//             for (int i = 0; i < 15; i++)
//                 if (rankCount[i] == 3) trip = true; 

//             if (trip) return true; 
//             return false; 
//         }
        
//     }

//     boolean isTwoPair(){
//         int pairCount = pairCount(); 
//         if (pairCount==2) return true; 
//         else return false; 
//     }

//     boolean isOnePair(){
//         int pairCount = pairCount(); 
//         if (pairCount==1) return true; 
//         else return false; 
//     }

//     void sortArrayPair(){
//         Comparator<Pair> sortingCriteria = new Comparator<Pair>(){
//             public int compare(Pair card1, Pair card2){
//                 return Integer.compare(card1.rank, card2.rank); 
//             }
//         };

//         Collections.sort(cardPair, sortingCriteria);
//     }

//     public void getRankCount(){
//         for (int i = 0; i < cardPair.size(); i++){
//             int idx = cardPair.get(i).rank;
//             rankCount[idx]++; 
//         }
//     }

//     public /*static*/ int getCategory(){
//         for (int i = 0; i < 15; i++) {
//             rankCount[i] = 0;
//         }

//         sortArrayPair();
//         getRankCount();
//         for (int i = 0; i < 15; i++)
//             System.out.printf("%s ", rankCount[i]);

//         boolean isStraightFlush = isStraightFlush(); 
//         boolean isFourOfAKind = isFourOfAKind();
//         boolean isFullHouse = isFullHouse();
//         boolean isFlush = isFlush();
//         boolean isStraight = isStraight();
//         boolean isThreeOfAKind = isThreeOfAKind();
//         boolean isTwoPair = isTwoPair();
//         boolean isOnePair = isOnePair();

//         if (isStraightFlush) return 9; 
//         else if (isFourOfAKind) return 8; 
//         else if (isFullHouse) return 7; 
//         else if (isFlush) return 6; 
//         else if (isStraight) return 5; 
//         else if (isThreeOfAKind) return 4; 
//         else if (isTwoPair) return 3; 
//         else if (isOnePair) return 2; 
//         else return 1; 
//     }

// }



// public class PokerHand{
//     static String[] cardHand = new String[5]; // ABSOLUTELY DO NOT MODIFY IN ANY WAY 
//     static ArrayList<Pair> cardPair = new ArrayList<Pair>();
//     static int[] rankCount = new int[15]; // ignore index 0 :)
//     Cards hand; 
//     public PokerHand(String[] cards){
//         hand = new Cards(cards, cardPair, rankCount);
//     }

//     public int get_category(){
//         return hand.getCategory();
//     }

//     public static void main(String[] args){
//         String[] cards = {"4H", "4C", "8S", "8D", "4S"};
//         Poker_hand hand_1 = new Poker_hand(cards);
//         String[] another_cards = {"AH", "4H", "10H", "8H", "JH"};
//         Poker_hand hand_2 = new Poker_hand(another_cards);

//         System.out.println(hand_1.get_category());
//         System.out.println(hand_2.get_category());
//     }
// }