/**
	@Name: Player Interface
	@Author: HobisJung(jhb0b@naver.com)
	@Date: 2012-10-22
	@Comment:
	{
	}
*/
package hb.media.core
{
	public interface IPlayer
	{
		// :: 컨텐트 스트림 닫기
		function close():void;

		// :: 컨텐트 로그
		function load(url:String):void;

		// :: 컨텐트 재생중지
		function stop():void;

		// :: 컨텐트 플레이
		function play():void;

		// :: 컨텐트 일시정지
		function pause():void;
	}
}
