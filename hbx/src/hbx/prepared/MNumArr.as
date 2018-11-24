package hbx.prepared
{
	import hbx.utils.MArrayUtil;


	public final class MNumArr
	{
		//:: 합계
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

		//:: 메디안
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


		//:: 평균
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

		//:: 발리언스
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

		//:: 에버리지 케이스
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