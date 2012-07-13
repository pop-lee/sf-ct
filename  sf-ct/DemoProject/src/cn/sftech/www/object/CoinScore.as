package cn.sftech.www.object
{
	import cn.sftech.www.model.Information;
	import cn.sftech.www.util.BaseUI;
	
	import flash.display.MovieClip;
	
	public class CoinScore extends MovieClip
	{
		private var _scoreCount : int;
		
		public function CoinScore()
		{
			super();
			init();
		}
		
		private var scoreNumSymbol : ScoreNumberSymbol;
		
		private function init():void
		{
			_scoreCount =0;
			scoreNumSymbol = new ScoreNumberSymbol();
			scoreNumSymbol.y = Information.coinScoreSymbol_y;
			addChild(scoreNumSymbol);
		}
		
		
		public function get score():int
		{
			return _scoreCount;
		}
		public function set score(value:int):void
		{
			_scoreCount = value;
			var pictureLength:int = _scoreCount.toString().length-1;
			scoreNumSymbol.x = Information.coinScoreSymbol_x-11*pictureLength;
			BaseUI.showInfo(scoreNumSymbol, _scoreCount.toString(), "scoreNum", 4);
		}
	}
}