package backtrack;
public class NQueens {

    public static void printNQueens(int n, int curr_col, int[] pos){
        if (curr_col == n){
            for (int i = 0; i < n; i++)
                System.out.print(pos[i] + " ");
            System.out.println();
        }
        else{
            for (int row = 0; row < n; row++){
                boolean isSafe = true; 
                for (int col = 0; col < curr_col; col++){
                    boolean sameRow = (pos[col] == row); 
                    boolean sameDiagLeft = ((pos[col]-col)==(row-curr_col)); // one down along with one left, +1 to both r and c, so difference is the same 
                    boolean sameDiagRight = ((pos[col]+col)==(row+curr_col)); // one up along with one right, -1 to r and +1 to c, so sum is the same 
                    if (sameRow || sameDiagLeft || sameDiagRight){
                        isSafe = false; 
                        break;
                    }
                }
                
                if (isSafe){
                    pos[curr_col] = row; 
                    printNQueens(n, curr_col+1, pos);
                }
            }
        }

    }
    public static void main(String[] args){
        int n = 8;
        int[] pos = new int[n];
        printNQueens(n, 0, pos);
    }    
    
}
