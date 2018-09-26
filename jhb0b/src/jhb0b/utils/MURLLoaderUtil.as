package jhb0b.utils
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import jhb0b.tools.MDebugTool;


	public final class MURLLoaderUtil
	{
		//:: URLLoader IOError
		private static function p_ul_ioError(event:IOErrorEvent):void
		{
			var t_ul:URLLoader = event.currentTarget as URLLoader;
			t_ul.removeEventListener(event.type, p_ul_ioError);

			MDebugTool.test('MURLLoaderUtil.p_ul_ioError');
		}

		//:: URLLoader 생성
		public static function create(
								completeHandler:Function = null,
								progressHandler:Function = null,
								ioErrorHandler:Function = null):URLLoader
		{
			var t_ul:URLLoader = new URLLoader();

			if (completeHandler != null)
			{
				t_ul.addEventListener(Event.COMPLETE, completeHandler);
			}

			if (progressHandler != null)
			{
				t_ul.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			}

			if (ioErrorHandler != null)
			{
				t_ul.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			}
			else
			{
				t_ul.addEventListener(IOErrorEvent.IO_ERROR, p_ul_ioError);
			}

			return t_ul;
		}

		//:: URLLoader 생성 후 로드
		public static function createAndLoad(
								url:String,
								completeHandler:Function = null,
								progressHandler:Function = null,
								ioErrorHandler:Function = null):URLLoader
		{
			var t_ul:URLLoader = create(completeHandler, progressHandler, ioErrorHandler);
			var t_ur:URLRequest = new URLRequest(url);
			t_ul.load(t_ur);

			return t_ul;
		}

		//::
		public static function createAndLoad_a(
								ur:URLRequest,
								completeHandler:Function = null,
								progressHandler:Function = null,
								ioErrorHandler:Function = null):URLLoader
		{
			var t_ul:URLLoader = create(completeHandler, progressHandler, ioErrorHandler);
			t_ul.load(ur);

			return t_ul;
		}
	}
}
