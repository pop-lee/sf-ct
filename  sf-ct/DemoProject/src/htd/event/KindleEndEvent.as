package htd.event
{
	import flash.events.Event;
	
	public class KindleEndEvent extends Event
	{
		public static const KINDLE_END_EVENT : String = "kindleEndEvent";
		
		public function KindleEndEvent()
		{
			super(KINDLE_END_EVENT);
		}
	}
}