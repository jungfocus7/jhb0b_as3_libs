package hbx.found
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	import hbx.common.CSpriteWrapper;
	import hbx.core.CEventCore;



	public class CBumSlider extends CSpriteWrapper
	{
		//- 슬라이더 업데이트
		public static const ET_UPDATE:String = 'update';
		//- 슬라이더 마우스업
		public static const ET_MOUSE_UP:String = MouseEvent.MOUSE_UP;
		//- 슬라이더 마우스다운
		public static const ET_MOUSE_DOWN:String = MouseEvent.MOUSE_DOWN;



		//- 슬라이더 세로방향
		public static const TYPE_HORIZONTAL:String = 'horizontal';
		//- 슬라이더 가로방향
		public static const TYPE_VERTICAL:String = 'vertical';



		public function CBumSlider(sprt:Sprite, type:String = null, thumbName:String = null, trackName:String = null)
		{
			super(sprt);

			_sprt.mouseChildren = false;
			_sprt.buttonMode = true;

			if (type == null)
				_type = TYPE_HORIZONTAL;
			else
				_type = type;

			if (thumbName == null)
				thumbName = 'mc_thumb';
			_thumb = _sprt[thumbName];
			if (_thumb == null)
				throw new Error('thumb is null.');

			if (trackName == null)
				trackName = 'mc_track';
			_track = _sprt[trackName];
			if (_track == null)
				throw new Error('track is null.');

			pp_rectAreaUpdate();

			_sprt.addEventListener(MouseEvent.MOUSE_DOWN, pp_mvc_mouseDown);
			_enabled = true;
		}

		public override function dispose():void
		{
			if (_sprt == null) return;
			_sprt.removeEventListener(MouseEvent.MOUSE_DOWN, pp_mvc_mouseDown);
			_type = null;
			_thumb = null;
			_track = null;
			_rectArea = null;
			super.dispose();
		}


		//-
		private var _type:String;
		public function get_type():String
		{
			return _type;
		}

		//-
		private var _thumb:DisplayObject;
		public function get_thumb():DisplayObject
		{
			return _thumb;
		}

		//-
		private var _track:DisplayObject;
		public function get_track():DisplayObject
		{
			return _track;
		}

		//-
		private var _rectArea:CRectArea;
		private function pp_rectAreaUpdate():void
		{
			if (_rectArea == null)
			{
				_rectArea = new CRectArea();
				_rectArea.thumbFirstX = _thumb.x;
				_rectArea.thumbFirstY = _thumb.y;
				_rectArea.thumbX = _rectArea.thumbFirstX;
				_rectArea.thumbY = _rectArea.thumbFirstY;
			}
			_rectArea.thumbWidth = _thumb.width;
			_rectArea.thumbHeight = _thumb.height;
			_rectArea.thumbWidthHalf = Math.round(_rectArea.thumbWidth / 2);
			_rectArea.thumbHeightHalf = Math.round(_rectArea.thumbHeight / 2);
			_rectArea.trackWidth = _track.width;
			_rectArea.trackHeight = _track.height;
			_rectArea.left = _rectArea.thumbX;
			_rectArea.width = _rectArea.trackWidth -
				(_rectArea.left + _rectArea.thumbWidth + _rectArea.left);
			_rectArea.right = _rectArea.left + _rectArea.width;
			_rectArea.top = _rectArea.thumbY;
			_rectArea.height = _rectArea.trackHeight -
				(_rectArea.top + _rectArea.thumbHeight + _rectArea.top);
			_rectArea.bottom = _rectArea.top + _rectArea.height;
		}

		//:: 포지션 업데이트
		private function pp_thumbPositionUpdate(v:Number):void
		{
			if (_type == TYPE_HORIZONTAL)
			{
				_rectArea.thumbX = v;

				if (_rectArea.thumbX < _rectArea.left)
					_rectArea.thumbX = _rectArea.left;
				else
				if (_rectArea.thumbX > _rectArea.right)
					_rectArea.thumbX = _rectArea.right;

				_thumb.x = _rectArea.thumbX;
			}
			else
			if (_type == TYPE_VERTICAL)
			{
				_rectArea.thumbY = v;

				if (_rectArea.thumbY < _rectArea.top)
					_rectArea.thumbY = _rectArea.top;
				else
				if (_rectArea.thumbY > _rectArea.bottom)
					_rectArea.thumbY = _rectArea.bottom;

				_thumb.y = _rectArea.thumbY;
			}
		}

		//::
		private function pp_stage_mouseMove(evt:MouseEvent):void
		{
			var tv:Number;

			if (_type == TYPE_HORIZONTAL)
				tv = _sprt.mouseX - _rectArea.thumbWidthHalf;
			else
			if (_type == TYPE_VERTICAL)
				tv = _sprt.mouseY - _rectArea.thumbHeightHalf;

			pp_thumbPositionUpdate(tv);
			this.dispatchEvent(new CEventCore(ET_UPDATE));

			evt.updateAfterEvent();
		}

		// ::
		private function pp_stage_mouseUp(evt:MouseEvent):void
		{
			_stage.removeEventListener(MouseEvent.MOUSE_UP, pp_stage_mouseUp);
			_stage.removeEventListener(MouseEvent.MOUSE_MOVE, pp_stage_mouseMove);
			this.dispatchEvent(new CEventCore(ET_MOUSE_UP));
		}

		// ::
		private function pp_mvc_mouseDown(evt:MouseEvent):void
		{
			_stage.addEventListener(MouseEvent.MOUSE_UP, pp_stage_mouseUp);
			_stage.addEventListener(MouseEvent.MOUSE_MOVE, pp_stage_mouseMove);
			this.dispatchEvent(new CEventCore(ET_MOUSE_DOWN));
			pp_stage_mouseMove(new MouseEvent(MouseEvent.MOUSE_MOVE));
		}




		public function get_ratio():Number
		{
			var rv:Number;

			if (_type == TYPE_HORIZONTAL)
				rv = (_rectArea.thumbX - _rectArea.left) / _rectArea.width;
			else
			if (_type == TYPE_VERTICAL)
				rv = (_rectArea.thumbY - _rectArea.top) / _rectArea.height;

			return rv;
		}
		public function set_ratio(v:Number):void
		{
			if (v < 0)
				v = 0;
			else
			if (v > 1)
				v = 1;


			var tv:Number;

			if (_type == TYPE_HORIZONTAL)
				tv = Math.round(_rectArea.left + (v * _rectArea.width));
			else
			if (_type == TYPE_VERTICAL)
				tv = Math.round(_rectArea.top + (v * _rectArea.height));

			pp_thumbPositionUpdate(tv);
		}


		public function rectAreaUpdate():void
		{
			pp_rectAreaUpdate();
		}


		public override function set_enabled(b:Boolean):void
		{
			if (b != _enabled)
			{
				_sprt.mouseEnabled = b;
				_enabled = b;
			}
		}

	}
}


internal final class CRectArea
{
	public var thumbFirstX:Number;
	public var thumbFirstY:Number;

	public var thumbX:Number;
	public var thumbY:Number;

	public var thumbWidth:Number;
	public var thumbHeight:Number;

	public var thumbWidthHalf:Number;
	public var thumbHeightHalf:Number;

	public var trackWidth:Number;
	public var trackHeight:Number;

	public var left:Number;
	public var width:Number;
	public var right:Number;
	public var top:Number;
	public var height:Number;
	public var bottom:Number;
}
