package jhb0b.media
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.SoundTransform;
	import jhb0b.events.CBumEvent;
	import jhb0b.utils.MLoaderUtil;
	import jhb0b.utils.MTimeUtil;


	public class CBumFramePlayer extends CBumAbstractPlayer
	{
		override public function dispose():void
		{
			if (_cont == null) return;

			this.close();
			_MediaCont.removeChild(_Loader);
			_Loader = null;

			super.dispose();
		}

		public function CBumFramePlayer(tCont:DisplayObjectContainer,
							tInstNameArr:Array = null, tbsfNumArr:Array = null, tbbComFrameArr:Array = null, tEtcValArr:Array = null)
		{
			super(tCont, tInstNameArr, tbsfNumArr, tbbComFrameArr, tEtcValArr);


			_Loader = MLoaderUtil.create(_MediaCont, ppLoaderComplete);
			_Loader.visible = false;
		}


		protected var _Loader:Loader;
		public function getLoader():Loader
		{
			return _Loader;
		}
		protected function ppLoaderComplete(tevt:Event):void
		{
			_TargetFrame = MovieClip(LoaderInfo(tevt.currentTarget).loader.content);
			_TargetFrame.gotoAndStop(1);
			_Controller.mouseChildren = true;
			_Loader.visible = true;
			if (_autoPlay)
				_bbPlayPause.set_selectedDispatch(true);
		}


		protected var _TargetFrame:MovieClip;
		public function getTargetFrame():MovieClip
		{
			return _TargetFrame;
		}


		override protected function pp_bbPlayPause_click(tevt:CBumEvent):void
		{
			if (_TargetFrame == null) return;

			if (_bbPlayPause.get_selected())
			{
				_TargetFrame.addEventListener(Event.ENTER_FRAME, ppEnterFrame);
				_TargetFrame.play();
			}
			else
			{
				_TargetFrame.removeEventListener(Event.ENTER_FRAME, ppEnterFrame);
				_TargetFrame.stop();
			}
		}


		override protected function pp_bbStop_click(tevt:CBumEvent):void
		{
			if (_TargetFrame == null) return;

			if (_bbPlayPause.get_selected())
			{
				_bbPlayPause.set_selectedDispatch(false);
				_TargetFrame.gotoAndStop(1);
				_bsfSeek.set_ratio(0);
				pp_tfTime_update(true);
			}
			else
			{
				_TargetFrame.gotoAndStop(1);
				_bsfSeek.set_ratio(0);
				pp_tfTime_update(true);
			}
		}


		override protected function pp_bsfSeek_update(tevt:CBumEvent):void
		{
			if (_TargetFrame == null) return;

			const tBaseFrame:int = 1;
			var tRatio:Number = _bsfSeek.get_ratio();
			var tMaxFrame:int = _TargetFrame.totalFrames;
			var tNowFrame:int = ((tMaxFrame - tBaseFrame) * tRatio) + tBaseFrame;
			_TargetFrame.gotoAndStop(tNowFrame);
			pp_tfTime_update(false);
		}
		override protected function pp_bsfSeek_mouseUp(tevt:CBumEvent):void
		{
			if (_bsfSeek.get_ratio() >= 1)
			{
				pp_bbStop_click(null);
			}
			else
			{
				if (_tempIsPlay)
				{
					_bbPlayPause.set_selectedDispatch(true);
				}
			}
			_tempIsPlay = false;
		}
		override protected function pp_bsfSeek_mouseDown(tevt:CBumEvent):void
		{
			_tempIsPlay = _bbPlayPause.get_selected();
			if (_tempIsPlay)
			{
				_bbPlayPause.set_selectedDispatch(false);
			}
		}


		protected var _frameRate:Number;
		override protected function pp_tfTime_update(tIsReset:Boolean):void
		{
			if (_TargetFrame == null)
			{
				if (tIsReset)
					_tfTime.text = '00:00 / 00:00';
				else
					_tfTime.text = '';
				return;
			}

			if (isNaN(_frameRate))
				_frameRate = _TargetFrame.loaderInfo.frameRate;
			var tNowFrame:int = _TargetFrame.currentFrame;
			var tMaxFrame:int = _TargetFrame.totalFrames;
			var tNowTime:String = MTimeUtil.formatCode(tNowFrame / _frameRate);
			var tEndTime:String = MTimeUtil.formatCode(tMaxFrame / _frameRate);
			if (tIsReset)
				_tfTime.text = '00:00' + ' / ' + tEndTime;
			else
				_tfTime.text = tNowTime + ' / ' + tEndTime;
		}



		override protected function pp_bbMute_click(tevt:CBumEvent):void
		{
			if (_TargetFrame == null) return;

			if (_bbMute.get_selected())
			{
				_TempRatio = _bsfVolume.get_ratio();
				_bsfVolume.set_ratio(0);
			}
			else
			{
				if (isNaN(_TempRatio))
				{
					_bsfVolume.set_ratio(_defaultRatio);
				}
				else
				{
					_bsfVolume.set_ratio(_TempRatio);
					_TempRatio = NaN;
				}
			}

			pp_bsfVolume_update(null);
		}


		override protected function pp_bsfVolume_update(tevt:CBumEvent):void
		{
			if (_TargetFrame == null) return;

			var tr:Number = _bsfVolume.get_ratio();
			if (tevt != null)
			{
				if (tr <= 0)
				{
					_bbMute.set_selected(true);
				}
				else
				{
					_bbMute.set_selected(false);
				}
			}
			var tstf:SoundTransform = _TargetFrame.soundTransform;
			tstf.volume = tr;
			_TargetFrame.soundTransform = tstf;
		}


		override protected function ppEnterFrame(tevt:Event):void
		{
			if (_TargetFrame == null) return;

			const tBASE_FRAME:int = 1;
			var tNowFrame:int = _TargetFrame.currentFrame;
			var tMaxFrame:int = _TargetFrame.totalFrames;
			var tRatio:Number = (tNowFrame - tBASE_FRAME) / (tMaxFrame - tBASE_FRAME);
			_bsfSeek.set_ratio(tRatio);
			pp_tfTime_update(false);

			if (_TargetFrame.currentFrame >= _TargetFrame.totalFrames)
			{
				pp_bbStop_click(null);
			}
		}




		override public function close():void
		{
			if (_TargetFrame == null) return;

			pp_bbStop_click(null);
			_Controller.mouseChildren = false;
			_TargetFrame = null;
			_Loader.visible = false;
			MLoaderUtil.unload(_Loader);
		}

		override public function open(tUrl:String):void
		{
			this.close();
			MLoaderUtil.load(_Loader, tUrl);
		}


		override public function stop():void
		{
			pp_bbStop_click(null);
		}

		override public function play():void
		{
			_bbPlayPause.set_selectedDispatch(true);
		}

		override public function pause():void
		{
			_bbPlayPause.set_selectedDispatch(false);
		}
	}
}
