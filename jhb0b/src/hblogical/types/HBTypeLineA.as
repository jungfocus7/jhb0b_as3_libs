package hblogical.types
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import hblogical.base.HBHerb;
	import jhb0b.events.CBumEvent;


	public class HBTypeLineA extends HBHerb
	{
		public static function detect(tcont:DisplayObjectContainer, thandler:Function = null):HBHerb
		{
			var tmc:MovieClip = tcont['mc_hbtla'];
			if (tmc != null)
			{
				var trv:HBHerb = new HBTypeLineA(tmc);
				if (thandler != null)
					trv.addEventListenerAll(thandler);
				return trv;
			}

			return null;
		}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		public static const ET_MOUSE_UP:String = MouseEvent.MOUSE_UP;
		public static const ET_MOUSE_MOVE:String = MouseEvent.MOUSE_MOVE;
		public static const ET_MOUSE_DOWN:String = MouseEvent.MOUSE_DOWN;

		override public function addEventListenerAll(listener:Function,
							useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			this.addEventListener(ET_MOUSE_UP, listener, useCapture, priority, useWeakReference);
			this.addEventListener(ET_MOUSE_MOVE, listener, useCapture, priority, useWeakReference);
			this.addEventListener(ET_MOUSE_DOWN, listener, useCapture, priority, useWeakReference);
		}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


		private static const _Thickness1:Number = 5;
		private static const _Thickness2:Number = 5;

		private static const _Color1:uint = 0x0f74aa;
		private static const _Color2:uint = 0xff0000;


		public function HBTypeLineA(towner:MovieClip)
		{
			super(towner);

			_drawRootCont = new Sprite();
			_owner.addChild(_drawRootCont);
			_drawRootCont.mouseChildren = false;
			_drawRootCont.mouseEnabled = false;
			_drawCont1 = new Sprite();
			_drawRootCont.addChild(_drawCont1);
			_drawCont2 = new Sprite();
			_drawRootCont.addChild(_drawCont2);

			_infoDic = new Dictionary();


			ppDragInit();
		}


		private function ppLineDraw1(tdrag:Sprite, tbx:Number, tby:Number, tex:Number, tey:Number):void
		{
			var tif:CInfo = _infoDic[tdrag];
			var tgrp:Graphics = tif.get_shp1().graphics;
			tgrp.clear();
			tgrp.lineStyle(_Thickness1, _Color1, 1);
			tgrp.moveTo(tbx, tby);
			tgrp.lineTo(tex, tey);
		}

		private function ppLineDraw2(tdrag:Sprite, tbx:Number, tby:Number, tex:Number, tey:Number):void
		{
			var tif:CInfo = _infoDic[tdrag];
			var tgrp:Graphics = tif.get_shp2().graphics;
			tgrp.clear();
			tgrp.lineStyle(_Thickness2, _Color2, 1);
			tgrp.moveTo(tbx, tby);
			tgrp.lineTo(tex, tey);
		}

		private function ppLineClear1(tdrag:Sprite):void
		{
			var tif:CInfo = _infoDic[tdrag];
			var tgrp:Graphics = tif.get_shp1().graphics;
			tgrp.clear();
		}

		private function ppLineClear2(tdrag:Sprite):void
		{
			var tif:CInfo = _infoDic[tdrag];
			var tgrp:Graphics = tif.get_shp2().graphics;
			tgrp.clear();
		}

		private function ppLinkedClear(tdrag:Sprite):void
		{
			if (tdrag == null) return;

			var tif1:CInfo = _infoDic[tdrag];
			if (tif1.linkedDrag != null)
			{
				ppLineClear1(tif1.linkedDrag);
				var tif2:CInfo = _infoDic[tif1.linkedDrag];
				if (tif2.linkedDrag != null)
				{
					ppLineClear1(tif2.linkedDrag);
					tif2.linkedDrag = null;
				}
				tif1.linkedDrag = null;
			}
		}


		override public function dispose():void
		{
			if (_drawRootCont == null) return;
			ppDragMouseUp(null);
			_drawRootCont.removeChild(_drawCont1);
			_drawCont1 = null;
			_drawRootCont.removeChild(_drawCont2);
			_drawCont2 = null;
			_owner.removeChild(_drawRootCont);
			_drawRootCont = null;
			super.dispose();
		}


		// 전체 그리기 컨테이너
		private var _drawRootCont:Sprite;
		// 사용자가 그린 선 컨테이너
		private var _drawCont1:Sprite;
		// 정답 선 컨테이너
		private var _drawCont2:Sprite;

		// 정보객체 참고용
		private var _infoDic:Dictionary;

		// 드래그 시작점
		private var _beginDrag:Sprite;
		// 드래그 끝점
		private var _endDrag:Sprite;


		private static const _reg1:RegExp = /ma\d+?_/;
		private function ppDragInit():void
		{
			for (var ti:int = 0, tl:int = _owner.numChildren; ti < tl; ti++)
			{
				var tmc:MovieClip = _owner.getChildAt(ti) as MovieClip;
				if (tmc != null)
				{
					var tnm:String = tmc.name;
					if (_reg1.test(tnm))
					{
						tmc.mouseChildren = false;
						tmc.buttonMode = true;
						tmc.addEventListener(MouseEvent.MOUSE_DOWN, ppDragMouseDown);


						var tshp1:Shape = new Shape();
						_drawCont1.addChild(tshp1);
						var tshp2:Shape = new Shape();
						_drawCont2.addChild(tshp2);

						var tinfo:CInfo = new CInfo(tnm, tshp1, tshp2);
						_infoDic[tmc] = tinfo;
					}
				}
			}
		}


		private function ppDragClear():void
		{
			if (_beginDrag == null) return;
			_beginDrag = null;
			_endDrag = null;
		}

		private function ppDragCheck():void
		{
			if (_beginDrag == null) return;

			var tif1:CInfo = _infoDic[_beginDrag];
			var tif2:CInfo, tif3:CInfo;
			var tgnm:String = tif1.get_groupName();
			//trace('tgnm: ' + tgnm);
			for (var ti:int = 0, tl:int = _owner.numChildren; ti < tl; ti++)
			{
				var tmc:MovieClip = _owner.getChildAt(ti) as MovieClip;
				if ((tmc != null) && (tmc != _beginDrag) &&
					tmc.hitTestPoint(_stage.mouseX, _stage.mouseY))
				{
					var tnm:String = tmc.name;
					tif2 = _infoDic[tmc];
					if ((tnm.indexOf(tgnm) == 0) &&
						CInfo.get_connectable(tif1, tif2))
					{
						_endDrag = tmc;
					}
					break;
				}
			}

			if (_endDrag != null)
			{
				ppLinkedClear(_endDrag);
				ppLineDraw1(_beginDrag, _beginDrag.x, _beginDrag.y, _endDrag.x, _endDrag.y);
				tif1.linkedDrag = _endDrag;
				tif2.linkedDrag = _beginDrag;
			}
			else
			{
				ppLineClear1(_beginDrag);
			}
		}

		private function ppDragMouseUp(evt:MouseEvent):void
		{
			if (_beginDrag == null) return;

			_stage.removeEventListener(MouseEvent.MOUSE_UP, ppDragMouseUp);
			_stage.removeEventListener(MouseEvent.MOUSE_MOVE, ppDragMouseMove);
			if (evt != null) ppDragCheck();
			ppDragClear();

			this.dispatchEvent(new CBumEvent(ET_MOUSE_UP));
		}

		private function ppDragMouseMove(evt:MouseEvent):void
		{
			if (_beginDrag == null) return;

			ppLineDraw1(_beginDrag, _beginDrag.x, _beginDrag.y, _owner.mouseX, _owner.mouseY);
			if (evt != null) evt.updateAfterEvent();

			this.dispatchEvent(new CBumEvent(ET_MOUSE_MOVE));
		}

		private function ppDragMouseDown(evt:MouseEvent):void
		{
			_beginDrag = MovieClip(evt.currentTarget);
			ppLinkedClear(_beginDrag);
			_stage.addEventListener(MouseEvent.MOUSE_UP, ppDragMouseUp);
			_stage.addEventListener(MouseEvent.MOUSE_MOVE, ppDragMouseMove);
			ppDragMouseMove(null);

			this.dispatchEvent(new CBumEvent(ET_MOUSE_DOWN));
		}



		private function ppAnswerClear(tdnm:String, tn:int):void
		{
			var tbd:Sprite = _owner[tdnm];
			var ted:Sprite = _owner[CInfo(_infoDic[tbd]).get_groupName() + '2_' + tn];
			//trace(tbd.name, ted.name);
			ppLineClear2(tbd);
			tbd.mouseEnabled = true;
			ted.mouseEnabled = true;
		}

		private function ppAnswerDraw(tdnm:String, tn:int):void
		{
			var tbd:Sprite = _owner[tdnm];
			var ted:Sprite = _owner[CInfo(_infoDic[tbd]).get_groupName() + '2_' + tn];
			//trace(tbd.name, ted.name);
			ppLinkedClear(tbd);
			ppLinkedClear(ted);
			ppLineDraw2(tbd, tbd.x, tbd.y, ted.x, ted.y);
			tbd.mouseEnabled = false;
			ted.mouseEnabled = false;
		}


		override public function callin(tcnm:String, ... targs):void
		{
			var tansArr:Array = targs[0];
			var ti:uint = targs[1];

			var tao:Object = tansArr[ti],
				taa:Array;

			var tl:uint, i:uint,
				to:Object;


			switch (tcnm)
			{
				case 'answerDraw':
				{
					taa = tao as Array;
					if (taa != null) {
						tl = taa.length;
						for (i = 0; i < tl; i++) {
							to = taa[i];
							ppAnswerDraw(to.tdnm, to.tn);
						}
					}
					else {
						ppAnswerDraw(tao.tdnm, tao.tn);
					}
					break;
				}
				case 'answerClear':
				{
					taa = tao as Array;
					if (taa != null) {
						tl = taa.length;
						for (i = 0; i < tl; i++) {
							to = taa[i];
							ppAnswerClear(to.tdnm, to.tn);
						}
					}
					else {
						ppAnswerClear(tao.tdnm, tao.tn);
					}
					break;
				}
			}
		}

/*
		override public function callin(tcnm:String, ... targs):void
		{
			switch (tcnm)
			{
				case 'answerClear':
				{
					ppAnswerClear(targs[0], targs[1]);
					break;
				}
				case 'answerDraw':
				{
					ppAnswerDraw(targs[0], targs[1]);
					break;
				}
			}
		}*/

	}
}








