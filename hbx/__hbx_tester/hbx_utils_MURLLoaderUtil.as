import flash.events.Event;
import flash.net.URLRequest;
import hbx.utils.MURLLoaderUtil;
import hbx.tools.MDebugTool;


var _xml:XML;

MURLLoaderUtil.createAndLoad('hbx_utils_MURLLoaderUtil_data.xml',
	function(evt:Event):void
	{
		_xml = new XML(evt.currentTarget['data']);
		MDebugTool.test('_xml: ' + _xml);
	}
);

MURLLoaderUtil.createAndLoad2(new URLRequest('hbx_utils_MURLLoaderUtil_data.xml'),
	function(evt:Event):void
	{
		_xml = new XML(evt.currentTarget['data']);
		MDebugTool.test('_xml: ' + _xml);
	}
);
