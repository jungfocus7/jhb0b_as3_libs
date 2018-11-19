package hbx.tools
{
	import flash.system.Capabilities;
	import flash.text.TextField;


	/**
	 * 디버그 툴
	 */
	public final class MDebugTool
	{
		//-- 접두사
		private static var _prefix:String = '[#hbx] ';
		/**
		 * 접두사 설정
		 * <br/>
		 * @param tv: ValueString
		 */
		public static function set_prefix(tv:String):void
		{
			_prefix = tv;
		}


		//-- 사용여부
		public static var is_use:Boolean = true;
		/**
		 * trace 사용
		 * <br/>
		 * @param tv: ValueString
		 */
		public static function test(tv:String):void
		{
			if (Capabilities.isDebugger && is_use)
			{
				trace(_prefix + tv);
			}
		}



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
