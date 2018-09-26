package jhb0b.media
{
	import flash.events.IOErrorEvent;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	import jhb0b.events.CBumEvent;


	public final class MBumSoundStick
	{
		private static var _bsnd:CBumSound = null;
		private static var _ac:Function = null;
		private static var _acps:Array = null;

		private static function p_bsnd_playEnd(evt:CBumEvent):void
		{
			var t_ac:Function = _ac;
			var t_acps:Array = _acps;

			stop();

			if (t_ac != null)
			{
				if (t_acps != null)
					t_ac.apply(null, t_acps);
				else
					t_ac();
			}
		}

		public static function stop():void
		{
			if (_bsnd == null) return;
			_bsnd.removeEventListener(CBumSound.ET_PLAY_END, p_bsnd_playEnd);
			_bsnd.dispose();
			_bsnd = null;
			_ac = null;
			_acps = null;
		}

		public static function play(
								ureq:URLRequest,
								slc:SoundLoaderContext = null,
								vol:Number = 1,
								loops:int = 0,
								ac:Function = null,
								acps:Array = null):CBumSound
		{
			stop();

			_bsnd = new CBumSound(ureq, slc);
			_bsnd.addEventListener(CBumSound.ET_PLAY_END, p_bsnd_playEnd);
			_bsnd.autoPlay = true;
			_bsnd.set_loops(loops);
			_ac = ac;
			_acps = acps;

			return _bsnd;
		}

	}
}