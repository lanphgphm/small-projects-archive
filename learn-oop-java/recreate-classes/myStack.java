interface Stack<T>{
    boolean isEmpty(); 
    void push(T item); 
    T pop(); 
    T peek(); 
}

class ArrayStack<T> implements Stack<T> {
    private T[] _a; 
    private int _top; 
    
    // constructor 
    @SuppressWarnings("unchecked")
    public ArrayStack(int max_size){
        this._a = (T[]) new Object[max_size]; 
        this._top = 0; 
    }

    public boolean isEmpty(){
        return (this._top < 1);
    }

    public void push(T item){
        this._a[this._top] = item; 
        this._top++; 
    }    

    public T pop(){
        if (this.isEmpty())
            throw new IllegalAccessError(); 
        this._top--; 
        return this._a[this._top]; 
    }

    public T peek(){
        if (this.isEmpty())
            throw new IllegalAccessError(); 
        return this._a[this._top-1]; 
    }

}

public class myStack{

    public static void main(String[] args) {
        
    }
}