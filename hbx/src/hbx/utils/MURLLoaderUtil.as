package hbx.utils
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	import hbx.tools.MDebugTool;



	public final class MURLLoaderUtil
	{
		/**
		 * URLLoader IOErrorHandler
		 * <br/>
		 * @param evt: Event
		 */
		private static function pp_uld_ioError(evt:IOErrorEvent):void
		{
			var uld:URLLoader = evt.currentTarget as URLLoader;
			uld.removeEventListener(evt.type, pp_uld_ioError);

			MDebugTool.test('MURLLoaderUtil.pp_ul_ioError');
		}


		/**
		 * URLLoader 생성
		 * <br/>
		 * @param completeHandler: EventHandler
		 * @param progressHandler: EventHandler
		 * @param ioErrorHandler: EventHandler
		 */
		public static function create(
			completeHandler:Function = null, progressHandler:Function = null, ioErrorHandler:Function = null):URLLoader
		{
			var uld:URLLoader = new URLLoader();

			if (completeHandler != null)
				uld.addEventListener(Event.COMPLETE, completeHandler);

			if (progressHandler != null)
				uld.addEventListener(ProgressEvent.PROGRESS, progressHandler);

			if (ioErrorHandler != null)
				uld.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			else
				uld.addEventListener(IOErrorEvent.IO_ERROR, pp_uld_ioError);

			return uld;
		}


		/**
		 * URLLoader 생성 후 로드
		 * <br/>
		 * @param url: UrlString
		 * @param completeHandler: EventHandler
		 * @param progressHandler: EventHandler
		 * @param ioErrorHandler: EventHandler
		 */
		public static function createAndLoad(url:String,
			completeHandler:Function = null, progressHandler:Function = null, ioErrorHandler:Function = null):URLLoader
		{
			var uld:URLLoader = create(completeHandler, progressHandler, ioErrorHandler);
			var ureq:URLRequest = new URLRequest(url);
			uld.load(ureq);

			return uld;
		}


		/**
		 * URLLoader 생성 후 로드 2
		 * <br/>
		 * @param ureq: URLRequest
		 * @param completeHandler: EventHandler
		 * @param progressHandler: EventHandler
		 * @param ioErrorHandler: EventHandler
		 */
		public static function createAndLoad2(ureq:URLRequest,
			completeHandler:Function = null, progressHandler:Function = null, ioErrorHandler:Function = null):URLLoader
		{
			var uld:URLLoader = create(completeHandler, progressHandler, ioErrorHandler);
			uld.load(ureq);

			return uld;
		}

	}
}
