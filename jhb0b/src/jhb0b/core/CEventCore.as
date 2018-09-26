package jhb0b.core
{
	import flash.events.EventDispatcher;
	import jhb0b.tools.MDebugTool;


	public class CEventCore extends EventDispatcher implements IDisposable
	{
		public function CEventCore()
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