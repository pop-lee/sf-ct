package cn.sftech.www.object
{
	import cn.sftech.www.event.KindleEndEvent;
	import cn.sftech.www.event.WaitPersonFinishEvent;
	import cn.sftech.www.model.GamingModel;
	import cn.sftech.www.model.Information;
	import cn.sftech.www.model.ModelLocator;
	import cn.sftech.www.util.MathUtil;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;

	/**
	 * 顾客人物
	 * @author LiYunpeng
	 * 
	 */	
	public class CustomerCharacter extends MovieClip
	{
		private var _model : ModelLocator = ModelLocator.getInstance();
		
		//private var WaitingTimer : Timer;
		private var wiatTimeLine :int;
		private var body:MovieClip;
		private var orderNum :int;
		private var _type:int;
		private var _speakPositionY:int;
		private var _speakPositionX:int;
		private var askFoodNum :int ;
		private var talkPane :MovieClip;
		private  const offsetCustomPosY:int = 5 ;
		private var down:TalkFood;
		private var mony:MovieClip;
		private var dollarNum : MovieClip;
		private var canMoney:int;
		//喜欢的食物在候选菜列表里的索引
		private var niceFoodIndex:int;
		private var _talkWidth :int;
		private var _talkHeight:int;
		private var moveMoneyEffect:Displayneed;
		private var personWidth:int;
		private var isCanBuy : Boolean; 
		private var talkPoint : Point;
		private var isCall :  Boolean;
		private var isMove :  Boolean;
		
		private var arrivedPos: Point;
		
		
//		private var 
		
		public function CustomerCharacter()
		{
			_talkWidth = 0;
			_talkHeight = 0;
			wiatTimeLine =0;
			canMoney =0;
			isCanBuy = false;	
			isCall= false;
			isMove= false;
			arrivedPos = null;
			super();
		}
		
		
		/*
		 * if person state is state for paying  true, else false 
		*/
		public function get canGiveMoney():int
		{
			return canMoney;
		}
		
		public function set IsMoveing(val:Boolean):void
		{
			isMove = val;
		}
		
		
		/*
		* person's Position for pay.
		*/
		public function get arrivedPosition():Point
		{
			return arrivedPos;
		}
		/**
		 * 顾客排队停留的位置
		 * @param val
		 * 
		 */		
		public function set arrivedPosition(val:Point):void
		{
			arrivedPos = val;
		}
		
		
		/*
		 if  person is moving true else false 
		*/
		public function get IsMoveing():Boolean
		{
			return isMove ;
		}
		
		
		public function get CanBuyFood():Boolean
		{
			return isCanBuy;
		}
		
		/*
		set person expression
		*/
		
		public function Happy(value :Boolean):void
		{
			if(isCall)
				return;
			if(this.isMove)
				return;
			isCall =true;			
			isCanBuy =false;
			if(value)
				body.gotoAndStop(2);
			else
				body.gotoAndStop(3);
				
						
		}
		
		
		public function NextPerson():void
		{
			
			this.dispatchEvent(new KindleEndEvent());
		}
		
		
		public function set talkSize(size:Point):void{
			_talkWidth  = Information.talkBoxWidth-size.x;
			_talkHeight = Information.talkBoxHeight-size.y;
		}
		
		/*
	 	 person type man1, man2 or women1 women2 
		*/
		public function set type(value:int):void
		{
			canMoney= 0;
			this._type = value;
			if(this.body)
				this.removeChild(body);
			
			niceFoodIndex = MathUtil.random(0,Information.foodBufferNum);
			canMoney = _model.getFoodPrice(niceFoodIndex);
			
			var second:int =-1;
			var first:int =-1;
			var third:int =-1;
			var numCount:int =0;
			
			while(numCount <3)
			{
				
				if(numCount == 0)
				{
					first = MathUtil.random(0,Information.foodBufferNum);
					if(niceFoodIndex != first)
					{
						canMoney += _model.getFoodPrice(first);
						numCount++;
					}
					
					
				}
				else if(numCount == 1)
				{
					second = MathUtil.random(0,Information.foodBufferNum);
					if((second != niceFoodIndex) && ( second  != first))
					{
						
						canMoney += _model.getFoodPrice(second);
						numCount++;
					}
					
				}
				else if(numCount == 2)
				{
					third = MathUtil.random(0,Information.foodBufferNum);
					if((third !=  second) && ( third != niceFoodIndex) && ( third != first))
					{
						
						canMoney += _model.getFoodPrice(third);
						numCount++;
					}
					
				}
			}
			var  div:int = canMoney/5;	
			canMoney = div*5 + 5;
			
			switch(_type)
			{
				case 0:
				{
					body =new Person1;
					_speakPositionY = 25;
					_speakPositionX = -37;
					if(Information.GameMode == Information.RandomGameMode)
						wiatTimeLine= Information.first_girl_waitingTime;
				}
					break;
				case 1:
				{
					body =new Person2;
					body.y = 3;
					_speakPositionY = 11;
					_speakPositionX = -48;	
					if(Information.GameMode == Information.RandomGameMode)
						wiatTimeLine=Information.first_boy_waitingTime;
				}
					break;
				case 2:
				{
					body =new Person3;
					body.y = 1;
					_speakPositionY = 23;
					_speakPositionX = -37;	
					if(Information.GameMode == Information.RandomGameMode)
						wiatTimeLine= Information.second_girl_waitingTime;
				}
					break;
				case 3:
				{
					body =new Person4;
					body.y = 11;
					_speakPositionY = 12;
					_speakPositionX = -28;
					if(Information.GameMode == Information.RandomGameMode)
						wiatTimeLine= Information.second_boy_waitingTime;
					
				}
					break;
			}
		//	if(Information.GameMode == Information.RandomGameMode)
		//		WaitingTimer.addEventListener(TimerEvent.TIMER, NotWaitePerson);
			personWidth= body.width;
			body.gotoAndStop(1);
			this.addChild(body);
		}
		
		/*
		 * person can't wait more 
		*/
		private function NotWaitePerson(event : TimerEvent):void
		{
			//WaitingTimer.stop();
			var noWaitEvent : WaitPersonFinishEvent = new WaitPersonFinishEvent();
			noWaitEvent.data = this.orderNum;
			this.dispatchEvent(noWaitEvent);
		}
		
		
		/*
		 * return peson like food num 
		*/
		
		public function get happyFood():int
		{
			return _model.gameingFoods[niceFoodIndex].type;
		}
		
		/*
		 *person's waiting time 
		*/
		
		public function get WaitingTime():int{
			return wiatTimeLine;
		}
		
		
		public function removeAll():void
		{
			//if(WaitingTimer)
				//WaitingTimer.stop();
			if(body)
			{
				this.removeChild(body);
			}
			//WaitingTimer =null;
			body= null;
		}
		
		/*
		
		*/
		
		public function set foodNum(num:int):void
		{
			this.foodNum =num;
		}
		
		/*
		 * person's order 
		*/
		public function set orderNums(odernum:int):void
		{
			this.orderNum = odernum;
		}
		
		public function get orderNums():int
		{
			return this.orderNum;
		}
		
		/*
		 *person's start point 
		*/
		public function get firstPos():int{
			return (5-this._speakPositionX - _talkWidth);
		}
		
		/*
		 *   
		*/
		public function get bodyWidth():int
		{
			return (this.personWidth-_speakPositionX-_talkWidth);
		}
		
		/*
		 *person's width 
		*/
		public function get personOfWidth():int
		{
			return this.personWidth;
		}
		
		
		/*
		 * add talk pane 
		*/
		public function addTalk():void{
			if(this.talkPane)
				this.removeChild(talkPane);
			
			talkPane = new TalkPan();
			talkPane.width =talkPane.width*(Information.talkBoxWidth-_talkWidth)/Information.talkBoxWidth;
			talkPane.height = talkPane.height*(Information.talkBoxHeight-_talkHeight)/Information.talkBoxHeight;
			talkPane.x = _speakPositionX + this._talkWidth;
			talkPane.y = (_speakPositionY + this._talkHeight)*80/90 +1;
			
			this.addChild(talkPane);
			
			mony = new MoneyCharacter();
			mony.x = talkPane.x+2*(Information.talkBoxWidth-_talkWidth)/Information.talkBoxWidth;
			mony.y = talkPane.y+20*(Information.talkBoxHeight-_talkHeight)/Information.talkBoxHeight;
			mony.width =mony.width*(Information.talkBoxWidth-_talkWidth)/Information.talkBoxWidth;
			mony.height =mony.height*(Information.talkBoxHeight-_talkHeight)/Information.talkBoxHeight;
			addChild(mony);		
			
			dollarNum =new DollarNumber();
			var wid:int = dollarNum.width;
			dollarNum.x = talkPane.x+15*(Information.talkBoxWidth-_talkWidth)/Information.talkBoxWidth;			
			dollarNum.y = talkPane.y+25*(Information.talkBoxHeight-_talkHeight)/Information.talkBoxHeight;
			dollarNum.dollarInTalk = this.canMoney;
			dollarNum.width =dollarNum.width*(Information.talkBoxWidth-_talkWidth)/Information.talkBoxWidth;
			dollarNum.height =dollarNum.height*(Information.talkBoxHeight-_talkHeight)/Information.talkBoxHeight;
			wid = dollarNum.width;
			addChild(dollarNum);
			
			
			moveMoneyEffect = new  Displayneed();
			moveMoneyEffect.x = talkPane.x+42*(Information.talkBoxWidth-_talkWidth)/Information.talkBoxWidth;
			moveMoneyEffect.y = talkPane.y+25*(Information.talkBoxHeight-_talkHeight)/Information.talkBoxHeight;
			moveMoneyEffect.width =moveMoneyEffect.width*(Information.talkBoxWidth-_talkWidth)/Information.talkBoxWidth;
			moveMoneyEffect.height =moveMoneyEffect.height*(Information.talkBoxHeight-_talkHeight)/Information.talkBoxHeight;
			addChild(moveMoneyEffect);
			
			
			
			down= _model.gameingFoods[niceFoodIndex].talkFood;
//			down.type = _model.gameingFoods[niceFoodIndex].get;
			down.x=talkPane.x+10*(Information.talkBoxWidth-_talkWidth)/Information.talkBoxWidth;
			down.y=talkPane.y+55*(Information.talkBoxHeight-_talkHeight)/Information.talkBoxHeight;			
			down.width =down.width*(Information.talkBoxWidth-_talkWidth)/Information.talkBoxWidth;
			down.height =down.height*(Information.talkBoxHeight-_talkHeight)/Information.talkBoxHeight;
			addChild(down);
			
			isCanBuy = true;
			Information.CanClickMouse = true;
			Information.CustomerCharacterIndex = this.orderNum;
			
			//WaitingTimer.start();
			
		}
		
		/*
		 * talk pane's annimation 
		*/
		public function kindlTalkAnimation():void
		{
			if(Information.isGameOver)
			{
				
				return;
			}	
			if(this.talkPane)
				this.removeChild(talkPane);
			talkPane = new TalkAnimation();
			//talkPane.x = _speakPositionX+35;
			//talkPane.y = body.y+_speakPositionY+45;
			
			
			talkPane.width =talkPane.width*(Information.talkBoxWidth-_talkWidth)/Information.talkBoxWidth;
			talkPane.height = talkPane.height*(Information.talkBoxHeight-_talkHeight)/Information.talkBoxHeight;
			talkPane.x = _speakPositionX + this._talkWidth + 35*(Information.talkBoxWidth-_talkWidth)/Information.talkBoxWidth;
			talkPane.y = (_speakPositionY + this._talkHeight)*80/90+45*(Information.talkBoxHeight-_talkHeight)/Information.talkBoxHeight+1;
			
			
			talkPane.addEventListener(Event.ENTER_FRAME, StartTalk)
			this.addChild(talkPane);	
				
		}
		
		/*
		 * talk animation finish event 
		*/
		private function StartTalk(event :Event):void
		{
			if((Information.isGameOver) || (talkPane == null))
			{				
				return;
			}
				if(talkPane.currentFrame == talkPane.totalFrames)
				{
					
					talkPane.removeEventListener(Event.ENTER_FRAME, StartTalk);
					this.dispatchEvent(new KindleEndEvent());
					
				}		
				else 
				{
					
					talkPane.nextFrame();
				}
			
		}
		
		/*
		 * remove talk pane 
		*/
		public function removeTalk():void{
			if(this.talkPane)
				this.removeChild(talkPane);
			
			
			if(this.mony)
				this.removeChild(mony);
			
			if(this.down)
				this.removeChild(down);
			
			if(this.dollarNum)
				this.removeChild(dollarNum);
			
			if(moveMoneyEffect)
				this.removeChild(moveMoneyEffect);
			
			talkPane = null;
			mony =null;
			down = null;
			dollarNum = null;;
			moveMoneyEffect = null;
			
			
		}
		
		
		public function goTofirstpoint():void{
			
		
			
		}
		
		
		
		
		/*
		 * person go to first place 
		*/
		
		public function gotofirstPlace():void
		{
			var time:int =MathUtil.random(0,5)/5;
			Information.canGofirstPlace = false;
			TweenLite.to(body, 1,
				{
					x:360, y:body.y,
					ease:Linear.easeNone, delay:time, onComplete:finishGotoFirstPlace
				}
			);	
			
		}
		
		
		
		
		public function finishGotoFirstPlace():void{
			TweenLite.killTweensOf(body);
			this.dispatchEvent(new KindleEndEvent());
		}
		
		/*
		* person wait
		*/
		public function waitForSecondPosition():void{
			
			TweenLite.killTweensOf(body);
			if(Information.canGosecondPlace)
			{
				TweenLite.to(body, 1.5,
					{
						x:body.x, y:body.y,
						ease:Linear.easeNone, delay:0.3, onComplete:finishComeSecondPlace
					}
				);	
			}
			
			
			
		}
		
		
		public function finishComeSecondPlace():void
		{
			gotosecondPlace();
		}
		
		
		/*
		* In easy mode
		*/
		
		public function gotosecondPlace():void
		{
			
			//var time:int =MathUtil.random(0,5)/5;
			
			TweenLite.killTweensOf(body);
			
			if(Information.canGosecondPlace)
			{
				TweenLite.to(body, 1.5,
					{
						x:240, y:body.y,
						ease:Linear.easeNone, delay:0.3, onComplete:goThirdPlace
					}
				);	
			}
			else
			{
				TweenLite.to(body, 1,
					{
						x:body.x, y:body.y,
						ease:Linear.easeNone, delay:0.5, onComplete:waitForthirdPosition
					}
				);	
			}	
			
			Information.canGosecondPlace =false;
			Information.canGofirstPlace =true;
			
		}
		
		
		
		public function waitForthirdPosition():void{
			TweenLite.killTweensOf(body);
			if(Information.canGosecondPlace)
			{
				TweenLite.to(body, 1.5,
					{
						x:body.x, y:body.y,
						ease:Linear.easeNone, delay:0.7, onComplete:goThirdPlace
					}
				);	
			}
			
			
			
		}
		
		
		
		public function goThirdPlace():void
		{
			TweenLite.killTweensOf(body);
			Information.canGosecondPlace =true;
			
			
	//		Information.canGothirdPlace =true;
			if(Information.canGothirdPlace)
			{
				TweenLite.to(body, 1.5,
					{
						x:120, y:body.y,
						ease:Linear.easeNone, delay:0.4, onComplete:customTalk
					}
				);	
			}
			else
			{
				TweenLite.to(body, 1,
					{
						x:body.x, y:body.y,
						ease:Linear.easeNone, delay:0.5, onComplete:gotosecondPlace
					}
				);	
			}	
			
			
	
			
		}
		
		/*
		 *  person go out screen 
		*/
		
		public function golastPlace():void
		{
			TweenLite.killTweensOf(body);
			Information.canGosecondPlace =true;
			//		Information.canGothirdPlace =true;
			
			{
				TweenLite.to(body, 1.5,
					{
						x:120, y:body.y,
						ease:Linear.easeNone, delay:0.4, onComplete:customTalk
					}
				);	
			}
			
			
			
			
		}
		
		
		
		private function customTalk():void
		{
			Information.canGothirdPlace =false;
			this.dispatchEvent(new KindleEndEvent());
		}
		
		
		
		
	}
}