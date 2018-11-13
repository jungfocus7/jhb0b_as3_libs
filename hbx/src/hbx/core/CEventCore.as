package hbx.core
{
	import flash.events.Event;


	public class CEventCore extends Event
	{
		public function CEventCore(
			type:String, obj:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
            super(type, bubbles, cancelable);
            _obj = obj;
		}

		private var _obj:Object;
		public function get_obj():Object
		{
			return _obj;
		}
	}

}