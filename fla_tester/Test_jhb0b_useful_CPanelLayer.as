import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import jhb0b.events.CBumEvent;
import jhb0b.tools.MDebugTool;
import jhb0b.useful.CPanelLayer;
import jhb0b.utils.MTextFieldUtil;



var _owner:MovieClip = this;
var _pl:CPanelLayer  = new CPanelLayer(_owner, 'mc_',
	function(tmc:MovieClip, ti:int):void
	{
		MTextFieldUtil.set_text(tmc, 'tf_1', 'Page - ' + tmc.name);
		tmc.visible = false;
	});
_pl.addEventListener(CPanelLayer.ET_CLOSE,
	function(evt:CBumEvent):void
	{
		//MDebugTool.test(evt.type);
		var t_mc:MovieClip = MovieClip(_pl.get_now());
		t_mc.visible = false;
	});
_pl.addEventListener(CPanelLayer.ET_OPEN,
	function(evt:CBumEvent):void
	{
		//MDebugTool.test(evt.type);
		var t_mc:MovieClip = MovieClip(_pl.get_now());
		t_mc.visible = true;
	});
	

SimpleButton(_owner.bt_7).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pl.prev();
	}
);
SimpleButton(_owner.bt_6).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pl.next();
	}
);
SimpleButton(_owner.bt_5).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pl.unselect();
	}
);

SimpleButton(_owner.bt_4).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pl.select(4);
	}
);
SimpleButton(_owner.bt_3).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pl.select(3);
	}
);
SimpleButton(_owner.bt_2).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pl.select(2);
	}
);
SimpleButton(_owner.bt_1).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pl.select(1);
	}
);

