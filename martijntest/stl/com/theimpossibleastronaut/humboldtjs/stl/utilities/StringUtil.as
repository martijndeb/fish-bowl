package com.theimpossibleastronaut.humboldtjs.stl.utilities
{
	/**
	 * String utility class, performs some non standard available string operations.
	 */
	public class StringUtil
	{
		/**
		 * Returns true if a string starts with a pattern.
		 * 
		 * @param aString String Full length string, the haystack if you will.
		 * @param aPattern String The search string, the needle if you will.
		 * @param aCaseInsensitive Boolean If set to true, ignore casing.
		 */
		public static function startsWith(aString:String, aPattern:String, aCaseInsensitive:Boolean = false):Boolean
		{
			return aCaseInsensitive
					? (aString.toLowerCase().lastIndexOf(aPattern.toLowerCase(), 0) === 0)
					: (aString.lastIndexOf(aPattern, 0) === 0);
		}
		
		/**
		 * Returns true if a string ends with a pattern.
		 * 
		 * @param aString String Full length string, the haystack if you will.
		 * @param aPattern String The search string, the needle if you will.
		 * @param aCaseInsensitive Boolean If set to true, ignore casing.
		 */
		public static function endsWith(aString:String, aPattern:String, aCaseInsensitive:Boolean = false):Boolean
		{
			return aCaseInsensitive
					? aString.toLowerCase().indexOf(aPattern.toLowerCase(), aString.length - aPattern.length) !== -1
					: aString.indexOf(aPattern, aString.length - aPattern.length) !== -1;
		}
		
		/**
		 * Trim the left hand and the right hand side of the given string.
		 * 
		 * @param aString String A string with (optional) whitespace wrapped around itself. 
		 */
		public static function trim(aString:String):String
		{
			return trimLeft(trimRight(aString));
		}
		
		/**
		 * Trim a string only on the left side.
		 * 
		 * @param aString A String with (optional) whitespace on the left.
		 */
		public static function trimLeft(aString:String):String
		{
			return aString.replace(/^\s+/,"");
		}
		
		/**
		 * Trim a string only on the right side.
		 * 
		 * @param aString A String with (optional) whitespace on the right.
		 */
		public static function trimRight(aString:String):String
		{
			return aString.replace(/\s+$/,"");
		}
	}
}