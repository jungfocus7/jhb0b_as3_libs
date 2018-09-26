/**
	@Name: NumberUtil
	@Author: HobisJung(jhb0b@naver.com)
	@Date: 2016-01-22
	@Comment:
	{
	}
*/
package hb.utils
{
	public final class NumberUtil
	{
		public function NumberUtil()
		{
		}

		// :: 실수인지 여부
		public function is_float(v:Number):Boolean
		{
			var rv:Boolean = false;

			if ((v % 1) != 0) rv = true;

			return rv;
		}

		// :: 음수인지 여부
		public function is_minus(v:Number):Boolean
		{
			var rv:Boolean = false;

			if (v < 0) rv = true;

			return rv;
		}

		// :: 0부터 v-1까지의 난수를 반환
		public static function random(v:Number):Number
		{
			return Math.round(Math.random() * (v - 1));
		}

		// :: min에서 max사이의 난수를 발생
		public static function randRange(min:Number, max:Number):Number
		{
			return min + Math.round(Math.random() * (max - min));
		}

		// :: 홀수인지 여부
		public static function is_oddEven(v:Number):Boolean
		{
			return ((v % 2) > 0);
		}
		
	}
}
