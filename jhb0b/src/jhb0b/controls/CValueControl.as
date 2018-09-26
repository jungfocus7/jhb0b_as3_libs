package jhb0b.controls
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import jhb0b.core.CDisplayObjectWrapper;
	import jhb0b.events.CBumEvent;
	import jhb0b.tools.MDebugTool;


	public class CValueControl extends CDisplayObjectWrapper
	{
		override public function dispose():void
		{
			if (_owner == null) return;
			this.stop();
			_prop = null;
			super.dispose();
		}

		//
		//
		////////////////////////////////////////////////////////////////////////////////////////////////////
		public static const ET_END:String = MControlProxy.ET_END;
		public static const ET_UPDATE:String = MControlProxy.ET_UPDATE;

		//::
		public function CValueControl(tdo:DisplayObject, prop:String,
										minValue:Number = 0, maxValue:Number = 1)
		{
			super(tdo);
			_prop = prop;
			_minValue = minValue;
			_maxValue = maxValue;
		}

		//-
		private var _prop:String = null;
		public function get_prop():String
		{
			return _prop;
		}

		//-
		private var _minValue:Number = 0;
		public function get_minValue():Number
		{
			return _minValue;
		}

		//-
		private var _maxValue:Number = 1;
		public function get_maxValue():Number
		{
			return _maxValue;
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
		private var _valueDirection:int;

		// -
		private var _valueGap:Number = .2;
		public function get_valueGap():Number
		{
			return _valueGap;
		}
		public function set_valueGap(v:Number):void
		{
			_valueGap = v;
		}


		// ::
		private function p_enterFrame(event:Event):void
		{
			var t_dist:Number = _endValue - _nowValue;

			if (Math.abs(t_dist) < _valueGap)
			{
				this.stop();

				_nowValue = _endValue;
				p_update();

				this.dispatchEvent(new CBumEvent(ET_END));
			}
			else
			{
				_nowValue  = _nowValue + (_valueGap * _valueDirection);
				p_update();

				this.dispatchEvent(new CBumEvent(ET_UPDATE));
			}
		}

		//::
		private function p_update():void
		{
			_nowValue = p_correctValue(_nowValue);
			_owner[_prop] = _nowValue;
		}

		//::
		private function p_correctValue(v:Number):Number
		{
			var t_rv:Number = v;

			if (t_rv < _minValue)
				t_rv = _minValue;
			else
			if (t_rv > _maxValue)
				t_rv = _maxValue;

			return t_rv;
		}

		//::
		public function to(endValue:Number):void
		{
			_endValue = p_correctValue(endValue);
			_nowValue = _owner[_prop];
			p_test('_minValue: ' + _minValue);
			p_test('_maxValue: ' + _maxValue);

			if (_endValue < _nowValue)
				_valueDirection = -1;
			else
			if (_endValue > _nowValue)
				_valueDirection = 1;
			else
			if (_endValue == _nowValue)
				return;

			_owner.addEventListener(Event.ENTER_FRAME, p_enterFrame);
		}

		//::
		public function stop():void
		{
			_owner.removeEventListener(Event.ENTER_FRAME, p_enterFrame);
		}

		//::
		public function is_end():Boolean
		{
			if (_nowValue == _endValue)
				return true;
			else
				return false;
		}

		//}}}
		////////////////////////////////////////////////////////////////////////////////////////////////////

	}

}
