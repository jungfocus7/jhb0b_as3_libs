package jhb0b.core
{
	import flash.display.DisplayObject;


	public class CDisplayObjectWrapper extends CEventCore
	{
		public function CDisplayObjectWrapper(tdo:DisplayObject)
		{
			_owner = tdo;
		}

		protected var _owner:DisplayObject;
		public function get_owner():DisplayObject
		{
			return _owner;
		}

		override public function dispose():void
		{
			_owner = null;
		}
	}

}