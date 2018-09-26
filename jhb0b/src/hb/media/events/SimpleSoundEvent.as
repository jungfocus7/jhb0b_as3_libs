/**
	@Name: SimpleSoundEvent
	@Author: HobisJung(jhb0b@naver.com)
	@Date: 2011-11-16
	@Comment:
	{
	}
*/
package hb.media.events
{
	import flash.events.Event;
	
	public class SimpleSoundEvent extends Event
	{	
		public function SimpleSoundEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}

		public static const SOUND_LOAD_COMPLETE:String = 'soundLoadComplete';
		public static const SOUND_PLAY_COMPLETE:String = 'soundPlayComplete';
	}
}