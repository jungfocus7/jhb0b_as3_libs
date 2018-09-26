package hobis.helper
{
	public final class MFilePathHelper
	{
		private static const _sept:String = '\\';


		public static function GetFileName(tfp:String):String
		{
			var tss:Array = tfp.split(_sept);
			if ((tss != null) && (tss.length > 0))
				return tss.pop();
			else
				return null;
		}

		public static function GetFileNameOnly(tfp:String):String
		{
			var tfnm:String = GetFileName(tfp);
			if (tfnm != null)
			{
				return tfnm.replace(/\.[^\.]+$/, '');
			}
			else return null;
		}

		public static function GetParentPath(tfp:String, tli:int = -1):String
		{
			var tss:Array = tfp.split(_sept);
			if ((tss != null) && (tss.length > 0))
				return tss.slice(0, tli).join(_sept);
			else
				return null;
		}

		public static function GetRelativePath(tfp:String, tli:int = -1):String
		{
			var tss:Array = tfp.split(_sept);
			if ((tss != null) && (tss.length > 0))
				return tss.slice(tli).join(_sept);
			else
				return null;
		}
	}
}