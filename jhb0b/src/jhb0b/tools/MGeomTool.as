package jhb0b.tools
{
	public final class MGeomTool
	{
		public static function get_fitAreaSize(areaSize:Object, targetSize:Object):Object
		{
			var t_rv:Object = {};

			var t_ratioX:Number = 1 - (targetSize.width / areaSize.width);
			var t_ratioY:Number = 1 - (targetSize.height / areaSize.height);
			var t_ratio:Number;

			if (t_ratioX < t_ratioY)
			{
				var t_distX:Number = areaSize.width - targetSize.width;
				t_ratio = areaSize.width / targetSize.width;
				t_rv.width = targetSize.width + t_distX;
				t_rv.height = targetSize.height * t_ratio;
			}
			else
			if (t_ratioX > t_ratioY)
			{
				var t_distY:Number = areaSize.height - targetSize.height;
				t_ratio = areaSize.height / targetSize.height;
				t_rv.width = targetSize.width * t_ratio;
				t_rv.height = targetSize.height + t_distY;
			}
			else
			{
				t_rv.width = areaSize.width;
				t_rv.height = areaSize.height;
			}

			t_rv.x = areaSize.x + (areaSize.width / 2) - (t_rv.width / 2);
			t_rv.y = areaSize.y + (areaSize.height / 2) - (t_rv.height / 2);

			return t_rv;
		}
	}
}
