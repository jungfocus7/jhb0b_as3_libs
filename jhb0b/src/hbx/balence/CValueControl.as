package hbx.balence
{
	import flash.display.DisplayObject;
	import flash.events.Event;

	import hbx.core.CDisplayObjectWrapper;
	import hbx.core.CEventCore;


	public class CValueControl extends CDisplayObjectWrapper
	{
		public static const ET_END:String = MControlProxy.ET_END;
		public static const ET_UPDATE:String = MControlProxy.ET_UPDATE;


		public function CValueControl(tdo:DisplayObject, tprop:String, tminVal:Number = 0, tmaxVal:Number = 1)
		{
			super(tdo);
			_prop = tprop;
			_minValue = tminVal;
			_maxValue = tmaxVal;
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

		private var _minValue:Number = 0;
		public function get_minValue():Number
		{
			return _minValue;
		}

		private var _maxValue:Number = 1;
		public function get_maxValue():Number
		{
			return _maxValue;
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

		private var _valueDirection:int;


		private var _valueGap:Number = .2;
		public function get_valueGap():Number
		{
			return _valueGap;
		}
		public function set_valueGap(tv:Number):void
		{
			_valueGap = tv;
		}


		private function pp_enterFrame(te:Event):void
		{
			var tdist:Number = _endValue - _nowValue;

			if (Math.abs(tdist) < _valueGap)
			{
				this.stop();

				_nowValue = _endValue;
				pp_update();

				this.dispatchEvent(new CEventCore(ET_END));
			}
			else
			{
				_nowValue  = _nowValue + (_valueGap * _valueDirection);
				pp_update();

				this.dispatchEvent(new CEventCore(ET_UPDATE));
			}
		}

		private function pp_update():void
		{
			_nowValue = pp_correctValue(_nowValue);
			_content[_prop] = _nowValue;
		}

		private function pp_correctValue(tv:Number):Number
		{
			var trv:Number = tv;

			if (trv < _minValue)
				trv = _minValue;
			else
			if (trv > _maxValue)
				trv = _maxValue;

			return trv;
		}


		public function to(tev:Number):void
		{
			_endValue = pp_correctValue(tev);
			_nowValue = _content[_prop];
			pp_test('_minValue: ' + _minValue);
			pp_test('_maxValue: ' + _maxValue);

			if (_endValue < _nowValue)
				_valueDirection = -1;
			else
			if (_endValue > _nowValue)
				_valueDirection = 1;
			else
			if (_endValue == _nowValue)
				return;

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
