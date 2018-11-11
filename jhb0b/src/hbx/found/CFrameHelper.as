﻿package hbx.found
{
	import flash.display.MovieClip;
	import flash.events.Event;

	import hbx.balence.MControlProxy;
	import hbx.core.CEventCore;
	import hbx.core.CMovieClipWrapper;
	import hbx.utils.MMovieClipUtil;



	public class CFrameHelper extends CMovieClipWrapper
	{
		public static const ET_END:String = MControlProxy.ET_END;
		public static const ET_UPDATE:String = MControlProxy.ET_UPDATE;



		public override function dispose():void
		{
			if (_mvc == null) return;
			super.dispose();
		}


		public function CFrameHelper(tmc:MovieClip)
		{
			super(tmc);
			_mvc.stop();
			_totalFrames = _mvc.totalFrames;
			_beginFrame = _mvc.currentFrame;
			_endFrame = _beginFrame;
			_currentFrame = _beginFrame;
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

		//private var _currentFrameLabel:String;
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





		private function p_checkEnterFrame(event:Event):void
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
			_mvc.removeEventListener(Event.ENTER_FRAME, p_checkEnterFrame);
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
			_mvc.addEventListener(Event.ENTER_FRAME, p_checkEnterFrame);
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
/*
		public function playEndLabel(endFrameLabel:String):void
		{
			this.playGotoEnd(_currentFrame, endFrame);
		}*/

		public function play():void
		{
			this.playGotoEnd(_currentFrame, _totalFrames);
		}









/*
		public function playEnd():void
		{
			if (_endFrame == _currentFrame) return;
			_beginFrame = _currentFrame;
			_endFrame = _owner.totalFrames;
			_currentFrame = _beginFrame;
			_frameCountEnd = _endFrame - _beginFrame;
			_frameCount = 0;
		}
*/



/*
		public function gotoPlay(beginFrame:int, endFrame:int,
									isStop:Boolean = false):void
		{
			if (beginFrame >= endFrame) return;

			_beginFrame = beginFrame;
			_endFrame = endFrame;
			_is_stop = isStop;
			_owner.addEventListener(Event.ENTER_FRAME, p_checkEnterFrame);
			//p_checkEnterFrame(null);
			if (_beginFrame < 1)
			{
				_owner.gotoAndPlay(_owner.currentFrame);
				//_owner.play();
			}
			else
			{
				_owner.gotoAndPlay(_beginFrame);
			}
		}

		public function gotoPlayLabel(beginFrameLabel:String, endFrameLabel:String,
										isStop:Boolean = false):void
		{
		}



		public function gotoPlayEnd(beginFrame:int, isStop:Boolean = false):void
		{
			this.gotoPlay(beginFrame, _owner.totalFrames, isStop);
		}

		public function playEnd(isStop:Boolean = false):void
		{
			this.gotoPlay(_owner.currentFrame, _owner.totalFrames, isStop);
		}
*/
	}
}