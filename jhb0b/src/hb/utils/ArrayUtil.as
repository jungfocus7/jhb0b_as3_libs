/**
	@Name: ArrayUtil
	@Author: HobisJung(jhb0b@naver.com)
	@Date: 2016-01-22
	@Comment:
	{
	}
*/
package hb.utils
{
	import hb.utils.NumberUtil;


	public final class ArrayUtil
	{
		public function ArrayUtil()
		{
		}
		
		
		// :: 
		public static function is_empty(target:Array):Boolean
		{
			if ((target == null) || (target.length == 0))
			{
				return true;
			}
			else
			{
				return false;
			}
		}		
		
		// :: [Array]배열에서 값이 있는지 여부
		public static function is_contains(target:Array, value:Object):Boolean
		{
			var t_rv:Boolean = false;

			var t_la:int, i:int;

			t_la = target.length;

			for (i = 0; i < t_la; i ++)
			{
				if (target[i] === value)
				{
					t_rv = true;
					break;
				}
			}

			return t_rv;
		}

		// :: [Array]배열 요소가 순서대로 같은지 여부 (1차원배열만, 길이도 같아야 됨)
		public static function equals1(aa:Array, ab:Array):Boolean
		{
			var t_rv:Boolean = false;

			if (aa == ab)
				t_rv = true;
			else
			{
				if (aa.length == ab.length)
				{
					var t_la:int = aa.length, i:int;
					for (i = 0; i < t_la; i ++)
					{
						t_rv = (aa[i] == ab[i]);

						if (!t_rv) break;
					}
				}
			}

			return t_rv;
		}

		// :: [Array]배열 요소가 섞여 있어도 값이 개수만큼 같은지 여부
		public static function equals(aa:Array, ab:Array):Boolean
		{
			var t_rv:Boolean = false;

			var t_la:int, i:int;
			var t_lb:int, j:int;
			var t_bool:Boolean = false;
			var t_count:int = 0;

			t_la = aa.length;

			for (i = 0; i < t_la; i ++)
			{
				t_lb = ab.length;

				for (j = 0; j < t_lb; j ++)
				{
					if (aa[i] == ab[j])
						t_bool = true;
				}

				if (t_bool)
				{
					t_count ++;
					t_bool = false;
				}
			}

			if (t_count >= t_la)
				t_rv = true;

			return t_rv;
		}

		// :: [Array]다중배열에서 배열이 아닌 원소의 총개수를 구하는 함수
		public static function get_totalLength(target:Array):uint
		{
			var t_rv:uint = 0;

			var t_len:uint = target.length, i:uint;
			var t_item:Object = null;

			for (i = 0; i < t_len; i ++)
			{
				t_item = target[i];

				if (t_item is Array)
					t_rv += arguments.callee(t_item);
				else
					t_rv ++;
			}

			return t_rv;
		}

		// :: [Array]배열 섞기
		public static function shuffle(target:Array):void
		{
			var t_len:uint = target.length;
			var t_obj:Object = null;
			var t_ranIndex:uint;

			for (var i:uint = 0; i < t_len; i ++)
			{
				t_obj = target[i];
				t_ranIndex = uint(NumberUtil.randRange(0, t_len - 1));

				target[i] = target[t_ranIndex];
				target[t_ranIndex] = t_obj;
			}
		}

		// :: [Array]배열 카피
		public static function copy(target:Array):Array
		{
			return target.slice();
		}

		// :: [Array]배열 요소 개수만큼 콜백실행
		public static function forEach(
											target:Array,
											loopFunc:Function,
											loopFuncParams:Array = null):void
		{
			/**
				@Params:
				{
					target - 타겟배열
					loopFunc - 반복콜백함수
					loopFuncParams - 반복콜백함수인자
				}

				@Using:
				{
					var m_arr:Array = [
						new MovieClip, 2, 3, 4, 5
					];
					ArrayUtil.forEach(this.m_arr,
						function(ei:Object, index:uint):void
						{
							trace('ei: ' + ei);
							trace('index: ' + index);
						}
					);
				}
			*/
			var t_la:uint = target.length;
			var i:uint = 0;

			while (i < t_la)
			{
				if (loopFuncParams != null)
					loopFunc.apply(null, [target[i], i].concat(loopFuncParams));
				else
					loopFunc(target[i], i);

				i ++;
			}
		}
		
		
		// :: [Array]배열 요소 삭제
		public static function remove(target:Array, value:Object):void
		{
			for (
				var i:uint = 0,
					t_la:uint = target.length;
				i < t_la; i++)
			{
				if (target[i] === value)
				{
					target.splice(i, 1);
					break;
				}
			}
		}
		
		// :: [Array]배열 요소 삭제
		public static function removeAt(target:Array, i:uint):void
		{
			target.splice(i, 1);
		}
		
		// :: [Array]배열 요소 인덱스
		public static function get_index(target:Array, value:Object):int
		{
			var t_rv:int = -1;
			
			for (
				var i:int = 0,
					t_la:int = target.length;
				i < t_la; i++)
			{
				if (target[i] === value)
				{
					t_rv = i;
					break;
				}
			}
			
			return t_rv;
		}
	}

}
