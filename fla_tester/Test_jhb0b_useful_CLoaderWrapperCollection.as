import flash.display.MovieClip;
import flash.events.Event;
import flash.net.URLRequest;
import jhb0b.tools.MDebugTool;
import jhb0b.useful.CLoaderWrapper;
import jhb0b.useful.CLoaderWrapperCollection;
import jhb0b.events.CBumEvent;


var _owner:MovieClip = this;


function p_lw_c(evt:Event):void
{
	MDebugTool.test('CLoaderWrapper: ' + evt.type);
}

var _lwc:CLoaderWrapperCollection =
	new CLoaderWrapperCollection(
		[
			new CLoaderWrapper(_owner, new URLRequest('Test_jhb0b_useful_CLoaderWrapper_Sub1.swf'), p_lw_c),
			new CLoaderWrapper(_owner, new URLRequest('Test_jhb0b_useful_CLoaderWrapper_Sub2.swf'), p_lw_c),
			new CLoaderWrapper(_owner, new URLRequest('Test_jhb0b_useful_CLoaderWrapper_Sub3.swf'), p_lw_c)
		]);
_lwc.addEventListener(CLoaderWrapperCollection.ET_COMPLETE,
	function(evt:CBumEvent):void
	{
		MDebugTool.test('CLoaderWrapperCollection: ' + evt.type);
		//_lwc.load();
	}
);
_lwc.load();

