package cn.sftech.www.object
{
	import cn.sftech.www.model.Information;
	import cn.sftech.www.util.BaseUI;
	
	import flash.display.MovieClip;
	
	public class LevelLetter extends MovieClip
	{
		private var _scoreCount : int;
		
		private var scoreNumSymbol : LevelLetterSymbol;
		
		public function LevelLetter()
		{
			super();
			init();
		}
		
		private function init():void
		{
			_scoreCount =0;
			scoreNumSymbol = new LevelLetterSymbol();
			scoreNumSymbol.x = Information.levelLetterSymbol_x;
			scoreNumSymbol.y = Information.levelLetterSymbol_y;
			addChild(scoreNumSymbol);
		}
		
		
		public function get score():int
		{
			return _scoreCount;
		}
		public function set score(value:int):void
		{
			_scoreCount = value;
			if(value > 800) {
				scoreNumSymbol.gotoAndStop(8);
			} else if(value > 450) {
				scoreNumSymbol.gotoAndStop(7);
			} else if(value > 300) {
				scoreNumSymbol.gotoAndStop(6);
			} else if(value > 240) {
				scoreNumSymbol.gotoAndStop(5);
			} else if(value > 180) {
				scoreNumSymbol.gotoAndStop(4);
			} else if(value > 120) {
				scoreNumSymbol.gotoAndStop(3);
			} else if(value > 60) {
				scoreNumSymbol.gotoAndStop(2);
			} else {
				scoreNumSymbol.gotoAndStop(1);
			}
		}
	}
}