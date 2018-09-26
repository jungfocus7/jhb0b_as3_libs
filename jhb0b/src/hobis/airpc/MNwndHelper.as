package hobis.airpc
{
	import flash.display.NativeWindow;
	import flash.display.Screen;
	import flash.geom.Rectangle;

	
	public final class MNwndHelper
	{
		public static function align_rightBottom(nwnd:NativeWindow, mw:Number = 40, mh:Number = 40):void
		{
			var tarr:Array = Screen.getScreensForRectangle(nwnd.bounds);
			if ((tarr != null) && (tarr.length > 0))
			{
				var tscr:Screen = tarr[0];
				var tr1:Rectangle = tscr.bounds;
				var tr2:Rectangle = nwnd.bounds;
				tr2.x = (tr1.x + (tr1.width - tr2.width)) - mw;
				tr2.y = (tr1.y + (tr1.height - tr2.height)) - mh;
				nwnd.bounds = tr2;
			}			
		}
	
		public static function align_centerScreen(nwnd:NativeWindow):void
		{
			var tarr:Array = Screen.getScreensForRectangle(nwnd.bounds);
			if ((tarr != null) && (tarr.length > 0))
			{
				var tscr:Screen = tarr[0];
				var tr1:Rectangle = tscr.bounds;
				var tr2:Rectangle = nwnd.bounds;
				tr2.x = Math.round((tr1.width / 2) - (tr2.width / 2));
				tr2.y = Math.round((tr1.height / 2) - (tr2.height / 2));
				nwnd.bounds = tr2;
			}
		}
	}
}