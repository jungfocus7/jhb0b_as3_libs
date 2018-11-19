package hbx.common
{
	import flash.display.MovieClip;

	import hbx.core.CDisplayObjectWrapper;



	public class CMovieClipWrapper extends CDisplayObjectWrapper
	{
		public function CMovieClipWrapper(mvc:MovieClip)
		{
			super(mvc);
			_mvc = mvc;
		}

		protected var _mvc:MovieClip;
		public function get_mvc():MovieClip
		{
			return _mvc;
		}


		public override function dispose():void
		{
			if (_mvc == null) return;
			_mvc = null;
			super.dispose();
		}

	}

}