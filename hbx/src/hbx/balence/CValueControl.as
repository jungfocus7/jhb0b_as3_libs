package hbx.balence
{
	import flash.display.DisplayObject;
	import flash.events.Event;

	import hbx.common.MEventTypes;
	import hbx.core.CDisplayObjectWrapper;
	import hbx.core.CEventCore;


	public class CValueControl extends CDisplayObjectWrapper
	{
		public static const ET_END:String = MEventTypes.ET_END;
		public static const ET_UPDATE:String = MEventTypes.ET_UPDATE;


		public function CValueControl(content:DisplayObject, prop:String, minVal:Number = 0, maxVal:Number = 1)
		{
			super(content);
			_prop = prop;
			_minValue = minVal;
			_maxValue = maxVal;
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
		public function set_valueGap(v:Number):void
		{
			_valueGap = v;
		}


		private function pp_enterFrame(evt:Event):void
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

		private function pp_correctValue(v:Number):Number
		{
			var trv:Number = v;

			if (trv < _minValue)
				trv = _minValue;
			else
			if (trv > _maxValue)
				trv = _maxValue;

			return trv;
		}


		public function to(endVal:Number):void
		{
			_endValue = pp_correctValue(endVal);
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
