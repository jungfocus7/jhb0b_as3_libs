package jhb0b.useful
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import jhb0b.core.CContainerWrapper;
	import jhb0b.events.CBumEvent;
	import jhb0b.utils.MDisplayObjectContainerUtil;
	import jhb0b.utils.MStringUtil;


	public class CPanelLayer extends CContainerWrapper
	{
		public static const ET_CLOSE:String = Event.CLOSE;
		public static const ET_OPEN:String = Event.OPEN;


		override public function dispose():void
		{
			if (_cont == null) return;
			this.unselect();
			_frontStr = null;
			_now = null;
			_cont = null;
			super.dispose();
		}

		//:: 생성자
		public function CPanelLayer(cont:DisplayObjectContainer, frontStr:String, initFunc:Function):void
		{
			super(cont);
			_frontStr = frontStr;
			_tempInitFunc = initFunc;
			_panelLen = 0;
			MDisplayObjectContainerUtil.contLoop_io(
											_cont, _frontStr, p_contLoop);
			_tempInitFunc = null;
		}

		//- 검색문자
		private var _frontStr:String;
		public function get_frontStr():String
		{
			return _frontStr;
		}

		//-
		private var _tempInitFunc:Function;
		//:: 검색후 아이템 설정
		private function p_contLoop(cdo:DisplayObject, idx:int):void
		{
			_tempInitFunc(cdo, idx);
			_panelLen++;
		}

		//- 패널 개수
		private var _panelLen:uint;
		public function get_panelLen():uint
		{
			return _panelLen;
		}

		//:: 선택 해제
		public function unselect():void
		{
			if (_now != null)
			{
				this.dispatchEvent(new CBumEvent(ET_CLOSE, {now: _now}));
				_now = null;
			}
		}

		//:: 선택
		public function select(n:int):void
		{
			var t_now:DisplayObject = _cont[_frontStr + n];
			if (t_now != null)
			{
				if (t_now != _now)
				{
					this.unselect();

					_now = t_now;
					this.dispatchEvent(new CBumEvent(ET_OPEN, {now: _now}));
				}
			}
		}

		//- 현재 선택중인 패널 번호 반환
		public function get_nowNum():int
		{
			var t_n:int = -1;
			if (_now != null)
			{
				t_n = MStringUtil.get_lastNum(_now.name);
			}
			return t_n;
		}

		//- 현재 선택중인 패널
		private var _now:DisplayObject;
		public function get_now():DisplayObject
		{
			return _now;
		}

		//:: 이전 패널 활성화
		public function prev():void
		{
			if (_now != null)
			{
				var t_n:int = MStringUtil.get_lastNum(_now.name);
				this.select(t_n - 1);
			}
		}

		//:: 다음 패널 활성화
		public function next():void
		{
			if (_now != null)
			{
				var t_n:int = MStringUtil.get_lastNum(_now.name);
				this.select(t_n + 1);
			}
		}

	}

}
