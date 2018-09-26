/**
	@Name: SliderLogicFrame
	@Author: HobisJung(jhb0b@naver.com)
	@Blog: http://blog.naver.com/jhb0b
	@Date: 2016-05-10
	@Using:
	{
		// # 본 클래스는 슬라이더바를 프래임방식으로 처리합니다.
	}
*/
package hbworks.uilogics
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import hb.core.ICallBack;
	import hb.core.IDisposable;
	import hb.core.INamer;


	public final class SliderFrameLogic implements ICallBack, IDisposable, INamer
	{
		// - 슬라이더 세로방향
		public static const TYPE_HORIZONTAL:String = 'horizontal';
		// - 슬라이더 가로방향
		public static const TYPE_VERTICAL:String = 'vertical';

		// - 슬라이더 업데이트
		public static const CT_UPDATE:String = 'update';
		// - 슬라이더 마우스업
		public static const CT_MOUSE_UP:String = 'mouseUp';
		// - 슬라이더 마우스다운
		public static const CT_MOUSE_DOWN:String = 'mouseDown';


		// :: 생성자
		public function SliderFrameLogic(
							targetCont:MovieClip, type:String,
							scrollBasePos:Number, scrollSize:Number,
							name:String = null)
		{
			_targetCont = targetCont;
			_type = type;
			_scrollBasePos = scrollBasePos;
			_scrollSize = scrollSize;
			_name = name;
			_stage = _targetCont.stage;
			p_init_once();
		}

		////////////////////////////////////////////////////////////////////////////////////////////////////
		//{{{ Implements
		////////////////////////////////////////////////////////////////////////////////////////////////////
		private var _callBack:Function = null;
		public function dispatch_callBack(eObj:Object):void
		{
			if (_callBack == null) return;
			_callBack(eObj);
		}
		public function set_callBack(f:Function):void
		{
			_callBack = f;
		}

		public function dispose():void
		{
			if (_targetCont == null) return;
			_stage.removeEventListener(MouseEvent.MOUSE_UP, p_stage_mouseUp);
			_stage.removeEventListener(MouseEvent.MOUSE_MOVE, p_stage_mouseMove);
			_targetCont.removeEventListener(MouseEvent.MOUSE_DOWN, p_mouseDown);
			_type = null;
			_name = null;
			_stage = null;
			_callBack = null;
			_targetCont = null;
		}
		//}}}
		////////////////////////////////////////////////////////////////////////////////////////////////////

		// :: 마우스 무브 핸들러
		private function p_stage_mouseMove(event:MouseEvent):void
		{
			var t_v:Number;
			var t_ratio:Number;
			if (_type == TYPE_HORIZONTAL)
			{
				t_v = _targetCont.mouseX - _scrollBasePos;
				t_ratio = t_v / _scrollSize;
			}
			else
			if (_type == TYPE_VERTICAL)
			{
				t_v = _targetCont.mouseY - _scrollBasePos;
				t_ratio = t_v / _scrollSize;
			}

			if (t_ratio < 0)
				t_ratio = 0;
			else
			if (t_ratio > 1)
				t_ratio = 1;


			var t_frame:int = int(Math.round(t_ratio * (_targetCont.totalFrames - 1))) + 1;
			_targetCont.gotoAndStop(t_frame);

			this.dispatch_callBack({type: CT_UPDATE});

			event.updateAfterEvent();
		}

		// :: 마우스 업 핸들러
		private function p_stage_mouseUp(event:MouseEvent):void
		{
			_stage.removeEventListener(MouseEvent.MOUSE_UP, p_stage_mouseUp);
			_stage.removeEventListener(MouseEvent.MOUSE_MOVE, p_stage_mouseMove);

			this.dispatch_callBack({type: CT_MOUSE_UP});
		}

		// :: 마우스 다운 핸들러
		private function p_mouseDown(event:MouseEvent):void
		{
			_stage.addEventListener(MouseEvent.MOUSE_UP, p_stage_mouseUp);
			_stage.addEventListener(MouseEvent.MOUSE_MOVE, p_stage_mouseMove);

			this.dispatch_callBack({type: CT_MOUSE_DOWN});

			p_stage_mouseMove(new MouseEvent(MouseEvent.MOUSE_MOVE));
		}

		// :: 초기화
		private function p_init_once():void
		{
			_targetCont.gotoAndStop(1);
			_targetCont.mouseChildren = false;
			_targetCont.buttonMode = true;
			_targetCont.addEventListener(MouseEvent.MOUSE_DOWN, p_mouseDown);
		}

		// - 슬라이더 타겟 무비클립 컨테이너
		private var _targetCont:MovieClip = null;
		public function get_targetCont():MovieClip
		{
			return _targetCont;
		}

		// - 슬라이더 타입
		private var _type:String = null;
		public function get_type():String
		{
			return _type;
		}


		// -
		private var _scrollBasePos:Number;
		// -
		private var _scrollSize:Number;


		// - 객체 이름 설정
		private var _name:String = null;
		public function get_name():String
		{
			return _name;
		}

		// - 스테이지 참조
		private var _stage:Stage = null;


		// :: 슬라이더 비율 반환
		public function get_ratio():Number
		{
			var t_rv:Number = (_targetCont.currentFrame - 1) / (_targetCont.totalFrames - 1);
			return t_rv;
		}
		// :: 슬라이더 비율 설정
		public function set_ratio(v:Number):void
		{
			if (v < 0)
			{
				v = 0;
			}
			else if (v > 1)
			{
				v = 1;
			}

			var t_frame:int = int(Math.round(v * (_targetCont.totalFrames - 1))) + 1;
			_targetCont.gotoAndStop(t_frame);
		}
	}

}
