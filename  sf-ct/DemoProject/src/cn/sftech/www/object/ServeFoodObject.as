package cn.sftech.www.object
{
	import flash.display.MovieClip;
	
	import cn.sftech.www.model.Information;
	
	public class ServeFoodObject extends MovieClip
	{
		private var body:MovieClip ;
		private var _type:int;
		
		
		public function ServeFoodObject()
		{
			super();
		}
		
		
		public function get type():int{
			return this._type;
		}
		
		
		/*
		 * Food In left Food pane
		*/
		
		public function set type(value:int):void
		{
			_type=value;
//			if(this.body)
//				this.removeChild(body);
//			switch(value)
//			{
//				case 0:{
//					body= new RiceinPlate();					
//				}
//					break;
//				case 1:{
//					body= new ColeinPlate();					
//				}
//					break;
//				case 2:{
//					body= new CeleryinPlate();		
//					
//				}
//					break;
//				case 3:{
//					
//					body= new PotatoinPlate();
//					
//					
//									
//				}
//					break;
//				case 4:{
//					body= new PorkinPlate();	
//									
//				}
//					break;
//				case 5:{
//					
//					body= new ShrimpinPlate();					
//				}
//					break;
//				
//			}
//			body.width = Information.serveFoodWidth;
//			body.height= Information.serveFoodHeight;
//			body.gotoAndStop(1);
//			addChild(body);
		}
		
		public function set background(mc : Class) : void
		{
			if(this.body)
				this.removeChild(body);
			
			body = new mc();
			body.width = Information.serveFoodWidth;
			body.height= Information.serveFoodHeight;
			body.gotoAndStop(1);
			
			addChild(body);
		}
	}
}