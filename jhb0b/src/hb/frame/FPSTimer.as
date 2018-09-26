/**
	@Name: FPSTimer
	@Author: HobisJung(jhb0b@naver.com)
	@Date: 2016-01-22
	@Comment:
	{
	}
*/
package hb.frame
{
	import flash.display.Sprite;
	import flash.events.Event;
	import hb.core.ICallBack;
	import hb.core.IDisposable;
	
	//
	// #
	public class FPSTimer implements ICallBack, IDisposable
	{
		//
		//
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
			this.stop();
			_callBack = null;
			_name = null;
		}
		//}}}
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		
		//
		//
		////////////////////////////////////////////////////////////////////////////////////////////////////
		//{{{ 구현부
		////////////////////////////////////////////////////////////////////////////////////////////////////
		public static const CT_UPDATE:String = 'update';
		public static const CT_UPDATE_END:String = 'updateEnd';
		
		// -
		private static const _USE_SPRITE:Sprite = new Sprite();
		
		//
		// :: 생성자
		public function FPSTimer(delayFrame:int, repeatCount:int = 0)
		{
			this.set_delayFrame(delayFrame);
			this.set_repeatCount(repeatCount);
		}
		
		// - 현재 진행중 여부
		private var _running:Boolean = false;
		public function get_running():Boolean
		{
			return _running;
		}
		
		// - 딜레이 프래임
		private var _delayFrame:int;
		public function get_delayFrame():int
		{
			return _delayFrame;
		}
		public function set_delayFrame(v:int):void
		{
			_delayFrame = (v < 0) ? 0 : v;
		}
		
		// - 현재 프래임
		private var _nowFrame:int = 0;
		public function get_nowFrame():int
		{
			return _nowFrame;
		}

		// - 반복 카운트
		private var _repeatCount:int;
		public function get_repeatCount():int
		{
			return _repeatCount;
		}
		public function set_repeatCount(v:int):void
		{
			_repeatCount = (v < 0) ? 0 : v;
		}
		
		// - 현재 카운트
		private var _currentCount:int = 0;		
		public function get_currentCount():int
		{
			return _currentCount;
		}

		// - 객체 식별자 이름
		private var _name:String = null;
		public function get_name():String
		{
			return _name;
		}
		public function set_name(v:String):void
		{
			_name = v;
		}

		// :: 엔터프래임
		private function p_enterFrame(event:Event):void
		{
			if (_nowFrame >= _delayFrame)
			{
				_nowFrame = 0;

				if
				(
					(_repeatCount == 0) ||
					(_currentCount < _repeatCount)
				)
				{
					_currentCount++;
					//
					this.dispatch_callBack(
					{
						type: CT_UPDATE
					});

					if
					(
						(_repeatCount > 0) &&
						(_currentCount >= _repeatCount)
					)
					{
						this.stop();
						//
						this.dispatch_callBack(
						{
							type: CT_UPDATE_END
						});
					}
				}
			}
			else
			{
				_nowFrame++;
			}
		}
		

		// :: 리셋
		public function reset():void
		{
			this.stop();
			//
			_nowFrame = 0;
			_currentCount = 0;
		}

		// :: 시작
		public function start():void
		{
			if (_running)
			{
			}
			else
			{
				if
				(
					(_repeatCount == 0) ||
					(_currentCount < _repeatCount)
				)
				{
					_USE_SPRITE.addEventListener(Event.ENTER_FRAME, this.p_enterFrame);
					//
					_running = true;
				}
			}
		}

		// :: 정지
		public function stop(frameReset:Boolean = false):void
		{
			if (_running)
			{
				_USE_SPRITE.removeEventListener(Event.ENTER_FRAME, this.p_enterFrame);

				if (frameReset)
					_nowFrame = 0;
				//
				_running = false;
			}
		}
		//}}}
		////////////////////////////////////////////////////////////////////////////////////////////////////

	}

}