package hobis.prepared
{
	import flash.globalization.DateTimeFormatter;
	import flash.globalization.LocaleID;
	import jhb0b.utils.MStringUtil;	
	
	public final class MDateFormatter
	{
		private static var _dtfmt:DateTimeFormatter = new DateTimeFormatter(LocaleID.DEFAULT);
		
		private static const _regf:RegExp = /f{1,3}/g;
		
		private static function ppSmartReplace(patt:String, dt:Date):String
		{
			var strms:String = MStringUtil.add_token(dt.milliseconds.toString(), 3);			
			var strrv:String = patt.replace(_regf,
				function():String
				{
					//trace(arguments);
					var ts:String = arguments[0];
					return strms.substr(0, ts.length);
				});			
			return strrv;
		}
		
		
		public static function get_format(patt:String):String
		{
			var dt:Date = new Date();
			_dtfmt.setDateTimePattern(ppSmartReplace(patt, dt));
			return _dtfmt.format(dt);
		}
	}
}
//
//
//internal class CFinder
//{
//	private static const _regt:RegExp = /◀◐◑▶/g;
//	private static const _regu:RegExp = /\{#([\s\S]+?)#\}/g;
//	
//	public function CFinder()
//	{
//	}
//}

