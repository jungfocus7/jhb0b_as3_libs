/**
	@Name: LogicCore
	@Author: HobisJung(jhb0b@naver.com)
	@Blog: http://blog.naver.com/jhb0b
	@Date: 2016-05-09
*/
package hbworks.uilogics.core
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import hb.core.IContainerObserver;
	import hb.core.IDisposable;
	import hb.core.INamer;


	public class LogicCore extends EventDispatcher implements IContainerObserver, INamer, IDisposable, ILogic
	{
		public function LogicCore(cont:DisplayObjectContainer, name:String = null)
		{
			if (cont.stage == null)
			{
				throw new Error('LogicCore::(This container is not added in stage.)');
			}
			else
			{
				_cont = cont;
				_stage = _cont.stage;
				_name = name;
			}
		}

		// - Container
		protected var _cont:DisplayObjectContainer = null;
		public function get_container():DisplayObjectContainer
		{
			return _cont;
		}

		// - Stage
		protected var _stage:Stage = null;

		// - Name
		private var _name:String = null;
		public function get_name():String
		{
			return _name;
		}

		public function dispose():void
		{
			if (_cont == null) return;
			_cont = null;
			_stage = null;
			_name = null;
		}

		// -
		private var _enabled:Boolean = true;
		public function get_enabled():Boolean
		{
			return _enabled;
		}
		public function set_enabled(b:Boolean):void
		{
			_enabled = b;
		}

	}

}
