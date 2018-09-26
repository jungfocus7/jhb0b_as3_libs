/**
	@Name: WrapLoaderMulti
	@Author: HobisJung
	@Date: 2016-05-03
	@Comment: 연속 로더
	@Using:
	{
	}
*/
package hb.useful
{
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import hb.core.ICallBack;

	public final class WrapLoaderMulti implements ICallBack
	{
		// - CallBack Type - Complete
		public static const CT_COMPLETE:String = Event.COMPLETE;
		
		
		// :: 생성자
		public function WrapLoaderMulti(wls:Array)
		{
			_wls = wls;

			_countEnd = _wls.length;
			_count = 0;
			
			for (
				var t_la:uint = _countEnd,
					i:uint = 0; i < t_la; i++)
			{
				var t_wl:WrapLoader = _wls[i];
				var t_loaderInfo:LoaderInfo = t_wl.get_loaderInfo();
				t_loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, p_ioErrorHandler);
				t_loaderInfo.addEventListener(Event.COMPLETE, p_completeHandler);
			}
		}

		// - WrapLoader들 배열 참조
		private var _wls:Array = null;
		public function get_wls():Array
		{
			return _wls;
		}
		
		// - 콜백 기본
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

		
		// :: 로더들 완료 체킹
		public function p_loadedCheck():void
		{
			if (_count < _countEnd)
			{
				_count++;
				if (_count >= _countEnd)
				{
					this.dispatch_callBack({type: CT_COMPLETE});
				}
			}
		}
		
		// - 로드 카운트 끝
		private var _countEnd:uint;
		public function get_countEnd():uint
		{
			return _countEnd;
		}

		// - 로드 카운트
		private var _count:uint;
		public function get_count():uint
		{
			return _count;
		}

		// :: 로더들 실패 핸들러
		private function p_ioErrorHandler(event:IOErrorEvent):void
		{
			p_loadedCheck();
		}
		
		// :: 로더들 완료 핸들러
		private function p_completeHandler(event:Event):void
		{
			p_loadedCheck();
		}

		// :: 객체 폐기
		public function dispose():void
		{
			for each (var t_wl:WrapLoader in _wls)
			{
				var t_loaderInfo:LoaderInfo = t_wl.get_loaderInfo();
				t_loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, p_ioErrorHandler);
				t_loaderInfo.removeEventListener(Event.COMPLETE, p_completeHandler);
				t_wl.dispose();
			}
			_callBack = null;
			_wls = null;
		}

		// :: 닫기
		public function close():void
		{
			for each (var t_wl:WrapLoader in _wls)
			{
				t_wl.close();
			}
		}

		// :: 로드
		public function load():void
		{
			this._count = 0;

			for each (var t_wl:WrapLoader in _wls)
			{
				t_wl.load();
			}
		}



	}
}
