/**
	@Name: ButtonLogic
	@Author: HobisJung(jhb0b@naver.com)
	@Blog: http://blog.naver.com/jhb0b
	@Date: 2016-05-10
	@Using:
	{
		// 	타겟이 되는 MovieClip의 프래임 정보
		//	#_0: Select_Out
		//	#_1: Select_Over
		//	#_2: Select_Down
		//	#_3: Unselect_Out
		//	#_4: Unselect_Over
		//	#_5: Unselect_Down

		var t_bl:ButtonLogic = new ButtonLogic(this.rect_mc, true);
		t_bl.enabled = false;
		t_bl.addEventListener(MouseEvent.CLICK,
			function(event:Event):void
			{
				t_bl2.selected = !t_bl2.selected;
			}
		);
	}
*/
package hbworks.uilogics
{
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import hb.core.IDisposable;
	import hb.utils.StringUtil;

	public class ButtonLogic extends EventDispatcher implements IDisposable
	{
		// ----------------------------------------------------------------------------------------------------
		//	 Initialize
		// ----------------------------------------------------------------------------------------------------
		// :: 생성자
		public function ButtonLogic(target:MovieClip, isUseToggle:Boolean = false)
		{
			_target = target;
			_isUseToggle = isUseToggle;
			p_setEnabled(true);
		}

		// :: 객체 활성화 설정
		private function p_setEnabled(b:Boolean):void
		{
			if (b != _enabled)
			{
				_enabled = b;

				if (_enabled)
				{
					_target.mouseChildren = false;
					_target.buttonMode = true;
					_target.addEventListener(MouseEvent.ROLL_OVER, p_target_moodc);
					_target.addEventListener(MouseEvent.ROLL_OUT, p_target_moodc);
					_target.addEventListener(MouseEvent.MOUSE_DOWN, p_target_moodc);
					_target.addEventListener(MouseEvent.MOUSE_UP, p_target_moodc);
					_target.addEventListener(MouseEvent.CLICK, p_target_moodc);
				}
				else
				{
					_target.mouseChildren = true;
					_target.buttonMode = false;
					_target.removeEventListener(MouseEvent.ROLL_OVER, p_target_moodc);
					_target.removeEventListener(MouseEvent.ROLL_OUT, p_target_moodc);
					_target.removeEventListener(MouseEvent.MOUSE_DOWN, p_target_moodc);
					_target.removeEventListener(MouseEvent.MOUSE_UP, p_target_moodc);
					_target.removeEventListener(MouseEvent.CLICK, p_target_moodc);
					p_stage_mu(null);
				}
			}
		}

		private var _target:MovieClip = null;
		private var _enabled:Boolean = false;

		private var _isUseToggle:Boolean = false;
		private var _isDown:Boolean = false;

		private static const _TOGGLE_FRAME_UINT:int = 3;
		private var _baseFrame:int = 0;

		private var _selected:Boolean = false;

		public var isListMode:Boolean = false;
		public var name:String = null;

		// ----------------------------------------------------------------------------------------------------


		// ----------------------------------------------------------------------------------------------------
		//	 Private Functions
		// ----------------------------------------------------------------------------------------------------
		// :: Target MouseEvent Handler(out, over, down, click)
		private function p_target_moodc(event:MouseEvent):void
		{
			switch (event.type)
			{
				case MouseEvent.ROLL_OUT:
				{
					p_gotoFrame(_baseFrame + 0);

					break;
				}
				case MouseEvent.ROLL_OVER:
				{
					if (_isDown)
						p_gotoFrame(_baseFrame + 2);
					else
						p_gotoFrame(_baseFrame + 1);

					break;
				}
				case MouseEvent.MOUSE_UP:
				{

					break;
				}
				case MouseEvent.MOUSE_DOWN:
				{
					_isDown = true;
					_target.stage.addEventListener(MouseEvent.MOUSE_UP, p_stage_mu);
					p_gotoFrame(_baseFrame + 2);

					break;
				}
				case MouseEvent.CLICK:
				{
					if (this.isListMode)
					{
					}
					else
					{
						if (_isUseToggle)
							p_setToggle(!_selected);
					}

					p_gotoFrame(_baseFrame + 1);

					break;
				}
			}


			this.dispatchEvent(event);

			event.updateAfterEvent();

			//DebugUtil.test('p_target_moodc');
			//DebugUtil.test('event.type: ' + event.type);
		}

		// :: Stage Mouse (Up, Down)
		private function p_stage_mu(event:MouseEvent):void
		{
			_target.stage.removeEventListener(MouseEvent.MOUSE_UP, p_stage_mu);
			_isDown = false;
		}

		// :: 타겟 프래임 이동
		private function p_gotoFrame(frame:int):void
		{
			const t_FIRST_STR:String = '#_';
			var t_label:String = t_FIRST_STR + frame;

			try
			{
				_target.gotoAndStop(t_label);
			}
			catch (e:Error) {}

			//DebugUtil.test('t_label: ' + t_label);
		};

		// :: 토글버튼 설정
		private function p_setToggle(b:Boolean):void
		{
			_selected = b;

			if (_selected)
			{
				_baseFrame = _TOGGLE_FRAME_UINT;
			}
			else
			{
				_baseFrame = 0;
			}
		}
		// ----------------------------------------------------------------------------------------------------


		// ----------------------------------------------------------------------------------------------------
		//	 Public Functions
		// ----------------------------------------------------------------------------------------------------
		// :: 버튼 타겟 반환
		public function get_target():MovieClip
		{
			return _target;
		}

		// :: 객체 활성화 상태 반환
		public function get_enabled():Boolean
		{
			return _enabled;
		}

		// :: 객체 활성화 설정
		public function set_enabled(b:Boolean):void
		{
			p_setEnabled(b);
		}

		// :: Selected Getter
		public function get_selected():Boolean
		{
			var t_rv:Boolean = false;

			if (_isUseToggle)
			{
				t_rv = _selected;
			}

			return t_rv;
		}

		// :: SetSelectedIndex
		private function p_setSelected(b:Boolean, isEvent:Boolean = false):void
		{
			if (_isUseToggle)
			{
				if (b != _selected)
				{
					p_setToggle(b);

					var t_v:int = StringUtil.get_lastNum2(_target.currentFrameLabel) % _TOGGLE_FRAME_UINT;
					p_gotoFrame(_baseFrame + t_v);

					if (isEvent)
						this.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
				}
			}
		}

		// :: Selected Setter
		public function set_selected(b:Boolean):void
		{
			p_setSelected(b);
		}

		// :: Selected후 이벤트 발생시키기
		public function set_selectedDispatch(b:Boolean):void
		{
			p_setSelected(b, true);
		}

		// :: 객체제거
		public function dispose():void
		{
			p_setEnabled(false);
			_target.gotoAndStop(1);
			_target = null;
		}
		// ----------------------------------------------------------------------------------------------------

	}

}
