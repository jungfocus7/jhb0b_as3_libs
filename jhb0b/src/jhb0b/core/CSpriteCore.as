package jhb0b.core
{
	import flash.display.Sprite;

	import jhb0b.tools.MDebugTool;


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