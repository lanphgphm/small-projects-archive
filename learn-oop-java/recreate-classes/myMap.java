interface Map<K, V>{
    boolean isEmpty(); 
    void clear(); 
    int size(); 
    void put(K key, V val); 
    boolean containsKey(K key); 
    V get(K key); 
    void remove(K key); 
    K[] keySet(); 
}

class ArrayMap<K, V> implements Map<K, V> {
    private K[] _keys; 
    private V[] _vals; 
    private int _size; 

    // constructor
    @SuppressWarnings("unchecked")
    public ArrayMap(int max_size){
        this._keys = (K[]) new Object[max_size]; 
        this._vals = (V[]) new Object[max_size]; 
        this._size = 0; 
    }

    public boolean isEmpty(){
        return (this._size < 1); 
    }

    public void clear(){
        this._size = 0; // this is enough, overwrite old data
    }

    public int size(){
        return this._size; 
    }

    public void put(K key, V val){
        this._keys[this._size] = key; 
        this._vals[this._size] = val; 
        this._size++; 
    }

    public boolean containsKey(K key){
        for (int i = 0; i < this._size; i++){
            if (this._keys[i].equals(key))
                return true; 
        }
        return false; 
    }

    public V get(K key){
        int index = -1; 
        for (int i = 0; i < this._size; i++){
            if (this._keys[i].equals(key)){
                index = i; 
                break; 
            }
        }
        if (index < 0)
            throw new IllegalAccessError(); 
        return this._vals[index]; 
    }

    public void remove(K key){
        int index = -1; 
        for (int i = 0; i < this._size; i++){
            if (this._keys[i].equals(key)){
                index = i; 
                break; 
            }
        }
        if (index < 0)
            throw new IllegalAccessError(); 
        for (int i = index; i < this._size-1; i++){
            this._keys[i] = this._keys[i+1]; 
            this._size--; 
        }
    } 

    @SuppressWarnings("unchecked")
    public K[] keySet(){
        K[] conciseKeys = (K[]) new Object[this._size]; 
        for (int i = 0; i < this._size; i++){
            conciseKeys[i] = this._keys[i]; 
        }
        return conciseKeys; 
    }
}

public class myMap{

    public static void main(String[] args) {
        
    }
}