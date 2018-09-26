package jhb0b.whats
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import jhb0b.events.CBumEvent;
	import jhb0b.core.CMovieClipBase;


	public class CBumSlider extends CMovieClipBase
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



		override public function dispose():void
		{
			if (_owner == null) return;
			_owner.removeEventListener(MouseEvent.MOUSE_DOWN, p_owner_mouseDown);
			_type = null;
			_thumb = null;
			_track = null;
			_rectArea = null;
			_stage = null;
			super.dispose();
		}

		//::
		public function CBumSlider(tmc:MovieClip, type:String = null,
							thumbName:String = null, trackName:String = null)
		{
			super(tmc);

			_owner.mouseChildren = false;
			_owner.buttonMode = true;

			if (type == null)
				_type = TYPE_HORIZONTAL;
			else
				_type = type;

			if (thumbName == null)
				thumbName = 'mc_thumb';
			_thumb = _owner[thumbName];
			if (_thumb == null)
				throw new Error('thumb is null.');

			if (trackName == null)
				trackName = 'mc_track';
			_track = _owner[trackName];
			if (_track == null)
				throw new Error('track is null.');

			p_rectAreaUpdate();

			_owner.addEventListener(MouseEvent.MOUSE_DOWN, p_owner_mouseDown);
			_enabled = true;
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
		private function p_rectAreaUpdate():void
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
		private function p_thumbPositionUpdate(v:Number):void
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
		private function p_stage_mouseMove(evt:MouseEvent):void
		{
			var t_v:Number;

			if (_type == TYPE_HORIZONTAL)
				t_v = _owner.mouseX - _rectArea.thumbWidthHalf;
			else
			if (_type == TYPE_VERTICAL)
				t_v = _owner.mouseY - _rectArea.thumbHeightHalf;

			p_thumbPositionUpdate(t_v);
			this.dispatchEvent(new CBumEvent(ET_UPDATE));

			evt.updateAfterEvent();
		}

		// ::
		private function p_stage_mouseUp(evt:MouseEvent):void
		{
			_stage.removeEventListener(MouseEvent.MOUSE_UP, p_stage_mouseUp);
			_stage.removeEventListener(MouseEvent.MOUSE_MOVE, p_stage_mouseMove);
			this.dispatchEvent(new CBumEvent(ET_MOUSE_UP));
		}

		// ::
		private function p_owner_mouseDown(evt:MouseEvent):void
		{
			_stage.addEventListener(MouseEvent.MOUSE_UP, p_stage_mouseUp);
			_stage.addEventListener(MouseEvent.MOUSE_MOVE, p_stage_mouseMove);
			this.dispatchEvent(new CBumEvent(ET_MOUSE_DOWN));
			p_stage_mouseMove(new MouseEvent(MouseEvent.MOUSE_MOVE));
		}




		public function get_ratio():Number
		{
			var t_rv:Number;

			if (_type == TYPE_HORIZONTAL)
				t_rv = (_rectArea.thumbX - _rectArea.left) / _rectArea.width;
			else
			if (_type == TYPE_VERTICAL)
				t_rv = (_rectArea.thumbY - _rectArea.top) / _rectArea.height;

			return t_rv;
		}
		public function set_ratio(v:Number):void
		{
			if (v < 0)
				v = 0;
			else
			if (v > 1)
				v = 1;


			var t_v:Number;

			if (_type == TYPE_HORIZONTAL)
				t_v = Math.round(_rectArea.left + (v * _rectArea.width));
			else
			if (_type == TYPE_VERTICAL)
				t_v = Math.round(_rectArea.top + (v * _rectArea.height));

			p_thumbPositionUpdate(t_v);
		}

		//::
		public function rectAreaUpdate():void
		{
			p_rectAreaUpdate();
		}


		override public function get_enabled():Boolean
		{
			return _enabled;
		}

		override public function set_enabled(b:Boolean):void
		{
			if (b != _enabled)
			{
				_owner.mouseEnabled = b;
				_enabled = b;
			}
		}
	}
}

final class CRectArea
{
	public function CRectArea()
	{
	}

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
