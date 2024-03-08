package backtrack;

public class BinaryString {
    // using backtrack to print all binary strings of length n

    public static void printBinaryString(int n, int idx, int[] s){
        if (idx == n){
            // done, print now 
            for (int i = 0; i < n; i++)
                System.out.print(s[i]);
            System.out.println();
        }
        else{
            for (int d = 0; d <= 1; d++){
                s[idx] = d; 
                printBinaryString(n, idx+1, s);
            }
        }

    }
    public static void main (String[] args){
        int n = 3; 
        int[] s = new int[n];
        printBinaryString(n, 0, s); 
    }
}
