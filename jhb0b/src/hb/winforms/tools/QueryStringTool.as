/*
@Name: QueryStringTool
@Author: HobisJung
@Date: 2015-10-04
@Comment: {

# 사용법
// 오브젝트를 -> 쿼리스트링으로 변환 (역직렬화)
QueryStringTool.convert_qStr({name: 'Hobis', job: 'Developer'});
// 쿼리스트링을 -> 오브젝트를로 변환 (직렬화)
QueryStringTool.convert_pObj('name=Hobis&job=Developer');

}
==================================================================================================== */
package hb.winforms.tools
{
	public class QueryStringTool
	{
		public function QueryStringTool() {}

		// :: pObj -> qStr
		public static function toString(pObj:Object):String
		{
			var t_rv:String = null;

			for (var t_p:String in pObj)
			{
				if (t_rv == null)
					t_rv = '';

				var t_valStr:String = pObj[t_p];
				t_valStr = encodeURIComponent(t_valStr);
				var t_addStr:String = t_p + '=' + t_valStr + '&';
				t_rv += t_addStr;
			}

			if (t_rv != null)
				t_rv = t_rv.substr(0, t_rv.length - 1);

			return t_rv;
		}

		// :: qStr -> pObj
		public static function toObject(qStr:String):Object
		{
			var t_rv:Object = null;

			var t_nvss:Array = qStr.split('&');
			if (t_nvss != null)
			{
				for each (var t_nvs:String in t_nvss)
				{
					if (t_rv == null)
						t_rv = {};

					var t_pis:Array = t_nvs.split('=');
					var t_pin:String = t_pis[0];
					var t_piv:String = decodeURIComponent(t_pis[1]);
					t_rv[t_pin] = t_piv;
				}
			}

			return t_rv;
		}
	}
}
