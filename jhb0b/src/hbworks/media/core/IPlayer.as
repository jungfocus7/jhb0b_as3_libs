/**
 * @Name: Player Interface
 * @Author: Hobis Jung
 * @Date: 2010-12-21
 */
package hbworks.media.core
{
	public interface IPlayer
	{
		function getType():String;
		function setType(type:String):void;

		function getContent():Object;
		function setContent(content:Object):void;
		function clearContent():void;

		function getIsPlay():Boolean;
		function getIsPause():Boolean;

		function getMaxValue():Number;
		function setMaxValue(v:Number):void;

		function getMinValue():Number;
		function setMinValue(v:Number):void;

		function getValue():Number;
		function setValue(v:Number):void;

		function play():void;
		function pause():void;
		function stop():void;
	}
}