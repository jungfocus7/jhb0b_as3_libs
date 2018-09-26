package jhb0b.utils
{
	public final class MGeomUtil
	{
		// -
		public static const FULL_ANGLE:Number = 360;
		// -
		public static const FULL_RADIAN:Number = Math.PI * 2;
		// -
		public static const TO_RADIANS:Number = Math.PI / 180;
		// -
		public static const TO_ANGLES:Number = 180 / Math.PI;


		//:: Angle To Radian
		public static function get_angleToRadian(a:Number):Number
		{
			return a * TO_RADIANS;
		}

		//:: Radian To Angle
		public static function get_radianToAngle(r:Number):Number
		{
			return r * TO_ANGLES;
		}

		//:: Get Length
		public static function get_length(r:Number, t:Number):Number
		{
			return r * t;
		}

		//:: Get Radius
		public static function get_radius(x:Number, y:Number):Number
		{
			return Math.sqrt((x * x) + (y * y));
		}

		//:: Get Radian
		public static function get_radian(y:Number, x:Number):Number
		{
			return Math.atan2(y, x);
		}

		//:: Get Radian2
		public static function get_radian2(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			var t_distX:Number = x2 - x1;
			var t_distY:Number = y2 - y1;
			return Math.atan2(t_distY, t_distX);
		}

		//:: Get Distance
		public static function get_distance(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			var t_distX:Number = x2 - x1;
			var t_distY:Number = y2 - y1;
			var pn:Number = Math.sqrt((t_distX * t_distX) + (t_distY * t_distY));
			return pn;
		}

		//:: Get Distance2
		public static function get_distance2(p1:Object, p2:Object):Number
		{
			var pn:Number = get_distance(p1.x, p1.y, p2.x, p2.y);
			return pn;
		}

		//:: cos x
		public static function get_x(r:Number, radius:Number):Number
		{
			return Math.cos(r) * radius;
		}

		//:: sin x
		public static function get_y(r:Number, radius:Number):Number
		{
			return Math.sin(r) * radius;
		}

	}
}
