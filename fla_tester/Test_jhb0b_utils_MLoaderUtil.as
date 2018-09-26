import flash.display.Loader;
import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.Event;
import flash.events.MouseEvent;
import jhb0b.utils.MLoaderUtil;
import jhb0b.utils.MStringUtil;
import jhb0b.tools.MDebugTool;



var _owner:MovieClip = this;
var _loader:Loader;

SimpleButton(_owner.bt_2).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		if (_loader == null)
		{
			var t_thisUrl:String = MStringUtil.get_thisUrl(_owner.loaderInfo.url);
			var t_baseUrl:String = MStringUtil.get_baseUrl(t_thisUrl);
			var t_thisName:String = MStringUtil.get_thisName(t_thisUrl);
			var t_url:String = t_baseUrl + t_thisName + '_Ani.swf';
			MDebugTool.test('t_url: ' + t_url);
			_loader = MLoaderUtil.createAndLoad(
				_owner.mc_cont, t_url, null,
				function(evt:Event):void
				{
					trace(evt.type);
				}
			);
			
			trace(_owner.mc_cont.numChildren);
		}
	}
);

SimpleButton(_owner.bt_1).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		if (_loader == null) return;
		MLoaderUtil.unload(_loader, true);
		_loader = null;
	}
);
