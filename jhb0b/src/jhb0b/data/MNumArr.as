package jhb0b.data
{
	import jhb0b.utils.MArrayUtil;

	/**
	 * ...
	 * @author hh
	 */
	public final class MNumArr
	{
		//::
		public static function GetSum(tNumArr:Array):Number
		{
			if (tNumArr == null) return NaN;

			var tSum:Number = 0;
			for each (var tVal:Number in tNumArr)
			{
				tSum += tVal;
			}

			return tSum;
		}

		//::
		public static function GetMedian(tNumArr:Array):Number
		{
			if (tNumArr == null) return NaN;

			tNumArr = tNumArr.slice();
			tNumArr.sort(Array.NUMERIC);

			var tLen:uint = tNumArr.length;
			var tLenHal:uint = tLen / 2;

			if ((tLen % 2) == 0)
			{
				var ta:Number = tNumArr[tLenHal - 1];
				var tb:Number = tNumArr[tLenHal];

				return (ta + tb) / 2;
			}

			return tNumArr[tLenHal];
		}


		//::
		public static function GetAverage(tNumArr:Array):Number
		{
			if (tNumArr == null) return NaN;

			var tSum:Number = 0;
			for each (var tVal:Number in tNumArr)
			{
				tSum += tVal;
			}
			return tSum / tNumArr.length;
		}

		//::
		public static function GetVariance(tNumArr:Array):Number
		{
			if (tNumArr == null) return NaN;

			var tSum:Number = 0;
			var tAvg:Number = GetAverage(tNumArr);
			for each (var tVal:Number in tNumArr)
			{
				tSum += Math.pow((tVal - tAvg), 2);
			}
			return tSum / (tNumArr.length - 1);
		}

		//::
		public static function GetAverageCase(tTableHeaderArr:Array, tTableArr:Array, tColcType:String):Number
		{
			var tci:uint = 0;
			var tri:uint = MArrayUtil.get_index(tTableHeaderArr, tColcType);
			var tArr:Array;
			for each (var tRowArr:Array in tTableArr)
			{
				if (tci++ == 0) continue;
				if (tArr == null)
					tArr = [];
				tArr.push(tRowArr[tri]);
			}

			if (tArr != null)
				return GetAverage(tArr);
			else
				return NaN;
		}
	}

}