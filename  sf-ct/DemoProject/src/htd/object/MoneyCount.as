package htd.object
{
	import flash.display.MovieClip;
	import htd.util.BaseUI;
	import htd.model.Information;
	
	public class MoneyCount extends MovieClip
	{
		
		private var _moneyCount : int;
		private var moneyCounterSymbol : MoneyNymberSymbol;
		public function MoneyCount()
		{
			super();
			init();
		}
		
		private function init():void
		{
			_moneyCount =0;
			moneyCounterSymbol = new MoneyNymberSymbol();
			moneyCounterSymbol.y = Information.moneyNumberSymbol_y;
			addChild(moneyCounterSymbol);
		}
		
		
		public function get moneyCount():int
		{
			return _moneyCount;
		}
		public function set moneyCount(value:int):void
		{
			_moneyCount = value;
			var pictureLength:int = _moneyCount.toString().length-1;
			moneyCounterSymbol.x = Information.moneyNumberSymbol_x-11*pictureLength;
			BaseUI.showInfo(moneyCounterSymbol, _moneyCount.toString(), "moneyNum", 3);
		}
		
		
	}
}