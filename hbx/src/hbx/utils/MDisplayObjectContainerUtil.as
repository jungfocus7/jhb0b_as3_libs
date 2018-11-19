package hbx.utils
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	import hbx.common.CCallback;



	public final class MDisplayObjectContainerUtil
	{
		/**
		 * 자식객체 반복검출 (필터링 없음)
		 * <br/>
		 * @param tcont: TargetContainer
		 * @param callback: CCallback
		 */
		public static function contLoop(tcont:DisplayObjectContainer, callback:CCallback):void
		{
			for (var l:int = tcont.numChildren, i:int = 0; i < l; i++)
			{
				var dpo:DisplayObject = tcont.getChildAt(i);
				if (callback.invoke([dpo, i])) break;
			}
		}


		/**
		 * 자식객체 조건검출 (Regex 정규식 사용)
		 * <br/>
		 * @param tcont: TargetContainer
		 * @param reg: RegExp
		 * @param callback: CCallback
		 */
		public static function contLoop_reg(tcont:DisplayObjectContainer, reg:RegExp, callback:CCallback):void
		{
			for (var l:int = tcont.numChildren, i:int = 0; i < l; i++)
			{
				var dpo:DisplayObject = tcont.getChildAt(i);
				if (reg.test(dpo.name)) {
					if (callback.invoke([dpo, i])) break;
				}
			}
		}


		/**
		 * 자식객체 조건검출 (IndexOf 문자열 접두사 사용)
		 * <br/>
		 * @param tcont: TargetContainer
		 * @param prefix: prefix
		 * @param callback: CCallback
		 */
		public static function contLoop_io(tcont:DisplayObjectContainer, prefix:String, callback:CCallback):void
		{
			for (var l:int = tcont.numChildren, i:int = 0; i < l; i++)
			{
				var dpo:DisplayObject = tcont.getChildAt(i);
				if (dpo.name.indexOf(prefix) > -1)
				{
					if (callback.invoke([dpo, i])) break;
				}
			}
		}


		/**
		 * 자식객체 제거하면서 콜백함수 호출
		 * <br/>
		 * @param tcont: TargetContainer
		 * @param bSub: BooleanSub
		 * @param callback: CCallback
		 */
		public static function contLoop_clear(tcont:DisplayObjectContainer, bSub:Boolean = false, callback:CCallback = null):void
		{
			var i:int = tcont.numChildren;
			while (i > 0)
			{
				var dpo:DisplayObject = tcont.removeChildAt(0);
				if (bSub)
				{
					var dpoc:DisplayObjectContainer = dpo as DisplayObjectContainer;
					if (dpoc != null) {
						arguments.callee(dpoc, bSub, callback);
					}
				}
				if (callback != null) {
					callback.invoke([dpo]);
				}

				i--;
			}
		}











		public static const SORT_TYPE_NAME:String = 'nm';
		public static const SORT_TYPE_X:String = 'x';
		public static const SORT_TYPE_Y:String = 'y';

		private static function pp_childArrSort(sortType:String, arr:Array):void
		{
			if (sortType == SORT_TYPE_NAME)
			{
				arr.sortOn('name');
			}
			else if (sortType == SORT_TYPE_X)
			{
				arr.sort(function(dpo1:DisplayObject, dpo2:DisplayObject):int
				{
					var t1:Number = dpo1.x;
					var t2:Number = dpo2.x;
					if (t1 > t2) return 1;
					else if (t1 < t2) return -1;
					else return 0;
				});
			}
			else if (sortType == SORT_TYPE_Y)
			{
				arr.sort(function(dpo1:DisplayObject, dpo2:DisplayObject):int
				{
					var t1:Number = dpo1.y;
					var t2:Number = dpo2.y;
					if (t1 > t2) return 1;
					else if (t1 < t2) return -1;
					else return 0;
				});
			}
		}

		private static function pp_distinct_childArr(arr:Array):Array
		{
			if ((arr == null) || (arr.length < 1)) return null;

			var esfun:Function = function(cdo:DisplayObject, i:uint, a:Array):Boolean {
				return cdo.name != dpo.name;
			};

			var rv:Array = null;

			for (var l:uint = arr.length, i:uint = 0; i < l; i++)
			{
				var dpo:DisplayObject = arr[i];
				if (rv == null) {
					rv = [dpo];
				}
				else {
					if (rv.every(esfun)) {
						rv.push(dpo);
					}
				}
			}

			return rv;
		}



		/**
		 * DisplayObjectContainer에서 자식객체를 배열에 담고 x 또는 y을 포지션을 기준으로 소팅해서 반환
		 * <br/>
		 * @param tcont: TargetContainer ()
		 * @param dt: Direction ('x', 'y')
		 * @param distinct: BooleanDistinct
		 */
		public static function get_childArr(tcont:DisplayObjectContainer, sortType:String = null, distinct:Boolean = false):Array
		{
			var rv:Array = null;

			for (var l:int = tcont.numChildren, i:int = 0; i < l; i++)
			{
				var dpo:DisplayObject = tcont.getChildAt(i);
				if (rv == null)
					rv = [dpo];
				else
					rv.push(dpo);
			}

			if (rv != null)
			{
				if (sortType != null)
				{
					pp_childArrSort(sortType, rv);
				}

				if (distinct)
				{
					rv = pp_distinct_childArr(rv);
				}
			}

			return rv;
		}


		/**
		 * DisplayObjectContainer에서 자식객체를 배열에 담고 x 또는 y을 포지션을 기준으로 소팅해서 반환
		 * <br/>
		 * @param tcont: TargetContainer ()
		 * @param fnm: FirstName
		 * @param dt: Direction ('x', 'y')
		 * @param distinct: BooleanDistinct
		 */
		public static function get_childArr_io(tcont:DisplayObjectContainer, fnm:String, sortType:String = null, distinct:Boolean = false):Array
		{
			var rv:Array = null;

			for (var l:int = tcont.numChildren, i:int = 0; i < l; i++)
			{
				var dpo:DisplayObject = tcont.getChildAt(i);
				if (dpo.name.indexOf(fnm) > -1)
				{
					if (rv == null) {
						rv = [dpo];
					}
					else {
						rv.push(dpo);
					}
				}
			}

			if (rv != null)
			{
				if (sortType != null)
				{
					pp_childArrSort(sortType, rv);
				}

				if (distinct)
				{
					rv = pp_distinct_childArr(rv);
				}
			}

			return rv;
		}


		/**
		 * DisplayObjectContainer에서 자식객체를 배열에 담고 x 또는 y을 포지션을 기준으로 소팅해서 반환
		 * <br/>
		 * @param tcont: TargetContainer ()
		 * @param reg: RegExp
		 * @param dt: Direction ('x', 'y')
		 * @param distinct: BooleanDistinct
		 */
		public static function get_childArr_reg(cont:DisplayObjectContainer, reg:RegExp, sortType:String = null, distinct:Boolean = false):Array
		{
			var rv:Array;

			for (var l:int = cont.numChildren, i:int = 0; i < l; i++)
			{
				var dpo:DisplayObject = cont.getChildAt(i);
				if (reg.test(dpo.name))
				{
					if (rv == null) {
						rv = [dpo];
					}
					else {
						rv.push(dpo);
					}
				}
			}

			if (rv != null)
			{
				if (sortType != null)
				{
					pp_childArrSort(sortType, rv);
				}

				if (distinct)
				{
					rv = pp_distinct_childArr(rv);
				}
			}

			return rv;
		}

	}
}