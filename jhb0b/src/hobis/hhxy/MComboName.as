package hobis.hhxy
{
	public final class MComboName
	{
		private static var _Separator:String = '|';
		public static function GetSeparator():String {
			return _Separator;
		}
		public static function SetSeparator(tstr:String):void {
			if (tstr == null) return;
			_Separator = tstr;
		}

		public static function GetIsIncluded(tcnm:String, tnm:String):Boolean {
			return tcnm.indexOf(tnm) > -1;
		}

		public static function CombineName(tnm1:String, tnm2:String):String {
			if (GetIsIncluded(tnm1, tnm2))
				return tnm1;
			else
			if (GetIsIncluded(tnm2, tnm1))
				return tnm2;
			else
				return tnm1 + _Separator + tnm2;
		}
	}

}