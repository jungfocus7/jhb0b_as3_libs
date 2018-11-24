import flash.display.Loader;
import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.Event;
import flash.events.MouseEvent;
import hbx.utils.MLoaderUtil;
import hbx.utils.MStringUtil;
import hbx.tools.MDebugTool;



var _thm:MovieClip = this;
var _loader:Loader;


SimpleButton(_thm.bt_2).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		if (_loader == null)
		{
			var thisUrl:String = MStringUtil.decode_url(_thm.loaderInfo.url);
			var baseUrl:String = MStringUtil.get_baseUrl(thisUrl);
			var thisName:String = MStringUtil.get_thisName(thisUrl);
			var url:String = baseUrl + '/' + thisName + '_ani.swf';
			MDebugTool.test('thisUrl: ' + thisUrl);
			MDebugTool.test('baseUrl: ' + baseUrl);
			MDebugTool.test('thisName: ' + thisName);			
			MDebugTool.test('url: ' + url);
			
			_loader = MLoaderUtil.createAndLoad(_thm.mc_cont, url, null,
				function(evt:Event):void
				{
					trace(evt.type);
				});
			
			MDebugTool.test('_thm.mc_cont.numChildren: ' + _thm.mc_cont.numChildren);
		}
	}
);

SimpleButton(_thm.bt_1).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		if (_loader == null) return;
		MLoaderUtil.unload(_loader, true);
		_loader = null;
	}
);
