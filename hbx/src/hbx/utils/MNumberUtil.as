package hbx.utils
{
	public final class MNumberUtil
	{
		/**
		 * 실수인지 여부
		 * <br/>
		 * @param v: Value
		 */
		public static function is_float(v:Number):Boolean
		{
			return ((v % 1) != 0);
		}


		/**
		 * 음수인지 여부
		 * <br/>
		 * @param v: Value
		 */
		public static function is_minus(v:Number):Boolean
		{
			return (v < 0);
		}


		/**
		 * 0부터 v-1까지의 난수를 반환
		 * <br/>
		 * @param v: Value
		 */
		public static function random(v:Number):Number
		{
			return Math.round(Math.random() * (v - 1));
		}


		/**
		 * min에서 max사이의 난수를 발생
		 * <br/>
		 * @param min: MinValue
		 * @param max: MaxValue
		 */
		public static function randRange(min:Number, max:Number):Number
		{
			return min + Math.round(Math.random() * (max - min));
		}


		/**
		 * 홀수인지 여부
		 * <br/>
		 * @param v: Value
		 */
		public static function is_odd(v:Number):Boolean
		{
			return ((v % 2) > 0);
		}


		/**
		 * 짝수인지 여부
		 * <br/>
		 * @param v: Value
		 */
		public static function is_even(v:Number):Boolean
		{
			return ((v % 2) == 0);
		}

	}
}
