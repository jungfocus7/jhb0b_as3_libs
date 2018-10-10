package jhb0b.core
{
	import flash.display.Sprite;

	import jhb0b.tools.MDebugTool;
	import flash.display.Stage;


	public class CSpriteCore extends Sprite implements IDisposable
	{
		public function CSpriteCore()
		{
			_owner = this;
			_stage = _owner.stage;
		}

		protected var _owner:Sprite;
		protected var _stage:Stage;


		public function dispose():void
		{
			if (_owner == null) return;
			_owner = null;
			_stage = null;
		}

		protected static function p_test(v:String):void
		{
			MDebugTool.test(v);
		}
	}

}