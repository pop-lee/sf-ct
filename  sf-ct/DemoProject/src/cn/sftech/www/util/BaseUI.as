package cn.sftech.www.util
{
	import flash.display.MovieClip;
	
	public class BaseUI
	{
		private static var roomRow:MovieClip;
		private static var roomInfoSelect:MovieClip;
		
		public function BaseUI()
		{
			
		}
		
		/**
		 * @param Mc : Parent MovieClip Object		
		 * 
		 */		
		public static function showInfo(Mc:MovieClip, val:String, str:String, Maxval:int):void
		{
			var tempP:Array = new Array();
			for (var i:int = 0; i < Maxval; i++)
			{
				tempP.push(Mc[str + i])
			}
			var tempnum:Array = MyMath.NumtoArray(val);
			var len:int = tempnum.length;			
			
			for (i = 0; i < Maxval; i++)
			{
				if (i < len)
				{
					tempP[i].visible = true;
					tempP[i].gotoAndStop(tempnum[i] + 1);
				}
				else
				{
					tempP[i].visible = false;
				}
			}
		}
		
			
		public static function showAlpha(Mc:MovieClip, str:String, Maxval:int):void
		{
			var tempP:Array = new Array();
			for (var i:int = 0; i < Maxval; i++)
			{
				tempP.push(Mc[str + i])
			}
			
			for (i = 0; i < Maxval; i++)
			{
				tempP[i].visible = false;
			}
		}
		
		
	}
}