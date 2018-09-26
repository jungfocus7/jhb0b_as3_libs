package jhb0b.utils
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;


	// #
	public final class MDisplayObjectContainerUtil
	{
		//:: 자식객체 반복검출 (필터링 없음)
		public static function contLoop(
									tcont:DisplayObjectContainer,	// Loop DisplayObjectContainer
									tlf:Function,					// Loop Function
									tlfpa:Array = null,				// Loop Function Parameter Array
									tlfs:Object = null):void		// Loop Function Scope
		{
			for (var tl:int = tcont.numChildren, ti:int = 0; ti < tl; ti++) {
				var tcdo:DisplayObject = tcont.getChildAt(ti);
				var targs:Array =
					(tlfpa != null) ? [tcdo, ti].concat(tlfpa) : [tcdo, ti];
				if (tlf.apply(tlfs, targs)) break;
			}
		}

		//:: 자식객체 조건검출 (정규식)
		public static function contLoop_reg(
									tcont:DisplayObjectContainer,	// Loop DisplayObjectContainer
									treg:RegExp,					// Search Regular Express
									tlf:Function,					// Loop Function
									tlfpa:Array = null,				// Loop Function Parameter Array
									tlfs:Object = null):void		// Loop Function Scope
		{
			for (var tl:int = tcont.numChildren, ti:int = 0; ti < tl; ti++)
			{
				var tcdo:DisplayObject = tcont.getChildAt(ti);
				if (treg.test(tcdo.name)) {
					var targs:Array =
						(tlfpa != null) ? [tcdo, ti].concat(tlfpa) : [tcdo, ti];
					if (tlf.apply(tlfs, targs)) break;
				}
			}
		}

		//:: 자식객체 조건검출 (문자열 접두사)
		public static function contLoop_io(
									tcont:DisplayObjectContainer,	// Loop DisplayObjectContainer
									tsprf:String,					// Search prefix
									tlf:Function,					// Loop Function
									tlfpa:Array = null,				// Loop Function Parameter Array
									tlfs:Object = null):void		// Loop Function Scope
		{
			for (var tl:int = tcont.numChildren, ti:int = 0; ti < tl; ti++)
			{
				var tcdo:DisplayObject = tcont.getChildAt(ti);
				if (tcdo.name.indexOf(tsprf) > -1) {
					var targs:Array =
						(tlfpa != null) ? [tcdo, ti].concat(tlfpa) : [tcdo, ti];
					if (tlf.apply(tlfs, targs)) break;
				}
			}
		}


		//:: 자식객체 제거하면서 콜백함스 호출
		public static function contLoop_clear(
									tcont:DisplayObjectContainer,	// Loop DisplayObjectContainer
									tbs:Boolean = false,			// Sub Container is Search
									tlf:Function = null,					// Loop Function
									tlfpa:Array = null,				// Loop Function Parameter Array
									tlfs:Object = null):void		// Loop Function Scope
		{
			var ti:int = tcont.numChildren;
			while (ti > 0)
			{
				var tcdo:DisplayObject = tcont.removeChildAt(0);
				if (tbs) {
					var tsc:DisplayObjectContainer = tcdo as DisplayObjectContainer;
					if (tsc != null) {
						arguments.callee(tsc, tbs, tlf, tlfpa, tlfs);
					}
				}
				if (tlf != null) {
					var targs:Array =
						(tlfpa != null) ? [tcdo].concat(tlfpa) : [tcdo];
					tlf.apply(tlfs, targs);
				}
				ti--;
			}
		}








		//::
		private static function pp_distinct_childArr(tarr:Array):Array {
			if ((tarr == null) || (tarr.length < 1)) return null;

			var tl:uint = tarr.length;
			var tna:Array;

			var tsf:Function = function(te:DisplayObject, ti:uint, ta:Array):Boolean {
				return te.name != tcdo.name;
			};

			for (var i:uint = 0; i < tl; i++) {
				var tcdo:DisplayObject = tarr[i];
				if (tna == null) tna = [];
				if (tna.every(tsf)) {
					tna.push(tcdo);
				}
			}

			return tna;
		}

		//::
		public static function get_childArr_io(tcont:DisplayObjectContainer, tsprf:String):Array {
			var tarr:Array;

			for (var tl:int = tcont.numChildren, ti:int = 0; ti < tl; ti++) {
				var tcdo:DisplayObject = tcont.getChildAt(ti);
				if (tcdo.name.indexOf(tsprf) > -1) {
					if (tarr == null)
						tarr = [];
					tarr.push(tcdo);
				}
			}

			if (tarr != null)
				tarr = pp_distinct_childArr(tarr);

			return tarr;
		}

		//::
		public static function get_childArr_reg(tcont:DisplayObjectContainer, treg:RegExp):Array {
			var tarr:Array;

			for (var tl:int = tcont.numChildren, ti:int = 0; ti < tl; ti++) {
				var tcdo:DisplayObject = tcont.getChildAt(ti);
				if (treg.test(tcdo.name)) {
					if (tarr == null)
						tarr = [];
					tarr.push(tcdo);
				}
			}

			if (tarr != null)
				tarr = pp_distinct_childArr(tarr);

			return tarr;
		}
	}
}