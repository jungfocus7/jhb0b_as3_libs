package jhb0b.utils
{
	public final class MObjectUtil
	{
		//:: 오브젝트에서 동적 콜백 호출
		public static function dispatch_callBack(
								tobj:Object, eventObj:Object):void
		{
			if (tobj.onCallBack != undefined)
				tobj.onCallBack(eventObj);
		}

		//:: 오브젝트에서 동적 콜백 호출
		public static function dispatch_callBack2(
								tobj:Object, eObj:Object, fn:String = null):void
		{
			if (fn == null)
				fn = '_onCallBack';

			var t_f:Function = tobj[fn];
			if (t_f != null)
				t_f(eObj);
		}

		//:: 오브젝트에서 동적 메서드 호출
		public static function call_method(
								tobj:Object, name:String, args:Array = null):void
		{
			var t_func:Function = tobj[name];
			if (t_func != null)
				t_func.apply(null, args);
		}

		//:: 오브젝트에서 동적 속성들 모드 나열하여 스트링 반환
		public static function get_toString(tobj:Object):String
		{
			var t_rv:String = '';

			for (var t_p:String in tobj)
			{
				t_rv += t_p + ': ' + tobj[t_p] + ', ';
			}
			t_rv = t_rv.substr(0, t_rv.length - 2);

			return t_rv;
		}
	}
}
