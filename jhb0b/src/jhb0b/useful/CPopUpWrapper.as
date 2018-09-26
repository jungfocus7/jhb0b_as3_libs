package jhb0b.useful
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import jhb0b.core.CMovieClipWrapper;
	import jhb0b.events.CBumEvent;


	public class CPopUpWrapper extends CMovieClipWrapper
	{
		public static const ET_OPEN:String = Event.OPEN;


		override public function dispose():void
		{
			if (_owner == null) return;
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
			_owner.gotoAndStop((fl == null) ? 1 : fl);
		}

		public function open(fl:String):void
		{
			if (_owner.currentFrameLabel == fl) {}
			else
			{
				_owner.gotoAndStop(fl);
				this.dispatchEvent(new CBumEvent(ET_OPEN, {owner: _owner}));
			}
		}

	}

}