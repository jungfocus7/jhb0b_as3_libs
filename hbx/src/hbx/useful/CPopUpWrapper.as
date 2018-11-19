package hbx.useful
{
	import flash.display.MovieClip;
	import flash.events.Event;

	import hbx.common.CMovieClipWrapper;
	import hbx.core.CEventCore;



	public class CPopUpWrapper extends CMovieClipWrapper
	{
		public static const ET_OPEN:String = Event.OPEN;


		/**
		 * 생성자
		 * <br/>
		 * @param mvc: MovieClip
		 */
		public function CPopUpWrapper(mvc:MovieClip)
		{
			super(mvc);
			this.close();
		}


		/** */
		public override function dispose():void
		{
			if (_mvc == null) return;
			this.close();
			super.dispose();
		}


		/**
		 * 닫기
		 * <br/>
		 * @param fl: FrameLabel
		 */
		public function close(fl:String = null):void
		{
			_mvc.gotoAndStop((fl == null) ? 1 : fl);
		}


		/**
		 * 닫기
		 * <br/>
		 * @param fl: FrameLabel
		 */
		public function open(fl:String):void
		{
			if (_mvc.currentFrameLabel != fl)
			{
				_mvc.gotoAndStop(fl);
				this.dispatchEvent(new CEventCore(ET_OPEN, { owner: _mvc }));
			}
		}

	}

}