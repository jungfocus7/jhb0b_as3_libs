package hbx.found
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	import hbx.core.CMovieClipWrapper;
	import hbx.core.CEventCore;



	public final class CBumSliderFrame extends CMovieClipWrapper
	{
		//- 슬라이더 업데이트
		public static const ET_UPDATE:String = 'update';
		//- 슬라이더 마우스업
		public static const ET_MOUSE_UP:String = MouseEvent.MOUSE_UP;
		//- 슬라이더 마우스다운
		public static const ET_MOUSE_DOWN:String = MouseEvent.MOUSE_DOWN;



		//- 슬라이더 세로방향
		public static const TYPE_HORIZONTAL:String = 'horizontal';
		//- 슬라이더 가로방향
		public static const TYPE_VERTICAL:String = 'vertical';




		override public function dispose():void
		{
			if (_mvc == null) return;
			_mvc.gotoAndStop(1);
			_mvc.mouseChildren = true;
			_mvc.buttonMode = false;
			_mvc.removeEventListener(MouseEvent.MOUSE_DOWN, p_owner_mouseDown);
			_type = null;
			super.dispose();
		}

		//:: 생성자
		public function CBumSliderFrame(tmvc:MovieClip, type:String, scrollBasePos:Number, scrollSize:Number)
		{
			super(tmvc);
			_type = type;
			_scrollBasePos = scrollBasePos;
			_scrollSize = scrollSize;
			_mvc.gotoAndStop(1);
			_mvc.mouseChildren = false;
			_mvc.buttonMode = true;
			_mvc.addEventListener(MouseEvent.MOUSE_DOWN, p_owner_mouseDown);
			_enabled = true;
		}

		//- 슬라이더 타입
		private var _type:String = null;
		public function get_type():String
		{
			return _type;
		}

		//-
		private var _scrollBasePos:Number;
		//-
		private var _scrollSize:Number;

		// :: 마우스 무브 핸들러
		private function p_stage_mouseMove(evt:MouseEvent):void
		{
			var t_v:Number;
			var t_ratio:Number;
			if (_type == TYPE_HORIZONTAL)
			{
				t_v = _mvc.mouseX - _scrollBasePos;
				t_ratio = t_v / _scrollSize;
			}
			else
			if (_type == TYPE_VERTICAL)
			{
				t_v = _mvc.mouseY - _scrollBasePos;
				t_ratio = t_v / _scrollSize;
			}

			if (t_ratio < 0)
				t_ratio = 0;
			else
			if (t_ratio > 1)
				t_ratio = 1;

			var t_fn:int = int(Math.round(t_ratio * (_mvc.totalFrames - 1))) + 1;
			_mvc.gotoAndStop(t_fn);
			this.dispatchEvent(new CEventCore(ET_UPDATE));

			evt.updateAfterEvent();
		}

		// :: 마우스 업 핸들러
		private function p_stage_mouseUp(evt:MouseEvent):void
		{
			_stage.removeEventListener(MouseEvent.MOUSE_UP, p_stage_mouseUp);
			_stage.removeEventListener(MouseEvent.MOUSE_MOVE, p_stage_mouseMove);
			this.dispatchEvent(new CEventCore(ET_MOUSE_UP));
		}

		// :: 마우스 다운 핸들러
		private function p_owner_mouseDown(evt:MouseEvent):void
		{
			_stage.addEventListener(MouseEvent.MOUSE_UP, p_stage_mouseUp);
			_stage.addEventListener(MouseEvent.MOUSE_MOVE, p_stage_mouseMove);
			this.dispatchEvent(new CEventCore(ET_MOUSE_DOWN));
			p_stage_mouseMove(new MouseEvent(MouseEvent.MOUSE_MOVE));
		}


		// :: 슬라이더 비율 반환
		public function get_ratio():Number
		{
			var t_rv:Number =
				(_mvc.currentFrame - 1) / (_mvc.totalFrames - 1);
			return t_rv;
		}
		// :: 슬라이더 비율 설정
		public function set_ratio(v:Number):void
		{
			if (v < 0)
				v = 0;
			else
			if (v > 1)
				v = 1;

			var t_fn:int = int(Math.round(v * (_mvc.totalFrames - 1))) + 1;
			_mvc.gotoAndStop(t_fn);
		}

		override public function get_enabled():Boolean
		{
			return _enabled;
		}
		override public function set_enabled(b:Boolean):void
		{
			if (b != _enabled)
			{
				_mvc.mouseEnabled = b;
				_enabled = b;
			}
		}
	}
}
