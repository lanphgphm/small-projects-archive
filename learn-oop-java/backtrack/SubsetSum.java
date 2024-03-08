package backtrack;
import java.util.ArrayList;

public class SubsetSum {
    // finds subset sum using backtracking 
    public static boolean containsSubsetSum(int[] arr, int sum, 
                                int idx, ArrayList<Integer> subset){
        if (sum == 0) return true; 
        if (idx == arr.length) return false;
        int num = arr[idx];
        if (num <= sum){
            subset.add(num); 
            if (containsSubsetSum(arr, sum - num, idx + 1, subset)) return true; 
            subset.remove(subset.size() - 1);
        }
        return containsSubsetSum(arr, sum, idx + 1, subset);
    }
    public static void main(String[] args) {
        int[] arr = { 2, 3, 7, 8, 10, 4, 13, 68, 90, 67, 32, 17, 24 };
        int sum = 123;
        ArrayList<Integer> ss = new ArrayList<>();

        if (containsSubsetSum(arr, sum, 0, ss))
            System.out.println("Subset with sum " + sum + " exists: " + ss);
        else
            System.out.println("Subset with sum " + sum + " does not exist");
    }
}
