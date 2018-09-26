import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.Event;
import flash.events.MouseEvent;
import jhb0b.media.CBumFramePlayer;




var _owner:MovieClip = this;
var _bfpRoot:CBumFramePlayer;

SimpleButton(_owner.bt_1).addEventListener(MouseEvent.CLICK,
	function(tevt:MouseEvent):void
	{
		if (_bfpRoot == null)
		{
			_bfpRoot = new CBumFramePlayer(_owner);
			_bfpRoot.set_autoPlay(true);
			_bfpRoot.getLoader().contentLoaderInfo.addEventListener(Event.COMPLETE,
				function(evt:Event):void
				{
					var tmc:MovieClip = MovieClip(_bfpRoot.getLoader().content);
					tmc.width = 800; tmc.height = 546;
				});
		}
	});
SimpleButton(_owner.bt_2).addEventListener(MouseEvent.CLICK,
	function(tevt:MouseEvent):void
	{
		if (_bfpRoot == null) return;
		_bfpRoot.dispose();
		_bfpRoot = null;
	});
	
SimpleButton(_owner.bt_3).addEventListener(MouseEvent.CLICK,
	function(tevt:MouseEvent):void
	{
		if (_bfpRoot == null) return;
		_bfpRoot.open('Test_jhb0b_media_CBumFramePlayer_Ani.swf');
	});
SimpleButton(_owner.bt_4).addEventListener(MouseEvent.CLICK,
	function(tevt:MouseEvent):void
	{
		if (_bfpRoot == null) return;
		_bfpRoot.close();
	});


//MLoaderUtil.createAndLoad(_owner.mc_View.mc_MediaCont, 'Test_jhb0b_media_CBumFramePlayer_Ani.swf', null,
//	function(tevt:Event):void
//	{
//		/*
//		_TargetFrame = MovieClip(LoaderInfo(tevt.currentTarget).loader.content);
//		_TargetFrame.visible = false;
//		_TargetFrame.width = 800; _TargetFrame.height = 546;
//		_TargetFrame.gotoAndStop(1);*/
//
//		SimpleButton(_owner.bt_1).addEventListener(MouseEvent.CLICK,
//			function(tevt:MouseEvent):void
//			{
//				if (_bfpRoot == null)
//				{
//					_bfpRoot = new CBumFramePlayer(_owner);
//				}
//			});
//		SimpleButton(_owner.bt_2).addEventListener(MouseEvent.CLICK,
//			function(tevt:MouseEvent):void
//			{
//				if (_bfpRoot == null) return;
//				_bfpRoot.dispose();
//				_bfpRoot = null;
//			});
//		//SimpleButton(_owner.bt_1).dispatchEvent(new MouseEvent(MouseEvent.CLICK));
//	}
//);
