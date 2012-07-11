package cn.sftech.www.event
{

	import flash.events.Event;
	
	public class WaitPersonFinishEvent extends Event
	{
		public static const NOT_WAIT_FINISH : String = "NoWait";
		
		
		public var data : int;
		
		
		public function WaitPersonFinishEvent()
		{
			super(NOT_WAIT_FINISH);
		}
	}
}