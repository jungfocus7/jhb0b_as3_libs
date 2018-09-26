package hb.core 
{
	
	import flash.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author Hobis
	 */
	public class CBase implements IContainerObserver, ICallBack, IDisposable
	{
		// :: 생성자
		public function CBase(cont:DisplayObjectContainer) 
		{
			_cont = cont;			
		}
		
		// - 컨테이너
		protected var _cont:DisplayObjectContainer = null;
		public function get_container():DisplayObjectContainer
		{
			return _cont;
		}
		
		// - 콜백 기본
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
		
		// :: 객체패기
		public function dispose():void
		{
			if (_cont == null) return;
			_cont = null;
			_callBack = null;
		}
	}
	
}