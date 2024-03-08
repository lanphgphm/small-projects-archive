package backtrack;
public class Permutations {
    static int[] get_set(int n){
        int[] set = new int[n]; 
        for (int i = 1; i <= n; i++)
            set[i-1] = i; 
        return set; 
    }

    public static void printPermutations(int n, int[] set, int elem, int[] subp){
        if (elem == n){
            for (int i = 0; i < n; i++)
                System.out.print(subp[i] + " ");
            System.out.println();
        }
        else {
            for (int i = 0; i < n; i++){
                boolean isRepeated = false; 
                for (int j = 0; j < elem; j++){
                    if (subp[j] == set[i]){
                        isRepeated = true; 
                        break; 
                    }
                }
                if (!isRepeated){
                    subp[elem] = set[i]; 
                    printPermutations(n, set, elem+1, subp);
                }
            }
        }
    }

    public static void main(String[] args){
        int n = 4; 
        int[] set = get_set(n);
        int[] p = new int[n]; 
        printPermutations(n, set, 0, p);

    }
}
