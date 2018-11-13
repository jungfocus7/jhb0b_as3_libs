package hbx.found
{
    import flash.display.MovieClip;
    import flash.events.MouseEvent;

    import hbx.core.CEventCore;
    import hbx.core.CMovieClipWrapper;
    import hbx.core.ISelected;



    public class CBumButton extends CMovieClipWrapper implements ISelected
    {
		public static const ET_ROLL_OUT:String = MouseEvent.ROLL_OUT;
		public static const ET_ROLL_OVER:String = MouseEvent.ROLL_OVER;
		public static const ET_MOUSE_UP:String = MouseEvent.MOUSE_UP;
		public static const ET_MOUSE_DOWN:String = MouseEvent.MOUSE_DOWN;
		public static const ET_CLICK:String = MouseEvent.CLICK;



        public function CBumButton(
			mvc:MovieClip, frameArr:Array = null, isToggleMode:Boolean = false, isListMode:Boolean = false)
        {
            super(mvc);
            _mvc.gotoAndStop(1);
			_frameArr = (frameArr == null) ? _DEFAULT_FRAME_ARR : frameArr;
			_isToggleMode = isToggleMode;
			_isListMode = isListMode;
			set_enabled(true);
        }


		private static const _DEFAULT_FRAME_ARR:Array = ['#01', '#02', '#03', '#04', '#05', '#06'];

		private static const _MOUSE_OUT_IDX:uint = 0;
		private static const _MOUSE_OVER_IDX:uint = 1;
		private static const _MOUSE_DOWN_IDX:uint = 2;


		private var _frameArr:Array;
		private var _isToggleMode:Boolean;
		private var _isListMode:Boolean;

		private var _originIdx:uint = 0;
		private var _nowIdx:uint = _MOUSE_OUT_IDX;
		private var _isMouseDown:Boolean = false;
		private var _selected:Boolean = false;



		public override function dispose():void
		{
			if (_frameArr == null) return;
			_frameArr = null;
			super.dispose();
		}


		public override function set_enabled(b:Boolean):void
		{
			if (b != _enabled)
			{
				_enabled = b;
				if (_enabled)
				{
					_mvc.mouseChildren = false;
					_mvc.buttonMode = true;
					_mvc.addEventListener(MouseEvent.ROLL_OUT, pp_mvc_rollOut);
					_mvc.addEventListener(MouseEvent.ROLL_OVER, pp_mvc_rollOver);
					_mvc.addEventListener(MouseEvent.MOUSE_UP, pp_mvc_mouseUp);
					_mvc.addEventListener(MouseEvent.MOUSE_DOWN, pp_mvc_mouseDown);
					_mvc.addEventListener(MouseEvent.CLICK, pp_mvc_click);
				}
				else
				{
					_mvc.mouseChildren = true;
					_mvc.buttonMode = false;
					_mvc.removeEventListener(MouseEvent.ROLL_OUT, pp_mvc_rollOut);
					_mvc.removeEventListener(MouseEvent.ROLL_OVER, pp_mvc_rollOver);
					_mvc.removeEventListener(MouseEvent.MOUSE_UP, pp_mvc_mouseUp);
					_mvc.removeEventListener(MouseEvent.MOUSE_DOWN, pp_mvc_mouseDown);
					_mvc.removeEventListener(MouseEvent.CLICK, pp_mvc_click);
				}
			}
		}


		private function pp_mvc_rollOut(evt:MouseEvent):void
		{
			_nowIdx = _MOUSE_OUT_IDX;
			pp_frameUpdate();
			evt.updateAfterEvent();

			this.dispatchEvent(new CEventCore(evt.type));
		}

		private function pp_mvc_rollOver(evt:MouseEvent):void
		{
			if (_isMouseDown)
				_nowIdx = _MOUSE_DOWN_IDX;
			else
				_nowIdx = _MOUSE_OVER_IDX;
			pp_frameUpdate();
			evt.updateAfterEvent();

			this.dispatchEvent(new CEventCore(evt.type));
		}

		private function pp_mvc_mouseUp(evt:MouseEvent):void
		{
			this.dispatchEvent(new CEventCore(evt.type));
		}

		private function pp_mvc_mouseDown(evt:MouseEvent):void
		{
			_nowIdx = _MOUSE_DOWN_IDX;
			pp_frameUpdate();
			_isMouseDown = true;
			_stage.addEventListener(MouseEvent.MOUSE_UP, pp_stage_mouseUp);
			evt.updateAfterEvent();

			this.dispatchEvent(new CEventCore(evt.type));
		}

		private function pp_mvc_click(evt:MouseEvent):void
		{
			_nowIdx = _MOUSE_OVER_IDX;
			if (_isListMode)
				pp_frameUpdate();
			else
			{
				if (_isToggleMode)
					pp_set_selected(!_selected);
				else
					pp_frameUpdate();
			}
			evt.updateAfterEvent();

			this.dispatchEvent(new CEventCore(evt.type));
		}


		private function pp_frameUpdate():void
		{
			var idx:uint = _originIdx + _nowIdx;
			var fl:String = _frameArr[idx];
			try
			{
				_mvc.gotoAndStop(fl);
			}
			catch (e:Error) {}
		}


		private function pp_stage_mouseUp(evt:MouseEvent):void
		{
			if (_isMouseDown)
			{
				_isMouseDown = false;
				_stage.removeEventListener(MouseEvent.MOUSE_UP, pp_stage_mouseUp);
			}
		}

		private function pp_set_selected(b:Boolean, be:Boolean = false):void
		{
			if (_isToggleMode)
			{
				if (b != _selected)
				{
					_selected = b;
					if (_selected)
						_originIdx = 3;
					else
						_originIdx = 0;
					pp_frameUpdate();

					if (be)
						this.dispatchEvent(new CEventCore(ET_CLICK));
				}
			}
		}


		public function get_selected():Boolean
		{
			if (_isToggleMode)
				return _selected;
			else
				return false;
		}

		public function set_selected(b:Boolean):void
		{
			pp_set_selected(b);
		}

		public function set_selectedDispatch(b:Boolean):void
		{
			pp_set_selected(b, true);
		}

    }
}