package jhb0b.core
{
	import jhb0b.tools.MDebugTool;
	import flash.display.Sprite;


	public class CSpriteCore extends Sprite implements IDisposable
	{
		public function CSpriteCore()
		{
		}

		public function dispose():void
		{
		}

		protected static function p_test(v:String):void
		{
			MDebugTool.test(v);
		}
	}

}