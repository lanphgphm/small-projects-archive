import java.util.Iterator;
import java.util.NoSuchElementException;

interface Set<T>{
    boolean isEmpty(); 
    int size(); 
    boolean contains(T item); 
    void add(T item); 
    void remove(T item); 
}

class ArraySet<T> implements Iterable<T> {
    private T[] _a; 
    private int _size; 

    // constructor
    @SuppressWarnings("unchecked")
    public ArraySet(int max_size){
        this._a = (T[]) new Object[max_size]; 
        this._size = 0; 
    }

    public boolean isEmpty(){
        return (this._size < 1); 
    }

    public int size(){
        return this._size; 
    }

    public boolean contains (T item){
        for (int i = 0; i < this._size; i++){
            if (this._a[i].equals(item)){
                return true;
            }
        }
        return false; 
    }

    public void add(T item){
        if (this.contains(item))
            return; 
        this._a[this._size] = item; 
        this._size++; 
    }

    public void remove (T item){
        int index = -1;
        for (int i = 0; i < this._size; i++){
            if (this._a[i].equals(item))
                index = i;
        }
        if (index == -1)
            throw new IllegalAccessError(); 
        for (int i = index; i < this._size-1; i++){
            this._a[i] = this._a[i+1]; 
            this._size--; 
        }
    }

    private class ArraySetIterator implements Iterator<T> {
        private int currIdx = 0; 

        public boolean hasNext(){
            return (currIdx < _size); 
        }

        public T next(){
            if (!hasNext())
                throw new NoSuchElementException(); 
            T item = _a[currIdx]; 
            currIdx++; 
            return item; 
        }
    }

    public Iterator<T> iterator() {
        return new ArraySetIterator(); 
    }

}

public class mySet{

    public static void main(String[] args) {
        
    }
}