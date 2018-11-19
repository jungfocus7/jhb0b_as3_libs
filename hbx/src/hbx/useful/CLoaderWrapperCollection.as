package hbx.useful
{
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;

	import hbx.core.CEventCore;
	import hbx.core.CEventDispatcherCore;




	public final class CLoaderWrapperCollection extends CEventDispatcherCore
	{
		public static const ET_COMPLETE:String = Event.COMPLETE;


		public override function dispose():void
		{
			if (_lws == null) return;

			for each (var lw:CLoaderWrapper in _lws)
			{
				var ldi:LoaderInfo = lw.get_loaderInfo();
				ldi.removeEventListener(IOErrorEvent.IO_ERROR, pp_ioErrorHandler);
				ldi.removeEventListener(Event.COMPLETE, pp_completeHandler);
				lw.dispose();
			}

			_lws = null;
		}

		public function CLoaderWrapperCollection(lws:Array)
		{
			_lws = lws;
			_seqEnd = _lws.length;
			_seq = 0;

			for (var i:uint = 0; i < _seqEnd; i++)
			{
				var lw:CLoaderWrapper = _lws[i];
				var ldi:LoaderInfo = lw.get_loaderInfo();
				ldi.addEventListener(IOErrorEvent.IO_ERROR, pp_ioErrorHandler);
				ldi.addEventListener(Event.COMPLETE, pp_completeHandler);
			}
		}

		//-- LoaderWrapperArray
		private var _lws:Array = null;
		public function get_lws():Array
		{
			return _lws;
		}


		/**
		 * 로더들 완료 체킹
		 */
		public function pp_loadedCheck():void
		{
			if (_seq < _seqEnd)
			{
				_seq++;
				if (_seq >= _seqEnd)
				{
					this.dispatchEvent(new CEventCore(ET_COMPLETE));
				}
			}
		}


		//-- 로드 카운트 끝
		private var _seqEnd:uint;
		public function get_seqEnd():uint
		{
			return _seqEnd;
		}


		//-- 로드 시퀀스
		private var _seq:uint;
		public function get_seq():uint
		{
			return _seq;

		}


		/**
		 * 로더들 실패 핸들러
		 * <br/>
		 * @param evt: Event
		 */
		private function pp_ioErrorHandler(evt:IOErrorEvent):void
		{
			pp_loadedCheck();
		}


		/**
		 * 로더들 완료 핸들러
		 * <br/>
		 * @param evt: Event
		 */
		private function pp_completeHandler(evt:Event):void
		{
			pp_loadedCheck();
		}


		/**
		 * 닫기
		 * <br/>
		 */
		public function close():void
		{
			for each (var lw:CLoaderWrapper in _lws)
			{
				lw.close();
			}
		}


		/**
		 * 로드
		 * <br/>
		 */
		public function load():void
		{
			_seq = 0;
			for each (var lw:CLoaderWrapper in _lws)
			{
				lw.load();
			}
		}

	}

}
