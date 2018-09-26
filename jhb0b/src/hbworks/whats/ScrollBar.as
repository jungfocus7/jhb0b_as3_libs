/**
@Name: ScrollBar
@Author: HobisJung
@Date: 2016-05-11
@Comment:
{
}
==================================================================================================== */
package hbworks.whats
{
	import flash.display.DisplayObjectContainer;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import hbworks.uilogics.SliderLogic;
	

	public class ScrollBar extends SliderLogic
	{
		public static const TYPE_HORIZONTAL:String = SliderLogic.TYPE_HORIZONTAL;
		public static const TYPE_VERTICAL:String = SliderLogic.TYPE_VERTICAL;
		
		
		public static function create(container:DisplayObjectContainer, name:String = null,
										type:String = null,
										btnNegative:SimpleButton = null, btnPositive:SimpleButton = null,
										valueMin:Number = 1, valueMax:Number = 10,
										vec:Number = 1):ScrollBar
		{
			return new ScrollBar(container, name, type, null, null,
									btnNegative, btnPositive, valueMin, valueMax, vec);
		}
		
		
		public function ScrollBar(container:DisplayObjectContainer, name:String = null,
									type:String = null,
									thumbName:String = null,
									trackName:String = null,
									btnNegative:SimpleButton = null, btnPositive:SimpleButton = null,
									valueMin:Number = 1, valueMax:Number = 10,
									vec:Number = 1)
		{
			super(container, name, type, thumbName, trackName);			

			this.addEventListener(MouseEvent.MOUSE_MOVE, p_mouseMove);
			
			_btnNegative = btnNegative;
			_btnPositive = btnPositive;
			_btnNegative.addEventListener(MouseEvent.MOUSE_DOWN, p_mouseDown);
			_btnPositive.addEventListener(MouseEvent.MOUSE_DOWN, p_mouseDown);
			
			_valueMin = valueMin;
			_valueMax = valueMax;
			_valueSize = _valueMax - _valueMin;
			_value = _valueMin;
			_vec = vec;
		}
		
		private var _btnNegative:SimpleButton = null;
		public function get_btnNegative():SimpleButton
		{
			return _btnNegative;
		}		
		
		private var _btnPositive:SimpleButton = null;
		public function get_btnPositive():SimpleButton
		{
			return _btnPositive;
		}
		
		private var _btnTemp:SimpleButton = null;
		
		private var _valueMin:Number;
		public function get_valueMin():Number
		{
			return _valueMin;
		}
		
		private var _valueMax:Number;
		public function get_valueMax():Number
		{
			return _valueMax;
		}		
		
		private var _valueSize:Number;
		public function get_valueSize():Number
		{
			return _valueSize;
		}		
		
		private var _value:Number;
		public function get_value():Number
		{
			return _value;
		}
		private var _vec:Number;
		public function get_vec():Number
		{
			return _vec;
		}
		
		
		private function p_checkOut():void
		{
			// Scroll Minus
			if (_btnTemp == _btnNegative)
			{
				if (_value > _valueMin)
				{
					_value -= _vec;
					if (_value < _valueMin)
						_value = _valueMin;
				}
			}
			else
			// Scroll Plus
			if (_btnTemp == _btnPositive)
			{
				if (_value < _valueMax)
				{
					_value += _vec;
					if (_value > _valueMax)
						_value = _valueMax;
				}
			}
			
			var t_r:Number = (_value - _valueMin) / _valueSize;
			this.set_ratio(t_r);
			
			this.dispatchEvent(new Event(Event.SCROLL));
		}		
		
		private var _downCountEnd:uint = 10;
		private var _downCount:uint = 0;
		private function p_enterFrame(event:Event):void
		{
			if (_downCount < _downCountEnd)
			{
				_downCount++;
				return;
			}
			p_checkOut();
		}
		
		// ::
		private function p_mouseMove(event:MouseEvent):void
		{
			_value = Math.round(_valueMin + (_valueSize * this.get_ratio()));
			
			this.dispatchEvent(new Event(Event.SCROLL));
		}
		
		// ::
		private function p_mouseUp(event:MouseEvent):void
		{
			_btnTemp.stage.removeEventListener(MouseEvent.MOUSE_UP, p_mouseUp);
			_cont.removeEventListener(Event.ENTER_FRAME, p_enterFrame);
			_btnTemp = null;
		}
		
		// ::
		private function p_mouseDown(event:MouseEvent):void
		{
			_btnTemp = SimpleButton(event.currentTarget);
			_btnTemp.stage.addEventListener(MouseEvent.MOUSE_UP, p_mouseUp);
			_downCount = 0;			
			_cont.addEventListener(Event.ENTER_FRAME, p_enterFrame);
			p_checkOut();
		}
		
		
		// ::
		override public function dispose():void 
		{
			if (_btnNegative == null) return;
			p_mouseUp(null);
			this.removeEventListener(MouseEvent.MOUSE_MOVE, p_mouseMove);
			_btnNegative.removeEventListener(MouseEvent.MOUSE_DOWN, p_mouseDown);
			_btnPositive.removeEventListener(MouseEvent.MOUSE_DOWN, p_mouseDown);			
			_btnNegative = null;
			_btnPositive = null;
			super.dispose();
		}		
		
	}
}
