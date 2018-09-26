package jhb0b.tools
{
	public final class MAlphabetTool
	{
		private static const _str:String = 'abcdefghijklmnopqrstuvwxyz';
		public static function get_str():String
		{
			return _str;
		}

		public static function get_indexOf(v:String):int
		{
			return _str.indexOf(v);
		}

		public static function get_charAt(i:int):String
		{
			return _str.charAt(i);
		}

		public static function is_val(v:String):Boolean
		{
			return (get_indexOf(v) > -1);
		}
	}
}
