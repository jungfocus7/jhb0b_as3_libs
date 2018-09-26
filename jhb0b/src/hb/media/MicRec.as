/**
	@Name: MicRec
	@Author: HobisJung
	@Date: 2014-01-21
	@Using:
	{
		// 사용준비
		MicRec.ready();

		// 사용해제
		MicRec.dispose();

		// 저장된 레코드 삭제
		MicRec.recordClear();

		// 정지
		MicRec.allStop();

		// 레코드 시작
		MicRec.recordStart();

		// 레코드 정지
		MicRec.recordStop();

		// 재생 시작
		MicRec.playStart();

		// 재생 정지
		MicRec.playStop();
	}
*/
package hb.media
{
	import flash.events.ActivityEvent;
	import flash.events.Event;
	import flash.events.SampleDataEvent;
	import flash.events.StatusEvent;
	import flash.media.Microphone;
	import flash.media.Sound;
	import flash.media.SoundChannel;
    import flash.system.Security;
    import flash.system.SecurityPanel;
	import flash.utils.ByteArray;


	public final class MicRec
	{
		public function MicRec()
		{
		}

		public static const STATE_RECORD:String = 'stateRecord';
		public static const STATE_PLAY:String = 'statePlay';
		public static const STATE_STOP:String = 'stateStop';

		private static var _state:String = STATE_STOP;
		public static function get_state():String
		{
			return _state;
		}

		// - 마이크객체
		private static var _mic:Microphone = null;
		public static function get_mic():Microphone
		{
			return _mic;
		}

/*
		private static function p_mic_activity(event:ActivityEvent):void
		{
			//trace('p_mic_activity');
		}
		private static function p_mic_status(event:StatusEvent):void
		{
			//trace('p_mic_status');
		}*/

		// - 바이트객체
		private static var _ba:ByteArray = null;
		public static function get_soundData():ByteArray
		{
			return _ba;
		}

		// ::
		private static function p_mic_sample(event:SampleDataEvent):void
		{
			var t_sba:ByteArray = event.data;
			while (t_sba.bytesAvailable > 0)
			{
				_ba.writeFloat(t_sba.readFloat());
			}

			//trace('p_mic_sample');
			//trace('t_sba.bytesAvailable: ' + t_sba.bytesAvailable);
			//trace('_ba.bytesAvailable: ' + _ba.bytesAvailable);
			//trace('_ba.length: ' + _ba.length);
		}

		// :: 사용시작
		public static function ready(mic:Microphone = null, isPanel:Boolean = true):void
		{
			if (_mic == null)
			{
				if (isPanel)
				{
					Security.showSettings(SecurityPanel.PRIVACY);
				}

				if (mic != null)
				{
					_mic = mic;
				}
				else
				{
					_mic = Microphone.getMicrophone();
					if (_mic != null)
					{
					//gain:uint=100, rate:uint=44, silenceLevel:uint=0, timeOut:uint=4000
						_mic.setSilenceLevel(0);
						//_mic.setUseEchoSuppression(true);
						_mic.gain = 100;
						_mic.rate = 44;

						//_mic.setLoopBack(true);
						//_mic.addEventListener(ActivityEvent.ACTIVITY, p_mic_activity);
						//_mic.addEventListener(StatusEvent.STATUS, p_mic_status);
						//_mic.addEventListener(SampleDataEvent.SAMPLE_DATA, p_mic_sample);
					}
				}

				if (_mic != null)
				{
					_snd = new Sound();
				}

				//trace('ready');
				//trace('_mic: ' + _mic);
				//trace('_mic.muted: ' + _mic.muted);
			}
		}

		// :: 사용해제
		public static function dispose():void
		{
			if (_mic == null) return;

			allStop();
			recordClear();

			_mic = null;
			try
			{
				_snd.close();
			}
			catch (e:Error) {}
			_snd = null;
		}

		// :: 저장중인 레코드 삭제
		public static function recordClear():void
		{
			if (_ba != null)
			{
				_ba.clear();
				_ba = null;
			}
		}

		// :: 모두정지
		public static function allStop():void
		{
			if (_mic == null) return;

			recordStop();
			playStop();
		}

		// :: 녹음정지
		public static function recordStop():void
		{
			if (_mic == null) return;

			if (_state == STATE_RECORD)
			{
				_mic.removeEventListener(SampleDataEvent.SAMPLE_DATA, p_mic_sample);
				_mic.setLoopBack(false);

				_ba.position = 0;
				//_ba.length = 0;

				_state = STATE_STOP;
			}
		}

		// :: 녹음시작
		public static function recordStart():void
		{
			if (_mic == null) return;

			if (_state == STATE_STOP)
			{
				recordClear();

				_ba = new ByteArray();
				_ba.position = 0;

				_mic.addEventListener(SampleDataEvent.SAMPLE_DATA, p_mic_sample);
				_mic.setLoopBack(true);

				_state = STATE_RECORD;
			}
		}

		// :: 재생정지
		public static function playStop():void
		{
			if (_mic == null) return;

			if (_state == STATE_PLAY)
			{
				_snd.removeEventListener(SampleDataEvent.SAMPLE_DATA, p_snd_sample);
				if (_sc != null)
				{
					_sc.stop();
					_sc = null;
				}

				_state = STATE_STOP;
			}
		}


		private static var _snd:Sound = null;
		private static var _sc:SoundChannel = null;
		// :: 샘플링 핸들러
		private static function p_snd_sample(event:SampleDataEvent):void
		{
			//const t_BUF:uint = 8192;
			const t_BUF:uint = 1024 * 2;

			var t_sba:ByteArray = event.data;
			for (var i:uint = 0; i < t_BUF; i++)
			{
				if (_ba.bytesAvailable < 4)
				{
					break;
				}
				else
				{
					var t_sample:Number = _ba.readFloat();
					t_sba.writeFloat(t_sample);
					t_sba.writeFloat(t_sample);
				}
			}
		}

		// :: 샘플링 핸들러
		private static function p_sc_end(event:Event):void
		{
			playStop();

			//trace('p_sc_end');
		}

		// :: 재생시작
		public static function playStart():void
		{
			if (_mic == null) return;

			if (_state == STATE_STOP)
			{
				if (_ba != null)
				{
					_ba.position = 0;

					_snd.addEventListener(SampleDataEvent.SAMPLE_DATA, p_snd_sample);
					_sc = _snd.play();
					_sc.addEventListener(Event.SOUND_COMPLETE, p_sc_end);

					_state = STATE_PLAY;
				}
			}
		}
	}
}
