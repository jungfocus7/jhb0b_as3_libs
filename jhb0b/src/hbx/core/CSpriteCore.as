package hbx.core
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;


	public class CSpriteCore extends Sprite implements IContainerObserver, IEnabled, IDisposable
	{
		public function CSpriteCore()
		{
			if (this.stage == null)
				this.addEventListener(Event.ADDED_TO_STAGE, ppInitOnce);
			else
				ppInitOnce(null);
		}

		protected function ppInitOnce(evt:Event):void
		{
			_container = this;
			_stage = _container.stage;
		}

		protected static function pp_test(msg:String):void
		{
			trace('[#hb] ' + msg);
		}


		protected var _container:DisplayObjectContainer;
		public function get_container():DisplayObjectContainer
		{
			return _container;
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
			if (_container == null) return;
			_container = null;
			_stage = null;
		}

	}

}