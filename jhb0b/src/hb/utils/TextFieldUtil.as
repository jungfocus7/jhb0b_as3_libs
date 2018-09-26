/**
	@Name: TextFieldUtil
	@Author: HobisJung(jhb0b@naver.com)
	@Date: 2016-01-22
	@Comment:
	{
	}
*/
package hb.utils
{
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;

	//
	// #
	public final class TextFieldUtil
	{
		public function TextFieldUtil()
		{
		}

		// :: Text Cutting
		public static function lastCut(target:TextField, str:String,
										gan:Number, lastTakeStr:String = null):void
		{
			if (lastTakeStr == null)
				lastTakeStr = '...';

			var t_str:String = '';
			var t_la:Number = str.length;
			var i:uint;
			for (i = 0; i < t_la; i++)
			{
				t_str = t_str + str.charAt(i);
				target.text = t_str;

				if (target.textWidth >= gan)
				{
					target.appendText(lastTakeStr);
					break;
				}
			}
		}

		////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		// :: 
		public static function get_text(cont:DisplayObjectContainer, tfn:String):String
		{
			var t_tf:TextField = cont[tfn];
			if (t_tf == null) return null;
			return t_tf.text;
		}
		
		// :: 
		public static function set_text(cont:DisplayObjectContainer, tfn:String, v:String):void
		{
			var t_tf:TextField = cont[tfn];
			if (t_tf == null) return;
			t_tf.text = v;
		}		
		
		// :: 
		public static function append_text(cont:DisplayObjectContainer, tfn:String, v:String):void
		{
			var t_tf:TextField = cont[tfn];
			if (t_tf == null) return;
			t_tf.appendText(v);
		}
		
		// :: 
		public static function clear_text(cont:DisplayObjectContainer, tfn:String):void
		{
			set_text(cont, tfn, '');
		}
		


	}
}
