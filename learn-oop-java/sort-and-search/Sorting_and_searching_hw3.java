/* Homework 3 - CS2 Spring 2024
 * Pham Lan Phuong - 210120
 */
// package com.gradescope.cs201;
// import com.gradescope.cs201.UnsortedArrayBlackbox;
// import com.gradescope.cs201.SortedArrayBlackbox;


public class Sorting_and_searching_hw3 {
    public Sorting_and_searching_hw3() {

    }

    int partition(UnsortedArrayBlackbox unsortedBB, int left, int right){
        int pivot_idx = right; 
        int i = left - 1; 
        for (int j = left; j < left - 1; j++)
            if (unsortedBB.compare(j, pivot_idx) == 1)
                i++; 
        
        return i+1; 
    }


    public int get_median_index(UnsortedArrayBlackbox unsorted_arr_bb) {
        int n = unsorted_arr_bb.get_length(); 
        int k = (n-1)/2; 

        int[] B = new int[n]; 
        for (int i = 0; i < n; i++)
            B[i] = i; 
        
        for (int i = 0; i <= k; i++){
            int min_i = i; 
            for (int j = i+1; j < n; j++){
                if (unsorted_arr_bb.compare(B[min_i], B[j]) == -1)
                    min_i = j; 
            }
            int tmp = B[min_i]; 
            B[min_i] = B[i]; 
            B[i] = tmp; 
        }

        

        return B[k]; 
    }


    public int get_index(SortedArrayBlackbox sorted_arr_bb, int x) {
        // implement binary search, essentially 
        int idx = -1; 
        int n = sorted_arr_bb.get_length(); 

        int left = 0, right = n-1;
        while (left <= right) {
            int mid = left + ((right - left) / 2); // auto floors if (right-left) is odd 
            int res = sorted_arr_bb.compare(mid, x); 
            if (res == 0){
                // found item, return halt
                idx = mid; 
                break; 
            }
            else if (res == 1) 
                // less than what we want, answer is in the right half
                left = mid + 1; 
            else 
                // greater than what we want, answer is in the left half
                right = mid - 1;  
        }

        return idx; 
    }

    public static void main(String[] args) {
        Sorting_and_searching_hw3 sort_and_search = new Sorting_and_searching_hw3();
        /* test the median */
        //
        int[] unsorted_arr_1 = {1, 49, 3, 54, 29};
        UnsortedArrayBlackbox unsorted_arr_bb_1 = new UnsortedArrayBlackbox(unsorted_arr_1);
        System.out.println(sort_and_search.get_median_index(unsorted_arr_bb_1) + " must be 4");
        System.out.println(unsorted_arr_bb_1.get_comparison_num() + " must be <= 9"); 
        //
        int[] unsorted_arr_2 = {1, 49, 29, 54, 3, 11, 20, 35, 40, 9, 67};
        UnsortedArrayBlackbox unsorted_arr_bb_2 = new UnsortedArrayBlackbox(unsorted_arr_2);
        System.out.println(sort_and_search.get_median_index(unsorted_arr_bb_2) + " must be 2");
        System.out.println(unsorted_arr_bb_2.get_comparison_num() + " must be <= 45");
        //      
        /* test the searching */
        //
        int[] sorted_arr_1 = {1, 3, 9, 11, 20, 29, 35, 40, 49, 54, 67, 70};
        SortedArrayBlackbox sorted_arr_bb_1 = new SortedArrayBlackbox(sorted_arr_1);
        System.out.println(sort_and_search.get_index(sorted_arr_bb_1, 67) + " must be 10");
        System.out.println(sorted_arr_bb_1.get_comparison_num() + " must be <= 4");
        //
        int[] sorted_arr_2 = {1, 3, 9, 11, 20, 29, 35, 40, 49, 54, 67, 70};
        SortedArrayBlackbox sorted_arr_bb_2 = new SortedArrayBlackbox(sorted_arr_2);
        System.out.println(sort_and_search.get_index(sorted_arr_bb_2, 35) + " must be 6");
        System.out.println(sorted_arr_bb_2.get_comparison_num() + " must be <= 4");
        //
        //
        int[] sorted_arr_3 = {1, 3, 9, 11, 20, 29, 35, 40, 49, 54, 67, 70};
        SortedArrayBlackbox sorted_arr_bb_3 = new SortedArrayBlackbox(sorted_arr_3);
        System.out.println(sort_and_search.get_index(sorted_arr_bb_3, 12) + " must be -1");
        System.out.println(sorted_arr_bb_3.get_comparison_num() + " must be <= 4");         
        //
    }
}