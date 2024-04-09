class BinaryTree<T>{
    private T data; 
    private BinaryTree<T> left; 
    private BinaryTree<T> right; 

    public BinaryTree(T data, BinaryTree<T> left, BinaryTree<T> right){
        this.data = data; 
        this.left = left; 
        this.right = right; 
    }

    private void printTree1Recursive(BinaryTree<T> tree, int layer, String prefix){
        if (tree==null){
            return; 
        }
        for (int i = 0; i < layer; i++){
            if (i == layer-1)
                System.out.print("|__");
            else 
                System.out.print("  ");
        }
        System.out.println(tree.data);
        String addOn = prefix.equals("") ? "  " : "| ";
        printTree1Recursive(tree.left, layer+1, prefix+addOn); 
        printTree1Recursive(tree.right, layer+1, prefix+addOn);
    }

    public void printTree1(){
        // TODO: old way 
        printTree1Recursive(this, 0, "");

    }

    public void printTree2(){
        // TODO: fancy tree
        
    }

    // add new element & keep the tree sorted, returns root of new tree
    // delete element in tree, returns root of new tree
    // search data in tree (using binary search)
    // traversing tree: dfs 
    // traversing tree: bfs 
}


public class myBinaryTree {
    
    public static void main(String[] args) {
        // BinaryTree<Character> root = new BinaryTree<Character>('B', null, null); // cost a lot of time

        BinaryTree<Character> l1 = new BinaryTree<Character>('A', null, null);
        BinaryTree<Character> l2 = new BinaryTree<Character>('C', null, null);
        BinaryTree<Character> left = new BinaryTree<Character>('B', l1, l2);

        BinaryTree<Character> l3 = new BinaryTree<Character>('E', null, null);
        BinaryTree<Character> l4 = new BinaryTree<Character>('G', null, null);
        BinaryTree<Character> right = new BinaryTree<Character>('F', l3, l4);

        BinaryTree<Character> root = new BinaryTree<Character>('D', left, right); 

        BinaryTree<Character> l5 = new BinaryTree<Character>('H', null, null);
        BinaryTree<Character> l6 = new BinaryTree<Character>('I', l5, null);

        BinaryTree<Character> l7 = new BinaryTree<Character>('J', null, null);
        BinaryTree<Character> l8 = new BinaryTree<Character>('K', l7, null);

        BinaryTree<Character> newLeft = new BinaryTree<Character>('L', l6, l8);

        BinaryTree<Character> l9 = new BinaryTree<Character>('M', null, null);
        BinaryTree<Character> l10 = new BinaryTree<Character>('N', l9, null);

        BinaryTree<Character> l11 = new BinaryTree<Character>('O', null, null);
        BinaryTree<Character> l12 = new BinaryTree<Character>('P', l11, null);

        BinaryTree<Character> newRight = new BinaryTree<Character>('Q', l10, l12);

        // Attach new nodes to root
        BinaryTree<Character> newRoot = new BinaryTree<Character>('R', newLeft, newRight);

        root.printTree1();
        // newRoot.printTree1();

    }
}

interface Queue<T>{
    boolean isEmpty(); 
    void enqueue(T data); 
    T dequeue(); 
    T peek(); 
}

class ArrayQueue<T> implements Queue<T> {
    private T[] _a; 
    private int _front; 
    private int _back; 
    
    // constructor 
    @SuppressWarnings("unchecked")
    public ArrayQueue(int max_size){
        this._a = (T[]) new Object[max_size]; 
        this._front = 0; 
        this._back = 0;
    }

    public boolean isEmpty(){
        return (this._front == this._back);
    }

    public void enqueue(T data){
        this._a[this._back] = data; 
        this._back++; 
    }

    public T dequeue(){
        if (this.isEmpty())
            throw new IllegalAccessError(); 
        T tmp = this._a[this._front]; 
        this._front++;
        return tmp; 
    }

    public T peek(){
        if (this.isEmpty())
            throw new IllegalAccessError();
        return this._a[this._front]; 
    }

    public int size(){ // novelty
        return (this._back - this._front); 
    }

    public T peekBack(){ // novelty
        if (this.isEmpty())
            throw new IllegalAccessError();
        return this._a[this._back-1];
    }
}


