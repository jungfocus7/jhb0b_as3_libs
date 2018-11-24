package hbx.core
{
	import flash.events.EventDispatcher;


	public class CEventDispatcherCore extends EventDispatcher implements IEnabled, IDisposable
	{

		public function CEventDispatcherCore()
		{
		}


		protected var _enabled:Boolean = true;
		public function get_enabled():Boolean
		{
			return _enabled;
		}
		public function set_enabled(b:Boolean):void
		{
			_enabled = b;
		}

		public function dispose():void
		{
		}

	}

}