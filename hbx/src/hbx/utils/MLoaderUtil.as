package hbx.utils
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;

	import hbx.tools.MDebugTool;



	public final class MLoaderUtil
	{
		/**
		 * 로더 에러 핸들러
		 * <br/>
		 * @param evt: Event
		 */
		private static function pp_loader_ioError(evt:IOErrorEvent):void
		{
			var loaderInfo:LoaderInfo = LoaderInfo(evt.currentTarget);
			loaderInfo.removeEventListener(evt.type, pp_loader_ioError);

			MDebugTool.test('pp_loader_ioError');
		}


		/**
		 * 로더 생성
		 * <br/>
		 * @param tcont: TargetContainer
		 * @param completeHandler: EventHandler
		 * @param progressHandler: EventHandler
		 * @param ioErrorHandler: EventHandler
		 */
		public static function create(tcont:DisplayObjectContainer,
			completeHandler:Function = null, progressHandler:Function = null, ioErrorHandler:Function = null):Loader
		{
			var loader:Loader = new Loader();
			var loaderInfo:LoaderInfo = loader.contentLoaderInfo;

			if (tcont != null)
			{
				tcont.addChild(loader);
			}

			if (completeHandler != null)
			{
				loaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			}

			if (progressHandler != null)
			{
				loaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			}

			if (ioErrorHandler != null)
			{
				loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			}
			else
			{
				loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, pp_loader_ioError);
			}

			return loader;
		}


		/**
		 * 로더 생성후 로드
		 * <br/>
		 * @param tcont: TargetContainer
		 * @param url: Url
		 * @param loaderContext: LoaderContext
		 * @param completeHandler: EventHandler
		 * @param progressHandler: EventHandler
		 * @param ioErrorHandler: EventHandler
		 */
		public static function createAndLoad(tcont:DisplayObjectContainer, url:String, loaderContext:LoaderContext = null,
			completeHandler:Function = null, progressHandler:Function = null, ioErrorHandler:Function = null):Loader
		{
			var loader:Loader = create(tcont, completeHandler, progressHandler, ioErrorHandler);
			var ur:URLRequest = new URLRequest(url);
			loader.load(ur, loaderContext);
			return loader;
		}


		/**
		 * 로더 생성후 로드 2
		 * <br/>
		 * @param tcont: TargetContainer
		 * @param urlReq: URLRequest
		 * @param loaderContext: LoaderContext
		 * @param completeHandler: EventHandler
		 * @param progressHandler: EventHandler
		 * @param ioErrorHandler: EventHandler
		 */
		public static function createAndLoad2(tcont:DisplayObjectContainer, urlReq:URLRequest, loaderContext:LoaderContext = null,
			completeHandler:Function = null, progressHandler:Function = null, ioErrorHandler:Function = null):Loader
		{
			var loader:Loader = create(tcont, completeHandler, progressHandler, ioErrorHandler);
			loader.load(urlReq, loaderContext);
			return loader;
		}


		/**
		 * 로드
		 * <br/>
		 * @param loader: Loader
		 * @param url: Url
		 * @param loaderContext: LoaderContext
		 * @param bUnload: BooleanUnload
		 */
		public static function load(
			loader:Loader, url:String, loaderContext:LoaderContext = null, bUnload:Boolean = false):void
		{
			if (bUnload)
			{
				try
				{
					loader.unloadAndStop(true);
				}
				catch (e:Error) {}
			}

			var ur:URLRequest = new URLRequest(url);
			loader.load(ur, loaderContext);
		}


		/**
		 * 로드 2
		 * <br/>
		 * @param loader: Loader
		 * @param urlReq: URLRequest
		 * @param loaderContext: LoaderContext
		 * @param bUnload: BooleanUnload
		 */
		public static function load2(
			loader:Loader, urlReq:URLRequest, loaderContext:LoaderContext = null, bUnload:Boolean = false):void
		{
			if (bUnload)
			{
				try
				{
					loader.unloadAndStop(true);
				}
				catch (e:Error) {}
			}

			loader.load(urlReq, loaderContext);
		}


		/**
		 * 언로드
		 * <br/>
		 * @param loader: Loader
		 * @param bRemove: BooleanRemove
		 */
		public static function unload(loader:Loader, bRemove:Boolean = false):void
		{
			try
			{
				loader.unloadAndStop(true);
			}
			catch (e:Error) { }

			if (bRemove)
			{
				var dpoc:DisplayObjectContainer = loader.parent;
				if (dpoc != null)
				{
					dpoc.removeChild(loader);
				}
			}
		}

	}
}
