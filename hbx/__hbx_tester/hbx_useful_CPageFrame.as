import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import hbx.core.CEventCore;
import hbx.useful.CPageFrame;





var _thm:MovieClip = this;
_thm.stop();


var _pf:CPageFrame  = new CPageFrame(_thm.mc_RectCont);
_pf.addEventListener(CPageFrame.ET_FrameClear,
	function(evt:CEventCore):void
	{
		trace(evt.type);
	});
_pf.addEventListener(CPageFrame.ET_FrameInit,
	function(evt:CEventCore):void
	{
		trace(evt.type);
	});	
	
SimpleButton(_thm.bt_1).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pf.gotop(1);
	});
SimpleButton(_thm.bt_2).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pf.gotop(2);
	});
SimpleButton(_thm.bt_3).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pf.gotop(3);
	});
SimpleButton(_thm.bt_4).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pf.gotop(4);
	});
SimpleButton(_thm.bt_5).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pf.gotop(5);
	});
SimpleButton(_thm.bt_6).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pf.prev();
	});
SimpleButton(_thm.bt_7).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pf.next();
	});
SimpleButton(_thm.bt_8).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pf.close();
	});
SimpleButton(_thm.bt_9).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pf.refresh();
	});

