package hbx.found
{
	import flash.display.MovieClip;
	import flash.events.Event;

	import hbx.common.CMovieClipWrapper;
	import hbx.common.MEventTypes;
	import hbx.core.CEventCore;
	import hbx.utils.MMovieClipUtil;



	public class CFrameHelper extends CMovieClipWrapper
	{
		public static const ET_END:String = MEventTypes.ET_END;
		public static const ET_UPDATE:String = MEventTypes.ET_UPDATE;



		public function CFrameHelper(mvc:MovieClip)
		{
			super(mvc);
			_mvc.stop();
			_totalFrames = _mvc.totalFrames;
			_beginFrame = _mvc.currentFrame;
			_endFrame = _beginFrame;
			_currentFrame = _beginFrame;
		}

		public override function dispose():void
		{
			if (_mvc == null) return;
			super.dispose();
		}



		private var _totalFrames:int;
		public function get_totalFrames():int
		{
			return _totalFrames;
		}

		private var _beginFrame:int;
		public function get_beginFrame():int
		{
			return _beginFrame;
		}

		private var _endFrame:int;
		public function get_endFrame():int
		{
			return _endFrame;
		}

		private var _currentFrame:int;
		public function get_currentFrame():int
		{
			return _currentFrame;
		}


		public function get_currentFrameLabel():String
		{
			return _mvc.currentFrameLabel;
		}


		public function gotoStop(endFrame:int):void
		{
			if (endFrame == _currentFrame) return;
			if (endFrame < 1) endFrame = 1;
			if (endFrame > _totalFrames) endFrame = _totalFrames;
			_beginFrame = _currentFrame;
			_endFrame = endFrame;
			_currentFrame = _endFrame;
			_mvc.gotoAndStop(_currentFrame);
		}

		public function gotoStopLabel(endFrameLabel:String):void
		{
			var t_ef:int = MMovieClipUtil.get_frameLabelToFrame(_mvc, endFrameLabel);
			this.gotoStop(t_ef);
		}



		private function pp_checkEnterFrame(evt:Event):void
		{
			var t_cn:uint = _frameCount + 1;
			if (t_cn <= _frameCountEnd)
			{
				_frameCount = t_cn;
				_currentFrame = _mvc.currentFrame;
				this.dispatchEvent(new CEventCore(ET_UPDATE));

				if (_frameCount >= _frameCountEnd)
				{
					this.dispatchEvent(new CEventCore(ET_END));
					this.playStop();
				}
			}
		}
		private var _frameCountEnd:uint;
		private var _frameCount:uint;


		public function playStop():void
		{
			_mvc.removeEventListener(Event.ENTER_FRAME, pp_checkEnterFrame);
			_mvc.stop();
			_frameCountEnd = 0;
			_frameCount = 0;
		}

		public function playGotoEnd(beginFrame:int, endFrame:int):void
		{
			if ((beginFrame < 1) || (beginFrame > _totalFrames)) return;
			if ((endFrame < 1) || (endFrame > _totalFrames)) return;
			if (beginFrame >= endFrame) return;
			this.playStop();
			this.gotoStop(beginFrame);
			_beginFrame = beginFrame;
			_endFrame = endFrame;
			_frameCountEnd = (_endFrame - _beginFrame);
			_frameCount = 0;
			_mvc.addEventListener(Event.ENTER_FRAME, pp_checkEnterFrame);
			_mvc.play();
		}

		public function playGotoEndLabel(beginFrameLabel:String, endFrameLabel:String):void
		{
			var t_bf:int = MMovieClipUtil.get_frameLabelToFrame(_mvc, beginFrameLabel);
			var t_ef:int = MMovieClipUtil.get_frameLabelToFrame(_mvc, endFrameLabel);
			this.playGotoEnd(t_bf, t_ef);
		}

		public function playEnd(endFrame:int):void
		{
			this.playGotoEnd(_currentFrame, endFrame);
		}

		public function play():void
		{
			this.playGotoEnd(_currentFrame, _totalFrames);
		}

	}
}