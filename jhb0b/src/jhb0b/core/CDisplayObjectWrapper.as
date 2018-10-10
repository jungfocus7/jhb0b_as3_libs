package jhb0b.core
{
	import flash.display.DisplayObject;
	import flash.display.Stage;


	public class CDisplayObjectWrapper extends CEventCore
	{
		public function CDisplayObjectWrapper(tdo:DisplayObject)
		{
			_owner = tdo;
			_stage = _owner.stage;
		}

		protected var _owner:DisplayObject;
		public function get_owner():DisplayObject
		{
			return _owner;
		}

		protected var _stage:Stage;
		public function get_stage():Stage
		{
			return _stage;
		}


		override public function dispose():void
		{
			if (_owner == null) return;
			_owner = null;
			_stage = null;
		}
	}

}