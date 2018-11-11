package hbx.core
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.EventDispatcher;


	public class CDisplayObjectWrapper extends EventDispatcher implements IContentObserver, IEnabled, IDisposable
	{
		public function CDisplayObjectWrapper(content:DisplayObject)
		{
			_content = content;
			_stage = _content.stage;
		}

		protected static function p_test(msg:String):void
		{
			trace('[#hb] ' + msg);
		}

        protected var _content:DisplayObject;
		public function get_content():DisplayObject
		{
			return _content;
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



		public function dispose():void
		{
			if (_content == null) return;
			_content = null;
			_stage = null;
		}

	}

}