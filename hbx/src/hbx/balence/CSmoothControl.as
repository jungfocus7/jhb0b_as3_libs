package hbx.balence
{
	import flash.display.DisplayObject;
	import flash.events.Event;

	import hbx.common.MEventTypes;
	import hbx.core.CDisplayObjectWrapper;
	import hbx.core.CEventCore;


	public class CSmoothControl extends CDisplayObjectWrapper
	{
		public static const ET_END:String = MEventTypes.ET_END;
		public static const ET_UPDATE:String = MEventTypes.ET_UPDATE;


		public function CSmoothControl(content:DisplayObject, prop:String)
		{
			super(content);
			_prop = prop;
		}

		public override function dispose():void
		{
			if (_content == null) return;
			this.stop();
			_prop = null;
			super.dispose();
		}


		private var _prop:String;
		public function get_prop():String
		{
			return _prop;
		}

		private var _endValue:Number;
		public function get_endValue():Number
		{
			return _endValue;
		}

		private var _nowValue:Number;
		public function get_nowValue():Number
		{
			return _nowValue;
		}

		private var _speed:Number = .6;
		public function get_speed():Number
		{
			return _speed;
		}
		public function set_speed(tv:Number):void
		{
			_speed = tv;
		}


		private function pp_enterFrame(te:Event):void
		{
			var dist:Number = _endValue - _nowValue;
			if (Math.abs(dist) < 1)
			{
				this.stop();
				_nowValue = _endValue;
				pp_update();

				this.dispatchEvent(new CEventCore(ET_END));
			}
			else
			{
				_nowValue = _nowValue + (dist * _speed);
				pp_update();

				this.dispatchEvent(new CEventCore(ET_UPDATE));
			}
		}

		private function pp_update():void
		{
			_content[_prop] = _nowValue;
		}


		public function to(tev:Number):void
		{
			_endValue = tev;
			_nowValue = _content[_prop];

			_content.addEventListener(Event.ENTER_FRAME, pp_enterFrame);
		}

		public function stop():void
		{
			_content.removeEventListener(Event.ENTER_FRAME, pp_enterFrame);
		}

		public function is_end():Boolean
		{
			if (_nowValue == _endValue)
				return true;
			else
				return false;
		}

	}

}
