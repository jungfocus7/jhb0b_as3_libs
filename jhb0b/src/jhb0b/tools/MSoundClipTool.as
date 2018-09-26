package jhb0b.tools
{
	import flash.display.MovieClip;
	import flash.media.SoundTransform;
	import jhb0b.utils.MMovieClipUtil;


	public final class MSoundClipTool
	{
		private static function p_find_clip(omc:MovieClip, clipName:String):MovieClip
		{
			if (clipName == null) clipName = 'snd_3';
			var t_mc:MovieClip = omc[clipName];
			return t_mc;
		}

		public static function stop(omc:MovieClip, clipName:String):void
		{
			var t_mc:MovieClip = p_find_clip(omc, clipName);
			if (t_mc == null) return;

			t_mc.gotoAndStop(1);
			MMovieClipUtil.delayExcute_stop(t_mc);
		}

		public static function play(
								omc:MovieClip, clipName:String, label:String,
								isGotoStop:Boolean = false, vol:Number = 1,
								ac:Function = null, acps:Array = null, countLen:uint = 1):void
		{
			var t_mc:MovieClip = p_find_clip(omc, clipName);
			if (t_mc == null) return;

			var t_st:SoundTransform = new SoundTransform();
			t_st.volume = vol;
			t_mc.soundTransform = t_st;
			t_mc.gotoAndStop(1);
			if (isGotoStop)
				t_mc.gotoAndStop(label);
			else
				t_mc.gotoAndPlay(label);

			if (ac != null)
				MMovieClipUtil.delayExcute(t_mc, ac, acps, countLen);
		}
	}
}
