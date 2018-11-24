import flash.display.Loader;
import flash.display.MovieClip;
import flash.events.MouseEvent;
import hbx.utils.MLoaderUtil;
import hbx.utils.MMovieClipUtil;
import hbx.utils.MStringUtil;
import hbx.tools.MDebugTool;



var _thm:MovieClip = this;
var _loader:Loader;



MMovieClipUtil.add_clickHandler_roo(_thm.mc_3,
	function(evt:MouseEvent):void
	{
		if (_loader == null) return;
		var mvcAni:MovieClip = MovieClip(_loader.content);
		MDebugTool.test(MMovieClipUtil.get_frameLabelToFrame(mvcAni, '#01').toString());
		MDebugTool.test(MMovieClipUtil.get_frameLabelToFrame(mvcAni, '#02').toString());
		MDebugTool.test(MMovieClipUtil.get_frameLabelToFrame(mvcAni, '#03').toString());
		MDebugTool.test(MMovieClipUtil.get_frameLabelToFrame(mvcAni, '#04').toString());
		MDebugTool.test(MMovieClipUtil.get_frameLabelCount(mvcAni, '#0').toString());
	}
);

MMovieClipUtil.add_clickHandler_roo(_thm.mc_2,
	function(evt:MouseEvent):void
	{
		if (_loader == null)
		{		
//			var thisUrl:String = MStringUtil.encode_url(_thm.loaderInfo.url);
//			var baseUrl:String = MStringUtil.get_baseUrl(thisUrl);
//			var thisName:String = MStringUtil.get_thisName(thisUrl);
//			var url:String = baseUrl + thisName + '_ani.swf';
			var url:String = MStringUtil.add_ext(_thm.loaderInfo.url, false, '_ani.swf');
			MDebugTool.test('url: ' + url);
			_loader = MLoaderUtil.createAndLoad(
				_thm.mc_cont, url, null,
				function(evt:Event):void
				{
					MDebugTool.test(evt.type);
					var mvcAni:MovieClip = MovieClip(_loader.content);
					mvcAni.gotoAndStop(1);
					MMovieClipUtil.delayExcute(_thm,
						function(ani:MovieClip):void
						{
							ani.gotoAndStop('#03');
						}, [mvcAni], 30 * 3);
				}
			);
		}
	}
);

MMovieClipUtil.add_clickHandler_roo(_thm.mc_1,
	function(evt:MouseEvent):void
	{
		if (_loader == null) return;
		MMovieClipUtil.delayExcute_stop(_thm);
		MLoaderUtil.unload(_loader, true);
		_loader = null;
	}
);



