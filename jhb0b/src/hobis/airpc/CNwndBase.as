package hobis.airpc
{
	import flash.display.NativeWindow;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	

	public class CNwndBase extends Sprite
	{		
		public function CNwndBase()
		{
			if (this.stage == null)
				this.addEventListener(Event.ADDED_TO_STAGE, ppInitOnce);
			else
				ppInitOnce(null);
		}
		
		protected function ppInitOnce(evt:Event):void
		{
			_own = this;
			_stg = _own.stage;
			_nwnd = _stg.nativeWindow;
			
			//_nwnd.title = 'CNwndBase~~';
			//MNwndHelper.align_rightBottom(_nwnd, 100, 100);
		}		
		
		protected var _own:Sprite;
		protected var _stg:Stage;
		protected var _nwnd:NativeWindow;
	}
}