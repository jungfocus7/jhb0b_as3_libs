package hbx.prepared
{
	import flash.display.DisplayObject;

	public final class MArrSorters
	{
		//-- [정규식] 문자열 뒷자리에서 넘버 추출
		private static const _regex1:RegExp = /\d+?$/;


		/**
		 * 소팅타입1
		 * <br/>
		 * @param dpo1: DisplayObject
		 * @param dpo2: DisplayObject
		 */
		public static function type1(dpo1:DisplayObject, dpo2:DisplayObject):int
		{
			try
			{
				var tn1:uint = uint(dpo1.name.match(_regex1)[0]);
				var tn2:uint = uint(dpo2.name.match(_regex1)[0]);
				if (tn1 < tn2)
					return -1;
				else
				if (tn1 > tn2)
					return 1;
				else
					return 0;
			}
			catch (e:Error) { }

			return 0;
		}

	}
}