/**
	@Name: ValueControl
	@Author: HobisJung(jhb0b@naver.com)
	@Date: 2016-01-20
	@Comment:
	{
	}
*/
package hb.controls
{
	import flash.events.Event;
	import hb.core.ICallBack;
	import hb.core.IDisposable;

	//
	public class ValueControl implements ICallBack, IDisposable
	{
		////////////////////////////////////////////////////////////////////////////////////////////////////
		//{{{ Implements
		////////////////////////////////////////////////////////////////////////////////////////////////////
		private var _callBack:Function = null;
		public function dispatch_callBack(eObj:Object):void
		{
			if (_callBack == null) return;
			_callBack(eObj);
		}
		public function set_callBack(f:Function):void
		{
			_callBack = f;
		}		
		public function dispose():void
		{
			if (this._target == null) return;
			this.stop();
			this._callBack = null;
			this._prop = null;
			this._target = null;
		}
		//}}}
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		//{{{ 구현부
		////////////////////////////////////////////////////////////////////////////////////////////////////
		public static const CT_END:String = ControlsProxy.CT_END;
		public static const CT_UPDATE:String = ControlsProxy.CT_UPDATE;
		
		// ::
		public function ValueControl(target:Object, prop:String,
										minValue:Number = 0, maxValue:Number = 1)
		{
			this._target = target;
			this._prop = prop;
			this._minValue = minValue;
			this._maxValue = maxValue;
		}
		
		// -
		private var _target:Object = null;
		public function get_target():Object
		{
			return this._target;
		}
		
		// -
		private var _prop:String = null;
		public function get_prop():String
		{
			return this._prop;
		}

		// -
		private var _minValue:Number = 0;
		public function get_minValue():Number
		{
			return this._minValue;
		}
		
		// -
		private var _maxValue:Number = 1;
		public function get_maxValue():Number
		{
			return this._maxValue;
		}

		// -
		private var _endValue:Number;
		public function get_endValue():Number
		{
			return this._endValue;
		}
		
		// -
		private var _nowValue:Number;
		public function get_nowValue():Number
		{
			return this._nowValue;
		}
		
		// -
		private var _valueDirection:int;
		
		// -
		private var _valueGap:Number = .2;
		public function get_valueGap():Number
		{
			return this._valueGap;
		}
		public function set_valueGap(v:Number):void
		{
			this._valueGap = v;
		}
		
		
		// ::
		private function p_enterFrame(event:Event):void
		{
			var t_dist:Number = this._endValue - this._nowValue;

			if (Math.abs(t_dist) < this._valueGap)
			{
				this.stop();

				this._nowValue = this._endValue;
				this.p_update();

				// CallBack End
				dispatch_callBack({type: CT_END});
			}
			else
			{
				this._nowValue  = this._nowValue + (this._valueGap * this._valueDirection);
				this.p_update();

				// CallBack Update
				dispatch_callBack({type: CT_UPDATE});
			}

			//trace('p_enterFrame');
		}
		
		// ::
		private function p_update():void
		{
			this._nowValue = this.p_correctValue(this._nowValue);
			this._target[this._prop] = this._nowValue;
		}
		
		// ::
		private function p_correctValue(v:Number):Number
		{
			var t_rv:Number = v;

			if (t_rv < this._minValue)
				t_rv = this._minValue;
			else
			if (t_rv > this._maxValue)
				t_rv = this._maxValue;

			return t_rv;
		}
		
		// ::
		public function to(endValue:Number):void
		{
			this._endValue = this.p_correctValue(endValue);
			this._nowValue = this._target[this._prop];
			//trace('_minValue: ' + _minValue);
			//trace('_maxValue: ' + _maxValue);

			if (this._endValue < this._nowValue)
				this._valueDirection = -1;
			else if (this._endValue > this._nowValue)
				this._valueDirection = 1;
			else if (this._endValue == this._nowValue)
				return;

			ControlsProxy.useSprite.addEventListener(Event.ENTER_FRAME, this.p_enterFrame);
		}
		
		// ::
		public function stop():void
		{
			ControlsProxy.useSprite.removeEventListener(Event.ENTER_FRAME, this.p_enterFrame);
		}
		
		// ::
		public function is_end():Boolean
		{
			if (_nowValue == _endValue) {
				return true;
			}
			else {
				return false;
			}
		}
		
		//}}}
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
	}

}
