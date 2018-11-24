package hbx.useful
{
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.utils.Dictionary;

	import hbx.core.CEventCore;
	import hbx.core.CEventDispatcherCore;
	import flash.display.DisplayObject;




	public final class CLoaderWrapperCollection extends CEventDispatcherCore
	{
		public static const ET_COMPLETE:String = Event.COMPLETE;
		public static const ET_COMPLETE_ALL:String = Event.COMPLETE + 'All';


		public override function dispose():void
		{
			if (_arr == null) return;
			for each (var lw:CLoaderWrapper in _arr)
			{
				var ldi:LoaderInfo = lw.get_loaderInfo();
				ldi.removeEventListener(IOErrorEvent.IO_ERROR, pp_ioErrorHandler);
				ldi.removeEventListener(Event.COMPLETE, pp_completeHandler);
				lw.dispose();
			}
			_diclw = null;
			_dicidx = null;
			_templw = null;
			_arr = null;
		}

		public function CLoaderWrapperCollection(arr:Array)
		{
			_arr = arr;
			_diclw = new Dictionary();
			_dicidx = new Dictionary();
			_countEnd = _arr.length;
			_count = 0;
			for (var i:uint = 0; i < _countEnd; i++)
			{
				var lw:CLoaderWrapper = _arr[i];
				var ldi:LoaderInfo = lw.get_loaderInfo();
				ldi.addEventListener(IOErrorEvent.IO_ERROR, pp_ioErrorHandler);
				ldi.addEventListener(Event.COMPLETE, pp_completeHandler);
				_diclw[ldi] = lw;
				_dicidx[ldi] = i;
			}
		}



		//-- LoaderWrapperArray
		private var _arr:Array = null;
		public function get_arr():Array
		{
			return _arr;
		}


		//--
		private var _diclw:Dictionary;
		private var _templw:CLoaderWrapper;
		public function get_lw():CLoaderWrapper
		{
			return _templw;
		}


		//--
		private var _dicidx:Dictionary;
		private var _tempidx:uint;
		public function get_idx():uint
		{
			return _tempidx;
		}


		//-- 로드 카운트 끝
		private var _countEnd:uint;
		public function get_countEnd():uint
		{
			return _countEnd;
		}


		//-- 로드 시퀀스
		private var _count:uint;
		public function get_count():uint
		{
			return _count;

		}



		/**
		 * 로더들 완료 체킹
		 */
		public function pp_loadedCheck(ldi:LoaderInfo):void
		{
			if (_count < _countEnd)
			{
				_count++;

				_templw = _diclw[ldi];
				_tempidx = _dicidx[ldi];
				this.dispatchEvent(new CEventCore(ET_COMPLETE));

				if (_count >= _countEnd)
				{
					this.dispatchEvent(new CEventCore(ET_COMPLETE_ALL));
				}
			}
		}


		/**
		 * 로더들 실패 핸들러
		 * <br/>
		 * @param evt: Event
		 */
		private function pp_ioErrorHandler(evt:IOErrorEvent):void
		{
			pp_loadedCheck(LoaderInfo(evt.currentTarget));
		}


		/**
		 * 로더들 완료 핸들러
		 * <br/>
		 * @param evt: Event
		 */
		private function pp_completeHandler(evt:Event):void
		{
			pp_loadedCheck(LoaderInfo(evt.currentTarget));
		}


		/**
		 * 닫기
		 * <br/>
		 */
		public function close():void
		{
			for each (var lw:CLoaderWrapper in _arr)
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
			_count = 0;
			for each (var lw:CLoaderWrapper in _arr)
			{
				lw.load();
			}
		}

	}

}
