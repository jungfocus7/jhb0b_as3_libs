/**
	@Name: EventManager
	@Author: HobisJung(jhb0b@naver.com)
	@Date: 2014-03-23
	@Comment:
	{
	}
*/
package hb.events
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;


	public class EventManager
	{
		public function EventManager()
		{
		}

		private var _list:Array = null;
		// :: List 입니다.
		public function get_list():Array
		{
			return this._list;
		}

		// :: 리스트에 이미 3가지 속성이 같은 아이템이 있으면 반환
		public function get_isItem(target:IEventDispatcher, type:String, handler:Function):Object
		{
			var t_rv:Object = null;

			if (this._list == null) {}
			else
			{
				for
				(
					var
						t_la:uint = this._list.length,
						i:uint = 0;
					i < t_la;
					i++
				)
				{
					var t_io:Object = this._list[i];
					var t_target:IEventDispatcher = t_io.target;
					var t_type:String = t_io.type;
					var t_handler:Function = t_io.handler;

					if
					(
						(t_target == target) &&
						(t_type == type) &&
						(t_handler == handler)
					)
					{
						t_rv = t_io;
						break;
					}
				}
			}

			return t_rv;
		}

		// ::
		public function add(target:IEventDispatcher, type:String, handler:Function):void
		{
			var t_io:Object = this.get_isItem(target, type, handler);
			if (t_io == null)
			{
				if (this._list == null)
					this._list = [];

				t_io =
				{
					target: target,
					type: type,
					handler: handler
				};
				this._list.push(t_io);

				target.addEventListener(type, handler);

				//trace('EventManager.add');
				//trace('target: ' + target + ', type: ' + type);
				//trace('this._list.length: ' + this._list.length);
			}
		}

		// ::
		public function del(target:IEventDispatcher, type:String, handler:Function = null):void
		{
			if (this._list == null) {}
			else
			{
				for
				(
					var
						t_la:uint = this._list.length,
						i:uint = 0;
					i < t_la;
					i++
				)
				{
					var t_io:Object = this._list[i];
					var t_target:IEventDispatcher = t_io.target;
					var t_type:String = t_io.type;
					var t_handler:Function = t_io.handler;

					if (handler == null)
					{
						if
						(
							(t_target == target) &&
							(t_type == type)
						)
						{
							t_target.removeEventListener(t_type, t_handler);
							this._list.splice(i, 1);
							t_la--;
							i--;
						}
					}
					else
					{
						if
						(
							(t_target == target) &&
							(t_type == type) &&
							(t_handler == handler)
						)
						{
							t_target.removeEventListener(t_type, t_handler);
							this._list.splice(i, 1);
							break;
						}
					}
				}
			}
		}

		// ::
		public function clear():void
		{
			if (this._list == null) {}
			else
			{
				for
				(
					var
						t_la:uint = this._list.length,
						i:uint = 0;
					i < t_la;
					i++
				)
				{
					var t_io:Object = this._list[i];
					var t_target:IEventDispatcher = t_io.target;
					var t_type:String = t_io.type;
					var t_handler:Function = t_io.handler;
					t_target.removeEventListener(t_type, t_handler);
				}

				this._list = null;
			}
		}
	}
}
