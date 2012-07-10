package htd.object
{
	import flash.display.MovieClip;
	
	import htd.model.Information;
	import htd.util.BaseUI;
	
	public class DollarNumber extends MovieClip
	{
		private var firstbody:MovieClip;
		private var secondbody:MovieClip;
		private var textWidth:int;
		private var realValu:int ;
		private var textLength:int;
		private const textPerWidth:int = 9;;
		private const bagTextPerWidth:int = 12;
		private const bagTextWidth:int = 36;
		private const dollarOffsetX:int =18;
		private const dollarOffsetY:int =54;
		
		private const TalkTextPerWidth:int = 10;
		private const TalkTextWidth:int = 32;
		
		public function DollarNumber()
		{
			//firstbody = new MovieClip();
			//this.addChild(body);
			super();
		}
		
		public function set valueNum(num:int):void{
			//Information.dollarPanWidth
			realValu = num;
			textLength = num.toString(10).length;
			var chars : String = num.toString();
			if(textLength == 2)
			{
				firstbody=new NumberinPlate();
				firstbody.gotoAndStop(int(chars.substr(0,1)));
				firstbody.x=(Information.dollarPanWidth - textPerWidth*2)/2;
				secondbody=new NumberinPlate();
				secondbody.gotoAndStop(int(chars.substr(1,1)));
				secondbody.x=firstbody.x + textPerWidth;
				addChild(firstbody);
				addChild(secondbody);
				
			}
			else
			{
				
				firstbody=new NumberinPlate();
				firstbody.gotoAndStop(int(chars.substr(0,1)));
				firstbody.x=(Information.dollarPanWidth - textPerWidth)/2;
				addChild(firstbody);
			}
				
			
		}
		
		public function set dollarInBag(num:int):void{
			realValu = num;
			textLength = num.toString(10).length;
			var chars : String = num.toString();
			if(textLength == 2)
			{
				firstbody=new Numberinbag();
				firstbody.gotoAndStop(int(chars.substr(0,1)));
				firstbody.x=(bagTextWidth - bagTextPerWidth*2)/2+dollarOffsetX;
				firstbody.y= dollarOffsetY;
				
				var secondNum:int =int(chars.substr(1,1));
				if(secondNum == 0)
					secondNum = 10
				secondbody=new Numberintalk();
				secondbody.gotoAndStop(secondNum);
				
				
				//secondbody=new Numberintalk();
				//secondbody.gotoAndStop(int(chars.substr(1,1)));
				secondbody.x=firstbody.x + bagTextPerWidth;
				secondbody.y= dollarOffsetY;
				
				addChild(firstbody);
				addChild(secondbody);
				
			}
			else
			{
				
				firstbody=new Numberinbag();
				firstbody.gotoAndStop(int(chars.substr(0,1)));
				firstbody.x=(bagTextWidth - bagTextPerWidth)/2+dollarOffsetX;
				firstbody.y= dollarOffsetY;
				addChild(firstbody);
			}
			
		}
	
		
		
		public function set dollarInTalk(num:int):void{
			realValu = num;
			textLength = num.toString(10).length;
			var chars : String = num.toString();
			if(textLength == 2)
			{
				firstbody=new Numberintalk();
				firstbody.gotoAndStop(int(chars.substr(0,1)));
				firstbody.x=(TalkTextWidth - TalkTextPerWidth*2)/2;
				//firstbody.y= dollarOffsetY;
				var secondNum:int =int(chars.substr(1,1));
				if(secondNum == 0)
					secondNum = 10
				secondbody=new Numberintalk();
				secondbody.gotoAndStop(secondNum);
				secondbody.x=firstbody.x + TalkTextPerWidth;
				//secondbody.y= dollarOffsetY;
				
				addChild(firstbody);
				addChild(secondbody);
				
			}
			else
			{
				
				firstbody=new Numberintalk();
				firstbody.gotoAndStop(int(chars.substr(0,1)));
				firstbody.x=(TalkTextWidth - TalkTextPerWidth)/2+dollarOffsetX;
				//firstbody.y= dollarOffsetY;
				addChild(firstbody);
			}
			
		}
		
	}
}