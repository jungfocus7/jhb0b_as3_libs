/**
	@Name: FrameControl
	@Author: HobisJung(jhb0b@naver.com)
	@Date: 2016-01-20
	@Comment:
	{
	}
*/
package hb.controls
{
	import flash.events.Event;
	import flash.display.MovieClip;
	import hb.core.ICallBack;
	import hb.core.IDisposable;
	
	//
	public class FrameControl implements ICallBack, IDisposable
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
		public function FrameControl(target:MovieClip)
		{
			_target = target;
		}
		// -
		private var _target:MovieClip = null;
		public function get_target():MovieClip
		{
			return this._target;
		}
		
		// -
		private var _endValue:int;
		public function get_endValue():int
		{
			return this._endValue;
		}
		
		// -
		private var _nowValue:int;
		public function get_nowValue():int
		{
			return this._nowValue;
		}
		
		// -
		private var _valueDirection:int;
		
		// -
		private var _valueGap:int = 1;
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
			var t_b:Boolean = false;

			if (this._valueDirection == 1)
				t_b = (this._nowValue >= this._endValue);
			else
			if (this._valueDirection == -1)
				t_b = (this._nowValue <= this._endValue);
				
			if (t_b)
			{
				this.stop();

				this._nowValue = this._endValue;
				this.p_update();

				// CallBack End
				dispatch_callBack({type: CT_END});
			}
			else
			{
				this._nowValue = int(this._nowValue + (this._valueGap * this._valueDirection));
				this.p_update();

				// CallBack Update
				dispatch_callBack({type: CT_UPDATE});
			}
		}

		// ::
		private function p_update():void
		{
			this._target.gotoAndStop(this._nowValue);
		}

		// ::
		public function to(endValue:int):void
		{
			this._endValue = endValue;
			this._nowValue = this._target.currentFrame;

			if (this._endValue < this._nowValue)
				this._valueDirection = -1;
			else
			if (this._endValue > this._nowValue)
				this._valueDirection = 1;
			else
			if (this._endValue == this._nowValue)
				return;

			ControlsProxy.useSprite.addEventListener(Event.ENTER_FRAME, this.p_enterFrame);
		}

		// ::
		public function stop():void
		{
			ControlsProxy.useSprite.removeEventListener(Event.ENTER_FRAME, this.p_enterFrame);
		}		
		//}}}
		////////////////////////////////////////////////////////////////////////////////////////////////////		
	}

}