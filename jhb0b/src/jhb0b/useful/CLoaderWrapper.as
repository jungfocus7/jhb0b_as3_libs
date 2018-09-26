package jhb0b.useful
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import jhb0b.core.CContainerWrapper;
	import jhb0b.tools.MDebugTool;


	public class CLoaderWrapper extends CContainerWrapper
	{
		override public function dispose():void
		{
			if (_loader == null) return;

			this.close();


			var t_loaderInfo:LoaderInfo = _loader.contentLoaderInfo;

			if (_completeHandler != null)
			{
				t_loaderInfo.removeEventListener(Event.COMPLETE, _completeHandler);
				_completeHandler = null;
			}

			if (_progressHandler != null)
			{
				t_loaderInfo.removeEventListener(ProgressEvent.PROGRESS, _progressHandler);
				_progressHandler = null;
			}

			if (_ioErrorHandler != null)
			{
				t_loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, _ioErrorHandler);
				_ioErrorHandler = null;
			}
			else
			{
				t_loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, p_loader_ioError);
			}


			_cont.removeChild(_loader);

			_urlreq = null;
			_loader = null;

			super.dispose();
		}

		public function CLoaderWrapper(
							cont:DisplayObjectContainer,
							urlreq:URLRequest = null,
							completeHandler:Function = null,
							progressHandler:Function = null,
							ioErrorHandler:Function = null):void
		{
			super(cont);

			_loader = new Loader();
			_cont.addChild(_loader);

			_urlreq = urlreq;


			var t_loaderInfo:LoaderInfo = _loader.contentLoaderInfo;

			if (completeHandler != null)
			{
				_completeHandler = completeHandler;
				t_loaderInfo.addEventListener(Event.COMPLETE, _completeHandler);
			}

			if (progressHandler != null)
			{
				_progressHandler = progressHandler;
				t_loaderInfo.addEventListener(ProgressEvent.PROGRESS, _progressHandler);
			}

			if (ioErrorHandler != null)
			{
				_ioErrorHandler = ioErrorHandler;
				t_loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, _ioErrorHandler);
			}
			else
			{
				t_loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, p_loader_ioError);
			}
		}

		//- 로더객체 반환
		private var _loader:Loader;
		public function get_loader():Loader
		{
			return _loader;
		}

		//:: 로더객체 반환
		public function get_loaderInfo():LoaderInfo
		{
			return _loader.contentLoaderInfo;
		}

		//- 완료 핸들러 참조
		private var _completeHandler:Function;
		public function get_completeHandler():Function
		{
			return _completeHandler;
		}

		//- 진행 핸들러 참조
		private var _progressHandler:Function;
		public function get_progressHandler():Function
		{
			return _progressHandler;
		}

		//- 에러 핸들러 참조
		private var _ioErrorHandler:Function;
		public function get_ioErrorHandler():Function
		{
			return _ioErrorHandler;
		}

		//:: 에러 핸들러 (기본용)
		private function p_loader_ioError(evt:IOErrorEvent):void
		{
			var t_loaderInfo:LoaderInfo = _loader.contentLoaderInfo;
			t_loaderInfo.removeEventListener(evt.type, p_loader_ioError);

			MDebugTool.test('p_loader_ioError');
		}

		//- UrlRequest 객체
		private var _urlreq:URLRequest;
		public function get_urlreq():URLRequest
		{
			return _urlreq;
		}

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

		public function load(urlreq:URLRequest = null, lc:LoaderContext = null):void
		{
			this.close();

			if (urlreq != null)
			{
				_urlreq = urlreq;
				_loader.load(_urlreq, lc);
			}
			else
			{
				if (_urlreq != null)
				{
					_loader.load(_urlreq, lc);
				}
			}
		}

		public function load_a(url:String, lc:LoaderContext = null):void
		{
			_urlreq = new URLRequest(url);
			this.load(_urlreq, lc);
		}

	}

}
