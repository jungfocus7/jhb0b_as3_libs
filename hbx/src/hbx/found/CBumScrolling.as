package hbx.found
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;

	import hbx.core.CEventCore;
	import hbx.core.IDisposable;
	import hbx.core.CDisplayObjectWrapper;



	public class CBumScrolling extends CDisplayObjectWrapper implements IDisposable
	{
		public override function dispose():void
		{
			if (_content == null) return;
			_content.removeEventListener(MouseEvent.MOUSE_WHEEL, pp_content_wheel);
			_content.mask = null;
			_tmk = null;
			_bsf.dispose();
			_bsf = null;
			super.dispose();
		}

		public function CBumScrolling(
			content:DisplayObject, tmk:DisplayObject, sfmc:MovieClip, sfbp:Number, sfss:Number, sfd:Number = 20)
		{
			super(content);
			_tmk = tmk;
			_content.mask = _tmk;
			_bsf = new CBumSliderFrame(sfmc, CBumSliderFrame.TYPE_VERTICAL, sfbp, sfss);
			_sfd = sfd;
			this.update_scrollSize();
		}

		private var _tmk:DisplayObject;

		private var _bsf:CBumSliderFrame;
		public function get_bsf():CBumSliderFrame
		{
			return _bsf;
		}

		private var _sfd:Number;
		public function get_scrollFrameDelta():Number
		{
			return _sfd;
		}
		public function set_scrollFrameDelta(tsfd:Number):void
		{
			_sfd = tsfd;
		}

		private var _sbase:Number;
		private var _ssize:Number;


		private function pp_content_wheel(evt:MouseEvent):void
		{
			var ty:Number = _content.y;
			if (evt.delta < 0) ty -= _sfd;
			else ty += _sfd;

			var minv:Number = _sbase - _ssize;
			var maxv:Number = _sbase;

			if (ty < minv) ty = minv;
			else if (ty > maxv) ty = maxv;

			var tr:Number = Math.abs(_sbase - ty) / _ssize;
			//pp_test(tr);
			_bsf.set_ratio(tr);

			_content.y = ty;
		}

		private function pp_bsf_update(evt:CEventCore):void
		{
			var ty:Number = _ssize * _bsf.get_ratio();
			ty = _sbase - ty;
			_content.y = ty;
		}

		public function update_scrollSize():void
		{
			_sbase = _content.y;
			_ssize = _content.height - _tmk.height;
			if (_ssize > 0)
				this.set_enabled(true);
			else
				this.set_enabled(false);
		}

		public override function set_enabled(b:Boolean):void
		{
			if (b != _enabled)
			{
				_enabled = b;
				if (_enabled)
				{
					_content.addEventListener(MouseEvent.MOUSE_WHEEL, pp_content_wheel);
					_bsf.addEventListener(CBumSliderFrame.ET_UPDATE, pp_bsf_update);
					_bsf.set_enabled(true);
					_bsf.get_mvc().visible = true;
				}
				else
				{
					_content.removeEventListener(MouseEvent.MOUSE_WHEEL, pp_content_wheel);
					_bsf.removeEventListener(CBumSliderFrame.ET_UPDATE, pp_bsf_update);
					_bsf.set_enabled(false);
					_bsf.get_mvc().visible = false;
				}
			}
		}

	}
}
