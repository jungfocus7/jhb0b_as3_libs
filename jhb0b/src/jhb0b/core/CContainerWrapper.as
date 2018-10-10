package jhb0b.core
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;


	public class CContainerWrapper extends CEventCore
	{
		public function CContainerWrapper(cont:DisplayObjectContainer)
		{
			_cont = cont;
			_stage = _cont.stage;
		}

		protected var _cont:DisplayObjectContainer;
		public function get_container():DisplayObjectContainer
		{
			return _cont;
		}

		protected var _stage:Stage;
		public function get_stage():Stage
		{
			return _stage;
		}


		override public function dispose():void
		{
			if (_cont == null) return;
			_cont = null;
			_stage = null;
		}
	}

}