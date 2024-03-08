// import java.util.ArrayList;

// public class mini_poker {
//     static String[] cardHand = new String[5]; // ABSOLUTELY DO NOT MODIFY IN ANY WAY 
//     static ArrayList<Pair> cardPair = new ArrayList<Pair>();
//     static int[] rankCount = new int[14]; 
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

//     static boolean checkDuplicateCards(){
//         for (int i = 0; i < cardHand.length; i++){
//             for (int j = i+1; j < cardHand.length; j++){
//                 if (cardHand[i].equals(cardHand[j])) return true; 
//             }
//         }
//         return false;
//     }

//     public mini_poker(String[] cards){
//         if (cards.length != 5){
//             throw new IllegalArgumentException("Invalid number of cards: require 5, got " + cards.length);
//         }

//         for (int i = 0; i < cards.length; i++){
//             String currentCard = cards[i];
//             if (!currentCard.matches("([2-9JQKA]|10)[HDCS]")){
//                 throw new IllegalArgumentException("Invalid card: " + currentCard);
//             }
//             else{
//                 cardHand[i] = currentCard; 

//                 int n = currentCard.length(); 
//                 String rank = currentCard.substring(0, n-1); 
//                 int numRank = getNumericalRank(rank); 
//                 String suit = currentCard.substring(n-1, n); 

//                 Pair currentCardPair = makePair(numRank, suit);
//                 cardPair.add(currentCardPair); 

//                 // add an extra card if Ace, because Ace can be 14 and 1 
//                 if (rank.equals("A")){
//                     int tmpAceNum = 1;
//                     Pair tmpCardPair = makePair(tmpAceNum, suit); 
//                     cardPair.add(tmpCardPair); 
//                 }  
//             }
//         }
        
//         if (checkDuplicateCards()){
//             throw new IllegalArgumentException("Invalid card hand: duplicate cards");
//         }
//     }


//     static boolean isSameSuit(){
//         String firstSuit = cardPair.get(0).suit; 
//         for (int i = 1; i < cardPair.size(); i++){
//             String currentCardSuit = cardPair.get(i).suit;
//             if (!currentCardSuit.equals(firstSuit)) return false;
//         }
//         return true; 
//     }

//     public static int get_category(){

//     }
// }
