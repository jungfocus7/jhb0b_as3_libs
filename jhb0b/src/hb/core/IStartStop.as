/**
	@Name: StartStop Interface
	@Author: HobisJung(jhb0b@naver.com)
	@Date: 2016-01-20
	@Comment:
	{
	}
*/
package hb.core
{
	public interface IStartStop
	{
		// :: 로직 리셋
		function reset():void;

		// :: 로직 일시재개
		function resume():void;

		// :: 로직 일시정지
		function pause():void;

		// :: 로직 완전정지
		function stop():void;

		// :: 로직 시작
		function start():void;
	}
}
