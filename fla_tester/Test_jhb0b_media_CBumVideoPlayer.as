import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.media.Video;
import jhb0b.media.CBumVideoPlayer;
import jhb0b.media.CBumVideoStream;



var _owner:MovieClip = this;
var _bvpRoot:CBumVideoPlayer;


SimpleButton(_owner.bt_1).addEventListener(MouseEvent.CLICK,
	function(tevt:MouseEvent):void
	{
		if (_bvpRoot == null)
		{
			_bvpRoot = new CBumVideoPlayer(_owner);
			_bvpRoot.set_autoPlay(true);
			var tbvs:CBumVideoStream = _bvpRoot.getVideoStream();
			var tvd:Video = tbvs.getVideo();
			tvd.width = 800;
			tvd.height = 560;
		}
	});
SimpleButton(_owner.bt_2).addEventListener(MouseEvent.CLICK,
	function(tevt:MouseEvent):void
	{
		if (_bvpRoot == null) return;
		_bvpRoot.dispose();
		_bvpRoot = null;
	});
	
SimpleButton(_owner.bt_3).addEventListener(MouseEvent.CLICK,
	function(tevt:MouseEvent):void
	{
		if (_bvpRoot == null) return;
		_bvpRoot.open('Test_jhb0b_media_CBumVideoStream_Video.mp4');
	});
SimpleButton(_owner.bt_4).addEventListener(MouseEvent.CLICK,
	function(tevt:MouseEvent):void
	{
		if (_bvpRoot == null) return;
		_bvpRoot.close();
	});


