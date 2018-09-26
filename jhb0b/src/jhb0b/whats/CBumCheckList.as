package jhb0b.whats
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import jhb0b.core.CEventCore;
	import jhb0b.data.MArrSortDisplayObject;
	import jhb0b.events.CBumEvent;


	public class CBumCheckList extends CEventCore
	{
		public static function contLoop(tcont:DisplayObjectContainer, tfstr:String,
											tfarr:Array = null):CBumCheckList
		{
			var tta:Array;

			for (var tl:int = tcont.numChildren, ti:int = 0; ti < tl; ti++)
			{
				var tmc:MovieClip = tcont.getChildAt(ti) as MovieClip;
				if ((tmc != null) && (tmc.name.indexOf(tfstr) == 0))
				{
					if (tta == null) tta = [];
					tta.push(tmc);
				}
			}

			if (tta != null)
			{
				tta.sort(MArrSortDisplayObject.type1);
				return new CBumCheckList(tta, tfarr);
			}
			else
				return null;
		}


		public static const ET_CLICK:String = MouseEvent.CLICK;
		public static const ET_CHANGE:String = Event.CHANGE;


		override public function dispose():void
		{
			if (_items == null) return;
			var t_l:uint = _items.length;
			for (var i:uint = 0; i < t_l; i ++)
			{
				var t_bbtn:CBumButton = _items[i];
				t_bbtn.dispose();
			}
			_dicIdx = null;
			_items = null;
		}

		public function CBumCheckList(targets:Array, frameArr:Array = null)
		{
			var t_l:uint = targets.length;
			for (var i:uint = 0; i < t_l; i ++)
			{
				var t_bbtn:CBumButton = new CBumButton(targets[i], frameArr, true, true);
				t_bbtn.addEventListener(CBumButton.ET_CLICK, p_bbtn_click);
				if (_items == null) _items = [];
				_items.push(t_bbtn);
				_dicIdx[t_bbtn] = i;
			}
			p_set_enabled(true);
		}

		private var _items:Array;
		public function get_items():Array
		{
			return _items;
		}

		private var _dicIdx:Dictionary = new Dictionary();
		private function p_get_dicIdx(bbtn:CBumButton):uint
		{
			return _dicIdx[bbtn];
		}


		private var _enabled:Boolean = false;
		private function p_set_enabled(b:Boolean):void
		{
			if (b != _enabled)
			{
				_enabled = b;
				var t_l:uint = _items.length;
				for (var i:uint = 0; i < t_l; i ++)
				{
					var t_bbtn:CBumButton = _items[i];
					t_bbtn.set_enabled(_enabled);
				}
			}
		}

		public function get_enabled():Boolean
		{
			return _enabled;
		}

		public function set_enabled(b:Boolean):void
		{
			p_set_enabled(b);
		}


		private var _isToggleMode:Boolean = false;
		public function get_isToggleMode():Boolean
		{
			return _isToggleMode;
		}
		public function set_isToggleMode(b:Boolean):void
		{
			_isToggleMode = b;
		}


		private function p_bbtn_click(evt:CBumEvent):void
		{
			if (evt != null)
				this.dispatchEvent(new CBumEvent(ET_CLICK));

			var t_bbtn:CBumButton = CBumButton(evt.currentTarget);
			var t_i:uint = p_get_dicIdx(t_bbtn);
			p_set_selectedIndex(t_i, true);
		}


		private var _selectIndex:int = -1;
		private function p_unselectedIndex(be:Boolean):void
		{
			if (_selectIndex > -1)
			{
				var t_bbtn:CBumButton = _items[_selectIndex];
				t_bbtn.set_selected(false);
				_selectIndex = -1;

				if (be)
					this.dispatchEvent(new CBumEvent(ET_CHANGE));
			}
		}

		private function p_set_selectedIndex(idx:int, be:Boolean):void
		{
			if ((idx > -1) && (idx < _items.length))
			{
				if (idx != _selectIndex)
				{
					p_unselectedIndex(false);
					_selectIndex = idx;
					var t_bbtn:CBumButton = _items[_selectIndex];
					t_bbtn.set_selected(true);
				}
				else
				{
					if (_isToggleMode)
						p_unselectedIndex(false);
					else
						be = false;
				}

				if (be)
					this.dispatchEvent(new CBumEvent(ET_CHANGE));
			}
		}


		public function get_selectedIndex():int
		{
			return _selectIndex;
		}

		public function set_selectedIndex(idx:int):void
		{
			p_set_selectedIndex(idx, false);
		}

		public function set_selectedIndexDispatch(idx:int):void
		{
			p_set_selectedIndex(idx, true);
		}

		public function unselect():void
		{
			p_unselectedIndex(false);
		}

		public function unselectDispatch():void
		{
			p_unselectedIndex(true);
		}


		private function p_get_itemAt(idx:int):CBumButton
		{
			if ((idx > -1) && (idx < _items.length))
				return _items[idx];
			else
				return null;
		}

		public function get_selectedItem():CBumButton
		{
			return p_get_itemAt(_selectIndex);
		}

		public function get_itemAt(idx:int):CBumButton
		{
			return p_get_itemAt(idx);
		}

	}

}