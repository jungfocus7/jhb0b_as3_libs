package jhb0b.useful
{
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import jhb0b.core.CEventCore;
	import jhb0b.events.CBumEvent;


	public final class CLoaderWrapperCollection extends CEventCore
	{
		public static const ET_COMPLETE:String = Event.COMPLETE;


		override public function dispose():void
		{
			if (_lws == null) return;

			for each (var t_lw:CLoaderWrapper in _lws)
			{
				var t_loaderInfo:LoaderInfo = t_lw.get_loaderInfo();
				t_loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, p_ioErrorHandler);
				t_loaderInfo.removeEventListener(Event.COMPLETE, p_completeHandler);
				t_lw.dispose();
			}

			_lws = null;
		}

		public function CLoaderWrapperCollection(lws:Array)
		{
			_lws = lws;
			_countEnd = _lws.length;
			_count = 0;

			for (var i:uint = 0; i < _countEnd; i++)
			{
				var t_lw:CLoaderWrapper = _lws[i];
				var t_loaderInfo:LoaderInfo = t_lw.get_loaderInfo();
				t_loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, p_ioErrorHandler);
				t_loaderInfo.addEventListener(Event.COMPLETE, p_completeHandler);
			}
		}

		//-
		private var _lws:Array = null;
		public function get_lws():Array
		{
			return _lws;
		}

		//:: 로더들 완료 체킹
		public function p_loadedCheck():void
		{
			if (_count < _countEnd)
			{
				_count++;
				if (_count >= _countEnd)
				{
					this.dispatchEvent(new CBumEvent(ET_COMPLETE));
				}
			}
		}

		//- 로드 카운트 끝
		private var _countEnd:uint;
		public function get_countEnd():uint
		{
			return _countEnd;
		}

		//- 로드 카운트
		private var _count:uint;
		public function get_count():uint
		{
			return _count;
		}

		//:: 로더들 실패 핸들러
		private function p_ioErrorHandler(evt:IOErrorEvent):void
		{
			p_loadedCheck();
		}

		//:: 로더들 완료 핸들러
		private function p_completeHandler(evt:Event):void
		{
			p_loadedCheck();
		}

		//:: 닫기
		public function close():void
		{
			for each (var t_lw:CLoaderWrapper in _lws)
			{
				t_lw.close();
			}
		}

		//:: 로드
		public function load():void
		{
			_count = 0;
			for each (var t_lw:CLoaderWrapper in _lws)
			{
				t_lw.load();
			}
		}

	}

}
