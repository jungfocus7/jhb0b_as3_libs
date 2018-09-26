package jhb0b.core
{
	import jhb0b.tools.MDebugTool;


	public class CObjectCore implements IDisposable
	{
		public function CObjectCore()
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