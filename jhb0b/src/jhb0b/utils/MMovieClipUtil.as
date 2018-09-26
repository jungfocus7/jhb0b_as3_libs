package jhb0b.utils
{
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;


	public final class MMovieClipUtil
	{
		//:: 무비클립 롤오버아웃 핸들러
		private static function p_roo(event:MouseEvent):void
		{
			var t_mc:MovieClip = MovieClip(event.currentTarget);

			if (event.type == MouseEvent.ROLL_OUT)
			{
				t_mc.gotoAndStop(1);
			}
			else if (event.type == MouseEvent.ROLL_OVER)
			{
				t_mc.gotoAndStop(2);
			}
		}

		//:: 무비클립 기본 롤오버아웃 등록해제
		public static function remove_roo(tmc:MovieClip):void
		{
			tmc.mouseChildren = true;
			tmc.buttonMode = false;
			tmc.removeEventListener(MouseEvent.ROLL_OUT, p_roo);
			tmc.removeEventListener(MouseEvent.ROLL_OVER, p_roo);
		}

		//:: 무비클립 기본 롤오버아웃 등록하기
		public static function add_roo(tmc:MovieClip,
								isButtonMode:Boolean = true):void
		{
			tmc.mouseChildren = false;
			tmc.buttonMode = isButtonMode;
			tmc.addEventListener(MouseEvent.ROLL_OUT, p_roo);
			tmc.addEventListener(MouseEvent.ROLL_OVER, p_roo);
		}

		//:: 무비클립 클릭 핸들러 제거
		public static function remove_clickHandler(tmc:MovieClip):void
		{
			var t_clickHandler:Function = tmc.$d_clickHandler;
			if (t_clickHandler == null) return;
			tmc.mouseChildren = true;
			tmc.buttonMode = false;
			tmc.removeEventListener(MouseEvent.CLICK, t_clickHandler);
			tmc.$d_clickHandler = undefined;
		}

		//:: 무비클립 클릭 핸들러 등록
		public static function add_clickHandler(tmc:MovieClip,
								clickHandler:Function,
								isButtonMode:Boolean = true):void
		{
			tmc.mouseChildren = false;
			tmc.buttonMode = isButtonMode;
			tmc.addEventListener(MouseEvent.CLICK, clickHandler);
			tmc.$d_clickHandler = clickHandler;
		}

		//:: 무비클립 클릭 핸들러 제거 roo
		public static function remove_clickHandler_roo(tmc:MovieClip):void
		{
			var t_clickHandler:Function = tmc.$d_clickHandler;
			if (t_clickHandler == null) return;
			remove_roo(tmc);
			tmc.removeEventListener(MouseEvent.CLICK, t_clickHandler);
			tmc.$d_clickHandler = undefined;
		}

		//:: 무비클립 클릭 핸들러 등록 roo
		public static function add_clickHandler_roo(tmc:MovieClip,
								clickHandler:Function,
								isButtonMode:Boolean = true):void
		{
			add_roo(tmc, isButtonMode);
			tmc.addEventListener(MouseEvent.CLICK, clickHandler);
			tmc.$d_clickHandler = clickHandler;
		}



		//:: 프래임에서 라벨이름 검색해서 개수 반환
		public static function get_frameLabelCount(tmc:MovieClip, keyword:String):uint
		{
			var t_rv:uint = 0;

			var t_fls:Array = tmc.currentLabels;
			var t_l:uint = t_fls.length;
			for (var i:uint = 0; i < t_l; i ++)
			{
				var t_fl:FrameLabel = t_fls[i];
				if (t_fl.name.indexOf(keyword) > -1)
				{
					t_rv ++;
				}
			}

			return t_rv;
		}

		//:: 프래임라벨로 프래임번호 알아내기
		public static function get_frameLabelToFrame(tmc:MovieClip, name:String):int
		{
			var t_rv:int = -1;

			var t_fls:Array = tmc.currentLabels;
			var t_l:uint = t_fls.length;
			for (var i:uint = 0; i < t_l; i ++)
			{
				var t_fl:FrameLabel = t_fls[i];
				if (name == t_fl.name)
				{
					t_rv = t_fl.frame;
					break;
				}
			}

			return t_rv;
		}



		//::
		private static function p_delayExcute_ef(evt:Event):void
		{
			var t_mc:MovieClip = MovieClip(evt.currentTarget);
			var t_countLen:uint = t_mc.$d_countLen;
			var t_count:uint = t_mc.$d_count;

			if (t_count < t_countLen)
			{
				t_count++;
				t_mc.$d_count = t_count;
			}
			else
			{
				var t_ac:Function = t_mc.$d_afterCall;
				var t_acps:Array = t_mc.$d_afterCallParams;

				delayExcute_stop(t_mc);

				if (t_acps == null)
					t_ac();
				else
					t_ac.apply(null, t_acps);
			}

			//MDebugTool.test('p_delayExcute_ef');
		}

		//:: 특정 프래임이후에 함수 호출 정지
		public static function delayExcute_stop(tmc:MovieClip):void
		{
			if (tmc.$d_afterCall == undefined) return;
			tmc.removeEventListener(Event.ENTER_FRAME, p_delayExcute_ef);
			tmc.$d_countLen = undefined;
			tmc.$d_count = undefined;
			tmc.$d_afterCall = undefined;
			tmc.$d_afterCallParams = undefined;
		}

		//:: 특정 프래임이후에 함수 호출
		public static function delayExcute(tmc:MovieClip,
								afterCall:Function, afterCallParams:Array = null,
								countLen:uint = 1):void
		{
			delayExcute_stop(tmc);
			tmc.$d_afterCall = afterCall;
			tmc.$d_afterCallParams = afterCallParams;
			tmc.$d_countLen = countLen;
			tmc.$d_count = 0;
			tmc.addEventListener(Event.ENTER_FRAME, p_delayExcute_ef);
		}

	}

}
