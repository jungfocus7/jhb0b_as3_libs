/**
	@Name: SmoothControl
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
	public class SmoothControl implements ICallBack, IDisposable
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
		
		//
		//
		////////////////////////////////////////////////////////////////////////////////////////////////////
		//{{{ 구현부
		////////////////////////////////////////////////////////////////////////////////////////////////////
		public static const CT_END:String = ControlsProxy.CT_END;
		public static const CT_UPDATE:String = ControlsProxy.CT_UPDATE;
		
		//
		// ::
		public function SmoothControl(target:Object, prop:String)
		{
			this._target = target;
			this._prop = prop;			
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
		private var _speed:Number = .6;
		public function get_speed():Number
		{
			return this._speed;
		}
		public function set_speed(v:Number):void
		{
			this._speed = v;
		}		
		
		// ::
		private function p_enterFrame(event:Event):void
		{
			var t_dist:Number = this._endValue - this._nowValue;

			if (Math.abs(t_dist) < 1)
			{
				this.stop();

				this._nowValue = this._endValue;
				this.p_update();

				// CallBack End
				dispatch_callBack({type: CT_END});
			}
			else
			{
				this._nowValue = this._nowValue + (t_dist * this._speed);
				this.p_update();

				// CallBack Update
				dispatch_callBack({type: CT_UPDATE});
			}

			//trace('p_enterFrame');
		}
		
		// ::
		private function p_update():void
		{
			this._target[this._prop] = this._nowValue;
		}

		// ::
		public function to(endValue:Number):void
		{
			this._endValue = endValue;
			this._nowValue = this._target[this._prop];

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
