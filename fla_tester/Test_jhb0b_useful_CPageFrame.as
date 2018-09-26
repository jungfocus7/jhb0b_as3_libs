import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import jhb0b.events.CBumEvent;
import jhb0b.useful.CPageFrame;



var _owner:MovieClip = this;
_owner.stop();
var _pf:CPageFrame  = new CPageFrame(_owner.mc_RectCont);
_pf.addEventListener(CPageFrame.ET_FrameClear,
	function(evt:CBumEvent):void
	{
		trace(evt.type);
	});
_pf.addEventListener(CPageFrame.ET_FrameInit,
	function(evt:CBumEvent):void
	{
		trace(evt.type);
	});	
	
SimpleButton(_owner.bt_1).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pf.goto(1);
	});
SimpleButton(_owner.bt_2).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pf.goto(2);
	});
SimpleButton(_owner.bt_3).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pf.goto(3);
	});
SimpleButton(_owner.bt_4).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pf.goto(4);
	});
SimpleButton(_owner.bt_5).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pf.goto(5);
	});
SimpleButton(_owner.bt_6).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pf.prev();
	});
SimpleButton(_owner.bt_7).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pf.next();
	});
SimpleButton(_owner.bt_8).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pf.close();
	});
SimpleButton(_owner.bt_9).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_pf.refresh();
	});

