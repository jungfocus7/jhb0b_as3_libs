/**
	@Name: LoaderUtil
	@Author: HobisJung(jhb0b@naver.com)
	@Date: 2016-01-22
	@Comment:
	{
	}
	@Using:
	{
		import flash.display.Loader;
		import flash.events.Event;
		import flash.events.IOErrorEvent;
		import flash.events.ProgressEvent;
		import flash.net.URLRequest;
		import hb.utils.LoaderUtil;

		var m_loader:Loader = LoaderUtil.create(this,
			function(event:Event):void
			{
				trace('event.type: ' + event.type);
			},
			function(event:ProgressEvent):void
			{
				trace('event.type: ' + event.type);
			},
			function(event:IOErrorEvent):void
			{
				trace('event.type: ' + event.type);
			}
		);
		this.m_loader.load(new URLRequest('LoaderUtil_Sub.swf'));

		LoaderUtil.createAndLoad(this, 'LoaderUtil_Sub.swf', null,
			function(event:Event):void
			{
				trace('event.type: ' + event.type);
			},
			function(event:ProgressEvent):void
			{
				trace('event.type: ' + event.type);
			},
			function(event:IOErrorEvent):void
			{
				trace('event.type: ' + event.type);
			}
		);
	}
*/
package hb.utils
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.system.LoaderContext;
	import flash.net.URLRequest;


	public final class LoaderUtil
	{
		// :: 생성자 사용안됨
		public function LoaderUtil()
		{
		}


		// :: 로더 에러
		private static function p_loader_ioError(event:IOErrorEvent):void
		{
			var t_loaderInfo:LoaderInfo = event.currentTarget as LoaderInfo;
			t_loaderInfo.removeEventListener(event.type, p_loader_ioError);

			trace('p_loader_ioError');
		}

		/**
			// 사용법
			LoaderUtil.create(
				// 로더 컨테이너
				//container:DisplayObjectContainer,

				// 로더 완료 핸들러
				completeHandler:Function,

				// 로더 진행 핸들러
				progressHandler:Function,

				// 로더 실패 핸들러
				ioErrorHandler:Function
			);
		*/
		// :: 로더 생성
		public static function create(
									container:DisplayObjectContainer,
									completeHandler:Function = null,
									progressHandler:Function = null,
									ioErrorHandler:Function = null):Loader
		{
			var t_loader:Loader = new Loader();
			var t_loaderInfo:LoaderInfo = t_loader.contentLoaderInfo;

			if (container != null)
			{
				container.addChild(t_loader);
			}

			if (completeHandler != null)
			{
				t_loaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			}

			if (progressHandler != null)
			{
				t_loaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			}

			if (ioErrorHandler != null)
			{
				t_loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			}
			else
			{
				t_loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, p_loader_ioError);
			}

			return t_loader;
		}

		/**
			// 사용법
			LoaderUtil.createAndLoad(
				// 로더 컨테이너
				container:DisplayObjectContainer,

				// 로더 url
				url:String,

				// 로더 컨텍스트
				loaderContext:LoaderContext,

				// 로더 완료 핸들러
				completeHandler:Function,

				// 로더 진행 핸들러
				progressHandler:Function,

				// 로더 실패 핸들러
				ioErrorHandler:Function
			);
		*/
		// :: 로더 생성후 로드
		public static function createAndLoad(
									container:DisplayObjectContainer,
									url:String,
									loaderContext:LoaderContext = null,
									completeHandler:Function = null,
									progressHandler:Function = null,
									ioErrorHandler:Function = null):Loader
		{
			var t_loader:Loader = create(container, completeHandler, progressHandler, ioErrorHandler);
			var t_ur:URLRequest = new URLRequest(url);
			t_loader.load(t_ur, loaderContext);
			
			return t_loader;
		}

		// :: 로드
		public static function load(
								loader:Loader,
								url:String,
								loaderContext:LoaderContext = null,
								isUnload:Boolean = true):void
		{
			if (isUnload)
			{
				try
				{
					loader.unloadAndStop(true);
				}
				catch (e:Error)
				{
				}
			}

			var t_ur:URLRequest = new URLRequest(url);
			loader.load(t_ur, loaderContext);
		}
	}
}
