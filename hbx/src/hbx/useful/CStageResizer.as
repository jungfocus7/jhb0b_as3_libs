package hbx.useful
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.Dictionary;

	import hbx.core.CDisplayObjectWrapper;



	public class CStageResizer extends CDisplayObjectWrapper
	{
		public static function recter(stg:Stage):void
		{
			stg.scaleMode = StageScaleMode.NO_SCALE;
			stg.align = StageAlign.TOP_LEFT;
		}

		public static function defaulter(stg:Stage):void
		{
			stg.scaleMode = StageScaleMode.SHOW_ALL;
			stg.align = '';
		}


		private static var _dic:Dictionary;
		public static function clearAll():void
		{
			if (_dic == null) return;
			try {
				for each (var te:CStageResizer in _dic) {
					te.dispose();
				}
			} catch (e:Error) { }
			_dic = null;
		}
		public static function clear(dpo:DisplayObject):void
		{
			if (_dic == null) return;
			var trb:CStageResizer = _dic[dpo];
			if (trb != null)
			{
				trb.dispose();
				delete _dic[dpo];
			}
		}
		public static function create(dpo:DisplayObject, sfw:Number = NaN, sfh:Number = NaN):void
		{
			clear(dpo);
			if (_dic == null) _dic = new Dictionary();
			var trb:CStageResizer = new CStageResizer(dpo, sfw, sfh);
			_dic[dpo] = trb;
		}



		public function CStageResizer(dpo:DisplayObject, sfw:Number = NaN, sfh:Number = NaN)
		{
			super(dpo);

			_sfw = isNaN(sfw) ? _stage.stageWidth : sfw;
			_sfh = isNaN(sfh) ? _stage.stageHeight : sfh;

			_stage.addEventListener(Event.RESIZE, pp_resize);
			pp_resize(null);
		}

		//-- 처음 스테이지 넓이
		private var _sfw:Number;
		//-- 처음 스테이지 높이
		private var _sfh:Number;



		public override function dispose():void
		{
			if (_content == null) return;
			_stage.removeEventListener(Event.RESIZE, pp_resize);
			super.dispose();
		}


		private function pp_resize(evt:Event):void
		{
			var sw:Number = _stage.stageWidth;
			var sh:Number = _stage.stageHeight;

			var osx:Number = sw / _sfw;
			var osy:Number = sh / _sfh;

			var opx:Number = (sw / 2) - ((_sfw * osy) / 2);
			var opy:Number = (sh / 2) - ((_sfh * osx) / 2);

			if (osx > osy) {
				osx = osy;
				opy = 0;
			}
			else
			if (osx < osy) {
				osy = osx;
				opx = 0;
			}
			else {
				opx = 0;
				opy = 0;
			}

			_content.scaleX = osx;
			_content.scaleY = osy;
			_content.x = opx;
			_content.y = opy;
		}

	}
}
