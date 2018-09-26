package jhb0b.tools
{
	import flash.system.Capabilities;
	import flash.text.TextField;


	public final class MDebugTool
	{
		private static var _frontStr:String = '[#jhb0b] ';
		public static function set_frontStr(v:String):void
		{
			_frontStr = v;
		}

		public static var is_use:Boolean = true;
		public static function test(v:String):void
		{
			if (Capabilities.isDebugger && is_use)
			{
				trace(_frontStr + v);
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

			if (ba)
			{
				if (bn)
					_ltf.appendText(msg + '\n');
				else
					_ltf.appendText(msg);
			}
			else
			{
				if (bn)
					_ltf.text = msg + '\n';
				else
					_ltf.text = msg;
			}
		}

	}
}
