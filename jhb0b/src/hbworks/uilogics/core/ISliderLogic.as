/**
	@Name: SliderLogic Interface
	@Author: HobisJung(jhb0b@naver.com)
	@Blog: http://blog.naver.com/jhb0b
	@Date: 2016-05-09

*/
package hbworks.uilogics.core
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;


	public interface ISliderLogic
	{
		function get_type():String;

		function get_thumb():DisplayObject;

		function get_track():DisplayObject;

		function get_ratio():Number;

		function set_ratio(v:Number):void;

		function rectAreaUpdate():void;
	}
}
