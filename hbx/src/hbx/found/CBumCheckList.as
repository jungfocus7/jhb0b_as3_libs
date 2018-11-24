package hbx.found
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;

	import hbx.core.CEventCore;
	import hbx.core.IDisposable;
	import hbx.found.CBumButton;
	import hbx.core.CEventDispatcherCore;



	public class CBumCheckList extends CEventDispatcherCore
	{
		private static const _regex1:RegExp = /\d+?$/;
		private static function ppSortDisplayObject1(dpo1:DisplayObject, dpo2:DisplayObject):int
		{
			try
			{
				var nb1:uint = uint(dpo1.name.match(_regex1)[0]);
				var nb2:uint = uint(dpo2.name.match(_regex1)[0]);
				if (nb1 < nb2)
					return -1;
				else
				if (nb1 > nb2)
					return 1;
				else
					return 0;
			}
			catch (e:Error) { }

			return 0;
		}

		public static function contLoop(dpoc:DisplayObjectContainer, fstr:String, farr:Array = null):CBumCheckList
		{
			var tarr:Array = null;

			for (var l:int = dpoc.numChildren, i:int = 0; i < l; i++)
			{
				var mvc:MovieClip = dpoc.getChildAt(i) as MovieClip;
				if ((mvc != null) && (mvc.name.indexOf(fstr) == 0))
				{
					if (tarr == null) tarr = [];
					tarr.push(mvc);
				}
			}

			if (tarr != null)
			{
				tarr.sort(ppSortDisplayObject1);
				return new CBumCheckList(tarr, farr);
			}
			else
				return null;
		}



		public static const ET_CLICK:String = MouseEvent.CLICK;
		public static const ET_CHANGE:String = Event.CHANGE;


		public function CBumCheckList(tarr:Array, frameArr:Array = null)
		{
			for (var l:uint = tarr.length, i:uint = 0; i < l; i++)
			{
				var bbtn:CBumButton = new CBumButton(tarr[i], frameArr, true, true);
				bbtn.addEventListener(CBumButton.ET_CLICK, pp_bbtn_click);
				if (_items == null) _items = [];
				_items.push(bbtn);
				_dicIdx[bbtn] = i;
			}
			pp_set_enabled(true);
		}

		public override function dispose():void
		{
			if (_items == null) return;
			for (var l:uint = _items.length, i:uint = 0; i < l; i++)
			{
				var bbtn:CBumButton = _items[i];
				bbtn.dispose();
			}
			_dicIdx = null;
			_items = null;
		}


		private var _items:Array;
		public function get_items():Array
		{
			return _items;
		}

		private var _dicIdx:Dictionary = new Dictionary();
		private function pp_get_dicIdx(bbtn:CBumButton):uint
		{
			return _dicIdx[bbtn];
		}


		private function pp_set_enabled(b:Boolean):void
		{
			_enabled = b;
			for (var l:uint = _items.length, i:uint = 0; i < l; i ++)
			{
				var bbtn:CBumButton = _items[i];
				bbtn.set_enabled(_enabled);
			}
		}
		public override function set_enabled(b:Boolean):void
		{
			if (b != _enabled)
				pp_set_enabled(b);
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


		private function pp_bbtn_click(evt:CEventCore):void
		{
			if (evt != null)
				this.dispatchEvent(new CEventCore(ET_CLICK));

			var bbtn:CBumButton = CBumButton(evt.currentTarget);
			var i:uint = pp_get_dicIdx(bbtn);
			pp_set_selectedIndex(i, true);
		}


		private var _selectIndex:int = -1;
		private function pp_unselectedIndex(be:Boolean):void
		{
			if (_selectIndex > -1)
			{
				var bbtn:CBumButton = _items[_selectIndex];
				bbtn.set_selected(false);
				_selectIndex = -1;

				if (be)
					this.dispatchEvent(new CEventCore(ET_CHANGE));
			}
		}

		private function pp_set_selectedIndex(idx:int, be:Boolean):void
		{
			if ((idx > -1) && (idx < _items.length))
			{
				if (idx != _selectIndex)
				{
					pp_unselectedIndex(false);
					_selectIndex = idx;
					var t_bbtn:CBumButton = _items[_selectIndex];
					t_bbtn.set_selected(true);
				}
				else
				{
					if (_isToggleMode)
						pp_unselectedIndex(false);
					else
						be = false;
				}

				if (be)
					this.dispatchEvent(new CEventCore(ET_CHANGE));
			}
		}


		public function get_selectedIndex():int
		{
			return _selectIndex;
		}

		public function set_selectedIndex(idx:int):void
		{
			pp_set_selectedIndex(idx, false);
		}

		public function set_selectedIndexDispatch(idx:int):void
		{
			pp_set_selectedIndex(idx, true);
		}

		public function unselect():void
		{
			pp_unselectedIndex(false);
		}

		public function unselectDispatch():void
		{
			pp_unselectedIndex(true);
		}


		private function pp_get_itemAt(idx:int):CBumButton
		{
			if ((idx > -1) && (idx < _items.length))
				return _items[idx];
			else
				return null;
		}

		public function get_selectedItem():CBumButton
		{
			return pp_get_itemAt(_selectIndex);
		}

		public function get_itemAt(idx:int):CBumButton
		{
			return pp_get_itemAt(idx);
		}

	}

}