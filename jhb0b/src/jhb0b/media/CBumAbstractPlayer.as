package jhb0b.media
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import jhb0b.core.CContainerBase;
	import jhb0b.events.CBumEvent;
	import jhb0b.whats.CBumButton;
	import jhb0b.whats.CBumSliderFrame;


	public class CBumAbstractPlayer extends CContainerBase
	{
		override public function dispose():void
		{
			if (_cont == null) return;

			_bbPlayPause.dispose();
			_bbPlayPause = null;
			_bbStop.dispose();
			_bbStop = null;
			_bsfSeek.dispose();
			_bsfSeek = null;
			_tempIsPlay = false;
			_tfTime = null;
			_bbMute.dispose();
			_bbMute = null;
			_bsfVolume.dispose();
			_bsfVolume = null;

			_View = null;
			_Controller = null;
			_MediaCont = null;

			super.dispose();
		}

		public function CBumAbstractPlayer(tCont:DisplayObjectContainer,
							tInstNameArr:Array = null, tbsfNumArr:Array = null, tbbComFrameArr:Array = null, tEtcValArr:Array = null)
		{
			super(tCont);


			if (tInstNameArr == null)
				tInstNameArr = ['mc_View', 'mc_Controller', 'mc_MediaCont', 'mc_1', 'mc_2', 'slider_1', 'tf_1', 'mc_3', 'slider_2'];

			if (tbsfNumArr == null)
				tbsfNumArr = [0, 300, 0, 100];

			if (tbbComFrameArr == null)
				tbbComFrameArr = ['#_0', '#_1', '#_2', '#_3', '#_4', '#_5'];

			if (tEtcValArr == null)
				tEtcValArr = [0.7];



			_View = _cont[tInstNameArr[0]];
			_View.mouseChildren = false;
			_View.mouseEnabled = false;
			_Controller = _cont[tInstNameArr[1]];
			_Controller.mouseChildren = false;
			_MediaCont = _View[tInstNameArr[2]];



			var tmc:MovieClip;

			tmc = _Controller[tInstNameArr[3]];
			_bbPlayPause = new CBumButton(tmc, tbbComFrameArr, true);
			_bbPlayPause.addEventListener(CBumButton.ET_CLICK, pp_bbPlayPause_click);
			tmc = _Controller[tInstNameArr[4]];
			_bbStop = new CBumButton(tmc, tbbComFrameArr);
			_bbStop.addEventListener(CBumButton.ET_CLICK, pp_bbStop_click);

			tmc = _Controller[tInstNameArr[5]];
			_bsfSeek = new CBumSliderFrame(tmc, CBumSliderFrame.TYPE_HORIZONTAL, tbsfNumArr[0], tbsfNumArr[1]);
			_bsfSeek.addEventListener(CBumSliderFrame.ET_MOUSE_UP, pp_bsfSeek_mouseUp);
			_bsfSeek.addEventListener(CBumSliderFrame.ET_MOUSE_DOWN, pp_bsfSeek_mouseDown);
			_bsfSeek.addEventListener(CBumSliderFrame.ET_UPDATE, pp_bsfSeek_update);

			_tfTime = _Controller[tInstNameArr[6]];
			pp_tfTime_update(true);

			tmc = _Controller[tInstNameArr[7]];
			_bbMute = new CBumButton(tmc, tbbComFrameArr, true);
			_bbMute.addEventListener(CBumButton.ET_CLICK, pp_bbMute_click);

			tmc = _Controller[tInstNameArr[8]];
			_bsfVolume = new CBumSliderFrame(tmc, CBumSliderFrame.TYPE_HORIZONTAL, tbsfNumArr[2], tbsfNumArr[3]);
			_bsfVolume.addEventListener(CBumSliderFrame.ET_UPDATE, pp_bsfVolume_update);
			_defaultRatio = tEtcValArr[0];
			_bsfVolume.set_ratio(_defaultRatio);
		}

		protected var _View:DisplayObjectContainer;
		public function getView():DisplayObjectContainer
		{
			return _View;
		}

		protected var _Controller:DisplayObjectContainer;
		public function getController():DisplayObjectContainer
		{
			return _Controller;
		}

		protected var _MediaCont:DisplayObjectContainer;
		public function getMediaCont():DisplayObjectContainer
		{
			return _MediaCont;
		}


		protected var _bbPlayPause:CBumButton;
		protected function pp_bbPlayPause_click(tevt:CBumEvent):void
		{
		}


		protected var _bbStop:CBumButton;
		protected function pp_bbStop_click(tevt:CBumEvent):void
		{
		}


		protected var _bsfSeek:CBumSliderFrame;
		protected var _tempIsPlay:Boolean = false;
		protected function pp_bsfSeek_update(tevt:CBumEvent):void
		{
		}
		protected function pp_bsfSeek_mouseUp(tevt:CBumEvent):void
		{
		}
		protected function pp_bsfSeek_mouseDown(tevt:CBumEvent):void
		{
		}


		protected var _tfTime:TextField;
		protected function pp_tfTime_update(tIsReset:Boolean):void
		{
		}


		protected var _bbMute:CBumButton;
		protected var _defaultRatio:Number;
		protected var _TempRatio:Number;
		protected function pp_bbMute_click(tevt:CBumEvent):void
		{
		}


		protected var _bsfVolume:CBumSliderFrame;
		protected function pp_bsfVolume_update(tevt:CBumEvent):void
		{
		}


		protected function ppEnterFrame(tevt:Event):void
		{
		}



		protected var _autoPlay:Boolean = false;
		public function get_autoPlay():Boolean
		{
			return _autoPlay;
		}
		public function set_autoPlay(tb:Boolean):void
		{
			_autoPlay = tb;
		}


		public function close():void
		{
		}

		public function open(tUrl:String):void
		{
		}

		public function stop():void
		{
		}

		public function play():void
		{
		}

		public function pause():void
		{
		}

	}

}