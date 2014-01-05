package com.theimpossibleastronaut.humboldtjs.stl.model
{
	import com.humboldtjs.system.Logger;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	/**
	 * A caching mechanism for all types of objects.
	 * Register your own ObjectStore on your facade to use it.
	 * 
	 * @example 
	 * facade.registerProxy(new ObjectStoreProxy(ObjectStoreNotes.MY_OBJECT_STORE_PROXY_NAME));
	 * var myObjectStore:ObjectStoreProxy = facade.retrieveProxy(ObjectStoreNotes.MY_OBJECT_STORE_PROXY_NAME) as ObjectStoreProxy;
	 */
	
	public class ObjectStoreProxy extends Proxy
	{
		public function ObjectStoreProxy(aProxyName:String)
		{
			super(aProxyName, new Array());
		}
		
		/**
		 * Store a key in the named array, and optionally throw an error if the key already exists.
		 * Default behaviour is to overwrite preexisting keys.
		 * 
		 * @param aKey String The object identifier
		 * @param aValue Object The value to be stored
		 * @param aOverwriteExistingKey if set to false throw an error on preexisting keys
		 */
		public function store(aKey:String, aValue:Object, aOverwriteExistingKey:Boolean = true):void
		{
			if (!aOverwriteExistingKey && contains(aKey))
			{
				Logger.error("Pre-existing key '" + aKey + "' in proxy '" + getProxyName() + "' can not be overwritten.");
				return;
			}
			
			data[aKey] = aValue;
		}
		
		/**
		 * Retrieve an object from the named array, return null if non existent.
		 * 
		 * @param aKey String The object identifier
		 */
		public function retrieve(aKey:String):Object
		{
			if (contains(aKey))
				return data[aKey];
			
			return null;
		}
		
		/**
		 * Removes an element by its object identifier.
		 * 
		 * @param aKey String The object identifier
		 */
		public function remove(aKey:String):void
		{
			if (contains(aKey))
				delete data[aKey];
		}
		
		/**
		 * Checks if an object with identifier aKey has been registered in the ObjectStore.
		 * 
		 * @param aKey String The object identifier
		 */
		public function contains(aKey:String):Boolean
		{
			return (data[aKey] != null);
		}
	}
}