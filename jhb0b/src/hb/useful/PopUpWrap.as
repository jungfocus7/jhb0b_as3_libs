package hb.useful 
{
	import flash.events.Event;
	import flash.display.MovieClip;
	import hb.core.ICallBack;
	import hb.core.IDisposable;	
	
	/**
	 * ...
	 * @author Hobis
	 */
	public class PopUpWrap implements ICallBack, IDisposable
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
			if (_target == null) return;
			this.close();
			_callBack = null;
			_target = null;
		}
		//}}}
		////////////////////////////////////////////////////////////////////////////////////////////////////		
		
		public static const CT_OPEN:String = 'open';
		
		
		public function PopUpWrap(target:MovieClip) 
		{
			_target = target;
			this.close();
		}
		
		private var _target:MovieClip = null;
		public function get_target():MovieClip
		{
			return _target;
		}
		
		// '#_0'
		public function close(fl:String = null):void
		{			
			_target.gotoAndStop((fl == null) ? 1 : fl);
		}
		
		public function open(fl:String):void
		{
			if (_target.currentFrameLabel == fl) { }
			else
			{
				_target.gotoAndStop(fl);
				this.dispatch_callBack({type: CT_OPEN, target: _target});
			}
		}
		
	}

}