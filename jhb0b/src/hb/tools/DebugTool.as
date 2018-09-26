/**
	@Name: Debug Trace Tool
	@Author: HobisJung(jhb0b@naver.com)
	@Date: 2016-01-22
	@Comment:
	{
	}
*/
package hb.tools
{
	import flash.system.Capabilities;
	import flash.text.TextField;

	// #
	public final class DebugTool
	{
		public function DebugTool()
		{
		}

		//
		public static var isDebug:Boolean = true;
		public static var fontMsg:String = '# [hb] ';		

		public static function test(str:String):void
		{
			if (Capabilities.isDebugger)
			{
				if (isDebug)
				{
					trace(fontMsg + str);
				}
			}
		}
		
		
		
		//
		//
		//
		private static var _ltf:TextField = null;
		public static function get_ltf():TextField
		{
			return _ltf;
		}		
		public static function set_ltf(tf:TextField):void
		{
			_ltf = tf;
		}
		
		public static function ltest(msg:String, ba:Boolean = false, bn:Boolean = false):void
		{
			if (_ltf == null) return;
			//
			if (ba) {
				if (bn)
					_ltf.appendText(msg + '\n');
				else
					_ltf.appendText(msg);
			}
			else {
				if (bn)
					_ltf.text = msg + '\n';
				else
					_ltf.text = msg;
			}
		}		
		
	}
}
