package hblogical.base
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;


	public class HBHerb extends EventDispatcher
	{
	////////////////////////////////////////////////////////////////////////////////////////////////////
	//// ## 객체 인스턴스 탐조 관련
	////////////////////////////////////////////////////////////////////////////////////////////////////
		//-- 생성된 객체를 모두 참조하는 딕셔너리
		private static var _dicHerb:Dictionary;

		//::
		public static function dicHerb_loopTest():void
		{
			if (_dicHerb == null) return;

			var ti:uint = 0;
			for (var tp:* in _dicHerb)
			{
				var thb:HBHerb = _dicHerb[tp];
				test((ti++).toString() + ', ' + MovieClip(tp).name + ', ' + thb.toString());
			}
		}

		//::
		public static function dicHerb_clear():void
		{
			if (_dicHerb == null) return;

			for (var tp:* in _dicHerb)
			{
				var thb:HBHerb = _dicHerb[tp];
				if (thb != null)
				{
					thb.dispose();
					delete _dicHerb[tp];
				}
			}
			_dicHerb = null;
		}

		//::
		public static function dicHerb_remove(towner:MovieClip):void
		{
			if (_dicHerb == null) return;

			var thb:HBHerb = _dicHerb[towner];
			if (thb != null)
			{
				thb.dispose();
				delete _dicHerb[towner];
			}
		}

		//::
		public static function dicHerb_add(towner:MovieClip, thb:HBHerb):void
		{
			if (_dicHerb == null)
			{
				_dicHerb = new Dictionary();
				_dicHerb[towner] = thb;
			}
			else
			{
				var thby:HBHerb = _dicHerb[towner];
				if (thby != null)
				{
					thby.dispose();
					delete _dicHerb[towner];
				}
				_dicHerb[towner] = thb;
			}
		}

		//::
		public static function dicHerb_get(towner:MovieClip):HBHerb
		{
			if (_dicHerb == null) return null;

			return _dicHerb[towner];
		}
		////////////////////////////////////////////////////////////////////////////////////////////////////




		////////////////////////////////////////////////////////////////////////////////////////////////////
		//// ## 유틸리티성 함수들
		////////////////////////////////////////////////////////////////////////////////////////////////////
		//:: 활성화,비활성화
		public static function loopEnabled(tcont:DisplayObjectContainer, tgnm:String, tb:Boolean):void
		{
			for (var ti:int = 0, tl:int = tcont.numChildren; ti < tl; ti++)
			{
				var tio:InteractiveObject = tcont.getChildAt(ti) as InteractiveObject;
				if (tio != null)
				{
					if (tio.name.indexOf(tgnm) == 0)
						tio.mouseEnabled = tb;
				}
			}
		}

		//:: 디버깅용
		public static function test(tvs:String):void
		{
			trace('[# hb] ' + tvs);
		}


		//
		//
		//
		//:: 컨테이너에서 데이터 가져오기
		public static function get_privateData(tcont:DisplayObjectContainer,
														tnma:String = null):Object
		{
			if (tnma == null)
				tnma = '__privateData';
			return tcont[tnma];
		}

		//:: 컨테이너에서 데이터 가져오기
		public static function get_answerArr(tcont:DisplayObjectContainer,
														tnma:String = null, tnmb:String = null):Array
		{
			var tao:Object = get_privateData(tcont, tnma);
			if (tao != null) {
				if (tnmb == null)
					tnmb = 'answerArr';
				return tao[tnmb];
			}
			else
				return null;
		}
		////////////////////////////////////////////////////////////////////////////////////////////////////




		////////////////////////////////////////////////////////////////////////////////////////////////////
		//// ## 허브 클래스 인스턴스 영역
		////////////////////////////////////////////////////////////////////////////////////////////////////
		public function HBHerb(towner:MovieClip)
		{
			_owner = towner;
			_stage = _owner.stage;

			HBHerb.dicHerb_add(towner, this);
		}

		protected var _owner:MovieClip;
		public function get_owner():MovieClip
		{
			return _owner;
		}

		protected var _stage:Stage;


		public function dispose():void
		{
			if (_owner == null) return;
			_stage = null;
			_owner = null;
		}


		public function addEventListenerAll(listener:Function,
							useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
		}

		public function callin(tcnm:String, ... targs):void
		{
		}
		////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}

