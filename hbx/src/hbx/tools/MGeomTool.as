package hbx.tools
{
	public final class MGeomTool
	{
		//-- Full 라디안
		public static const FULL_RADIAN:Number = Math.PI * 2;
		//-- Full 각도
		public static const FULL_ANGLE:Number = 360;

		//-- 변환용 라디안
		public static const TO_RADIANS:Number = Math.PI / 180;
		//-- 변환용 앵글
		public static const TO_ANGLES:Number = 180 / Math.PI;



		/**
		 * Angle To Radian
		 * <br/>
		 * @param a: Angle
		 */
		public static function get_angleToRadian(a:Number):Number
		{
			return a * TO_RADIANS;
		}


		/**
		 * Radian To Angle
		 * <br/>
		 * @param r: Radian
		 */
		public static function get_radianToAngle(r:Number):Number
		{
			return r * TO_ANGLES;
		}


		/**
		 * Get Length
		 * <br/>
		 * @param r: Radian
		 * @param t: Theta
		 */
		public static function get_length(r:Number, t:Number):Number
		{
			return r * t;
		}


		/**
		 * Get Radius
		 * <br/>
		 * @param x:
		 * @param y:
		 */
		public static function get_radius(x:Number, y:Number):Number
		{
			return Math.sqrt((x * x) + (y * y));
		}


		/**
		 * Get Radian
		 * <br/>
		 * @param y:
		 * @param x:
		 */
		public static function get_radian(y:Number, x:Number):Number
		{
			return Math.atan2(y, x);
		}


		/**
		 * Get Radian2
		 * <br/>
		 * @param x1:
		 * @param y1:
		 * @param x2:
		 * @param y2:
		 */
		public static function get_radian2(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			var dsx:Number = x2 - x1;
			var dsy:Number = y2 - y1;
			return Math.atan2(dsy, dsx);
		}


		/**
		 * Get Distance
		 * <br/>
		 * @param x1:
		 * @param y1:
		 * @param x2:
		 * @param y2:
		 */
		public static function get_distance(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			var dsx:Number = x2 - x1;
			var dsy:Number = y2 - y1;
			var pn:Number = Math.sqrt((dsx * dsx) + (dsy * dsy));
			return pn;
		}


		/**
		 * Get Distance2
		 * <br/>
		 * @param p1: PointObject
		 * @param p2: PointObject
		 */
		public static function get_distance2(p1:Object, p2:Object):Number
		{
			var pn:Number = get_distance(p1.x, p1.y, p2.x, p2.y);
			return pn;
		}


		/**
		 * cos x
		 * <br/>
		 * @param r: Radian
		 * @param radius: Radius
		 */
		public static function get_x(r:Number, radius:Number):Number
		{
			return Math.cos(r) * radius;
		}


		/**
		 * sin x
		 * <br/>
		 * @param r: Radian
		 * @param radius: Radius
		 */
		public static function get_y(r:Number, radius:Number):Number
		{
			return Math.sin(r) * radius;
		}

	}
}
