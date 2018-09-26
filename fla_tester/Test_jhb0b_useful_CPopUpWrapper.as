import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import jhb0b.events.CBumEvent;
import jhb0b.useful.CPopUpWrapper;
import jhb0b.tools.MDebugTool;



var _owner:MovieClip = this;
var _pw:CPopUpWrapper = new CPopUpWrapper(_owner.mc_popUp);
_pw.addEventListener(CPopUpWrapper.ET_OPEN, 
	function(evt:CBumEvent):void
	{
		MDebugTool.test(evt.type);
	}
);

SimpleButton(_owner.bt_4).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pw.open('#01');
	}
);
SimpleButton(_owner.bt_3).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pw.open('#02');
	}
);
SimpleButton(_owner.bt_2).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pw.open('#03');
	}
);
SimpleButton(_owner.bt_1).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pw.close();
	}
);
