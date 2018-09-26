package jhb0b.frame
{
	import flash.display.Sprite;
	import flash.events.Event;
	import jhb0b.controls.MControlProxy;
	import jhb0b.core.CEventCore;
	import jhb0b.events.CBumEvent;


	public class CFrameTimer extends CEventCore
	{
		override public function dispose():void
		{
			this.stop(true);
		}

		//
		//
		////////////////////////////////////////////////////////////////////////////////////////////////////
		public static const ET_END:String = MControlProxy.ET_END;
		public static const ET_UPDATE:String = MControlProxy.ET_UPDATE;

		//-
		private static const _UseSprite:Sprite = new Sprite();

		//
		//:: 생성자
		public function CFrameTimer(delayFrame:int, repeatCount:int = 0)
		{
			this.set_delayFrame(delayFrame);
			this.set_repeatCount(repeatCount);
		}

		//- 현재 진행중 여부
		private var _running:Boolean = false;
		public function get_running():Boolean
		{
			return _running;
		}

		//- 딜레이 프래임
		private var _delayFrame:int;
		public function get_delayFrame():int
		{
			return _delayFrame;
		}
		public function set_delayFrame(v:int):void
		{
			_delayFrame = (v < 0) ? 0 : v;
		}

		//- 현재 프래임
		private var _nowFrame:int = 0;
		public function get_nowFrame():int
		{
			return _nowFrame;
		}

		//- 반복 카운트
		private var _repeatCount:int;
		public function get_repeatCount():int
		{
			return _repeatCount;
		}
		public function set_repeatCount(v:int):void
		{
			_repeatCount = (v < 0) ? 0 : v;
		}

		//- 현재 카운트
		private var _currentCount:int = 0;
		public function get_currentCount():int
		{
			return _currentCount;
		}

		//:: 엔터프래임
		private function p_enterFrame(event:Event):void
		{
			if (_nowFrame >= _delayFrame)
			{
				_nowFrame = 0;
				if (_repeatCount == 0)
				{
					_currentCount++;
					this.dispatchEvent(new CBumEvent(ET_UPDATE));
				}
				else
				if (_currentCount < _repeatCount)
				{
					_currentCount++;
					this.dispatchEvent(new CBumEvent(ET_UPDATE));
					if (_currentCount >= _repeatCount)
					{
						this.stop();
						this.dispatchEvent(new CBumEvent(ET_END));
					}
				}
				else
				{
					this.stop();
				}
			}
			else
			{
				_nowFrame++;
			}
		}


		//:: 리셋
		public function reset():void
		{
			this.stop();
			_nowFrame = 0;
			_currentCount = 0;
		}

		//:: 시작
		public function start():void
		{
			if (!_running)
			{
				if ((_repeatCount == 0) ||
					(_currentCount < _repeatCount))
				{
					_UseSprite.addEventListener(Event.ENTER_FRAME, p_enterFrame);
					_running = true;
				}
			}
		}

		//:: 정지
		public function stop(frameReset:Boolean = false):void
		{
			if (_running)
			{
				_UseSprite.removeEventListener(Event.ENTER_FRAME, p_enterFrame);
				if (frameReset)
					_nowFrame = 0;
				_running = false;
			}
		}
		////////////////////////////////////////////////////////////////////////////////////////////////////

	}

}