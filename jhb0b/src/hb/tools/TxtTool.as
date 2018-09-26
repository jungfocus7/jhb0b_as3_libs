package hb.tools
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	

	public final class TxtTool
	{
		public function TxtTool()
		{
		}

		public static function start(cont:MovieClip, frontName:String = null):void
		{
			_cont = cont;
			_frontName = (frontName == null) ? 'tf_' : frontName;
		}
		private static var _cont:MovieClip = null;
		public static function get_cont():MovieClip
		{
			return _cont;
		}

		private static var _frontName:String = null;

		public static function stop():void
		{
			_cont = null;
			_frontName = null;
		}

		private static function p_get_tf(lastName:String):TextField
		{
			if (_cont == null) return null;
			if (_frontName == null) return null;
			var t_tf:TextField = _cont[_frontName + lastName];
			return t_tf;
		}

		public static function get(lastName:String):String
		{
			var t_tf:TextField = p_get_tf(lastName);
			if (t_tf == null) return null;
			return t_tf.text;
		}

		public static function set(lastName:String, v:String):void
		{
			var t_tf:TextField = p_get_tf(lastName);
			if (t_tf == null) return;
			t_tf.text = v;
		}

		public static function add(lastName:String, v:String, bNewLine:Boolean = true):void
		{
			var t_tf:TextField = p_get_tf(lastName);
			if (t_tf == null) return;
			if (bNewLine)
				t_tf.appendText(v + '\n');
			else
				t_tf.appendText(v);
		}

		public static function clear(lastName:String):void
		{
			var t_tf:TextField = p_get_tf(lastName);
			if (t_tf == null) return;
			t_tf.text = '';
		}
	}

}
