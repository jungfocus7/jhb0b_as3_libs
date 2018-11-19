package hbx.utils
{
	import hbx.common.CCallback;


	public final class MArrayUtil
	{
		/**
		 * 배열이 비어 있는지 여부
		 * <br/>
		 * @param arr: Array
		 */
		public static function is_empty(arr:Array):Boolean
		{
			if ((arr == null) || (arr.length == 0))
			{
				return true;
			}
			else
			{
				return false;
			}
		}


		/**
		 * 배열에 요소가 포함되어 있는지 여부
		 * <br/>
		 * @param arr: Array
		 * @param eo: ElementObject
		 */
		public static function is_contains(arr:Array, eo:*):Boolean
		{
			var rv:Boolean = false;

			for (var l:uint = arr.length, i:uint = 0; i < l; i++)
			{
				if (arr[i] == eo)
				{
					rv = true;
					break;
				}
			}

			return rv;
		}


		/**
		 * 배열 요소가 순서대로 같은지 여부 (1차원배열만, 길이도 같아야 됨)
		 * <br/>
		 * @param arr1: Array
		 * @param arr2: Array
		 */
		public static function is_equals1(arr1:Array, arr2:Array):Boolean
		{
			var rv:Boolean = false;

			if (arr1 == arr2)
			{
				rv = true;
			}
			else
			{
				if (arr1.length == arr2.length)
				{
					for (var l:uint = arr1.length, i:uint = 0; i < l; i++)
					{
						rv = (arr1[i] == arr2[i]);
						if (!rv) break;
					}
				}
			}

			return rv;
		}


		/**
		 * 배열 요소가 섞여 있어도 값이 개수만큼 같은지 여부
		 * <br/>
		 * @param arr1: Array
		 * @param arr2: Array
		 */
		public static function is_equals2(arr1:Array, arr2:Array):Boolean
		{
			var rv:Boolean = false;

			var b:Boolean = false;
			var c:int = 0;

			for (var la:uint = arr1.length, i:uint = 0; i < la; i++)
			{
				for (var lb:uint = arr2.length, j:uint = 0; j < lb; j++)
				{
					if (arr1[i] == arr2[j])
					{
						b = true;
						break;
					}
				}

				if (b)
				{
					b = false;
					c++;
				}
			}

			if (c >= la)
				rv = true;

			return rv;
		}


		/**
		 * 다중배열에서 배열이 아닌 원소의 총개수를 구하는 함수
		 * <br/>
		 * @param arr: Array
		 */
		public static function get_totalLength(arr:Array):uint
		{
			var rv:uint = 0;

			for (var l:uint = arr.length, i:uint = 0; i < l; i++)
			{
				var eo:* = arr[i];
				if (eo is Array)
					rv += arguments.callee(eo);
				else
					rv++;
			}

			return rv;
		}


		/**
		 * 배열 섞기
		 * <br/>
		 * @param arr: Array
		 */
		public static function shuffle(arr:Array):void
		{
			for (var l:uint = arr.length, i:uint = 0; i < l; i++)
			{
				var eo:* = arr[i];
				var ri:uint = uint(MNumberUtil.randRange(0, l - 1));

				arr[i] = arr[ri];
				arr[ri] = eo;
			}
		}


		/**
		 * 배열 복사
		 * <br/>
		 * @param arr: Array
		 */
		public static function copy(arr:Array):Array
		{
			return arr.slice();
		}


		/**
		 * 배열 요소 개수만큼 콜백실행
		 * <br/>
		 * @param arr: Array
		 */
		public static function forEach(arr:Array, callback:CCallback):void
		{
			var l:uint = arr.length, i:uint = 0;
			while (i < l)
			{
				callback.invoke([arr[i], i]);
				i++;
			}
		}


		/**
		 * 배열 요소 삭제
		 * <br/>
		 * @param arr: Array
		 * @param eo: ElementObject
		 */
		public static function remove(arr:Array, eo:*):void
		{
			for (var l:uint = arr.length, i:uint = 0; i < l; i++)
			{
				if (arr[i] == eo)
				{
					arr.splice(i, 1);
					break;
				}
			}
		}


		/**
		 * 배열 요소 삭제
		 * <br/>
		 * @param arr: Array
		 * @param i: Index
		 */
		public static function removeAt(arr:Array, i:uint):void
		{
			arr.splice(i, 1);
		}


		/**
		 * 배열 요소 인덱스 반환
		 * <br/>
		 * @param arr: Array
		 * @param eo: ElementObject
		 */
		public static function get_index(arr:Array, eo:*):int
		{
			var rv:int = -1;

			for (var l:uint = arr.length, i:uint = 0; i < l; i++)
			{
				if (arr[i] == eo)
				{
					rv = i;
					break;
				}
			}

			return rv;
		}


		/**
		 * 배열 요소 중복제거
		 * <br/>
		 * @param arr: Array
		 */
		public static function distinct(arr:Array):Array
		{
			if ((arr == null) || (arr.length < 1)) return null;

			var rv:Array = [];

			for (var l:uint = arr.length, i:uint = 0; i < l; i++)
			{
				var eo:* = arr[i];
				if (rv.indexOf(eo) == -1) {
					rv.push(eo);
				}
			}

			return rv;
		}


	}

}
