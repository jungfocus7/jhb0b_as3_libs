import flash.events.Event;
import jhb0b.utils.MURLLoaderUtil;
import jhb0b.tools.MDebugTool;


var _xml:XML;
MURLLoaderUtil.createAndLoad('Test_jhb0b_utils_MURLLoaderUtil_Data.xml',
	function(evt:Event):void
	{
		_xml = new XML(evt.currentTarget['data']);
		MDebugTool.test('_xml: ' + _xml);
	}
);
