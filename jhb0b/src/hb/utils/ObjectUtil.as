/**
	@Name: ObjectUtil
	@Author: HobisJung(jhb0b@naver.com)
	@Date: 2016-01-22
	@Comment:
	{
	}
*/
package hb.utils
{
	public final class ObjectUtil
	{
		public function ObjectUtil()
		{
		}

		// :: 오브젝트에서 동적 콜백 호출
		public static function dispatch_callBack(target:Object, eventObj:Object):void
		{
			if (target.onCallBack != undefined)
				target.onCallBack(eventObj);
		}

		// :: 오브젝트에서 동적 콜백 호출
		public static function dispatch_callBack2(target:Object, eObj:Object, fn:String = null):void
		{
			if (fn == null)
				fn = '_onCallBack';

			var t_f:Function = target[fn];
			if (t_f != null)
				t_f(eObj);
		}

		// :: 오브젝트에서 동적 메서드 호출
		public static function call_method(target:Object, name:String, args:Array = null):void
		{
			var t_func:Function = target[name];
			if (t_func != null)
				t_func.apply(null, args);
		}

		// :: 오브젝트에서 동적 속성들 모드 나열하여 스트링 반환
		public static function get_toString(target:Object):String
		{
			var t_rv:String = '';

			for (var t_p:String in target)
			{
				t_rv += t_p + ': ' + target[t_p] + ', ';
			}
			t_rv = t_rv.substr(0, t_rv.length - 2);

			return t_rv;
		}
	}
}
