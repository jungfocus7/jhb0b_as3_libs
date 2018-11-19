package hbx.utils
{
	public final class MObjectUtil
	{
		/**
		 * 오브젝트에서 동적 콜백 호출
		 * <br/>
		 * @param obj: Object
		 * @param eObj: EventObject
		 */
		public static function dispatch_callBack(obj:Object, eObj:Object):void
		{
			var func:Function = obj['onCallBack'];
			if (func != null)
				func(eObj);
		}


		/**
		 * 오브젝트에서 동적 콜백 호출2
		 * <br/>
		 * @param obj: Object
		 * @param eObj: EventObject
		 * @param fnm: FirstName
		 */
		public static function dispatch_callBack2(obj:Object, eObj:Object, fnm:String = null):void
		{
			if (fnm == null)
				fnm = 'onCallBack';

			var func:Function = obj[fnm];
			if (func != null)
				func(eObj);
		}


		/**
		 * 오브젝트에서 동적 메서드 호출
		 * <br/>
		 * @param obj: Object
		 * @param mnm: MethodName
		 * @param args: Arguments
		 */
		public static function call_method(obj:Object, mnm:String, args:Array = null):void
		{
			var func:Function = obj[mnm];
			if (func != null)
				func.apply(null, args);
		}


		/**
		 * 오브젝트에서 동적 속성들 모드 나열하여 스트링 반환
		 * <br/>
		 * @param obj: Object
		 */
		public static function to_string(obj:Object):String
		{
			var rv:String = '';

			for (var p:String in obj)
			{
				rv += p + ': ' + obj[p] + ', ';
			}
			rv = rv.substr(0, rv.length - 2);

			return rv;
		}

	}
}
