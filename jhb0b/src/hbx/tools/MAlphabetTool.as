package hbx.tools
{
	/**
	 * 알파벳 문자열을 이용한 툴제공
	 * <br/>
	 */
	public final class MAlphabetTool
	{
		private static const _str:String = 'abcdefghijklmnopqrstuvwxyz';


		/**
		 * 알파벳 문자열 전체 반환
		 */
		public static function get_str():String
		{
			return _str;
		}


		/**
		 * 알파벳 위치 반환
		 */
		public static function get_indexOf(tv:String):int
		{
			return _str.indexOf(tv);
		}


		/**
		 * @comment: 알파벳 한개 반환
		 */
		public static function get_charAt(ti:int):String
		{
			return _str.charAt(ti);
		}


		/**
		 * @comment: 알파벳 문자가 맞는지 여부
		 */
		public static function is_val(tv:String):Boolean
		{
			return (get_indexOf(tv) > -1);
		}
	}
}
