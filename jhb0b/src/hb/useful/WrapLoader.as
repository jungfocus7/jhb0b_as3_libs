/**	
	@Name: WrapLoader
	@Author: HobisJung
	@Date: 2016-05-03
	@Comment: 좀 사용하기 편하게 만든 로더
	@Using:
	{
	}
*/
package hb.useful
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.IOErrorEvent;	
	import flash.events.ProgressEvent;	
	import flash.system.LoaderContext;
	import flash.net.URLRequest;
	import hb.tools.DebugTool;


	public class WrapLoader
	{
		// :: 생성자
		public function WrapLoader(
								container:DisplayObjectContainer,
								urlRequest:URLRequest = null,
								completeHandler:Function = null,
								progressHandler:Function = null,
								ioErrorHandler:Function = null):void
		{
			_loader = new Loader();
			container.addChild(_loader);
				
			if (urlRequest != null)
			{
				_urlRequest = urlRequest;
			}
			
			
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
		
		// - 로더 객체
		private var _loader:Loader = null;		
		
		// :: 로더 컨테이너 반환
		public function get_loaderContainer():DisplayObjectContainer
		{
			return _loader.parent;
		}
		
		// :: 로더 인포 반환
		public function get_loaderInfo():LoaderInfo
		{
			return _loader.contentLoaderInfo;
		}
		
		// :: 로더 객체 반환
		public function get_loader():Loader
		{
			return _loader;
		}
		
		
		// - 완료 핸들러 참조
		private var _completeHandler:Function = null;
		public function get_completeHandler():Function
		{
			return _completeHandler;
		}
		
		// - 진행 핸들러 참조
		private var _progressHandler:Function = null;
		public function get_progressHandler():Function
		{
			return _progressHandler;
		}
		
		// - 에러 핸들러 참조
		private var _ioErrorHandler:Function = null;
		public function get_ioErrorHandler():Function
		{
			return _ioErrorHandler;
		}		

		// :: 에러 핸들러 (기본용)
		private function p_loader_ioError(event:IOErrorEvent):void
		{
			var t_loaderInfo:LoaderInfo = this._loader.contentLoaderInfo;
			t_loaderInfo.removeEventListener(event.type, this.p_loader_ioError);
			
			DebugTool.test('p_loader_ioError');
		}
		
		
		// :: 닫기
		public function close(gc:Boolean = true):void
		{
			try
			{
				_loader.close();
			}
			catch (e:Error) {}
			
			_loader.unloadAndStop(gc);
		}
		
		// - Url 객체
		private var _urlRequest:URLRequest = null;
		public function get_urlRequest():URLRequest
		{
			return _urlRequest;
		}

		// :: 로드
		public function load(urlRequest:URLRequest = null, lc:LoaderContext = null):void
		{
			this.close();
			
			if (urlRequest != null)
			{
				_urlRequest = urlRequest;
				_loader.load(_urlRequest, lc);
			}
			else
			{
				if (_urlRequest != null)
				{
					_loader.load(_urlRequest, lc);
				}
			}
		}
		
		// :: 로드_a
		public function load_a(url:String, lc:LoaderContext = null):void
		{
			_urlRequest = new URLRequest(url);
			this.load(_urlRequest, lc);
		}
		

		// :: 객체 폐기(재사용 안됨)
		public function dispose():void
		{
			this.close();
			
			var t_loaderInfo:LoaderInfo = this._loader.contentLoaderInfo;
			
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
			
			var t_loaderCont:DisplayObjectContainer = _loader.parent;
			if (t_loaderCont != null)
			{
				t_loaderCont.removeChild(_loader);
			}
			
			_urlRequest = null;
			_loader = null;
		}
	}
}
