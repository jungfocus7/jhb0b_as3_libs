package hobis.prepared
{
	import jhb0b.utils.MStringUtil;


	public final class MDateTime
	{
		public static function TimeStamp(td:Date = null):String
		{
			var td1:Date = (td == null) ? new Date() : td;
			//trace(td1.fullYear);
			//trace(td1.month);
			//trace(td1.date);
			//trace(td1.hours);
			//trace(td1.minutes);
			//trace(td1.seconds);
			//trace(td1.milliseconds);
			var tyea:String = MStringUtil.add_token(td1.fullYear.toString(), 4);
			var tmon:String = MStringUtil.add_token((td1.month + 1).toString(), 2);
			var tdat:String = MStringUtil.add_token(td1.date.toString(), 2);
			var thou:String = MStringUtil.add_token(td1.hours.toString(), 2);
			var tmin:String = MStringUtil.add_token(td1.minutes.toString(), 2);
			var tsec:String = MStringUtil.add_token(td1.seconds.toString(), 2);
			var tmil:String = MStringUtil.add_token(td1.milliseconds.toString(), 3);
			var trv:String = tyea + tmon + tdat + thou + tmin + tsec + tmil;
			return trv;
		}
		public static function TimeStampToNumber(td:Date = null):Number
		{
			return Number(TimeStamp(td));
		}
		public static function TimeStampToDate(tss:String):Date
		{
			var td:Date = new Date();
			td.fullYear = Number(ToYear(tss));
			td.month = Number(ToMonth(tss)) - 1;
			td.date = Number(ToDate(tss));
			td.hours = Number(ToHours(tss));
			td.minutes = Number(ToMinutes(tss));
			td.seconds = Number(ToSeconds(tss));
			td.milliseconds = Number(ToMilliseconds(tss));
			return td;
		}



		public static function ToYear(tts:String):String
		{
			return tts.substr(0, 4);
		}
		public static function ToMonth(tts:String):String
		{
			return tts.substr(4, 2);
		}
		public static function ToDate(tts:String):String
		{
			return tts.substr(6, 2);
		}
		public static function ToHours(tts:String):String
		{
			return tts.substr(8, 2);
		}
		public static function ToMinutes(tts:String):String
		{
			return tts.substr(10, 2);
		}
		public static function ToSeconds(tts:String):String
		{
			return tts.substr(12, 2);
		}
		public static function ToMilliseconds(tts:String):String
		{
			return tts.substr(14, 3);
		}


		public static function GetYear(td:Date = null):String
		{
			return ToYear(TimeStamp(td));
		}
		public static function GetMonth(td:Date = null):String
		{
			return ToMonth(TimeStamp(td));
		}
		public static function GetDate(td:Date = null):String
		{
			return ToDate(TimeStamp(td));
		}
		public static function GetHours(td:Date = null):String
		{
			return ToHours(TimeStamp(td));
		}
		public static function GetMinutes(td:Date = null):String
		{
			return ToMinutes(TimeStamp(td));
		}
		public static function GetSeconds(td:Date = null):String
		{
			return ToSeconds(TimeStamp(td));
		}
		public static function GetMilliseconds(td:Date = null):String
		{
			return ToMilliseconds(TimeStamp(td));
		}
	}
}






