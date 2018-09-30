package jhb0b.core
{
	import flash.display.MovieClip;
	import flash.display.Stage;


	public class CMovieClipWrapper extends CEventCore
	{
		public function CMovieClipWrapper(tmc:MovieClip)
		{
			_owner = tmc;
			_stage = _owner.stage;
		}

		protected var _owner:MovieClip;
		public function get_owner():MovieClip
		{
			return _owner;
		}

		protected var _stage:Stage;
		public function get_stage():Stage
		{
			return _stage;
		}

		override public function dispose():void
		{
			if (_owner == null) return;
			_owner = null;
			_stage = null;
		}
	}

}