import flash.display.Shape;
import flash.display.Sprite;


class CInfo
{
	private static function ppGetGroupName(tnm:String):String
	{
		var tarr:Array = tnm.split('_');
		if (tarr.length >= 3)
		{
			var trv:String = tarr[0] + '_';
			return trv;
		}
		else
		{
			return null;
		}
	}

	private static function ppGetBackName(tnm:String):String
	{
		var tarr:Array = tnm.split('_');
		if (tarr.length >= 3)
		{
			var trv:String = tarr[1] + '_' + tarr[2];
			return trv;
		}
		else
		{
			return null;
		}
	}

	private static function ppGetColNum(tnm:String):int
	{
		var tarr:Array = tnm.split('_');
		if (tarr.length >= 3)
		{
			var trv:int = int(tarr[1]);
			return trv;
		}
		else
		{
			return -1;
		}
	}

	private static function ppGetRowNum(tnm:String):int
	{
		var tarr:Array = tnm.split('_');
		if (tarr.length >= 3)
		{
			var trv:int = int(tarr[2]);
			return trv;
		}
		else
		{
			return -1;
		}
	}

	public static function get_connectable(tif1:CInfo, tif2:CInfo):Boolean
	{
		if (tif1.get_groupName() == tif2.get_groupName())
		{
			if (tif1.get_colNum() != tif2.get_colNum())
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		else
		{
			return false;
		}
	}

	private static function ppPrint(tnm:String):void
	{
		trace('FullName: ' + tnm + ', ' +
			  'GroupName: ' + ppGetGroupName(tnm) + ', ' +
			  'BackName: ' + ppGetBackName(tnm) + ', ' +
			  'ColNum: ' + ppGetColNum(tnm) + ', ' +
			  'RowNum: ' + ppGetRowNum(tnm))
	}

//	{
//			ppPrint('ma1_1_1');
//			ppPrint('ma1_1_2');
//			ppPrint('ma1_1_3');
//			ppPrint('ma1_2_1');
//			ppPrint('ma1_2_2');
//			ppPrint('ma1_2_3');
//			trace('');
//			ppPrint('ma2_1_1');
//			ppPrint('ma2_2_1');
//			ppPrint('ma2_2_2');
//			trace('');
//			ppPrint('ma3_1_1');
//			ppPrint('ma3_2_1');
//			ppPrint('ma3_2_2');
//			trace('');
//			ppPrint('ma4_1_1');
//			ppPrint('ma4_2_1');
//			ppPrint('ma4_2_2');
//			trace('');
//			trace('');
//			trace('');
//			trace(get_connectable('ma1_1_1', 'ma1_1_1'));
//			trace(get_connectable('ma1_1_1', 'ma1_2_1'));
//	}


	public function CInfo(tfullName:String, tshp1:Shape, tshp2:Shape)
	{
		_fullName = tfullName;
		_groupName = ppGetGroupName(_fullName);
		_backName = ppGetBackName(_fullName);
		_colNum = ppGetColNum(_fullName);
		_rowNum = ppGetRowNum(_fullName);
		_shp1 = tshp1;
		_shp2 = tshp2;
		//print();
	}

	private var _fullName:String;
	public function get_fullName():String
	{
		return _fullName;
	}

	private var _groupName:String;
	public function get_groupName():String
	{
		return _groupName;
	}

	private var _backName:String;
	public function get_backName():String
	{
		return _backName;
	}

	private var _colNum:int;
	public function get_colNum():int
	{
		return _colNum;
	}

	private var _rowNum:int;
	public function get_rowNum():int
	{
		return _rowNum;
	}


	public function print():void
	{
		trace('FullName: ' + _fullName + ', ' +
			  'GroupName: ' + _groupName + ', ' +
			  'BackName: ' + _backName + ', ' +
			  'ColNum: ' + _colNum + ', ' +
			  'RowNum: ' + _rowNum);
	}



	private var _shp1:Shape;
	public function get_shp1():Shape
	{
		return _shp1;
	}

	private var _shp2:Shape;
	public function get_shp2():Shape
	{
		return _shp2;
	}

	public var linkedDrag:Sprite;
}





