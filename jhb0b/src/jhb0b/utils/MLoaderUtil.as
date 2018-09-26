package jhb0b.utils
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import jhb0b.tools.MDebugTool;


	public final class MLoaderUtil
	{
		//:: 로더 에러
		private static function p_loader_ioError(evt:IOErrorEvent):void
		{
			var t_loaderInfo:LoaderInfo = LoaderInfo(evt.currentTarget);
			t_loaderInfo.removeEventListener(evt.type, p_loader_ioError);

			MDebugTool.test('p_loader_ioError');
		}

		//:: 로더 생성
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

		//:: 로더 생성후 로드
		public static function createAndLoad(
								container:DisplayObjectContainer,
								url:String,
								loaderContext:LoaderContext = null,
								completeHandler:Function = null,
								progressHandler:Function = null,
								ioErrorHandler:Function = null):Loader
		{
			var t_loader:Loader = create(
					container, completeHandler, progressHandler, ioErrorHandler);
			var t_ur:URLRequest = new URLRequest(url);
			t_loader.load(t_ur, loaderContext);

			return t_loader;
		}

		//:: 로드
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
				catch (e:Error) {}
			}

			var t_ur:URLRequest = new URLRequest(url);
			loader.load(t_ur, loaderContext);
		}

		//::
		public static function unload(loader:Loader, isRemove:Boolean = false):void
		{
			try
			{
				loader.unloadAndStop(true);
			}
			catch (e:Error) { }

			if (isRemove)
			{
				var t_doc:DisplayObjectContainer = loader.parent;
				if (t_doc != null)
				{
					t_doc.removeChild(loader);
				}
			}
		}
	}
}
