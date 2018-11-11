package hbx.useful
{
	import flash.display.MovieClip;
	import flash.events.Event;

	import hbx.core.CEventCore;
	import hbx.core.CMovieClipWrapper;



	public class CPopUpWrapper extends CMovieClipWrapper
	{
		public static const ET_OPEN:String = Event.OPEN;


		override public function dispose():void
		{
			if (_mvc == null) return;
			this.close();
			super.dispose();
		}

		public function CPopUpWrapper(tmc:MovieClip)
		{
			super(tmc);
			this.close();
		}

		// '#_0'
		public function close(fl:String = null):void
		{
			_mvc.gotoAndStop((fl == null) ? 1 : fl);
		}

		public function open(fl:String):void
		{
			if (_mvc.currentFrameLabel == fl) {}
			else
			{
				_mvc.gotoAndStop(fl);
				this.dispatchEvent(new CEventCore(ET_OPEN, {owner: _mvc}));
			}
		}

	}

}