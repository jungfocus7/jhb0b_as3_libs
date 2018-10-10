package hobis.airpc
{
	import flash.desktop.NativeApplication;
	import flash.display.NativeWindow;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.filesystem.File;

	import jhb0b.core.CSpriteCore;


	public class CNwndBase extends CSpriteCore
	{
		public function CNwndBase()
		{
			if (this.stage == null)
				this.addEventListener(Event.ADDED_TO_STAGE, ppInitOnce);
			else
				ppInitOnce(null);
		}

		protected function ppInitOnce(evt:Event):void
		{
			_napp = NativeApplication.nativeApplication;
			_nwnd = _stage.nativeWindow;
			_appdf = new File(File.applicationDirectory.nativePath);

			//_nwnd.title = 'CNwndBase~~';
			//MNwndHelper.align_rightBottom(_nwnd, 100, 100);
		}

		protected var _napp:NativeApplication;
		protected var _nwnd:NativeWindow;
		protected var _appdf:File;
	}
}