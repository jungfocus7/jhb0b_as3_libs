package jhb0b.core
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;


	public class CContainerBase extends CContainerWrapper implements IStageObserver, IEnabled, INamer
	{
		override public function dispose():void
		{
			if (_cont == null) return;
			_stage = null;
			super.dispose();
		}

		public function CContainerBase(tcont:DisplayObjectContainer)
		{
			super(tcont);
			_stage = _cont.stage;
		}

		protected var _stage:Stage;
		public function get_stage():Stage
		{
			return _stage;
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
