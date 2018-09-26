/**
	@Name: ICallBack
	@Author: HobisJung(jhb0b@naver.com)
	@Date: 2016-01-20
	@Comment:
	{
	}
*/
package hb.core
{
	public interface ICallBack
	{
		function dispatch_callBack(eObj:Object):void;
		function set_callBack(f:Function):void;
	}
}
