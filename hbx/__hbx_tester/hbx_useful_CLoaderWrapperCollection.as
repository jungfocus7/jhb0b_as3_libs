import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.Event;
import flash.net.URLRequest;
import hbx.core.CEventCore;
import hbx.tools.MDebugTool;
import hbx.useful.CLoaderWrapper;
import hbx.useful.CLoaderWrapperCollection;




var _thm:MovieClip = this;


function pp_lw_comp(evt:Event):void
{
	MDebugTool.test('pp_lw_comp');
}


var _lwc:CLoaderWrapperCollection =
	new CLoaderWrapperCollection(
		[
			new CLoaderWrapper(_thm, new URLRequest('hbx_useful_CLoaderWrapper_sub1.swf'), pp_lw_comp),
			new CLoaderWrapper(_thm, new URLRequest('hbx_useful_CLoaderWrapper_sub2.swf'), pp_lw_comp),
			new CLoaderWrapper(_thm, new URLRequest('hbx_useful_CLoaderWrapper_sub3.swf'), pp_lw_comp)
		]);
_lwc.addEventListener(CLoaderWrapperCollection.ET_COMPLETE_ALL,
	function(evt:CEventCore):void
	{
		MDebugTool.test(
			'CLoaderWrapperCollection: ' + evt.type +
			', Count: ' + _lwc.get_count() +
			', CountEnd: ' + _lwc.get_countEnd());
	}
);
_lwc.addEventListener(CLoaderWrapperCollection.ET_COMPLETE,
	function(evt:CEventCore):void
	{
		var dpo:DisplayObject = _lwc.get_lw().get_loaderContent();
		dpo.x = 200 * _lwc.get_idx();
		dpo.y = 200 * _lwc.get_idx();
		
		MDebugTool.test(
			'CLoaderWrapperCollection: ' + evt.type +
			', Index: ' + _lwc.get_idx() +
			', Count: ' + _lwc.get_count() +
			', CountEnd: ' + _lwc.get_countEnd());
	}
);
_lwc.load();

