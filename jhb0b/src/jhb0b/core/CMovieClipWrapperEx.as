package jhb0b.core
{
	import flash.display.MovieClip;

	import jhb0b.core.CMovieClipWrapper;
	import jhb0b.core.IEnabled;
	import jhb0b.core.INamer;


	public class CMovieClipWrapperEx extends CMovieClipWrapper implements IEnabled, INamer
	{
		public function CMovieClipWrapperEx(tmc:MovieClip)
		{
			super(tmc);
		}

		protected var _enabled:Boolean = false;
		public function get_enabled():Boolean
		{
			return _enabled;
		}
		public function set_enabled(b:Boolean):void
		{
			_enabled = b;
		}

		protected var _name:String;
		public function get_name():String
		{
			return _name;
		}
		public function set_name(tnm:String):void
		{
			_name = tnm;
		}

	}

}