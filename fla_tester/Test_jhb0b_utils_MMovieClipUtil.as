import flash.display.Loader;
import flash.display.MovieClip;
import flash.events.MouseEvent;
import jhb0b.utils.MLoaderUtil;
import jhb0b.utils.MMovieClipUtil;
import jhb0b.utils.MStringUtil;
import jhb0b.tools.MDebugTool;



var _owner:MovieClip = this;
var _loader:Loader;

MMovieClipUtil.add_clickHandler_roo(_owner.mc_3,
	function(evt:MouseEvent):void
	{
		if (_loader == null) return;
		var t_ani:MovieClip = MovieClip(_loader.content);
		MDebugTool.test(MMovieClipUtil.get_frameLabelToFrame(t_ani, '#01').toString());
		MDebugTool.test(MMovieClipUtil.get_frameLabelToFrame(t_ani, '#02').toString());
		MDebugTool.test(MMovieClipUtil.get_frameLabelToFrame(t_ani, '#03').toString());
		MDebugTool.test(MMovieClipUtil.get_frameLabelToFrame(t_ani, '#04').toString());
		MDebugTool.test(MMovieClipUtil.get_frameLabelCount(t_ani, '#0').toString());
	}
);

MMovieClipUtil.add_clickHandler_roo(_owner.mc_2,
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
					MDebugTool.test(evt.type);
					var t_ani:MovieClip = MovieClip(_loader.content);
					t_ani.gotoAndStop(1);
					MMovieClipUtil.delayExcute(_owner,
						function(ani:MovieClip):void
						{
							ani.gotoAndStop('#03');
						}, [t_ani], 30 * 3);
				}
			);
		}
	}
);

MMovieClipUtil.add_clickHandler_roo(_owner.mc_1,
	function(evt:MouseEvent):void
	{
		if (_loader == null) return;
		MMovieClipUtil.delayExcute_stop(_owner);
		MLoaderUtil.unload(_loader, true);
		_loader = null;
	}
);

