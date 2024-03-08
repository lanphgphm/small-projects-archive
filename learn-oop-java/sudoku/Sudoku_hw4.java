/* Homework 4 - CS2 Spring 2024
 * Pham Lan Phuong - 210120
 */
package com.gradescope.cs201;
import java.util.ArrayList;

public class Sudoku_hw4{

    private static int[] find_small_square(int x, int y){
        int[] ans = new int[2]; 
        ans[0] = x - x % 3; 
        ans[1] = y - y % 3; 
        return ans;
    }

    public static int[] find_possible_values(int[][] mat, int x, int y){
        ArrayList<Integer> ans = new ArrayList<Integer>(); 
        for (int i = 0; i < 10; i++){
            ans.add(i); 
        }

        for (int i = 0; i < 9; i++){
            int rval = mat[x][i]; 
            int cval = mat[i][y];
            if (rval != 0 && ans.get(rval) != 0)
                ans.set(rval, 0); 

            if (cval != 0 && ans.get(cval) != 0)
                ans.set(cval, 0); 
        }

        int[] which_small = find_small_square(x, y);
        int xstart = which_small[0]; 
        int ystart = which_small[1]; 

        for (int i = xstart; i < xstart+3; i++){
            for (int j = ystart; j < ystart+3; j++){
                int num = mat[i][j];
                if ((num != 0) && (ans.get(num) != 0))
                    ans.set(num, 0); 
            }
        }

        int k = 0; 
        for (int i = 0; i < ans.size(); i++)
            if (ans.get(i) != 0)
                k++; 
        
        int[] final_ans = new int[k];
        int d = 0; 
        for (int i = 0; i < ans.size(); i++){
            if (ans.get(i) != 0){
                final_ans[d] = ans.get(i); 
                d++; 
            }
        }
        return final_ans;
    }

    public static void printArray(int[] a, int n){
        for (int i = 0; i < n; i++){
            System.out.print(a[i] + " ");
        }
        System.out.println();
    }

    public static void printMatrix(int[][] mat){ // O(n^2)
        for (int i = 0; i < 9; i++){
            printArray(mat[i], 9);
        }
    }

    public static boolean validSudoku(int[][] mat){
        for (int r = 0; r < 9; r++){
            for (int c = 0; c < 9; c++){
                int cell = mat[r][c]; 
                if (cell==0) return false;

                // checking all row r and column c
                for (int i = 0; i < 9; i++){ 
                    if ((i!=c) && mat[r][i]==cell) return false;
                    if ((i!=r) && mat[i][c]==cell) return false; 
                }

                // checking submat
                int[] which = find_small_square(r, c); 
                int xstart = which[0]; 
                int ystart = which[1]; 
                for (int i = xstart; i < xstart+3; i++){
                    for (int j = ystart; j < ystart+3; j++){
                        if ((i!= r && j!=c) && (mat[i][j] == cell))
                            return false; 
                    }
                }
            }
        }
        return true; 
    }

    public static boolean canFill(int[][] mat, int r, int c, int num){
        for (int i = 0; i < 9; i++){
            if ((i!=c) && (mat[r][i]==num)) return false; 
            if ((i!=r) && (mat[i][c]==num)) return false; 
        }

        // checking submat
        int[] which = find_small_square(r, c); 
        int xstart = which[0]; 
        int ystart = which[1]; 
        for (int i = xstart; i < xstart+3; i++){
            for (int j = ystart; j < ystart+3; j++){
                if ((i!= r && j!=c) && (mat[i][j] == num))
                    return false; 
            }
        }
        return true; 
    }
    
    public static boolean solver(int[][] mat){
        if (validSudoku(mat)){
            // printMatrix(mat);
            return true; 
        }

        for (int r = 0; r < 9; r++){
            for (int c = 0; c < 9; c++){
                if (mat[r][c]==0){
                    int[] ls = find_possible_values(mat, r, c);
                    int d = ls.length; 
                    if (d==0) return false; 

                    for (int i = 0; i < d; i++){
                        int num = ls[i]; 
                        if (canFill(mat, r, c, num)){
                            mat[r][c] = num; 
                            if (solver(mat)) return true; 
                            mat[r][c] = 0; // reset for backtrack
                        }
                    }
                    return false; // backtrack 
                }
            }
        }
        return false; // new return
    }

    public static void solve(int[][] mat){
        solver(mat);
    }

    // public static void main(String[] args) { 
    //     int[][] matrix_1 = {{0, 5, 0, 0, 0, 2, 0, 0, 6},
    //                         {0, 8, 0, 0, 0, 6, 7, 0, 3},
    //                         {0, 0, 0, 7, 4, 0, 0, 0, 8},
    //                         {6, 7, 0, 9, 8, 0, 0, 0, 0},
    //                         {0, 3, 1, 0, 5, 0, 6, 0, 9},
    //                         {0, 0, 0, 0, 0, 3, 8, 2, 0},
    //                         {0, 0, 0, 0, 0, 0, 1, 8, 0},
    //                         {0, 0, 0, 3, 0, 0, 0, 0, 2},
    //                         {9, 2, 0, 5, 0, 0, 0, 7, 0}};
        
    //     Sudoku_hw4.solve(matrix_1); // while using solve(), the correct matrix will be printed
    //     System.out.println("after solving: ");
    //     Sudoku_hw4.printMatrix(matrix_1); // this does not print the filled sudoku as expected, but only fill the original incomplete sudoku   
    // }
}