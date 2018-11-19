package hbx.utils
{
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;


	public final class MMovieClipUtil
	{
		/**
		 * 무비클립 롤오버아웃 핸들러
		 * <br/>
		 * @param evt: Event
		 */
		private static function pp_roo(evt:MouseEvent):void
		{
			var mvc:MovieClip = MovieClip(evt.currentTarget);
			if (evt.type == MouseEvent.ROLL_OUT)
			{
				mvc.gotoAndStop(1);
			}
			else if (evt.type == MouseEvent.ROLL_OVER)
			{
				mvc.gotoAndStop(2);
			}
		}


		/**
		 * 무비클립 기본 롤오버아웃 등록해제
		 * <br/>
		 * @param mvc: MovieClip
		 */
		public static function remove_roo(mvc:MovieClip):void
		{
			mvc.mouseChildren = true;
			mvc.buttonMode = false;
			mvc.removeEventListener(MouseEvent.ROLL_OUT, pp_roo);
			mvc.removeEventListener(MouseEvent.ROLL_OVER, pp_roo);
		}


		/**
		 * 무비클립 기본 롤오버아웃 등록하기
		 * <br/>
		 * @param mvc: MovieClip
		 * @param bButtonMode: BooleanButtonMode
		 */
		public static function add_roo(mvc:MovieClip, bButtonMode:Boolean = true):void
		{
			mvc.mouseChildren = false;
			mvc.buttonMode = bButtonMode;
			mvc.addEventListener(MouseEvent.ROLL_OUT, pp_roo);
			mvc.addEventListener(MouseEvent.ROLL_OVER, pp_roo);
		}


		/**
		 * 무비클립 클릭 핸들러 제거
		 * <br/>
		 * @param mvc: MovieClip
		 */
		public static function remove_clickHandler(mvc:MovieClip):void
		{
			var clickHandler:Function = mvc.$d_clickHandler;
			if (clickHandler == null) return;
			mvc.mouseChildren = true;
			mvc.buttonMode = false;
			mvc.removeEventListener(MouseEvent.CLICK, clickHandler);
			mvc.$d_clickHandler = undefined;
		}


		/**
		 * 무비클립 클릭 핸들러 등록
		 * <br/>
		 * @param mvc: MovieClip
		 * @param clickHandler: EventHandler
		 * @param bButtonMode: BooleanButtonMode
		 */
		public static function add_clickHandler(mvc:MovieClip, clickHandler:Function, bButtonMode:Boolean = true):void
		{
			mvc.mouseChildren = false;
			mvc.buttonMode = bButtonMode;
			mvc.addEventListener(MouseEvent.CLICK, clickHandler);
			mvc.$d_clickHandler = clickHandler;
		}


		/**
		 * 무비클립 클릭 핸들러 제거 roo
		 * <br/>
		 * @param mvc: MovieClip
		 */
		public static function remove_clickHandler_roo(mvc:MovieClip):void
		{
			var clickHandler:Function = mvc.$d_clickHandler;
			if (clickHandler == null) return;
			remove_roo(mvc);
			mvc.removeEventListener(MouseEvent.CLICK, clickHandler);
			mvc.$d_clickHandler = undefined;
		}


		/**
		 * 무비클립 클릭 핸들러 등록 roo
		 * <br/>
		 * @param mvc: MovieClip
		 * @param clickHandler: EventHandler
		 * @param bButtonMode: BooleanButtonMode
		 */
		public static function add_clickHandler_roo(mvc:MovieClip, clickHandler:Function, bButtonMode:Boolean = true):void
		{
			add_roo(mvc, bButtonMode);
			mvc.addEventListener(MouseEvent.CLICK, clickHandler);
			mvc.$d_clickHandler = clickHandler;
		}



		/**
		 * 프래임에서 라벨이름 검색해서 개수 반환
		 * <br/>
		 * @param mvc: MovieClip
		 * @param keyword: Keyword
		 */
		public static function get_frameLabelCount(mvc:MovieClip, keyword:String):uint
		{
			var rv:uint = 0;

			var fls:Array = mvc.currentLabels;
			for (var l:uint = fls.length, i:uint = 0; i < l; i++)
			{
				var fl:FrameLabel = fls[i];
				if (fl.name.indexOf(keyword) > -1)
				{
					rv++;
				}
			}

			return rv;
		}


		/**
		 * 프래임라벨로 프래임번호 알아내기
		 * <br/>
		 * @param mvc: MovieClip
		 * @param name: Name
		 */
		public static function get_frameLabelToFrame(mvc:MovieClip, name:String):int
		{
			var rv:int = -1;

			var fls:Array = mvc.currentLabels;
			for (var l:uint = fls.length, i:uint = 0; i < l; i++)
			{
				var fl:FrameLabel = fls[i];
				if (name == fl.name)
				{
					rv = fl.frame;
					break;
				}
			}

			return rv;
		}




		/**
		 * 딜레이에 사용되는 엔터프래임 핸들러
		 * <br/>
		 * @param evt: Event
		 */
		private static function pp_delayExcute_ef(evt:Event):void
		{
			var mvc:MovieClip = MovieClip(evt.currentTarget);
			var countLen:uint = mvc.$d_countLen;
			var count:uint = mvc.$d_count;

			if (count < countLen)
			{
				count++;
				mvc.$d_count = count;
			}
			else
			{
				var ac:Function = mvc.$d_afterCall;
				var acps:Array = mvc.$d_afterCallParams;

				delayExcute_stop(mvc);

				if (acps == null)
					ac();
				else
					ac.apply(null, acps);
			}

			//MDebugTool.test('pp_delayExcute_ef');
		}


		/**
		 * 특정 프래임이후에 함수 호출 정지
		 * <br/>
		 * @param mvc: MovieClip
		 */
		public static function delayExcute_stop(mvc:MovieClip):void
		{
			if (mvc.$d_afterCall == undefined) return;
			mvc.removeEventListener(Event.ENTER_FRAME, pp_delayExcute_ef);
			mvc.$d_countLen = undefined;
			mvc.$d_count = undefined;
			mvc.$d_afterCall = undefined;
			mvc.$d_afterCallParams = undefined;
		}


		/**
		 * 특정 프래임이후에 함수 호출
		 * <br/>
		 * @param mvc: MovieClip
		 * @param afterCall: Function
		 * @param afterCallParams: Array
		 * @param countLen: CountLenth
		 */
		public static function delayExcute(mvc:MovieClip, afterCall:Function, afterCallParams:Array = null, countLen:uint = 1):void
		{
			delayExcute_stop(mvc);
			mvc.$d_afterCall = afterCall;
			mvc.$d_afterCallParams = afterCallParams;
			mvc.$d_countLen = countLen;
			mvc.$d_count = 0;
			mvc.addEventListener(Event.ENTER_FRAME, pp_delayExcute_ef);
		}

	}

}
