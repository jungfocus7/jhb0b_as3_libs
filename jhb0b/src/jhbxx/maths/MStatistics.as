package jhbxx.maths 
{
	public final class MStatistics
	{
		///
		private static function pp_permute1(inputArr:Array, returnArr:Array = null, tempArr:Array = null):Array
		{
			if ((inputArr != null) && (inputArr.length > 0))
			{
				if (returnArr == null) returnArr = [];
				if (tempArr == null) tempArr = [];
				
				for (var l:uint = inputArr.length, i:uint = 0; i < l; i++)
				{
					var ei:* = inputArr.splice(i, 1)[0];
					tempArr.push(ei);
					if (inputArr.length == 0)
						returnArr.push(tempArr.slice());
					
					//trace('~~ ' + inputArr, inputArr.length, inputArr.length == 0);
					arguments.callee(inputArr, returnArr, tempArr);
					inputArr.splice(i, 0, ei);
					tempArr.pop();
				}
				
				return returnArr;
			}
			else
			{
				return null;
			}
		}
		public static function permute1(inputArr:Array):Array
		{
			return pp_permute1(inputArr);
		}
		
		
		public static function returnTrace(returnArr:Array):void
		{
			for each (var ei:* in returnArr) {
				trace(ei);
			}
		}
		
	}
}