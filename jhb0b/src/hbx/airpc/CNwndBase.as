package hbx.airpc
{
	import flash.desktop.NativeApplication;
	import flash.display.NativeWindow;
	import flash.events.Event;
	import flash.filesystem.File;

	import hbx.core.CSpriteCore;



	public class CNwndBase extends CSpriteCore
	{
		public function CNwndBase()
		{
		}

		protected override function ppInitOnce(evt:Event):void
		{
			super.ppInitOnce(evt);

			_napp = NativeApplication.nativeApplication;
			_nwnd = _stage.nativeWindow;
			_appdf = MFileHelper.get_applicationDirectory();
		}

		protected var _napp:NativeApplication;
		protected var _nwnd:NativeWindow;
		protected var _appdf:File;

	}
}