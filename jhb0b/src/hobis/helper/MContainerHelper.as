package hobis.helper
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;


	public final class MContainerHelper
	{
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
		 * @comment - 컨테이너에서 (tdt: Direction)을 기준으로 자식객체의 참조를 배열로 담아 반환
		 * @param tcont TargetContainer
		 * @param tfnm FirstName
		 * @param tdt Direction
		 */
		public static function GetChildArr(tcont:DisplayObjectContainer, tfnm:String = null, tdt:String = 'x'):Array
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
		 * @comment - 컨테이너에서 (tdt: Direction)을 기준으로 자식객체의 참조를 배열로 담아 반환
		 * @param tcont TargetContainer
		 * @param tfnm FirstName
		 * @param tdt Direction
		 */		
		public static function GetChildArr1(tcont:DisplayObjectContainer, tfnm:String, tdt:String = 'x'):Array
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
		 * @comment - 컨테이너에서 (tdt: Direction)을 기준으로 자식객체의 참조를 배열로 담아 반환
		 * @param tcont TargetContainer
		 * @param tdt Direction
		 */		
		public static function GetChildArr2(tcont:DisplayObjectContainer, tdt:String = 'x'):Array
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
		 * @comment - 컨테이너에서 (tdt: Direction)을 기준으로 자식객체의 참조를 배열로 담아 반환 (RegEx방식)
		 * @param tcont TargetContainer
		 * @param tfnm FirstName
		 * @param tdt Direction
		 */
		public static function GetChildArrReg(tcont:DisplayObjectContainer, treg:RegExp, tdt:String = 'x'):Array
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
