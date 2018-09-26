package jhb0b.hbcontents
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import jhb0b.hbcore.HBCore;
	import jhb0b.utils.MDisplayObjectContainerUtil;	
	import jhb0b.utils.MStringUtil;
	

	public class HBTypeLine extends HBCore
	{
		public function HBTypeLine(towner:MovieClip)
		{
			super(towner);
					
			_drc = new Sprite();
			_owner.addChild(_drc);
			_dc1 = new Sprite();
			_dc1.name = '_dc1';
			_dc1.mouseChildren = false;
			_dc1.mouseEnabled = false;
			_dc2 = new Sprite();
			_dc2.name = '_dc2';
			_dc2.mouseChildren = false;
			_dc2.mouseEnabled = false;
			_owner.addChild(_dc2);
			_owner.addChild(_dc1);
			
			_dic1 = new Dictionary();
			_dic2 = new Dictionary();
			
			ppndmc_init();
		}
		
		
		// DrawRootContainer (전체 캔바스 컨테이너)
		private var _drc:Sprite;
		// DrawCanvas1 (유저 그리기 완료 컨테이너)
		private var _dc1:Sprite;
		// DrawCanvas2 (정답 그리기 완료 컨테이너)
		private var _dc2:Sprite;
		
		// 
		private var _dic1:Dictionary;
		// 
		private var _dic2:Dictionary;
		
		// NowDrawMovieClip (현재 마우스다운 중인 무비클립)
		private var _ndmc:MovieClip;
		


		private function ppndmc_draw1(tgrp:Graphics, tbx:Number, tby:Number, tex:Number, tey:Number):void
		{
			tgrp.clear();
			tgrp.lineStyle(HBTypeConfig.LineThickness1, HBTypeConfig.LineColor1, 1);
			tgrp.moveTo(tbx, tby);
			tgrp.lineTo(tex, tey);
		}
		
		private function ppndmc_draw2(tgrp:Graphics, tbx:Number, tby:Number, tex:Number, tey:Number):void
		{
			tgrp.clear();
			tgrp.lineStyle(HBTypeConfig.LineThickness2, HBTypeConfig.LineColor2, 1);
			tgrp.moveTo(tbx, tby);
			tgrp.lineTo(tex, tey);
		}


		private function ppndmc_clear():void
		{
			if (_ndmc == null) return;
			_dc1.graphics.clear();
			_ndmc = null;
		}

		private function ppndmc_chk():void
		{
			if (_ndmc == null) return;			
			
			var tnfnm:String = _ndmc.name.split('_')[0];
			trace('tnfnm: ' + tnfnm);
			
			var tsfnm:String;
			if (tnfnm == HBTypeConfig.LineFrontName1)
				tsfnm = HBTypeConfig.LineFrontName2;
			else
			if (tnfnm == HBTypeConfig.LineFrontName2)
				tsfnm = HBTypeConfig.LineFrontName1;
			//trace('tsfnm: ' + tsfnm);			
			
			var tro:Object = { dtmc: null };
			MDisplayObjectContainerUtil.contLoop_b(_owner, tsfnm,
				function():Boolean
				{
					var tcdo:DisplayObject = arguments[0];
					var ti:uint = arguments[1];
					var tro:Object = arguments[2];
					//trace(tcdo, ti, to);

					var tmc:MovieClip = tcdo as MovieClip;
					if (tmc != null)
					{
						if (tmc.hitTestPoint(_stage.mouseX, _stage.mouseY))
						{
							tro.dtmc = tmc;
							//trace(tmc);
							return true;
						}
					}
					
					return false;
				}, [tro]);
			
			
			var ttmc:MovieClip = tro.dtmc;
			if (ttmc != null)
			{
				//trace(ttmc.name);
				/*
				var tshp:Shape = _dic1[_ndmc];
				trace(tshp);
				ppndmc_draw2(tshp.graphics, ttmc.x, ttmc.y, _ndmc.x, _ndmc.y);*/
				
				/*
				trace('타겟 찾음');
				var tshp:Shape = _dic1[_ndmc];
				//ppndmc_draw2(tshp.graphics, ttmc.x, ttmc.y, _ndmc.x, _ndmc.y);
				//_dic1[ttmc].graphics.clear();
				trace(tshp.parent.name);
				//trace(ttmc.x, ttmc.y, tshp.x, tshp.y);
				*/
			}
			else
			{
				//trace('타겟 없음');
			}
			
			ppndmc_clear();
		}

		private function ppndmc_mm(evt:MouseEvent):void
		{
			if (_ndmc == null) return;
			
			//ppndmc_draw1(_dc1.graphics, _ndmc.x, _ndmc.y, _stage.mouseX, _stage.mouseY);
			
			if (evt != null) evt.updateAfterEvent();
		}
		
		private function ppndmc_mu(evt:MouseEvent):void
		{
			if (_ndmc == null) return;
			
			_stage.removeEventListener(MouseEvent.MOUSE_UP, ppndmc_mu);
			_stage.removeEventListener(MouseEvent.MOUSE_MOVE, ppndmc_mm);			
			ppndmc_chk();
		}
		
		private function ppndmc_md(evt:MouseEvent):void
		{
			_ndmc = MovieClip(evt.currentTarget);
			_stage.addEventListener(MouseEvent.MOUSE_UP, ppndmc_mu);
			_stage.addEventListener(MouseEvent.MOUSE_MOVE, ppndmc_mm);
			ppndmc_mm(null);
		}
		
		private function ppndmc_init():void
		{
			MDisplayObjectContainerUtil.contLoop_ba(_owner,
				function():Boolean
				{
					var tcdo:DisplayObject = arguments[0];
					var ti:uint = arguments[1];
					//trace(tcdo, ti);
					
					var tmc:MovieClip = tcdo as MovieClip;
					if (tmc != null)
					{												
						var tnm:String = tmc.name;
						var tna:int;
						var tshp:Shape;
						if (tnm.indexOf(HBTypeConfig.LineFrontName1) > -1)
						{
							tmc.mouseChildren = false;
							tmc.buttonMode = true;
							tmc.addEventListener(MouseEvent.MOUSE_DOWN, ppndmc_md);
							tmc.d_na = MStringUtil.get_lastNum2(tnm, 1);
							tmc.d_nb = MStringUtil.get_lastNum2(tnm, 0);
							//trace(tmc.d_na, tmc.d_nb);
							
							//trace(_dic1[tmc]);
							//trace(_dic2[tmc]);
							//trace(tmc.name);
							//trace(MStringUtil.get_lastNum2(tmc.name, 0));
							//trace(tnm, MStringUtil.get_lastNum2(tnm, 1), MStringUtil.get_lastNum2(tnm, 0));
//							tna = MStringUtil.get_lastNum2(tnm, 1);
//							//trace(tna);
//							tshp = new Shape();
//							_dc1.addChild(tshp);
//							_dic1[tna] = tshp;
//							trace(tna, 298-296);
//							trace(_dic1[298-296]);
						}
						else
						if (tnm.indexOf(HBTypeConfig.LineFrontName2) > -1)
						{
							tmc.mouseChildren = false;
							tmc.buttonMode = true;
							tmc.addEventListener(MouseEvent.MOUSE_DOWN, ppndmc_md);
							tmc.d_na = MStringUtil.get_lastNum2(tnm, 1);
							tmc.d_nb = MStringUtil.get_lastNum2(tnm, 0);
							//trace(tmc.d_na, tmc.d_nb);
							
							//trace(MStringUtil.get_lastNum2(tmc.name, 0));
							/*tshp = new Shape();
							_dc2.addChild(tshp);
							_dic2[tmc] = tshp;*/
						}
						/*
						_dic1[tmc] = MStringUtil.get_lastNum2(tnm, 1);
						_dic2[tmc] = MStringUtil.get_lastNum2(tnm, 0);
						trace(_dic2[tmc]);*/
						
						//trace(tnm, tmc.d_na, tmc.d_nb);
					}
					
					return false;
				}, null);
				
				
//			(function():void
//			{
//				for each (var to:* in _dic1)
//					trace(to);
//			})();
//			
//			(function():void
//			{
//				for each (var to:* in _dic2)
//					trace(to);
//			})();
		}
		
		
		override public function dispose():void
		{
			if (_drc == null) return;			
			ppndmc_clear();
			_dic1 = null;
			_dic2 = null;
			MDisplayObjectContainerUtil.clear(_dc1, function():void {});
			MDisplayObjectContainerUtil.clear(_dc2, function():void {});
			_drc.removeChild(_dc1);
			_drc.removeChild(_dc2);
			_dc1 = null;
			_dc2 = null;
			_owner.removeChild(_drc);
			_drc = null;			
			super.dispose();
		}
		
	}
}