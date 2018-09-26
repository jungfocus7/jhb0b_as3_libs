package jhb0b.core
{
	import flash.display.DisplayObjectContainer;


	public class CContainerWrapper extends CEventCore implements IContainerObserver
	{
		//:: 생성자
		public function CContainerWrapper(cont:DisplayObjectContainer)
		{
			_cont = cont;
		}

		//- 컨테이너
		protected var _cont:DisplayObjectContainer;
		public function get_container():DisplayObjectContainer
		{
			return _cont;
		}

		//:: 객체패기
		override public function dispose():void
		{
			_cont = null;
		}
	}

}