class tile {
    private boolean merged;
    private int value;
 
    tile(int val) {
        value = val;
    }
 
    int getValue() {
        return value;
    }
 
    void setMerged(boolean m) {
        merged = m;
    }
 
    boolean canMergeWith(tile other) {
        return !merged && other != null && !other.merged && value == other.getValue();
    }
 
    int mergeWith(tile other) {
        if (canMergeWith(other)) {
            value *= 2;
            merged = true;
            return value;
        }
        return -1;
    }
}