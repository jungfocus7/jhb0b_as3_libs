package jhb0b.utils
{
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;


	public final class MTextFieldUtil
	{
		//:: Text Cutting
		public static function cutting_last(ttf:TextField, str:String,
										gan:Number, takeStr:String = null):void
		{
			if (takeStr == null)
				takeStr = '...';

			var t_str:String = '';
			var t_la:Number = str.length;
			var i:uint;
			for (i = 0; i < t_la; i++)
			{
				t_str = t_str + str.charAt(i);
				ttf.text = t_str;

				if (ttf.textWidth >= gan)
				{
					ttf.appendText(takeStr);
					break;
				}
			}
		}

		//::
		public static function get_text(cont:DisplayObjectContainer,
								tfn:String):String
		{
			var t_tf:TextField = cont[tfn];
			if (t_tf == null) return null;
			return t_tf.text;
		}

		//::
		public static function set_text(cont:DisplayObjectContainer,
								tfn:String, v:String):void
		{
			var t_tf:TextField = cont[tfn];
			if (t_tf == null) return;
			t_tf.text = v;
		}

		//::
		public static function append_text(cont:DisplayObjectContainer,
								tfn:String, v:String,
								bnl:Boolean = false, bes:Boolean = false):void
		{
			var t_tf:TextField = cont[tfn];
			if (t_tf == null) return;

			var t_ml:Boolean = t_tf.multiline;
			if (bnl && t_ml)
				t_tf.appendText(v + '\n');
			else
				t_tf.appendText(v);
			if (bes && t_ml)
				t_tf.scrollV = t_tf.maxScrollV;
		}

		//::
		public static function clear_text(cont:DisplayObjectContainer,
								tfn:String):void
		{
			set_text(cont, tfn, '');
		}



	}
}
