package jhb0b.utils
{
	public final class MArrayUtil
	{
		//::
		public static function is_empty(tarr:Array):Boolean
		{
			if ((tarr == null) ||
				(tarr.length == 0))
			{
				return true;
			}
			else
			{
				return false;
			}
		}

		//:: 배열에서 값이 있는지 여부
		public static function is_contains(tarr:Array, eo:Object):Boolean
		{
			var t_rv:Boolean = false;

			var t_l:uint = tarr.length;
			for (var i:uint = 0; i < t_l; i ++)
			{
				if (tarr[i] == eo)
				{
					t_rv = true;
					break;
				}
			}

			return t_rv;
		}

		//:: 배열 요소가 순서대로 같은지 여부 (1차원배열만, 길이도 같아야 됨)
		public static function equals1(tarr1:Array, tarr2:Array):Boolean
		{
			var t_rv:Boolean = false;

			if (tarr1 == tarr2)
			{
				t_rv = true;
			}
			else
			{
				if (tarr1.length == tarr2.length)
				{
					var t_l:uint = tarr1.length;
					for (var i:uint = 0; i < t_l; i ++)
					{
						t_rv = (tarr1[i] == tarr2[i]);

						if (!t_rv) break;
					}
				}
			}

			return t_rv;
		}

		//:: 배열 요소가 섞여 있어도 값이 개수만큼 같은지 여부
		public static function equals2(tarr1:Array, tarr2:Array):Boolean
		{
			var t_rv:Boolean = false;

			var t_bool:Boolean = false;
			var t_count:int = 0;

			var t_la:uint, i:uint;
			var t_lb:uint, j:uint;

			t_la = tarr1.length;
			for (i = 0; i < t_la; i ++)
			{
				t_lb = tarr2.length;
				for (j = 0; j < t_lb; j ++)
				{
					if (tarr1[i] == tarr2[j])
					{
						t_bool = true;
						break;
					}
				}

				if (t_bool)
				{
					t_bool = false;
					t_count++;
				}
			}

			if (t_count >= t_la)
				t_rv = true;

			return t_rv;
		}

		//:: 다중배열에서 배열이 아닌 원소의 총개수를 구하는 함수
		public static function get_totalLength(tarr:Array):uint
		{
			var t_rv:uint = 0;

			var t_eo:Object;
			var t_l:uint = tarr.length;
			for (var i:uint = 0; i < t_l; i ++)
			{
				t_eo = tarr[i];

				if (t_eo is Array)
					t_rv += arguments.callee(t_eo);
				else
					t_rv++;
			}

			return t_rv;
		}

		//:: 배열 섞기
		public static function shuffle(tarr:Array):void
		{
			var t_eo:Object = null;
			var t_ranIdx:uint;

			var t_l:uint = tarr.length;
			for (var i:uint = 0; i < t_l; i ++)
			{
				t_eo = tarr[i];
				t_ranIdx = uint(MNumberUtil.randRange(0, t_l - 1));

				tarr[i] = tarr[t_ranIdx];
				tarr[t_ranIdx] = t_eo;
			}
		}

		//:: 배열 카피
		public static function copy(tarr:Array):Array
		{
			return tarr.slice();
		}

		//:: 배열 요소 개수만큼 콜백실행
		/**
			@Params:
			{
				target: 타겟배열
				loopFunc: 반복콜백함수
				loopFuncParams: 반복콜백함수인자
			}

			@Using:
			{
				var m_arr:Array = [
					new MovieClip, 2, 3, 4, 5
				];
				ArrayUtil.forEach(this.m_arr,
					function(eo:Object, index:uint):void
					{
						trace('eo: ' + eo);
						trace('index: ' + index);
					}
				);
			}
		*/
		public static function forEach(tarr:Array,
						loopFunc:Function, loopFuncParams:Array = null):void
		{
			var t_l:uint = tarr.length;
			var i:uint = 0;
			while (i < t_l)
			{
				if (loopFuncParams != null)
					loopFunc.apply(null, [tarr[i], i].concat(loopFuncParams));
				else
					loopFunc(tarr[i], i);

				i++;
			}
		}


		//:: 배열 요소 삭제
		public static function remove(tarr:Array, eo:Object):void
		{
			for (
				var t_l:uint = tarr.length,
					i:uint = 0;
				i < t_l; i++)
			{
				if (tarr[i] == eo)
				{
					tarr.splice(i, 1);
					break;
				}
			}
		}

		//:: 배열 요소 삭제
		public static function removeAt(tarr:Array, i:uint):void
		{
			tarr.splice(i, 1);
		}

		//:: 배열 요소 인덱스
		public static function get_index(tarr:Array, value:Object):int
		{
			var t_rv:int = -1;

			for (
				var t_l:uint = tarr.length,
					i:uint = 0;
				i < t_l; i++)
			{
				if (tarr[i] == value)
				{
					t_rv = i;
					break;
				}
			}

			return t_rv;
		}







		//:: 배열 요소 중복제거
		public static function distinct(tarr:Array):Array {
			if ((tarr == null) || (tarr.length < 1)) return null;

			var tl:uint = tarr.length;
			var tna:Array = [];

			for (var i:uint = 0; i < tl; i++)
			{
				var te:* = tarr[i];
				if (tna.indexOf(te) == -1) {
					tna.push(te);
				}
			}

			return tna;
		}
	}

}
