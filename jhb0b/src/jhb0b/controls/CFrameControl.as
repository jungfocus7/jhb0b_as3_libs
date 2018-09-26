package jhb0b.controls
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import jhb0b.core.CMovieClipWrapper;
	import jhb0b.events.CBumEvent;


	public class CFrameControl extends CMovieClipWrapper
	{
		override public function dispose():void
		{
			if (_owner == null) return;
			this.stop();
			super.dispose();
		}

		//
		//
		////////////////////////////////////////////////////////////////////////////////////////////////////
		public static const ET_END:String = MControlProxy.ET_END;
		public static const ET_UPDATE:String = MControlProxy.ET_UPDATE;

		//::
		public function CFrameControl(tmc:MovieClip)
		{
			super(tmc);
		}

		//-
		private var _endValue:int;
		public function get_endValue():int
		{
			return _endValue;
		}

		//-
		private var _nowValue:int;
		public function get_nowValue():int
		{
			return _nowValue;
		}

		//-
		private var _valueDirection:int;

		//-
		private var _valueGap:int = 1;
		public function get_valueGap():Number
		{
			return _valueGap;
		}
		public function set_valueGap(v:Number):void
		{
			_valueGap = v;
		}


		//::
		private function p_enterFrame(event:Event):void
		{
			var t_b:Boolean = false;

			if (_valueDirection == 1)
				t_b = (_nowValue >= _endValue);
			else
			if (_valueDirection == -1)
				t_b = (_nowValue <= _endValue);

			if (t_b)
			{
				this.stop();

				_nowValue = _endValue;
				p_update();

				this.dispatchEvent(new CBumEvent(ET_END));
			}
			else
			{
				_nowValue = int(_nowValue + (_valueGap * _valueDirection));
				p_update();

				this.dispatchEvent(new CBumEvent(ET_UPDATE));
			}
		}

		//::
		private function p_update():void
		{
			_owner.gotoAndStop(_nowValue);
		}

		//::
		public function to(endValue:int):void
		{
			_endValue = endValue;
			_nowValue = _owner.currentFrame;

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
		////////////////////////////////////////////////////////////////////////////////////////////////////
	}

}