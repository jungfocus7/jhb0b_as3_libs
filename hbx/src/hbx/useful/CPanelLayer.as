package hbx.useful
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;

	import hbx.common.CDisplayObjectContainerWrapper;
	import hbx.core.CEventCore;
	import hbx.utils.MDisplayObjectContainerUtil;
	import hbx.utils.MStringUtil;
	import hbx.common.CCallback;



	public class CPanelLayer extends CDisplayObjectContainerWrapper
	{
		public static const ET_CLOSE:String = Event.CLOSE;
		public static const ET_OPEN:String = Event.OPEN;


		/**
		 * 생성자
		 * <br/>
		 * @param tcont: TargetContainer
		 */
		public function CPanelLayer(tcont:DisplayObjectContainer, frontStr:String, initFunc:Function):void
		{
			super(tcont);
			_frontStr = frontStr;
			_tempInitFunc = initFunc;
			_panelLen = 0;
			MDisplayObjectContainerUtil.contLoop_io(_container, _frontStr, new CCallback(pp_contLoop));
			_tempInitFunc = null;
		}

		/** */
		public override function dispose():void
		{
			if (_container == null) return;
			this.unselect();
			_frontStr = null;
			_tempInitFunc = null;
			_now = null;
			super.dispose();
		}


		//-- 검색문자
		private var _frontStr:String;
		public function get_frontStr():String
		{
			return _frontStr;
		}


		//-- 초기화 함수
		private var _tempInitFunc:Function;



		/**
		 * 검색후 아이템 설정
		 * <br/>
		 * @param dpo: DisplayObject
		 */
		private function pp_contLoop(dpo:DisplayObject, i:int):void
		{
			_tempInitFunc(dpo, i);
			_panelLen++;
		}


		//-- 패널 개수
		private var _panelLen:uint;
		public function get_panelLen():uint
		{
			return _panelLen;
		}


		/**
		 * 선택 해제
		 * <br/>
		 */
		public function unselect():void
		{
			if (_now != null)
			{
				this.dispatchEvent(new CEventCore(ET_CLOSE, {now: _now}));
				_now = null;
			}
		}


		/**
		 * 선택
		 * <br/>
		 * @param n: Number
		 */
		public function select(n:int):void
		{
			var now:DisplayObject = _container[_frontStr + n];
			if (now != null)
			{
				if (now != _now)
				{
					this.unselect();

					_now = now;
					this.dispatchEvent(new CEventCore(ET_OPEN, { now: _now }));
				}
			}
		}


		/**
		 * 현재 선택중인 패널 번호 반환
		 * <br/>
		 */
		public function get_nowNum():int
		{
			var n:int = -1;
			if (_now != null)
			{
				n = MStringUtil.get_lastNum(_now.name);
			}
			return n;
		}


		//-- 현재 선택중인 패널
		private var _now:DisplayObject;
		public function get_now():DisplayObject
		{
			return _now;
		}


		/**
		 * 이전 패널 활성화
		 * <br/>
		 */
		public function prev():void
		{
			if (_now != null)
			{
				var t_n:int = MStringUtil.get_lastNum(_now.name);
				this.select(t_n - 1);
			}
		}


		/**
		 * 다음 패널 활성화
		 * <br/>
		 */
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
