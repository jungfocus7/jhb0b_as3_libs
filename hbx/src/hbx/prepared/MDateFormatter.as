﻿package hbx.prepared
{
	import flash.globalization.DateTimeFormatter;
	import flash.globalization.LocaleID;

	import hbx.utils.MStringUtil;


	public final class MDateFormatter
	{
		private static var _dtfmt:DateTimeFormatter = new DateTimeFormatter(LocaleID.DEFAULT);

		private static const _regf:RegExp = /f{1,3}/g;

		private static function ppSmartReplace(patt:String, dt:Date):String
		{
			var strms:String = MStringUtil.fill_token(dt.milliseconds.toString(), 3);
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

