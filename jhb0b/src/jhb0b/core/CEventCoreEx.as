package jhb0b.core
{
	public class CEventCoreEx extends CEventCore implements IEnabled
	{
		public function CEventCoreEx()
		{
		}

		protected var _enabled:Boolean = false;
		public function get_enabled():Boolean
		{
			return _enabled;
		}
		public function set_enabled(b:Boolean):void
		{
			_enabled = b;
		}
	}
}