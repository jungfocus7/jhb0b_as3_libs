package hobis.hhxy
{
/**
	#이름: CResizeBalance
	#사용법: {
		
		//
		CResizeBalance.stageRecter(this.stage);
		CResizeBalance.create(this, 1280, 800);
		
	}
	*/	
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	

	public class CResizeBalance
	{
		public static function stageRecter(tstg:Stage):void {
			tstg.scaleMode = StageScaleMode.NO_SCALE;
			tstg.align = StageAlign.TOP_LEFT;
		}
		
		public static function stageDefaulter(tstg:Stage):void {
			tstg.scaleMode = StageScaleMode.SHOW_ALL;
			tstg.align = '';
		}		
		
		
		private static var _dic:Dictionary;
		public static function clearAll():void {
			if (_dic == null) return;
			try {
				for each (var te:CResizeBalance in _dic) {
					te.dispose();
				}
			} catch (e:Error) { }
			_dic = null;
		}
		
		public static function create(tow:DisplayObject, tsww:Number = NaN, tswh:Number = NaN):void {
			if (_dic == null) _dic = new Dictionary();
			_dic[tow] = new CResizeBalance(tow, tsww, tswh);
		}
		
		
		
		//::
		public function CResizeBalance(tow:DisplayObject, tsww:Number = NaN, tswh:Number = NaN) {
			//
//			tow.loaderInfo.addEventListener(Event.COMPLETE,
//				function(te:Event):void {
//					IEventDispatcher(te.currentTarget).removeEventListener(te.type, arguments.callee);
//					
//					_owner = tow;
//					_stage = _owner.stage;
//					
//					//_sww = isNaN(tsww) ? _stage.stageWidth : tsww;
//					//_swh = isNaN(tswh) ? _stage.stageHeight : tswh;
//					var tldi:LoaderInfo = _owner.loaderInfo;
//					_sww = isNaN(tsww) ? tldi.width : tsww;
//					_swh = isNaN(tswh) ? tldi.height : tswh;
//					//trace(_sww, _swh);
//					
//					_stage.addEventListener(Event.RESIZE, pp_resize);
//					pp_resize(null);
//				});
				
			_owner = tow;
			_stage = _owner.stage;
			
			_sww = isNaN(tsww) ? _stage.stageWidth : tsww;
			_swh = isNaN(tswh) ? _stage.stageHeight : tswh;
			//trace(_sww, _swh);
			
			_stage.addEventListener(Event.RESIZE, pp_resize);
			pp_resize(null);
		}
		
		
		//--
		private var _owner:DisplayObject;
		//--
		private var _stage:Stage;
		
		//-- 처음 스테이지 넓이
		private var _sww:Number;
		//-- 처음 스테이지 높이
		private var _swh:Number;
		

		
		public function dispose():void {
			if (_owner == null) return;
			_stage.removeEventListener(Event.RESIZE, pp_resize);
			_stage = null;
			_owner = null;
		}
		
		private function pp_resize(te:Event):void {
			//trace(_sww, _swh);
			
			var tsw:Number = _stage.stageWidth;
			var tsh:Number = _stage.stageHeight;
			//trace(tsw, tsh);
			
			var tosx:Number = tsw / _sww;
			var tosy:Number = tsh / _swh;
			//trace(tosx, tosy);
			
			var topx:Number = (tsw / 2) - ((_sww * tosy) / 2);
			var topy:Number = (tsh / 2) - ((_swh * tosx) / 2);
			//topx = Math.round(topx);
			//topy = Math.round(topy);
			//trace(topx, topy);
			
			if (tosx > tosy) {
				tosx = tosy;
				topy = 0;
			}
			else
			if (tosx < tosy) {
				tosy = tosx;
				topx = 0;
			}
			else {
				topx = 0;
				topy = 0;
			}				
			
			_owner.scaleX = tosx;
			_owner.scaleY = tosy;				
			_owner.x = topx;
			_owner.y = topy;
		}
	}	
}
