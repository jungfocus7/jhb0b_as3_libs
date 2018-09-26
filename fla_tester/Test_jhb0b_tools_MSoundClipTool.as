import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import jhb0b.tools.MSoundClipTool;


var _owner:MovieClip = this;

SimpleButton(_owner.bt_5).addEventListener(
	MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		MSoundClipTool.play(_owner, 'se_1', '#_13', true);
	}
);
SimpleButton(_owner.bt_4).addEventListener(
	MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		MSoundClipTool.play(_owner, 'se_1', '#_4', true);
	}
);
SimpleButton(_owner.bt_3).addEventListener(
	MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		MSoundClipTool.play(_owner, 'se_1', '#_5', true);
	}
);
SimpleButton(_owner.bt_2).addEventListener(
	MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		MSoundClipTool.play(_owner, 'se_1', '#_6', true);
	}
);
SimpleButton(_owner.bt_1).addEventListener(
	MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		MSoundClipTool.stop(_owner, 'se_1');
	}
);
