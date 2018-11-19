package hbx.utils
{
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;



	public final class MTextFieldUtil
	{
		/**
		 * 텍스트필드 글자 잘라서 표현
		 * <br/>
		 * @param ttf: TargetTextField
		 * @param str: String
		 * @param gan: 간격
		 * @param takeStr: 대신 채워질 문자열
		 */
		public static function cutting_last(ttf:TextField, str:String, gan:Number, takeStr:String = '...'):void
		{
			var tstr:String = '';
			for (var l:uint = str.length, i:uint = 0; i < l; i++)
			{
				tstr = tstr + str.charAt(i);
				ttf.text = tstr;
				if (ttf.textWidth >= gan)
				{
					ttf.appendText(takeStr);
					break;
				}
			}
		}


		/**
		 * 컨테이너에서 텍스트필드를 찾아서 텍스트 반환
		 * <br/>
		 * @param dpoc: DisplayObjectContainer
		 * @param tfnm: TextFieldName
		 */
		public static function get_text(dpoc:DisplayObjectContainer, tfnm:String):String
		{
			var tf:TextField = dpoc[tfnm];
			if (tf == null) return null;
			return tf.text;
		}


		/**
		 * 컨테이너에서 텍스트필드를 찾아서 텍스트 대입
		 * <br/>
		 * @param dpoc: DisplayObjectContainer
		 * @param tfnm: TextFieldName
		 * @param v: String
		 */
		public static function set_text(dpoc:DisplayObjectContainer, tfnm:String, v:String):void
		{
			var tf:TextField = dpoc[tfnm];
			if (tf == null) return;
			tf.text = v;
		}


		/**
		 * 컨테이너에서 텍스트필드를 찾아서 텍스트 추가대입
		 * <br/>
		 * @param dpoc: DisplayObjectContainer
		 * @param tfnm: TextFieldName
		 * @param v: String
		 * @param bnl: BooleanNewLine
		 * @param bes: BooleanEndScroll
		 */
		public static function append_text(
			dpoc:DisplayObjectContainer, tfnm:String, v:String, bnl:Boolean = false, bes:Boolean = false):void
		{
			var tf:TextField = dpoc[tfnm];
			if (tf == null) return;

			var ml:Boolean = tf.multiline;
			if (bnl && ml)
				tf.appendText(v + '\n');
			else
				tf.appendText(v);
			if (bes && ml)
				tf.scrollV = tf.maxScrollV;
		}


		/**
		 * 컨테이너에서 텍스트필드를 찾아서 텍스트 비우기
		 * <br/>
		 * @param dpoc: DisplayObjectContainer
		 * @param tfnm: TextFieldName
		 */
		public static function clear_text(dpoc:DisplayObjectContainer, tfnm:String):void
		{
			set_text(dpoc, tfnm, '');
		}

	}
}
