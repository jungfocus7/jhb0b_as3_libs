/**
	@Name: PanelLayer 선택하는 로직 단순화
	@Author: HobisJung(jhb0b@naver.com)
	@Date: 2016-01-22
	@Comment:
	{
	}
*/
package hb.useful
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import hb.core.IContainerObserver;
	import hb.core.IDisposable;
	import hb.utils.DisplayObjectContainerUtil;
	import hb.utils.StringUtil;	
	
	//
	// #
	public class PanelLayer implements IContainerObserver, IDisposable
	{
		public static const CT_INIT:String = 'contentInit';
		//
		public static const CT_CLOSE:String = 'contentClose';
		public static const CT_OPEN:String = 'contentOpen';	
		//

		
		// ::
		public function dispose():void
		{
			if (this._cont == null) return;
			this._cont = null;
			this._searchStr = null;
			this._callBack = null;
			this._now = null;
			this._cont = null;
		}		
		
		// :: 생성자
		public function PanelLayer(cont:DisplayObjectContainer, searchStr:String, callBack:Function):void
		{
			this._cont = cont;
			this._searchStr = searchStr;
			this._callBack = callBack;
			this._panelLen = 0;
			//
			DisplayObjectContainerUtil.contLoop(this._cont, searchStr, this.p_contLoop);
		}

		// - 아이템들
		private var _cont:DisplayObjectContainer = null;
		public function get_container():DisplayObjectContainer
		{
			return this._cont;
		}
		
		// - 검색문자
		private var _searchStr:String = null;
		public function get_searchStr():String
		{
			return this._searchStr;
		}		
		
		// -
		private var _callBack:Function = null;
		public function dispatch_callBack(eObj:Object):void
		{
			if (_callBack == null) return;
			_callBack(eObj);
		}

		
		// :: 검색후 아이템 설정
		private function p_contLoop(cdo:DisplayObject, index:int):void
		{
			this.dispatch_callBack(
			{
				type: CT_INIT, now: cdo
			});
			//
			this._panelLen++;
		}
		
		// - 패널 개수
		private var _panelLen:uint;
		public function get_panelLen():uint
		{
			return this._panelLen;
		}

		// :: 선택 해제
		public function unselect():void
		{
			if (this._now != null)
			{
				this.dispatch_callBack(
				{
					type: CT_CLOSE, now: this._now
				});
				//
				this._now = null;
			}
		}

		// :: 선택
		public function select(num:int):void
		{
			var t_now:DisplayObject = this._cont[this._searchStr + num];
			if (t_now != null)
			{
				if (t_now != this._now)
				{
					this.unselect();
					//
					this._now = t_now;
					//
					this.dispatch_callBack(
					{
						type: CT_OPEN, now: this._now
					});
				}
			}
		}
		
		// - 현재 선택중인 패널 번호 반환
		public function get_nowNum():int
		{
			var t_num:int = -1;
			
			if (this._now != null)
			{
				t_num = StringUtil.get_lastNum(this._now.name);
			}
			
			return t_num;
		}
		
		// - 현재 선택중인 패널
		private var _now:DisplayObject = null;
		public function get_now():DisplayObject
		{
			return this._now;
		}
		
		// :: 이전 패널 활성화
		public function prev():void
		{
			if (this._now != null)
			{
				var t_num:int = StringUtil.get_lastNum(this._now.name);
				this.select(t_num - 1);
			}
		}		
		// :: 다음 패널 활성화
		public function next():void
		{
			if (this._now != null)
			{
				var t_num:int = StringUtil.get_lastNum(this._now.name);
				this.select(t_num + 1);
			}			
		}
		//}}}
		////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}
