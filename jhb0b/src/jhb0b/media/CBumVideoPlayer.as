package jhb0b.media
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.text.TextField;
	import jhb0b.core.CContainerBase;
	import jhb0b.core.IPlayer;
	import jhb0b.core.IStream;
	import jhb0b.events.CBumEvent;
	import jhb0b.utils.MTimeUtil;
	import jhb0b.whats.CBumButton;
	import jhb0b.whats.CBumSliderFrame;


	public class CBumVideoPlayer extends CBumAbstractPlayer
	{
		override public function dispose():void
		{
			if (_cont == null) return;

			this.close();
			_VideoStream.dispose();
			_VideoStream = null;

			super.dispose();
		}

		public function CBumVideoPlayer(tCont:DisplayObjectContainer,
							tInstNameArr:Array = null, tbsfNumArr:Array = null, tbbComFrameArr:Array = null, tEtcValArr:Array = null)
		{
			super(tCont, tInstNameArr, tbsfNumArr, tbbComFrameArr, tEtcValArr);


			_VideoStream = new CBumVideoStream();
			_VideoStream.addEventListener(CBumVideoStream.ET_STREAM_ERROR, ppVideoStreamStreamError);
			_VideoStream.addEventListener(CBumVideoStream.ET_LOAD_PROGRESS, ppVideoStreamLoadProgress);
			_VideoStream.addEventListener(CBumVideoStream.ET_LOAD_COMPLETE, ppVideoStreamLoadComplete);
			_VideoStream.addEventListener(CBumVideoStream.ET_PLAY_READY, ppVideoStreamPlayReady);
			_VideoStream.addEventListener(CBumVideoStream.ET_PLAY_STOP, ppVideoStreamPlayStop);
			_VideoStream.addEventListener(CBumVideoStream.ET_POSITION_UPDATE, ppVideoStreamPositionUpdate);
			_VideoStream.addEventListener(CBumVideoStream.ET_ENTER_FRAME, ppEnterFrame);
			_MediaCont.addChild(_VideoStream.getVideo());
		}


		protected var _VideoStream:CBumVideoStream;
		public function getVideoStream():CBumVideoStream
		{
			return _VideoStream;
		}
		public function getIsEmptyVideoStream():Boolean
		{
			return ((_VideoStream == null) || _VideoStream.getIsClosed());
		}
		protected function ppVideoStreamStreamError(tevt:CBumEvent):void
		{
			//p_test(tevt.type);
		}
		protected function ppVideoStreamLoadProgress(tevt:CBumEvent):void
		{
			//p_test(tevt.type);
		}
		protected function ppVideoStreamLoadComplete(tevt:CBumEvent):void
		{
			//p_test(tevt.type);
		}
		protected function ppVideoStreamPlayReady(tevt:CBumEvent):void
		{
			//p_test(tevt.type);
			pp_tfTime_update(true);
			pp_bsfVolume_update(null);
			if (_autoPlay)
				_bbPlayPause.set_selectedDispatch(true);
		}
		protected function ppVideoStreamPlayStop(tevt:CBumEvent):void
		{
			//p_test(tevt.type);
			pp_bbStop_click(null);
		}
		protected function ppVideoStreamPositionUpdate(tevt:CBumEvent):void
		{
			//p_test(tevt.type);
			if (_bsfSeek.get_ratio() >= 1)
			{
				pp_bbStop_click(null);
			}
			else
			{
				var tNowPos:Number = _VideoStream.getPosition();
				var tEndPos:Number = _VideoStream.getDuration();
				var tPosRatio:Number = tNowPos / tEndPos;
				_bsfSeek.set_ratio(tPosRatio);
			}
		}


		override protected function ppEnterFrame(tevt:Event):void
		{
			//p_test(tevt.type);
			pp_tfTime_update(false);
		}


		override protected function pp_bbPlayPause_click(tevt:CBumEvent):void
		{
			if (this.getIsEmptyVideoStream()) return;

			if (_bbPlayPause.get_selected())
			{
				_VideoStream.play();
			}
			else
			{
				_VideoStream.pause();
			}
		}


		override protected function pp_bbStop_click(tevt:CBumEvent):void
		{
			if (this.getIsEmptyVideoStream()) return;

			if (_bbPlayPause.get_selected())
			{
				_bbPlayPause.set_selected(false);
				_VideoStream.stop();
				_bsfSeek.set_ratio(0);
				pp_tfTime_update(true);
			}
			else
			{
				_VideoStream.stop();
				_bsfSeek.set_ratio(0);
				pp_tfTime_update(true);
			}
		}


		override protected function pp_bsfSeek_update(tevt:CBumEvent):void
		{
			if (this.getIsEmptyVideoStream()) return;

			var tRatio:Number = _bsfSeek.get_ratio();
			var tValue:Number = _VideoStream.getDuration() * tRatio;
			_VideoStream.setPosition(tValue);
		}
		override protected function pp_bsfSeek_mouseUp(tevt:CBumEvent):void
		{
			if (this.getIsEmptyVideoStream()) return;

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
			if (this.getIsEmptyVideoStream()) return;

			_tempIsPlay = _bbPlayPause.get_selected();
			if (_tempIsPlay)
			{
				_bbPlayPause.set_selectedDispatch(false);
			}
		}


		override protected function pp_tfTime_update(tIsReset:Boolean):void
		{
			if (this.getIsEmptyVideoStream())
			{
				if (tIsReset)
					_tfTime.text = '00:00 / 00:00';
				else
					_tfTime.text = '';
				return;
			}

			var tNowPos:Number = _VideoStream.getPosition();
			var tEndPos:Number = _VideoStream.getDuration();
			var tNowTime:String = MTimeUtil.formatCode(tNowPos);
			var tEndTime:String = MTimeUtil.formatCode(tEndPos);
			if (tIsReset)
				_tfTime.text = '00:00' + ' / ' + tEndTime;
			else
				_tfTime.text = tNowTime + ' / ' + tEndTime;
		}


		override protected function pp_bbMute_click(tevt:CBumEvent):void
		{
			if (this.getIsEmptyVideoStream()) return;

			if (_bbMute.get_selected())
			{
				_TempRatio = _bsfVolume.get_ratio();
				_bsfVolume.set_ratio(0);
			}
			else
			{
				if (isNaN(_TempRatio))
				{
					_bsfVolume.set_ratio(0.7);
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
			if (this.getIsEmptyVideoStream()) return;

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
			var tstf:SoundTransform = _VideoStream.getSoundTransform();
			tstf.volume = tr;
			_VideoStream.setSoundTransform(tstf);
		}





		override public function close():void
		{
			if (this.getIsEmptyVideoStream()) return;

			pp_bbStop_click(null);
			_VideoStream.close();
			_Controller.mouseChildren = false;
			pp_tfTime_update(true);
		}

		override public function open(tUrl:String):void
		{
			this.close();
			_VideoStream.open(tUrl);
			_Controller.mouseChildren = true;
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
