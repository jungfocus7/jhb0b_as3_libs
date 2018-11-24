package hbx.utils
{
	public final class MStringUtil
	{
		//-- 빈 문자열
		public static const empty:String = '';


		/**
		 * 문자열 데이터가 완전이 없지 여부
		 * <br/>
		 * @param tstr: TargetString
		 */
		public static function is_empty(tstr:String):Boolean
		{
			var rv:Boolean = false;

			if ((tstr == null) || (tstr == '') || (tstr.split(' ').join('').length < 1))
			{
				rv = true;
			}

			return rv;
		}


		/**
		 * 토큰문자 개수만큼 채우기
		 * <br/>
		 * @param tstr: TargetString
		 * @param count: Count
		 * @param token: TokenString
		 */
		public static function fill_token(tstr:String, count:int, token:String = '0'):String
		{
			var l:int = count - tstr.length, i:int = 0;
			while (i < l)
			{
				tstr = token + tstr;
				i++;
			}
			return tstr;
		}


		/**
		 * 문자열 길이 만큼 문자 채우기
		 * <br/>
		 * @param tstr: TargetString
		 * @param astr:
		 */
		public static function fill_rm(tstr:String, astr:String):String
		{
			var la:uint = tstr.length, lb:uint = astr.length;
			if (la < lb)
			{
				var l:uint = lb - la;
				var nstr:String = astr.substr(0, l) + tstr;
				return nstr;
			}
			else
			{
				return tstr;
			}
		}


		/**
		 * 문자열 앞,뒤 공백제거
		 * <br/>
		 * @param tstr: TargetString
		 * @param type: Type(b: Begin, e: End)
		 */
		public static function clear_whiteSpace(tstr:String, type:String = 'be'):String
		{
			const REG_BEGIN:RegExp = /^\s+/;
			const REG_END:RegExp = /\s+$/;

			var rv:String = tstr;

			if (type == 'b')
			{
				rv = rv.replace(REG_BEGIN, '');
			}
			else
			if (type == 'e')
			{
				rv = rv.replace(REG_END, '');
			}
			else
			if (type == 'be')
			{
				rv = rv.replace(REG_BEGIN, '');
				rv = rv.replace(REG_END, '');
			}

			return rv;
		}


		/**
		 * 문자열 치환
		 * <br/>
		 * @param tstr: TargetString
		 * @param ostr: OriginalString
		 * @param nstr: NewString
		 */
		public static function replace(tstr:String, ostr:String, nstr:String):String
		{
			return tstr.split(ostr).join(nstr);
		}


		/**
		 * 라스트 인덱트 찾기
		 * <br/>
		 * @param tstr: TargetString
		 * @param token: TokenString
		 */
		public static function get_lastNum(tstr:String, token:String = '_'):int
		{
			var li:int = tstr.lastIndexOf(token) + 1;
			var rv:int = int(tstr.substr(li));
			return rv;
		}


		/**
		 * 라스트 인덱트 찾기2
		 * <br/>
		 * @param tstr: TargetString
		 * @param step: Step
		 * @param token: TokenString
		 */
		public static function get_lastNum2(name:String, step:uint = 0, token:String = '_'):int
		{
			var rv:int = -1;

			var fi:int = name.length - 1;
			var ti:int, bi:int;
			var len:int;

			for (var i:uint = 0; i <= step; i ++)
			{
				ti = name.lastIndexOf(token, fi);

				if (ti > -1)
				{
					bi = ti + token.length;
					len = (fi - bi) + 1;
					fi = ti - 1;
				}
				else
				{
					bi = -1;
					break;
				}
			}

			if (bi > -1)
			{
				var numStr:String = name.substr(bi, len);
				var check:Number = Number(numStr);
				if (!isNaN(check))
				{
					rv = int(check);
				}
			}

			return rv;
		}



		/**
		 * URL문자열 디코딩
		 * <br/>
		 * @param turl: TargetUrl
		 */
		public static function decode_url(turl:String):String
		{
			return decodeURIComponent(turl);
		}


		/**
		 * URL문자열 인코딩
		 * <br/>
		 * @param turl: TargetUrl
		 */
		public static function encode_url(turl:String):String
		{
			return encodeURIComponent(turl);
		}



		/**
		 * 현재 파일 이름만 반환
		 * <br/>
		 * @param turl: TargetUrl
		 * @param bDec: BooleanDecode
		 */
		public static function get_thisName(turl:String, bDec:Boolean = false):String
		{
			var rv:String = turl;
			if (bDec) rv = decode_url(turl);

			var si:int = rv.lastIndexOf('/') + 1;
			var ei:int = rv.lastIndexOf('.swf');
			rv = rv.substring(si, ei);

			return rv;
		}


		/**
		 * 절대 경로 반환하기
		 * <br/>
		 * @param turl: TargetUrl
		 * @param bDec: BooleanDecode
		 */
		public static function get_baseUrl(turl:String, bDec:Boolean = false):String
		{
			var rv:String = turl;
			if (bDec) rv = decode_url(turl);

			var li:int = rv.lastIndexOf('/');
			rv = rv.substring(0, li);

			return rv;
		}


		/**
		 * 절대 경로에서 추가해서 반환
		 * <br/>
		 * @param turl: TargetUrl
		 * @param bDec: BooleanDecode
		 * @param strAdd: StringAdd
		 */
		public static function add_url(turl:String, bDec:Boolean = false, strAdd:String = ''):String
		{
			return get_baseUrl(turl, bDec) + strAdd;
		}


		/**
		 * 절대 경로에서 추가해서 반환
		 * <br/>
		 * @param turl: TargetUrl
		 * @param bDec: BooleanDecode
		 * @param strExt: StringExtension
		 */
		public static function add_ext(turl:String, bDec:Boolean = false, strExt:String = '.xml'):String
		{
			var rv:String = turl;
			if (bDec) rv = decode_url(turl);

			var ei:int = rv.lastIndexOf('.swf');
			rv = rv.substring(0, ei) + strExt;

			return rv;
		}

	}
}
