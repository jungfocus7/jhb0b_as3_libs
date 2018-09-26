package jhb0b.data
{
	import flash.display.DisplayObject;

	public final class MArrSortDisplayObject
	{
		private static const _regex1:RegExp = /\d+?$/;

		public static function type1(tdo1:DisplayObject, tdo2:DisplayObject):int
		{
			try
			{
				var tn1:uint = uint(tdo1.name.match(_regex1)[0]);
				var tn2:uint = uint(tdo2.name.match(_regex1)[0]);
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