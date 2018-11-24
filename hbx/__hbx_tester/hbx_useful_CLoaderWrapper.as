import flash.display.MovieClip;
import flash.events.Event;
import flash.net.URLRequest;
import hbx.tools.MDebugTool;
import hbx.useful.CLoaderWrapper;


var _thm:MovieClip = this;
var _lw:CLoaderWrapper = new CLoaderWrapper(
		_thm, new URLRequest('hbx_useful_CLoaderWrapper_sub1.swf'),
		function(evt:Event):void
		{
			MDebugTool.test(evt.type);
		}
);
_lw.load();