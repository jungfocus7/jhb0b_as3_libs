package hbworks.media.events
{
	import flash.events.Event;

	public class PlayerEvent extends Event
	{
		public function PlayerEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}

		public static const ITEM_CLICK_PLAY:String = 'itemClickPlay';
		public static const ITEM_CLICK_STOP:String = 'itemClickStop';
		public static const ITEM_CLICK_PAUSE:String = 'itemClickPause';
		public static const ITEM_CLICK_VOLUME:String = 'itemClickViewVolume';
		public static const ITEM_CLICK_FULLSCREEN:String = 'itemClickFullScreen';
	}

}