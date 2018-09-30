package jhb0b.core
{
	public class CObjectCoreEx extends CObjectCore implements IEnabled
	{
		public function CObjectCoreEx()
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