import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import hbx.core.CEventCore;
import hbx.tools.MDebugTool;
import hbx.useful.CPanelLayer;
import hbx.utils.MTextFieldUtil;



var _thm:MovieClip = this;
var _pl:CPanelLayer  = new CPanelLayer(_thm, 'mc_',
	function(tmc:MovieClip, ti:int):void
	{
		MTextFieldUtil.set_text(tmc, 'tf_1', 'Page - ' + tmc.name);
		tmc.visible = false;
	});
_pl.addEventListener(CPanelLayer.ET_CLOSE,
	function(evt:CEventCore):void
	{
		//MDebugTool.test(evt.type);
		var t_mc:MovieClip = MovieClip(_pl.get_now());
		t_mc.visible = false;
	});
_pl.addEventListener(CPanelLayer.ET_OPEN,
	function(evt:CEventCore):void
	{
		//MDebugTool.test(evt.type);
		var t_mc:MovieClip = MovieClip(_pl.get_now());
		t_mc.visible = true;
	});
	

SimpleButton(_thm.bt_7).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pl.prev();
	}
);
SimpleButton(_thm.bt_6).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pl.next();
	}
);
SimpleButton(_thm.bt_5).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pl.unselect();
	}
);

SimpleButton(_thm.bt_4).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pl.select(4);
	}
);
SimpleButton(_thm.bt_3).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pl.select(3);
	}
);
SimpleButton(_thm.bt_2).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pl.select(2);
	}
);
SimpleButton(_thm.bt_1).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pl.select(1);
	}
);

