/**
	@Name: GeomTool
	@Author: HobisJung(jhb0b@naver.com)
	@Date: 2016-01-22
	@Comment:
	{
	}
*/
package hb.tools
{
	public final class GeomTool
	{
		public function GeomTool()
		{
		}

		/**
			@Name: 사이즈 영역만큼 비율 유지하면서 사이즈 변경하기
			@Using:
			{
				// - 적용될 영역의 사이즈
				var t_fitSize:Object =
				{
					x: this.fitArea_mc.x,
					y: this.fitArea_mc.y,
					width: this.fitArea_mc.width,
					height: this.fitArea_mc.height
				};
				// - 대상이 되는 사이즈
				var t_targetSize:Object =
				{
					x: this.target_mc.x,
					y: this.target_mc.y,
					width: this.target_mc.width,
					height: this.target_mc.height
				};
				var t_size:Object = GeomUtil.get_fitAreaSize
				(
					t_fitSize,
					t_targetSize
				);

				this.target_mc.x = t_size.x;
				this.target_mc.y = t_size.y;
				this.target_mc.width = t_size.width;
				this.target_mc.height = t_size.height;
			}
		*/		
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

		//		trace('x 방향 조절');
			}
			else if (t_ratioX > t_ratioY)
			{
				var t_distY:Number = areaSize.height - targetSize.height;

				t_ratio = areaSize.height / targetSize.height;
				t_rv.width = targetSize.width * t_ratio;
				t_rv.height = targetSize.height + t_distY;

		//		trace('y 방향 조절');
			}
			else
			{
				t_rv.width = areaSize.width;
				t_rv.height = areaSize.height;

		//		trace('같다');
			}

			t_rv.x = areaSize.x + (areaSize.width / 2) - (t_rv.width / 2);
			t_rv.y = areaSize.y + (areaSize.height / 2) - (t_rv.height / 2);

		//	trace('areaSize.width: ' + areaSize.width);
		//	trace('areaSize.height: ' + areaSize.height);
		//	trace('targetSize.width: ' + targetSize.width);
		//	trace('targetSize.height: ' + targetSize.height);
		//	trace('t_ratioX: ' + t_ratioX);
		//	trace('t_ratioY: ' + t_ratioY);
		//	trace('t_ratio: ' + t_ratio);

			return t_rv;
		}
	}
}
