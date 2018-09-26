package jhb0b.core
{
	import flash.display.MovieClip;


	public class CMovieClipWrapper extends CEventCore
	{
		public function CMovieClipWrapper(tmc:MovieClip)
		{
			_owner = tmc;
		}

		protected var _owner:MovieClip;
		public function get_owner():MovieClip
		{
			return _owner;
		}

		override public function dispose():void
		{
			_owner = null;
		}
	}

}