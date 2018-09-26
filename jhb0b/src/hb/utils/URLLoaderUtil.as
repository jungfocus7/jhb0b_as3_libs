/**
	@Name: URLLoaderUtil
	@Author: HobisJung(jhb0b@naver.com)
	@Date: 2016-01-22
	@Comment:
	{
	}
	@Using:
	{

import flash.events.Event;
import flash.net.URLLoader;
import hb.utils.URLLoaderUtil;


// :: XML로드하기
URLLoaderUtil.createAndLoad('URLLoaderUtil.xml',
	function(event:Event):void
	{
		var t_ur:URLLoader = event.currentTarget as URLLoader;
		var t_xml:XML = new XML(t_ur.data);
		trace('t_xml: ' + t_xml);
	}
);

	}
*/
package hb.utils
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;


	public final class URLLoaderUtil
	{
		// :: 생성자 사용안됨
		public function URLLoaderUtil()
		{
		}


		// :: URLLoader IOError
		private static function p_ul_ioError(event:IOErrorEvent):void
		{
			var t_ul:URLLoader = event.currentTarget as URLLoader;
			t_ul.removeEventListener(event.type, p_ul_ioError);

			trace('p_ul_ioError');
		}

		/**
			// 사용법
			URLLoaderUtil.create(
				// 완료 핸들러
				//completeHandler:Function,

				// 진행 핸들러
				//progressHandler:Function,

				// 실패 핸들러
				//ioErrorHandler:Function
			);
		*/
		// :: URLLoader 생성
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

		// :: URLLoader 생성 후 로드
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
		
		
		// ::
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
