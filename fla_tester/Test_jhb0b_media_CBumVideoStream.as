import flash.display.MovieClip;
import jhb0b.media.CBumVideoStream;
import flash.media.Video;


var _owner:MovieClip = this;
var _bvsRoot:CBumVideoStream;
SimpleButton(_owner.bt_1).addEventListener(MouseEvent.CLICK,
	function(tevt:MouseEvent):void
	{
		if (_bvsRoot == null)
		{
			_bvsRoot = new CBumVideoStream();
			_bvsRoot.autoPlay = true;
			var tvd:Video = _bvsRoot.getVideo();
			tvd.width = 800; tvd.height = 560;
			_owner.addChild(tvd);
			_bvsRoot.open('Test_jhb0b_media_CBumVideoStream_Video.mp4');
		}
	});
SimpleButton(_owner.bt_2).addEventListener(MouseEvent.CLICK,
	function(tevt:MouseEvent):void
	{
		if (_bvsRoot == null) return;
		_bvsRoot.dispose();
		_bvsRoot = null;
	});
	
SimpleButton(_owner.bt_1).dispatchEvent(new MouseEvent(MouseEvent.CLICK));

