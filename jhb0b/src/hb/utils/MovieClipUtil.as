/**
	@Name: MovieClipUtil
	@Author: HobisJung(jhb0b@naver.com)
	@Date: 2016-01-22
	@Comment:
	{
	}
*/
package hb.utils
{
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	// ::
	public final class MovieClipUtil
	{
		public function MovieClipUtil()
		{
		}

		// :: 무비클립 롤오버아웃 핸들러
		private static function p_roo(event:MouseEvent):void
		{
			var t_mc:MovieClip = event.currentTarget as MovieClip;

			if (event.type == MouseEvent.ROLL_OUT)
			{
				t_mc.gotoAndStop(1);
			}
			else if (event.type == MouseEvent.ROLL_OVER)
			{
				t_mc.gotoAndStop(2);
			}
		}
		// :: 무비클립 기본 롤오버아웃 등록해제
		public static function remove_roo(target:MovieClip):void
		{
			target.mouseChildren = true;
			target.buttonMode = false;
			target.removeEventListener(MouseEvent.ROLL_OUT, p_roo);
			target.removeEventListener(MouseEvent.ROLL_OVER, p_roo);
		}
		// :: 무비클립 기본 롤오버아웃 등록하기
		public static function add_roo(target:MovieClip):void
		{
			target.mouseChildren = false;
			target.buttonMode = true;
			target.addEventListener(MouseEvent.ROLL_OUT, p_roo);
			target.addEventListener(MouseEvent.ROLL_OVER, p_roo);
		}

		// :: 무비클립 콜백 호출
		public static function dispatch_callBack(target:MovieClip, eventObj:Object):void
		{
			if (target.d_onCallBack != undefined)
				target.d_onCallBack(eventObj);
		}

		// :: 프래임에서 라벨이름 검색해서 개수 반환
		public static function get_frameLabelCount(target:MovieClip, keyword:String):uint
		{
			var t_rv:uint = 0;

			var t_fls:Array = null;
			var t_fl:FrameLabel = null;
			var t_la:uint, i:uint;

			t_fls = target.currentLabels;
			t_la = t_fls.length;
			for (i = 0; i < t_la; i ++)
			{
				t_fl = t_fls[i];
				if (t_fl.name.indexOf(keyword) > -1)
				{
					t_rv ++;
				}
			}

			return t_rv;
		}

		// :: 프래임라벨로 프래임번호 알아내기
		public static function get_frameLabelToFrame(target:MovieClip, name:String):int
		{
			var t_rv:int = -1;

			var t_fls:Array = target.currentLabels;
			var t_fl:FrameLabel = null;
			var t_la:uint, i:uint;

			t_la = t_fls.length;
			for (i = 0; i < t_la; i ++)
			{
				t_fl = t_fls[i];
				if (name == t_fl.name)
				{
					t_rv = t_fl.frame;

					break;
				}
			}

			return t_rv;
		}

		// ::
		private static function p_delayExcute_ef(event:Event):void
		{
			var t_mc:MovieClip = event.currentTarget as MovieClip;

			if (t_mc.$d_count < t_mc.$d_countLen)
			{
				t_mc.$d_count ++;
			}
			else
			{
				var t_ac:Function = t_mc.$d_ac;
				var t_acps:Array = t_mc.$d_acps;
				
				delayExcute_stop(t_mc);

				if (t_acps == null)
					t_ac();
				else
					t_ac.apply(null, t_acps);
			}

			//trace('p_delayExcute_ef');
		}
		// :: 특정 프래임이후에 함수 호출 정지
		public static function delayExcute_stop(target:MovieClip):void
		{
			target.removeEventListener(Event.ENTER_FRAME, p_delayExcute_ef);
			target.$d_countLen = undefined;
			target.$d_count = undefined;
			target.$d_ac = undefined;
			target.$d_acps = undefined;
		}
		// :: [Frame]특정 프래임이후에 함수 호출
		/**
			@Params:
			{
				target 타겟무비클립,
				ac(AfterCallBack) 경과후 실행되는 함수,
				acps(AfterCallBack Params) 실행되는 함수의 전달 인자들 배열,
				countLen 프래임반복횟수
			}

			@Using:
			{
				MovieClipUtil.delayExcute(this,
					function():void
					{
						trace(arguments);
						trace(this);
					}, [this, 0, 1, 2], 100
				);
			}
		*/
		public static function delayExcute(target:MovieClip, ac:Function, acps:Array = null, countLen:uint = 1):void
		{
			if (target.$d_ac != undefined)
			{
				delayExcute_stop(target);
			}

			target.$d_ac = ac;
			target.$d_acps = acps;
			target.$d_countLen = countLen;
			target.$d_count = 0;
			target.addEventListener(Event.ENTER_FRAME, p_delayExcute_ef);
		}


		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// # 130829 추가
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// :: 무비클립 클릭 핸들러 제거
		public static function remove_clickHandler(target:MovieClip,
													isButtonMode:Boolean = true):void
		{
			if (target.d_clickHandler != undefined)
			{
				if (isButtonMode)
				{
					target.mouseChildren = true;
					target.buttonMode = false;
				}
				target.removeEventListener(MouseEvent.CLICK, target.d_clickHandler);
				target.d_clickHandler = undefined;
			}
		}
		// :: 무비클립 클릭 핸들러 등록
		public static function add_clickHandler(target:MovieClip, clickHandler:Function,
													isButtonMode:Boolean = true):void
		{
			if (isButtonMode)
			{
				target.mouseChildren = false;
				target.buttonMode = true;
			}
			target.addEventListener(MouseEvent.CLICK, clickHandler);
			target.d_clickHandler = clickHandler;
		}


		//
		//
		//
		//
		// :: 무비클립 클릭 핸들러 제거 roo
		public static function remove_clickHandler_roo(target:MovieClip):void
		{
			if (target.d_clickHandler != undefined)
			{
				remove_roo(target);
				target.removeEventListener(MouseEvent.CLICK, target.d_clickHandler);
				target.d_clickHandler = undefined;
			}
		}

		// :: 무비클립 클릭 핸들러 등록 roo
		public static function add_clickHandler_roo(target:MovieClip, clickHandler:Function):void
		{
			add_roo(target);
			target.addEventListener(MouseEvent.CLICK, clickHandler);
			target.d_clickHandler = clickHandler;
		}

	}

}
