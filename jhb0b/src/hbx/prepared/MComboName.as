package hbx.prepared
{
	public final class MComboName
	{
		private static var _separator:String = '|';
		public static function GetSeparator():String
		{
			return _separator;
		}
		public static function set_separator(tstr:String):void
		{
			if (tstr == null) return;
			_separator = tstr;
		}

		public static function is_included(tcnm:String, tnm:String):Boolean
		{
			return tcnm.indexOf(tnm) > -1;
		}

		public static function combineName(tnm1:String, tnm2:String):String
		{
			if (is_included(tnm1, tnm2))
				return tnm1;
			else
			if (is_included(tnm2, tnm1))
				return tnm2;
			else
				return tnm1 + _separator + tnm2;
		}
	}

}