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
			_content.removeEventListener(MouseEvent.MOUSE_WHEEL, pp_tdo_wheel);
			_content.mask = null;
			_tmk = null;
			_bsf.dispose();
			_bsf = null;
			super.dispose();
		}

		public function CBumScrolling(tdo:DisplayObject, ttmk:DisplayObject,
							tsfmc:MovieClip, tsfbp:Number, tsfss:Number, tsfd:Number = 20)
		{
			super(tdo);
			_tmk = ttmk;
			_content.mask = _tmk;
			_bsf = new CBumSliderFrame(tsfmc, CBumSliderFrame.TYPE_VERTICAL, tsfbp, tsfss);
			_sfd = tsfd;
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


		private function pp_tdo_wheel(evt:MouseEvent):void
		{
			if (_content == null) return;

			var ty:Number = _content.y;
			if (evt.delta < 0) ty -= _sfd;
			else ty += _sfd;

			var tminv:Number = _sbase - _ssize;
			var tmaxv:Number = _sbase;

			if (ty < tminv) ty = tminv;
			else if (ty > tmaxv) ty = tmaxv;

			var tr:Number = Math.abs(_sbase - ty) / _ssize;
			//p_test(tr);
			_bsf.set_ratio(tr);

			_content.y = ty;
		}

		private function pp_bsf_update(evt:CEventCore):void
		{
			if (_content == null) return;

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



		override public function set_enabled(tb:Boolean):void
		{
			if (_content == null) return;

			super.set_enabled(tb);
			if (_enabled)
			{
				_content.addEventListener(MouseEvent.MOUSE_WHEEL, pp_tdo_wheel);
				_bsf.addEventListener(CBumSliderFrame.ET_UPDATE, pp_bsf_update);
				_bsf.set_enabled(true);
				_bsf.get_mvc().visible = true;
			}
			else
			{
				_content.removeEventListener(MouseEvent.MOUSE_WHEEL, pp_tdo_wheel);
				_bsf.removeEventListener(CBumSliderFrame.ET_UPDATE, pp_bsf_update);
				_bsf.set_enabled(false);
				_bsf.get_mvc().visible = false;
			}
		}
	}
}
