package cn.sftech.www.object
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class FoodObject extends MovieClip
	{
		private var body:MovieClip ;
		private var _type:int;
		private var _price:int;
		
		private var _bg_p_Class : Class;
		private var _bg_t_Class : Class;
		
		public function FoodObject()
		{
			super();
		}
		
		public function get serveFood() : ServeFoodObject
		{
			var serveFood : ServeFoodObject = new ServeFoodObject();
			serveFood.type = this._type;
			serveFood.background =  this._bg_p_Class;
			
			return serveFood;
		}
		
		public function get talkFood() : TalkFood
		{
			var talkFood : TalkFood = new TalkFood();
			talkFood.type = this._type;
			talkFood.background = this._bg_t_Class;
			
			return talkFood;
		}
		
		public function get type():int
		{
			return _type;
		}
		
		public function set type(value:int):void
		{
			_type=value;
//			if(this.body)
//				this.removeChild(body);
//			switch(value)
//			{
//				case 0:{
//					body= new RiceAnimation();
//					_price=1;
//					//this.addChild(body);
//				}
//					break;
//				case 1:{
//					body= new ColeAnimation();
//					_price=2;
//					//this.addChild(body);
//				}
//					break;
//				case 2:{
//					body= new CeleryAnimation();
//					_price=5;
//					//this.addChild(body);
//					
//				}
//					break;
//				case 3:{
//					body= new PotatoAnimation();
//					_price=8;
//					//addChild(body);
//				}
//					break;
//				case 4:{
//					
//					body= new PorkAnimation();
//					_price=11;
//					//addChild(body);
//				}
//					break;
//				case 5:{
//					
//					body= new ShrimpAnimation();
//					_price=15;
//				}
//					break;
//				
//			}
//			body.gotoAndStop(1);
//			
//			addChild(body);
		}
		
		public function set background(mc : Class) : void
		{
			if(this.body)
				this.removeChild(body);
			
			body = new mc();
			body.gotoAndStop(1);
			
			addChild(body);
		}
		
		public function setBGClass(p_class : Class,t_class : Class) : void
		{
			this._bg_p_Class = p_class;
			this._bg_t_Class = t_class;
		}
		
		public function set price(value : int) : void
		{
			this._price = value;
		}
		
		public function get price():int
		{
			return this._price;
		}
		
		public function goToStartState():void{
			if(this.body)
				body.gotoAndStop(1);
		}
		
		public function set state(index:int):void
		{
			body.gotoAndStop(index);
		}
		public function palyAndStopEnd():void
		{
			if(this.body)
				body.gotoAndStop(2);
				//body.addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function enterFrame(evt : Event):void
		{
			if(body.currentFrame == body.totalFrames)
			{
				
				body.removeEventListener(Event.ENTER_FRAME, enterFrame);
							
			}		
			else 
			{
				
				body.nextFrame();
			}
		}
	}
}