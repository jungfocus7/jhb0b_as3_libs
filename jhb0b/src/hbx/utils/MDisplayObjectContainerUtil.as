package hbx.utils
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;



	public final class MDisplayObjectContainerUtil
	{
		/**
		 * 자식객체 반복검출 (필터링 없음)
		 * <br/>
		 * @param tcont:DisplayObjectContainer 	//Loop DisplayObjectContainer
		 * @param tlf:Function 					//Loop Function
		 * @param tlfpa:Array = null			//Loop Function Parameter Array
		 * @param tlfs:Object = null			//Loop Function Scope
		 */
		public static function contLoop(
			tcont:DisplayObjectContainer, tlf:Function, tlfpa:Array = null, tlfs:Object = null):void
		{
			for (var tl:int = tcont.numChildren, ti:int = 0; ti < tl; ti++) {
				var tcdo:DisplayObject = tcont.getChildAt(ti);
				var targs:Array =
					(tlfpa != null) ? [tcdo, ti].concat(tlfpa) : [tcdo, ti];
				if (tlf.apply(tlfs, targs)) break;
			}
		}


		/**
		 * 자식객체 조건검출 (Regex 정규식)
		 * <br/>
		 * @param tcont:DisplayObjectContainer	//Loop DisplayObjectContainer
		 * @param treg:RegExp					//Search Regular Express
		 * @param tlf:Function					//Loop Function
		 * @param tlfpa:Array = null			//Loop Function Parameter Array
		 * @param tlfs:Object = null			//Loop Function Scope
		 */
		public static function contLoop_reg(
			tcont:DisplayObjectContainer, treg:RegExp, tlf:Function, tlfpa:Array = null, tlfs:Object = null):void
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


		/**
		 * 자식객체 조건검출 (IndexOf 문자열 접두사)
		 * <br/>
		 * @param tcont:DisplayObjectContainer	//Loop DisplayObjectContainer
		 * @param tsprf:String					//Search prefix
		 * @param tlf:Function					//Loop Function
		 * @param tlfpa:Array = null			//Loop Function Parameter Array
		 * @param tlfs:Object = null			//Loop Function Scope
		 */
		public static function contLoop_io(
			tcont:DisplayObjectContainer, tsprf:String, tlf:Function, tlfpa:Array = null, tlfs:Object = null):void
		{
			for (var tl:int = tcont.numChildren, ti:int = 0; ti < tl; ti++)
			{
				var tcdo:DisplayObject = tcont.getChildAt(ti);
				if (tcdo.name.indexOf(tsprf) > -1)
				{
					var targs:Array =
						(tlfpa != null) ? [tcdo, ti].concat(tlfpa) : [tcdo, ti];
					if (tlf.apply(tlfs, targs)) break;
				}
			}
		}


		/**
		 * 자식객체 제거하면서 콜백함스 호출
		 * <br/>
		 * @param tcont:DisplayObjectContainer	//Loop DisplayObjectContainer
		 * @param tbs:Boolean = false			//Sub Container is Search
		 * @param tlf:Function = null			//Loop Function
		 * @param tlfpa:Array = null			//Loop Function Parameter Array
		 * @param tlfs:Object = null			//Loop Function Scope
		 */
		public static function contLoop_clear(
			tcont:DisplayObjectContainer, tbs:Boolean = false, tlf:Function = null, tlfpa:Array = null, tlfs:Object = null):void
		{
			var ti:int = tcont.numChildren;
			while (ti > 0)
			{
				var tcdo:DisplayObject = tcont.removeChildAt(0);
				if (tbs)
				{
					var tsc:DisplayObjectContainer = tcdo as DisplayObjectContainer;
					if (tsc != null) {
						arguments.callee(tsc, tbs, tlf, tlfpa, tlfs);
					}
				}
				if (tlf != null)
				{
					var targs:Array =
						(tlfpa != null) ? [tcdo].concat(tlfpa) : [tcdo];
					tlf.apply(tlfs, targs);
				}

				ti--;
			}
		}








		/** */
		private static function pp_distinct_childArr(tarr:Array):Array
		{
			if ((tarr == null) || (tarr.length < 1)) return null;

			var tl:uint = tarr.length;
			var tna:Array;

			var tsf:Function = function(te:DisplayObject, ti:uint, ta:Array):Boolean
			{
				return te.name != tcdo.name;
			};

			for (var i:uint = 0; i < tl; i++)
			{
				var tcdo:DisplayObject = tarr[i];
				if (tna == null) tna = [];
				if (tna.every(tsf))
				{
					tna.push(tcdo);
				}
			}

			return tna;
		}


		/** */
		public static function get_childArr_io(tcont:DisplayObjectContainer, tsprf:String):Array
		{
			var tarr:Array;

			for (var tl:int = tcont.numChildren, ti:int = 0; ti < tl; ti++)
			{
				var tcdo:DisplayObject = tcont.getChildAt(ti);
				if (tcdo.name.indexOf(tsprf) > -1)
				{
					if (tarr == null)
						tarr = [];
					tarr.push(tcdo);
				}
			}

			if (tarr != null)
				tarr = pp_distinct_childArr(tarr);

			return tarr;
		}


		/** */
		public static function get_childArr_reg(tcont:DisplayObjectContainer, treg:RegExp):Array
		{
			var tarr:Array;

			for (var tl:int = tcont.numChildren, ti:int = 0; ti < tl; ti++)
			{
				var tcdo:DisplayObject = tcont.getChildAt(ti);
				if (treg.test(tcdo.name))
				{
					if (tarr == null)
						tarr = [];
					tarr.push(tcdo);
				}
			}

			if (tarr != null)
				tarr = pp_distinct_childArr(tarr);

			return tarr;
		}




		private static var _dt:String;
		private static function ppArrSort(td1:DisplayObject, td2:DisplayObject):int
		{
			var t1:Number, t2:Number;

			if (_dt == 'x')
			{
				t1 = td1.x;
				t2 = td2.x;
			}
			else
			if (_dt == 'y')
			{
				t1 = td1.y;
				t2 = td2.y;
			}
			else
				return 0;

			if (t1 > t2)
				return 1;
			else
			if (t1 < t2)
				return -1;
			else
				return 0;
		}



		/**
		 * 컨테이너에서 (tdt: Direction)을 기준으로 자식객체의 참조를 배열로 담아 반환
		 * <br/>
		 * @param tcont TargetContainer
		 * @param tfnm FirstName
		 * @param tdt Direction
		 */
		public static function get_childArr(tcont:DisplayObjectContainer, tfnm:String = null, tdt:String = 'x'):Array
		{
			var tl:int = tcont.numChildren;
			if (tl > -1)
			{
				var tarr:Array;

				for (var ti:int = 0; ti < tl; ti++)
				{
					var tdo:DisplayObject = tcont.getChildAt(ti);
					if (tarr == null) tarr = [];
					if (tfnm != null) {
						if (tdo.name.indexOf(tfnm) == 0) {
							tarr.push(tdo);
						}
					}
					else {
						tarr.push(tdo);
					}
				}

				if (tarr != null) {
					_dt = tdt;
					tarr.sort(ppArrSort);
				}

				return tarr;
			}
			else
				return null;
		}


		/**
		 * 컨테이너에서 (tdt: Direction)을 기준으로 자식객체의 참조를 배열로 담아 반환
		 * <br/>
		 * @param tcont TargetContainer
		 * @param tfnm FirstName
		 * @param tdt Direction
		 */
		public static function get_childArr1(tcont:DisplayObjectContainer, tfnm:String, tdt:String = 'x'):Array
		{
			var tarr:Array;
			for (var tl:int = tcont.numChildren, ti:int = 0; ti < tl; ti++)
			{
				var tdo:DisplayObject = tcont.getChildAt(ti);
				if (tdo.name.indexOf(tfnm) == 0) {
					if (tarr == null) tarr = [];
					tarr.push(tdo);
				}
			}

			if (tarr != null) {
				_dt = tdt;
				tarr.sort(ppArrSort);
			}

			return tarr;
		}


		/**
		 * 컨테이너에서 (tdt: Direction)을 기준으로 자식객체의 참조를 배열로 담아 반환
		 * <br/>
		 * @param tcont TargetContainer
		 * @param tdt Direction
		 */
		public static function get_childArr2(tcont:DisplayObjectContainer, tdt:String = 'x'):Array
		{
			var tarr:Array;
			for (var tl:int = tcont.numChildren, ti:int = 0; ti < tl; ti++)
			{
				var tdo:DisplayObject = tcont.getChildAt(ti);
				if (tarr == null) tarr = [];
				tarr.push(tdo);
			}

			if (tarr != null) {
				_dt = tdt;
				tarr.sort(ppArrSort);
			}

			return tarr;
		}


		/**
		 * 컨테이너에서 (tdt: Direction)을 기준으로 자식객체의 참조를 배열로 담아 반환 (RegEx방식)
		 * <br/>
		 * @param tcont TargetContainer
		 * @param tfnm FirstName
		 * @param tdt Direction
		 */
		public static function get_childArrReg(tcont:DisplayObjectContainer, treg:RegExp, tdt:String = 'x'):Array
		{
			var tarr:Array;
			for (var tl:int = tcont.numChildren, ti:int = 0; ti < tl; ti++)
			{
				var tcdo:DisplayObject = tcont.getChildAt(ti);
				if (treg.test(tcdo.name)) {
					if (tarr == null) tarr = [];
					tarr.push(tcdo);
				}
			}

			if (tarr != null) {
				_dt = tdt;
				tarr.sort(ppArrSort);
			}

			return tarr;
		}

	}
}