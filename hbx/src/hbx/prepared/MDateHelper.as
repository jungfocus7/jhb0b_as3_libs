package hbx.prepared
{
	import hbx.utils.MStringUtil;


	public final class MDateHelper
	{
		public static function timeStamp(td:Date = null):String
		{
			const td1:Date = (td == null) ? new Date() : td;
			//trace('td1.fullYear: ' + td1.fullYear);
			//trace('td1.month: ' + td1.month);
			//trace('td1.date: ' + td1.date);
			//trace('td1.hours: ' + td1.hours);
			//trace('td1.minutes: ' + td1.minutes);
			//trace('td1.seconds: ' + td1.seconds);
			//trace('td1.milliseconds: ' + td1.milliseconds);

			var tyear:String = MStringUtil.add_token(td1.fullYear.toString(), 4);
			var tmonth:String = MStringUtil.add_token((td1.month + 1).toString(), 2);
			var tdate:String = MStringUtil.add_token(td1.date.toString(), 2);
			var thours:String = MStringUtil.add_token(td1.hours.toString(), 2);
			var tminutes:String = MStringUtil.add_token(td1.minutes.toString(), 2);
			var tseconds:String = MStringUtil.add_token(td1.seconds.toString(), 2);
			var tmilliseconds:String = MStringUtil.add_token(td1.milliseconds.toString(), 3);
			var trv:String = tyear + tmonth + tdate + thours + tminutes + tseconds + tmilliseconds;

			return trv;
		}

		public static function timeStampToNumber(td:Date = null):Number
		{
			return Number(timeStamp(td));
		}

		public static function timeStampToDate(tss:String):Date
		{
			const td:Date = new Date();
			td.fullYear = Number(to_year(tss));
			td.month = Number(to_month(tss)) - 1;
			td.date = Number(to_date(tss));
			td.hours = Number(to_hours(tss));
			td.minutes = Number(to_minutes(tss));
			td.seconds = Number(to_seconds(tss));
			td.milliseconds = Number(to_milliseconds(tss));
			return td;
		}



		public static function to_year(tts:String):String
		{
			return tts.substr(0, 4);
		}
		public static function to_month(tts:String):String
		{
			return tts.substr(4, 2);
		}
		public static function to_date(tts:String):String
		{
			return tts.substr(6, 2);
		}
		public static function to_hours(tts:String):String
		{
			return tts.substr(8, 2);
		}
		public static function to_minutes(tts:String):String
		{
			return tts.substr(10, 2);
		}
		public static function to_seconds(tts:String):String
		{
			return tts.substr(12, 2);
		}
		public static function to_milliseconds(tts:String):String
		{
			return tts.substr(14, 3);
		}


		public static function get_year(td:Date = null):String
		{
			return to_year(timeStamp(td));
		}
		public static function get_month(td:Date = null):String
		{
			return to_month(timeStamp(td));
		}
		public static function get_date(td:Date = null):String
		{
			return to_date(timeStamp(td));
		}
		public static function get_hours(td:Date = null):String
		{
			return to_hours(timeStamp(td));
		}
		public static function get_minutes(td:Date = null):String
		{
			return to_minutes(timeStamp(td));
		}
		public static function get_seconds(td:Date = null):String
		{
			return to_seconds(timeStamp(td));
		}
		public static function get_milliseconds(td:Date = null):String
		{
			return to_milliseconds(timeStamp(td));
		}



		public static function parseNumber(value:String, token:String = ':'):Number
		{
			var t_rv:Number = 0;
			var t_a:Array = value.split(token);

			if (t_a.length > 1)
			{
				// Clock format, e.g. "hh:mm:ss"
				t_rv += Number(t_a[0]) * 3600;
				t_rv += Number(t_a[1]) * 60;
				t_rv += Number(t_a[2]);
			}
			else
			{
				// Offset t_rv format, e.g. "1h", "8m", "10s"
				var t_mul:int = 0;

				switch (value.charAt(value.length - 1))
				{
					case 'h':
					{
						t_mul = 3600;
						break;
					}
					case 'm':
					{
						t_mul = 60;
						break;
					}
					case 's':
					{
						t_mul = 1;
						break;
					}
				}

				if (t_mul > 0)
				{
					t_rv = Number(value.substr(0, value.length - 1)) * t_mul;
				}
				else
				{
					t_rv = Number(value);
				}
			}

			return t_rv;
		}


		public static function formatCode(sec:Number, token:String = ':'):String
		{
			var t_h:Number = Math.floor(sec / 3600);
			t_h = isNaN(t_h) ? 0 : t_h;

			var t_m:Number = Math.floor((sec % 3600) / 60);
			t_m = isNaN(t_m) ? 0 : t_m;

			var t_s:Number = Math.floor((sec % 3600) % 60);
			t_s = isNaN(t_s) ? 0 : t_s;

			var t_ten:Number = 10;
			var t_ns:String = '0';

			var t_rv:String =
				(
					(t_h == 0) ?
						('') :
						(
							(t_h < t_ten) ?
								(t_ns + t_h.toString() + token) :
								(t_h.toString() + token)
						)
				) +
				(
					(
						(t_m < t_ten) ?
							(t_ns + t_m.toString()) :
							(t_m.toString())
					) + token +
					(
						(t_s < t_ten) ?
							(t_ns + t_s.toString()) :
							(t_s.toString())
					)
				);

			return t_rv;
		}
	}
}






