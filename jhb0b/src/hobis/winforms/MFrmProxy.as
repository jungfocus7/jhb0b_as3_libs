package hobis.winforms
{
	import flash.external.ExternalInterface;
	import jhb0b.tools.MQueryStringTool;


	public final class MFrmProxy
	{
		public static function call_o(funcName:String, pObj:Object):*
		{
			if (ExternalInterface.available)
				return ExternalInterface.call(funcName, MQueryStringTool.to_str(pObj));
			else
				return null;
		}

		public static function call(funcName:String, ... args):*
		{
			if (ExternalInterface.available)
				return ExternalInterface.call(funcName, args);
			else
				return null;
		}

		public static function addCallback(funcName:String, closure:Function):void
		{
			if (ExternalInterface.available)
				ExternalInterface.addCallback(funcName, closure);
		}

		public static function get_available():Boolean
		{
			return ExternalInterface.available;
		}
	}
}
