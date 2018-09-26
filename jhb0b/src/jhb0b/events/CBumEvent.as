package jhb0b.events
{
	import flash.events.Event;

	public class CBumEvent extends Event
	{
		public function CBumEvent(type:String, dataObj:Object = null,
								bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			_dataObj = dataObj;
		}

		private var _dataObj:Object;
		public function get_dataObj():Object
		{
			return _dataObj;
		}
	}
}