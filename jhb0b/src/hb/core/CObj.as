package hb.core
{
	public class CObj implements ICallBack
	{
		public function CObj()
		{
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

	}

}