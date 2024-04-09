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


public class myQueue{

    public static void main(String[] args) {
        
    }
}