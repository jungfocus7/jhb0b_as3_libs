﻿package hbx.core
{
	import flash.display.DisplayObjectContainer;


	public class CDisplayObjectContainerWrapper extends CDisplayObjectWrapper implements IContainerObserver
	{
		public function CDisplayObjectContainerWrapper(container:DisplayObjectContainer)
		{
			super(container);
			_container = container;
		}

		protected var _container:DisplayObjectContainer;
		public function get_container():DisplayObjectContainer
		{
			return _container;
		}


		public override function dispose():void
		{
			if (_container == null) return;
			_container = null;
			super.dispose();
		}
	}

}