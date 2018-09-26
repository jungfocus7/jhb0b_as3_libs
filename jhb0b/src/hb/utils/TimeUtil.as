/**
	@Name: TimeUtil
	@Author: HobisJung(jhb0b@naver.com)
	@Date: 2016-01-22
	@Comment:
	{
	}
	@Using:
	{
		import hb.utils.TimeUtil;
		trace(TimeUtil.formatAsTimeCode(60));
	}
*/
package hb.utils
{
	public final class TimeUtil
	{
		public function TimeUtil()
		{
		}

		// ::
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

		// ::
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
