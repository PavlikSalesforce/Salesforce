public abstract class SyncDTOAbstract implements SycnDTOInterface {

    public virtual String toMap() {
    	return JSON.serialize(this);
    }
    
}