/**

// 오브젝트를 -> 쿼리스트링으로 변환 (직렬화)
MQueryStringTool.to_str({name: 'Hobis', job: 'Developer'});
// 쿼리스트링을 -> 오브젝트를로 변환 (역직렬화)
MQueryStringTool.to_obj('name=Hobis&job=Developer');

==================================================================================================== */
package hbx.tools
{
	public final class MQueryStringTool
	{
		/**
		 * ParamObj -> QueryString
		 * <br/>
		 * @param pObj: ParamObj
		 */
		public static function to_str(pObj:Object):String
		{
			var rv:String = null;

			for (var p:String in pObj)
			{
				if (rv == null)
					rv = '';

				var valStr:String = pObj[p];
				valStr = encodeURIComponent(valStr);
				var addStr:String = p + '=' + valStr + '&';
				rv += addStr;
			}

			if (rv != null)
				rv = rv.substr(0, rv.length - 1);

			return rv;
		}


		/**
		 * QueryString -> ParamObj
		 * <br/>
		 * @param qStr: QueryString
		 */
		public static function to_obj(qStr:String):Object
		{
			var rv:Object = null;

			var nvss:Array = qStr.split('&');
			if (nvss != null)
			{
				for each (var nvs:String in nvss)
				{
					if (rv == null)
						rv = {};

					var pis:Array = nvs.split('=');
					var pin:String = pis[0];
					var piv:String = decodeURIComponent(pis[1]);
					rv[pin] = piv;
				}
			}

			return rv;
		}

	}
}
