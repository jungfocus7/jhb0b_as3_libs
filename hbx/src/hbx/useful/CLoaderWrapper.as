package hbx.useful
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;

	import hbx.common.CDisplayObjectContainerWrapper;
	import hbx.tools.MDebugTool;



	public class CLoaderWrapper extends CDisplayObjectContainerWrapper
	{
		public function CLoaderWrapper(
			tcont:DisplayObjectContainer, ureq:URLRequest = null, completeHandler:Function = null,
			progressHandler:Function = null, ioErrorHandler:Function = null):void
		{
			super(tcont);

			_loader = new Loader();
			_container.addChild(_loader);

			_ureq = ureq;


			var ldi:LoaderInfo = _loader.contentLoaderInfo;

			if (completeHandler != null)
			{
				_completeHandler = completeHandler;
				ldi.addEventListener(Event.COMPLETE, _completeHandler);
			}

			if (progressHandler != null)
			{
				_progressHandler = progressHandler;
				ldi.addEventListener(ProgressEvent.PROGRESS, _progressHandler);
			}

			if (ioErrorHandler != null)
			{
				_ioErrorHandler = ioErrorHandler;
				ldi.addEventListener(IOErrorEvent.IO_ERROR, _ioErrorHandler);
			}
			else
			{
				ldi.addEventListener(IOErrorEvent.IO_ERROR, pp_loader_ioError);
			}
		}

		//-- 로더객체 반환
		private var _loader:Loader;
		public function get_loader():Loader
		{
			return _loader;
		}

		//-- 로더객체 반환
		public function get_loaderInfo():LoaderInfo
		{
			return _loader.contentLoaderInfo;
		}

		//-- 완료 핸들러 참조
		private var _completeHandler:Function;
		public function get_completeHandler():Function
		{
			return _completeHandler;
		}

		//-- 진행 핸들러 참조
		private var _progressHandler:Function;
		public function get_progressHandler():Function
		{
			return _progressHandler;
		}

		//-- 에러 핸들러 참조
		private var _ioErrorHandler:Function;
		public function get_ioErrorHandler():Function
		{
			return _ioErrorHandler;
		}


		/**
		 * 객체 소거
		 */
		public override function dispose():void
		{
			if (_loader == null) return;

			this.close();


			var ldi:LoaderInfo = _loader.contentLoaderInfo;

			if (_completeHandler != null)
			{
				ldi.removeEventListener(Event.COMPLETE, _completeHandler);
				_completeHandler = null;
			}

			if (_progressHandler != null)
			{
				ldi.removeEventListener(ProgressEvent.PROGRESS, _progressHandler);
				_progressHandler = null;
			}

			if (_ioErrorHandler != null)
			{
				ldi.removeEventListener(IOErrorEvent.IO_ERROR, _ioErrorHandler);
				_ioErrorHandler = null;
			}
			else
			{
				ldi.removeEventListener(IOErrorEvent.IO_ERROR, pp_loader_ioError);
			}


			_container.removeChild(_loader);

			_ureq = null;
			_loader = null;

			super.dispose();
		}



		/**
		 * 에러 핸들러 (기본용)
		 * <br/>
		 * @param evt: Event
		 */
		private function pp_loader_ioError(evt:IOErrorEvent):void
		{
			var t_loaderInfo:LoaderInfo = _loader.contentLoaderInfo;
			t_loaderInfo.removeEventListener(evt.type, pp_loader_ioError);

			MDebugTool.test('pp_loader_ioError');
		}


		//-- UrlRequest 객체
		private var _ureq:URLRequest;
		public function get_ureq():URLRequest
		{
			return _ureq;
		}


		/**
		 * 닫고 언로드
		 * <br/>
		 * @param gc: 가비콜렉션 실행 여부
		 */
		public function close(gc:Boolean = true):void
		{
			try
			{
				_loader.close();
			}
			catch (e:Error) {}

			try
			{
				_loader.unloadAndStop(gc);
			}
			catch (e:Error) {}
		}


		/**
		 * 로드
		 * <br/>
		 * @param ureq:
		 * @param ldc:
		 */
		public function load(ureq:URLRequest = null, ldc:LoaderContext = null):void
		{
			this.close();

			if (ureq != null)
			{
				_ureq = ureq;
				_loader.load(_ureq, ldc);
			}
			else
			{
				if (_ureq != null)
				{
					_loader.load(_ureq, ldc);
				}
			}
		}


		/**
		 * 로드
		 * <br/>
		 * @param url: UrlString
		 * @param ldc:
		 */
		public function load2(url:String, ldc:LoaderContext = null):void
		{
			_ureq = new URLRequest(url);
			this.load(_ureq, ldc);
		}

	}

}
