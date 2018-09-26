/**
	@Name: CustomEvent
	@Author: HobisJung(jhb0b@naver.com)
	@Date: 2012-12-26
	@Comment:
	{
	}
*/
package hb.events
{
	import flash.events.Event;

	public class CustomEvent extends Event
	{
		public function CustomEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}

		public var pObj:Object = null;
	}
}