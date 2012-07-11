package cn.sftech.www.util
{
	
	public class MyMath
	{
		
		public function MyMath() 
		{
			
		}
		
		/**
		 * 
		 * @param num
		 * @return Array
		 */
		public static function NumtoArray(num:String):Array 
		{
			var str:String = String(num);
			var len:int = str.length;
			var i:int = 0;
			var array:Array = new Array;
			for (i; i < len; i++) 
			{
				array.push(int(str.charAt(i)));
			}
			
			return array;
		}
		
		
	}
}