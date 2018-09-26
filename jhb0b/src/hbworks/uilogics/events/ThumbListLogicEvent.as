/**
	@Name: ThumbListLogic
	@Author: Hobis Jung
	@Data: 2013-04-17
	@Using:
	{
	}
*/
package hbworks.uilogics.events
{
	import flash.events.Event;

	public class ThumbListLogicEvent extends Event
	{
		public function ThumbListLogicEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}

		public var dataObj:Object = null;

		public static const PAGE_UPDATE_START:String = 'pageUpdateStart';
		public static const PAGE_UPDATE_END:String = 'pageUpdateEnd';
		public static const THUMBS_SELECT:String = 'thumbSelect';
	}

}
