import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import hbx.useful.CCountTask;
import hbx.utils.MStringUtil;
import hbx.tools.MDebugTool;



var _thmvc:MovieClip = this;

var _ct:CCountTask = new CCountTask(0, 10, 1);
SimpleButton(_thmvc.btn_1).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void {
		if (!_ct.is_last())
		{
			MDebugTool.test('Counting~~  ' +
				'Count: ' + MStringUtil.rmfill(_ct.get_count().toString(), '00') + ' / ' +
				'CountEnd: ' + _ct.get_countEnd());
		}
	});
SimpleButton(_thmvc.btn_2).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void {
		_ct.reset();
		MDebugTool.test('Reset~~  ' +
			'Count: ' + MStringUtil.rmfill(_ct.get_count().toString(), '00') + ' / ' +
			'CountEnd: ' + _ct.get_countEnd());
	});

















/*
import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.system.LoaderContext;
import hbx.common.CCallback;
import hbx.utils.MLoaderUtil;
import hbx.utils.MTextFieldUtil;
import hbx.utils.MStringUtil;




var _thm:MovieClip = this;


(function():void {
	//trace(MStringUtil.add_url(_thm.loaderInfo.url, false, '/common_code_view.swf'));
	var url:String = _thm.loaderInfo.url;
	var ldc:LoaderContext = new LoaderContext();
	ldc.parameters = { url: url };
	MLoaderUtil.createAndLoad(_thm, MStringUtil.add_url(url, false, '/common_code_view.swf'), ldc); 
})();


MTextFieldUtil.clear_text(_thm, 'tf_1');
SimpleButton(_thm.btn_1).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		var cb:CCallback = new CCallback(
			function():void
			{
				trace(this, arguments);
				MTextFieldUtil.set_text(_thm, 'tf_1', arguments.toString());
			}, ['a', 'b', 'c'], _thm);
		cb.invoke([1, 2, 3]);			
	});

*/