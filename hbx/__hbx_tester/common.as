import flash.display.MovieClip;
import flash.system.LoaderContext;
import hbx.utils.MLoaderUtil;
import hbx.utils.MStringUtil;



(function(thm:MovieClip):void
{
	var url:String = thm.loaderInfo.url;
	var ldc:LoaderContext = new LoaderContext();
	ldc.parameters = { url: url };
	MLoaderUtil.createAndLoad(thm.stage, MStringUtil.add_url(url, false, '/code_view.swf'), ldc);
	
})(this);


/*
include './common.as';
include './hbx_common_CCallback.as';



*/
