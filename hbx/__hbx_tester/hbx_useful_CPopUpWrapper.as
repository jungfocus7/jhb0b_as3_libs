import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import hbx.core.CEventCore;
import hbx.useful.CPopUpWrapper;
import hbx.tools.MDebugTool;



var _thm:MovieClip = this;
var _pw:CPopUpWrapper = new CPopUpWrapper(_thm.mc_popUp);
_pw.addEventListener(CPopUpWrapper.ET_OPEN, 
	function(evt:CEventCore):void
	{
		MDebugTool.test(evt.type);
	}
);

SimpleButton(_thm.bt_4).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pw.open('#01');
	}
);
SimpleButton(_thm.bt_3).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pw.open('#02');
	}
);
SimpleButton(_thm.bt_2).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pw.open('#03');
	}
);
SimpleButton(_thm.bt_1).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pw.close();
	}
);
