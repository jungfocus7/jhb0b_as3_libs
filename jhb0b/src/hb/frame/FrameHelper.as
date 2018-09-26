/**
	@Name: FrameHelper
	@Author: HobisJung(jhb0b@naver.com)
	@Date: 2016-01-22
	@Comment:
	{
	}
*/
package hb.frame
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import hb.core.ICallBack;
	import hb.core.IDisposable;
	import hb.utils.MovieClipUtil;
	
	//
	// #
	public class FrameHelper implements ICallBack, IDisposable
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
			eObj.target = this;
			_callBack(eObj);
		}
		public function set_callBack(f:Function):void
		{
			_callBack = f;
		}		
		public function dispose():void
		{			
			if (_target == null) return;
			this.stop();
			_callBack = null;
			_beginFrameLabel = null;
			_endFrameLabel = null;
			_currentFrameLabel = null;
			_target.gotoAndStop(1);
			_target = null;
		}
		//}}}
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		
		
		//
		//
		////////////////////////////////////////////////////////////////////////////////////////////////////
		//{{{ 구현부
		////////////////////////////////////////////////////////////////////////////////////////////////////
		public static const CT_END_FRAME:String = 'endFrame';
		public static const CT_ENTER_FRAME:String = Event.ENTER_FRAME;	
		
		// ::
		public function FrameHelper(target:MovieClip)
		{
			_target = target;
			_target.gotoAndStop(1);
		}
		
		// - 타겟 무비클립
		private var _target:MovieClip = null;
		public function get_target():MovieClip
		{
			return _target;
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
		
		private var _isStop:Boolean = false;
		
		// -
		private var _currentFrame:int;
		public function get_currentFrame():int
		{
			return _currentFrame;
		}

		
		// -
		private var _beginFrameLabel:String = null;
		public function get_beginFrameLabel():String
		{
			return _beginFrameLabel;
		}
		
		// -
		private var _endFrameLabel:String = null;
		public function get_endFrameLabel():String
		{
			return _endFrameLabel;
		}
		
		// -
		private var _currentFrameLabel:String;
		public function get_currentFrameLabel():String
		{
			return _currentFrameLabel;
		}
		
		// :: 
		public function stop():void
		{
			_target.removeEventListener(Event.ENTER_FRAME, p_checkEnterFrame);
			_target.stop();
		}
		
		// :: 
		private function p_checkEnterFrame(event:Event):void
		{	
			_currentFrame = _target.currentFrame;
			_currentFrameLabel = _target.currentFrameLabel;
			
			this.dispatch_callBack({
				type: CT_ENTER_FRAME
			});
			
			//
			if (_currentFrame >= _endFrame)
			{
				_target.removeEventListener(Event.ENTER_FRAME, p_checkEnterFrame);
				if (_isStop) {
					_target.stop();
				}
				
				this.dispatch_callBack({
					type: CT_END_FRAME
				});
			}
			
			//trace('_currentFrame: ' + _currentFrame);
		}
		
		
		// :: 
		public function gotoStop(endFrame:int):void
		{
			_target.gotoAndStop(endFrame);
		}
		
		// :: 
		public function gotoStopLabel(endFrameLabel:String, endFramePlus:int = 0):void
		{
			var t_ef:int = MovieClipUtil.get_frameLabelToFrame(_target, endFrameLabel);
			if (t_ef < 1) return;
			_endFrameLabel = endFrameLabel;
			t_ef += endFramePlus;
			_target.gotoAndStop(t_ef);
		}
		
	
		
		// :: 
		public function gotoPlay(
							beginFrame:int, endFrame:int,
							isStop:Boolean = false):void
		{
			if (beginFrame >= endFrame) return;
			_beginFrame = beginFrame;
			_endFrame = endFrame;
			_isStop = isStop;
			_target.addEventListener(Event.ENTER_FRAME, p_checkEnterFrame);
			//p_checkEnterFrame(null);
			if (_beginFrame < 1) {
				_target.gotoAndPlay(_target.currentFrame);
				//_target.play();
			}
			else {
				_target.gotoAndPlay(_beginFrame);
			}
		}
		
		// :: 
		public function gotoPlayLabel(
							beginFrameLabel:String, endFrameLabel:String,
							isStop:Boolean = false,
							beginFramePlus:int = 0, endFramePlus:int = 0):void
		{
			var t_bf:int = MovieClipUtil.get_frameLabelToFrame(_target, beginFrameLabel);
			var t_ef:int = MovieClipUtil.get_frameLabelToFrame(_target, endFrameLabel);
			if (t_bf >= t_ef) return;
			if (t_ef < 1) return;
			
			_beginFrameLabel = beginFrameLabel;
			_endFrameLabel = endFrameLabel;
			if (t_bf < 1)
			{
				t_ef += endFramePlus;
				gotoPlay(0, t_ef, isStop);
			}
			else
			{
				t_bf += beginFramePlus;
				t_ef += endFramePlus;
				gotoPlay(t_bf, t_ef, isStop);				
			}
		}
		
		
		
		
		
		// :: 
		public function gotoPlayEnd(
							beginFrame:int,
							isStop:Boolean = false):void
		{
			this.gotoPlay(beginFrame, _target.totalFrames, isStop);
		}
		
		// :: 
		public function playEnd(isStop:Boolean = false):void
		{
			this.gotoPlay(_target.currentFrame, _target.totalFrames, isStop);
		}		
		
		//}}}
		////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}