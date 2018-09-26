/**
	@Name: CheckListLogic
	@Author: HobisJung(jhb0b@naver.com)
	@Blog: http://blog.naver.com/jhb0b
	@Date: 2016-05-10
	@Using:
	{
	}
*/
package hbworks.uilogics
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import hb.core.IDisposable;
	import hb.utils.StringUtil;
	import hbworks.uilogics.ButtonLogic;


	public class CheckListLogic extends EventDispatcher implements IDisposable
	{
		// :: 생성자
		public function CheckListLogic(targets:Array, selectedIndex:int = -1)
		{
			p_item_setting(targets);
			p_setEnabled(true);
			p_setSelectedIndex(selectedIndex);
		}

		private var _items:Array = null;
		private var _selectIndex:int = -1;

		private var _enabled:Boolean = false;

		public var isToggleMode:Boolean = false;
		public var name:String = null;



		// :: 아이템 초기 설정
		private function p_item_setting(targets:Array):void
		{
			var t_bl:ButtonLogic = null;
			var t_la:uint = targets.length;
			var i:uint;
			_items = new Array();

			for (i = 0; i < t_la; i ++)
			{
				t_bl = new ButtonLogic(targets[i], true);
				t_bl.isListMode = true;
				t_bl.name = 'bl_' + i;
				t_bl.addEventListener(MouseEvent.CLICK, p_item_click);
				_items.push(t_bl);
			}
		}

		// :: 아이템 클릭
		private function p_item_click(event:MouseEvent):void
		{
			var t_bl:ButtonLogic = event.currentTarget as ButtonLogic;
			var t_blIndex:int = StringUtil.get_lastNum2(t_bl.name);

			p_setSelectedIndex(t_blIndex, true);

			if (event != null)
				this.dispatchEvent(event);

			//DebugUtil.test('p_item_click');
			//DebugUtil.test('t_blIndex: ' + t_blIndex);
		}

		// :: 객체 활성화 설정
		private function p_setEnabled(b:Boolean):void
		{
			if (b != _enabled)
			{
				_enabled = b;


				var t_bl:ButtonLogic = null;
				var t_la:uint = _items.length;
				var i:uint;

				for (i = 0; i < t_la; i ++)
				{
					t_bl = _items[i];
					t_bl.set_enabled(_enabled);
				}
			}
		}

		// :: 버튼 타겟들 반환
		public function get_items():Array
		{
			return _items;
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

		// :: SelectedIndex Setter
		public function get_selectedIndex():int
		{
			return _selectIndex;
		}

		// :: UnSetSelectedIndex
		private function p_unSelectedIndex():void
		{
			if (_selectIndex > -1)
			{
				var t_item:ButtonLogic = _items[_selectIndex];
				t_item.set_selected(false);
				_selectIndex = -1;
			}
		}

		// ::
		public function unselect():void
		{
			p_unSelectedIndex();
		}

		// :: SetSelectedIndex
		private function p_setSelectedIndex(index:int, isEvent:Boolean = false):void
		{
			if (_items != null)
			{
				// - Selected
				if
				(
					(index > -1) &&
					(index < _items.length)
				)
				{
					var t_item:ButtonLogic = null;

					if (index != _selectIndex)
					{
						p_unSelectedIndex();

						_selectIndex = index;
						t_item = _items[_selectIndex];
						t_item.set_selected(true);
					}
					else
					{
						if (this.isToggleMode)
							p_unSelectedIndex();
						else
							isEvent = false;
					}
				}

				// - UnSelected
				else
				if (index == -1)
				{
					if (this.isToggleMode)
						p_unSelectedIndex();
				}

				if (isEvent)
				{
					this.dispatchEvent(new Event(Event.CHANGE));
				}
			}
		}

		// :: SelectedIndex Setter
		public function set_selectedIndex(index:int):void
		{
			p_setSelectedIndex(index);
		}

		// :: Selected후 이벤트 발생시키기
		public function set_selectedIndexDispatch(index:int):void
		{
			p_setSelectedIndex(index, true);
		}

		// :: 특정 인덱스에 아이템 반환
		private function p_getItemAt(index:int):ButtonLogic
		{
			var t_rv:ButtonLogic = null;

			if (_items != null)
			{
				if
				(
					(index > -1) &&
					(index < _items.length)
				)
				{
					t_rv = _items[index];
				}

			}

			return t_rv;
		}

		// :: 선택된 객체 번환
		public function get_selectedItem():ButtonLogic
		{
			return p_getItemAt(_selectIndex);
		}

		// ::
		public function get_itemAt(index:int):ButtonLogic
		{
			return p_getItemAt(index);
		}

		// :: 객체제거
		public function dispose():void
		{
			p_setEnabled(false);

			if (_items != null)
			{
				var t_bl:ButtonLogic = null;
				var t_la:uint = _items.length;
				var i:uint;

				for (i = 0; i < t_la; i ++)
				{
					t_bl = _items[i];
					t_bl.dispose();
				}

				_items = null;
			}
		}
	}
}
