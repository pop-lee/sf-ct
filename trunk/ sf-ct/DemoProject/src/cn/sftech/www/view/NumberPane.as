package cn.sftech.www.view
{
//	import cn.sftech.www.view.SFContainer;
	
	import flash.display.MovieClip;
	
	import cn.sftech.www.model.Information;
	import cn.sftech.www.util.BaseUI;
	
	public class NumberPane extends MovieClip
	{
		
		private var goldCounterSymbol : GoldCoinNumberSymbol;
		private var heartCounterSymbol : HeartNumberSymbol;
		
		
		private var _goldCount : int;
		private var _heartCount : int;
		
		
		public function NumberPane()
		{
			super();
			init();
		}
		private function init():void
		{
			_goldCount =0;
			_heartCount =0;
			
			goldCounterSymbol = new GoldCoinNumberSymbol();
			goldCounterSymbol.y = Information.goldNumberSymbol_y;
			addChild(goldCounterSymbol);
			heartCounterSymbol = new HeartNumberSymbol();
			heartCounterSymbol.y = Information.heartNumberSymbol_y;
			addChild(heartCounterSymbol);
			
		}

		public function get goldCount():int
		{
			return _goldCount;
		}
		public function set goldCount(value:int):void
		{
			_goldCount = value;
			var pictureLength:int = _goldCount.toString().length-1;
			goldCounterSymbol.x = Information.goldNumberSymbol_x - 8*pictureLength;
			BaseUI.showInfo(goldCounterSymbol, _goldCount.toString(), "goldNum", 4);
		}

		
		public function get heartCount():int
		{
			return _heartCount;
		}
		public function set heartCount(value:int):void
		{
			_heartCount = value;
			var pictureLength:int = _heartCount.toString().length-1;
			heartCounterSymbol.x = Information.heartNumberSymbol_x-10*pictureLength;
			BaseUI.showInfo(heartCounterSymbol, _heartCount.toString(), "heartNum", 2);
		}

	
	}
}