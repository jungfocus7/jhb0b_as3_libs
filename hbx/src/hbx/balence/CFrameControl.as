package hbx.balence
{
	import flash.display.MovieClip;
	import flash.events.Event;

	import hbx.common.CMovieClipWrapper;
	import hbx.common.MEventTypes;
	import hbx.core.CEventCore;



	public class CFrameControl extends CMovieClipWrapper
	{
		public static const ET_END:String = MEventTypes.ET_END;
		public static const ET_UPDATE:String = MEventTypes.ET_UPDATE;


		public function CFrameControl(mvc:MovieClip)
		{
			super(mvc);
		}

		public override function dispose():void
		{
			if (_mvc == null) return;
			this.stop();
			super.dispose();
		}


		private var _endValue:int;
		public function get_endValue():int
		{
			return _endValue;
		}


		private var _nowValue:int;
		public function get_nowValue():int
		{
			return _nowValue;
		}


		private var _valueDirection:int;


		private var _valueGap:int = 1;
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
				pp_update();

				this.dispatchEvent(new CEventCore(ET_END));
			}
			else
			{
				_nowValue = int(_nowValue + (_valueGap * _valueDirection));
				pp_update();

				this.dispatchEvent(new CEventCore(ET_UPDATE));
			}
		}

		private function pp_update():void
		{
			_mvc.gotoAndStop(_nowValue);
		}

		public function to(endValue:int):void
		{
			_endValue = endValue;
			_nowValue = _mvc.currentFrame;

			if (_endValue < _nowValue)
				_valueDirection = -1;
			else
			if (_endValue > _nowValue)
				_valueDirection = 1;
			else
			if (_endValue == _nowValue)
				return;

			_mvc.addEventListener(Event.ENTER_FRAME, pp_enterFrame);
		}

		public function stop():void
		{
			_mvc.removeEventListener(Event.ENTER_FRAME, pp_enterFrame);
		}

	}

}