package jhb0b.core
{
	public class CSpriteCoreEx extends CSpriteCore implements IEnabled
	{
		public function CSpriteCoreEx()
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