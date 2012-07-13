package cn.sftech.www.object
{
	import cn.sftech.www.model.Information;
	import cn.sftech.www.util.BaseUI;
	
	import flash.display.MovieClip;
	
	public class ExperienceScore extends MovieClip
	{
		private var _scoreCount : int;
		
		private var scoreNumSymbol : ScoreNumberSymbol;
		
		public function ExperienceScore()
		{
			super();
			init();
		}
		
		private function init():void
		{
			_scoreCount =0;
			scoreNumSymbol = new ScoreNumberSymbol();
			scoreNumSymbol.y = Information.ExperienceScoreSymbol_y;
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
			scoreNumSymbol.x = Information.ExperienceScoreSymbol_x-11*pictureLength;
			BaseUI.showInfo(scoreNumSymbol, _scoreCount.toString(), "scoreNum", 4);
		}
	}
}