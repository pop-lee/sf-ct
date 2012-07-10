package htd.object
{
	import flash.display.MovieClip;

	public class TalkFood extends MovieClip
	{
		private var body : MovieClip;
		private var _type:int;
		
		
		
		public function TalkFood()
		{
		}
		
		/* In talk Pane food type */
		
		public function set type(value:int):void
		{
			_type=value;
			if(this.body)
				this.removeChild(body);
			switch(_type)
			{
				case 0:{
					body= new Riceintalk();					
				}
					break;
				case 1:{
					body= new Coleintalk();					
				}
					break;
				case 2:{
					body= new Celeryintalk();		
					
				}
					break;
				case 3:{
					body= new Potatointalk();					
				}
					break;
				case 4:{
					
					body= new Porkintalk();					
				}
					break;
				case 5:{
					
					body= new Shrimpintalk();					
				}
					break;
				
			}
			//body.width = Information.serveFoodWidth;
			//body.height= Information.serveFoodHeight;
			body.gotoAndStop(1);
			addChild(body);
		}
		
		
		
	}
}