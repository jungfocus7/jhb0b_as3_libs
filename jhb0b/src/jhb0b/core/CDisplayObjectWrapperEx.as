package jhb0b.core
{
	import flash.display.DisplayObject;
	import flash.display.Stage;


	public class CDisplayObjectWrapperEx extends CDisplayObjectWrapper implements IEnabled, INamer
	{
		public function CDisplayObjectWrapperEx(tdo:DisplayObject)
		{
			super(tdo);
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

		protected var _name:String;
		public function get_name():String
		{
			return _name;
		}
		public function set_name(tnm:String):void
		{
			_name = tnm;
		}
	}

}