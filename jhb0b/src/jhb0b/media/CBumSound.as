package jhb0b.media
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import jhb0b.core.CEventCore;
	import jhb0b.events.CBumEvent;
	import jhb0b.core.IPlayer;


	public class CBumSound extends CEventCore implements IPlayer
	{
		public static const ET_LOAD_COMPLETE:String = 'loadComplete';
		public static const ET_PLAY_END:String = 'playEnd';


		override public function dispose():void
		{
			if (_snd == null) return;
			this.stop();
			p_snd_clear();
			_snd = null;
		}

		public function CBumSound(ureq:URLRequest, slc:SoundLoaderContext = null)
		{
			_snd = new Sound();
			_snd.addEventListener(Event.COMPLETE, p_snd_loadComplete);
			_snd.addEventListener(IOErrorEvent.IO_ERROR, p_snd_ioError);
			_snd.load(ureq, slc);
		}

		//- Sound
		private var _snd:Sound;
		public function get_snd():Sound
		{
			return _snd;
		}

		//- SoundChannel
		private var _sc:SoundChannel;
		public function get_sc():SoundChannel
		{
			return _sc;
		}

		//- PausePosition 재생중 사운드 채널의 일시정지 포지션
		private var _pp:Number;
		public function get_pp():Number
		{
			return _pp;
		}
		public function set_pp(v:Number):void
		{
			_pp = v;
			p_sc_clear();
			this.play();
		}

		//- Sound Volume
		private var _vol:Number = 1;
		public function get_vol():Number
		{
			return _vol;
		}
		public function set_vol(v:Number):void
		{
			if (v < 0)
				v = 0;
			else
			if (v > 1)
				v = 1;

			_vol = v;
			p_vol_update();
		}

		private function p_vol_update():void
		{
			if (_sc == null) return;
			var t_st:SoundTransform = _sc.soundTransform;
			t_st.volume = _vol;
			_sc.soundTransform = t_st;
		}


		//- AutoPlay
		public var autoPlay:Boolean = false;

		private var _loops:int = 0;
		public function get_loops():int
		{
			return _loops;
		}
		public function set_loops(v:int):void
		{
			if (v < 0)
				v = 0;

			_loops = v;
		}


		private function p_snd_ioError(evt:IOErrorEvent):void
		{
			this.dispatchEvent(evt);
		}

		private function p_snd_loadComplete(evt:Event):void
		{
			if (this.autoPlay)
				this.play();
			this.dispatchEvent(new CBumEvent(ET_LOAD_COMPLETE));
		}

		private function p_sc_playEnd(evt:Event):void
		{
			this.stop();
			this.dispatchEvent(new CBumEvent(ET_PLAY_END));
		}

		private function p_snd_clear():void
		{
			if (_snd == null) return;
			_snd.removeEventListener(Event.COMPLETE, p_snd_loadComplete);
			_snd.removeEventListener(IOErrorEvent.IO_ERROR, p_snd_ioError);
			try
			{
				_snd.close();
			}
			catch (e:Error) {}
			_snd = null;
		}

		private function p_sc_clear():void
		{
			if (_sc == null) return;
			_sc.removeEventListener(Event.SOUND_COMPLETE, p_sc_playEnd);
			_sc.stop();
			_sc = null;
		}

		public function stop():void
		{
			p_sc_clear();
			_pp = NaN;
		}

		public function play():void
		{
			if (_sc == null)
			{
				var t_st:Number = isNaN(_pp) ? 0 : _pp;
				_sc = _snd.play(t_st, _loops);
				p_vol_update();
				_sc.addEventListener(Event.SOUND_COMPLETE, p_sc_playEnd);
			}
		}

		public function pause():void
		{
			if (_sc == null) return;
			_pp = _sc.position;
			p_sc_clear();
		}

		////////////////////////////////////////////////////////////////////////////////////////////////


	}
}
