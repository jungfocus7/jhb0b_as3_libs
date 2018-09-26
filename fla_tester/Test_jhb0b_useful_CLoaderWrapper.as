import flash.display.MovieClip;
import flash.events.Event;
import flash.net.URLRequest;
import jhb0b.tools.MDebugTool;
import jhb0b.useful.CLoaderWrapper;


var _owner:MovieClip = this;
var _lw:CLoaderWrapper = new CLoaderWrapper(
		_owner, new URLRequest('Test_jhb0b_useful_CLoaderWrapper_Sub1.swf'),
		function(evt:Event):void
		{
			MDebugTool.test(evt.type);
		}
);
_lw.load();