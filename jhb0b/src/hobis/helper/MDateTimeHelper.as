package hobis.helper
{
	import jhb0b.utils.MStringUtil;

	public final class MDateTimeHelper
	{
		//::
		public static function ffStamp(d:Date = null):String
		{
			var t_d:Date = (d == null) ? new Date() : d;

			var t_yy:Number = t_d.fullYear;
			var t_mm:Number = t_d.month + 1;
			var t_dd:Number = t_d.date;
			var t_tt:Number = t_d.hours;
			var t_mi:Number = t_d.minutes;
			var t_ss:Number = t_d.seconds;
			var t_ms:Number = t_d.milliseconds;

			var t_ds:String	=
				MStringUtil.add_token(t_yy.toString().substr(2, 2), 2) +
				MStringUtil.add_token(t_mm.toString(), 2) +
				MStringUtil.add_token(t_dd.toString(), 2) +
				MStringUtil.add_token(t_tt.toString(), 2) +
				MStringUtil.add_token(t_mi.toString(), 2) +
				MStringUtil.add_token(t_ss.toString(), 2) +
				MStringUtil.add_token(t_ms.toString(), 3);
			return t_ds;
		}
	}
}
