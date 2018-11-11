package hbx.balence
{
	import flash.display.DisplayObject;
	import flash.events.Event;

	import hbx.core.CDisplayObjectWrapper;
	import hbx.core.CEventCore;

	//
	public class CSmoothControl extends CDisplayObjectWrapper
	{
		override public function dispose():void
		{
			if (_content == null) return;
			this.stop();
			_prop = null;
			super.dispose();
		}

		//
		//
		////////////////////////////////////////////////////////////////////////////////////////////////////
		public static const ET_END:String = MControlProxy.ET_END;
		public static const ET_UPDATE:String = MControlProxy.ET_UPDATE;

		//
		//::
		public function CSmoothControl(tdo:DisplayObject, prop:String)
		{
			super(tdo);
			_prop = prop;
		}

		//-
		private var _prop:String = null;
		public function get_prop():String
		{
			return _prop;
		}

		//-
		private var _endValue:Number;
		public function get_endValue():Number
		{
			return _endValue;
		}

		//-
		private var _nowValue:Number;
		public function get_nowValue():Number
		{
			return _nowValue;
		}

		//-
		private var _speed:Number = .6;
		public function get_speed():Number
		{
			return _speed;
		}
		public function set_speed(v:Number):void
		{
			_speed = v;
		}

		//::
		private function p_enterFrame(event:Event):void
		{
			var t_dist:Number = _endValue - _nowValue;

			if (Math.abs(t_dist) < 1)
			{
				this.stop();

				_nowValue = _endValue;
				p_update();

				this.dispatchEvent(new CEventCore(ET_END));
			}
			else
			{
				_nowValue = _nowValue + (t_dist * _speed);
				this.p_update();

				this.dispatchEvent(new CEventCore(ET_UPDATE));
			}
		}

		//::
		private function p_update():void
		{
			_content[_prop] = _nowValue;
		}

		//::
		public function to(endValue:Number):void
		{
			_endValue = endValue;
			_nowValue = _content[_prop];

			_content.addEventListener(Event.ENTER_FRAME, p_enterFrame);
		}

		//::
		public function stop():void
		{
			_content.removeEventListener(Event.ENTER_FRAME, p_enterFrame);
		}


		//::
		public function is_end():Boolean
		{
			if (_nowValue == _endValue)
				return true;
			else
				return false;
		}

	}

}
