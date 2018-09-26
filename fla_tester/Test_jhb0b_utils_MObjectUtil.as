import jhb0b.utils.MObjectUtil;
import jhb0b.tools.MDebugTool;


function p_hello(v:String):void
{
	MDebugTool.test('p_hello');
	MDebugTool.test(v);
}
MObjectUtil.call_method(this, 'p_hello', ['안녕하세요.']);


function onCallBack(eObj:Object):void
{
	MDebugTool.test('onCallBack');
	MDebugTool.test(eObj.toString());	
}
MObjectUtil.dispatch_callBack(this, {});


function onCallBack2(eObj:Object):void
{
	MDebugTool.test('onCallBack2');
	MDebugTool.test(eObj.toString());	
}
MObjectUtil.dispatch_callBack2(this, {}, 'onCallBack2');


function call_method(na:int, nb:int, nc:int):void
{
	MDebugTool.test('call_method');
	trace(na, nb, nc);
}
MObjectUtil.call_method(this, 'call_method', [1, 2, 3]);



MDebugTool.test(MObjectUtil.get_toString({Name: '정희범', Job: 'Programmer'}));


