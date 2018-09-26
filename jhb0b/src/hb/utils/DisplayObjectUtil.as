/**
	@Name: DisplayObjectUtil
	@Author: HobisJung(jhb0b@naver.com)
	@Date: 2016-01-22
	@Comment:
	{
	}
*/
package hb.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Transform;

	public final class DisplayObjectUtil
	{
		public function DisplayObjectUtil()
		{
		}

		// :: DisplayObject에 섭네일을 생성하여 반환
		public static function get_thumbBitmap(target:DisplayObject, props:Object = null):Bitmap
		{
			if (props == null)
			{
				props = new Object();
				props.width = target.width;
				props.height = target.height;
				props.transparent = false;
				props.fillColor = 0xffffffff;
			}

			var t_bitmapData:BitmapData = new BitmapData(
				props.width, props.height, props.transparent, props.fillColor);
			t_bitmapData.draw(target);

			return new Bitmap(t_bitmapData);
		}

		// :: DisplayObject 기본값으로 설정하기
		public static function reset(target:DisplayObject):void
		{
			target.x = 0;
			target.y = 0;
			target.scaleX = 1;
			target.scaleY = 1;
			target.rotation = 0;
			target.alpha = 1;
		}

		// :: 채도 죽이기, 살리기
		public static function set_desaturation(target:DisplayObject, b:Boolean = true):void
		{
			//- 무비클립 무채색 적용
			const t_CMF_DESAT:ColorMatrixFilter = new ColorMatrixFilter
			(
				[
					0.308600008487701, 0.609399974346161, 0.0820000022649765, 0, 0,
					0.308600008487701, 0.609399974346161, 0.0820000022649765, 0, 0,
					0.308600008487701, 0.609399974346161, 0.0820000022649765, 0, 0,
					0, 0, 0, 1, 0
				]
			);
			//- 무비클립 무채색 제거
			const t_CMF_NORMAL:ColorMatrixFilter = new ColorMatrixFilter
			(
				[
					1, 0, 0, 0, 0,
					0, 1, 0, 0, 0,
					0, 0, 1, 0, 0,
					0, 0, 0, 1, 0
				]
			);

			if (b)
			{
				target.filters = [t_CMF_DESAT];
			}
			else
			{
				target.filters = [t_CMF_NORMAL];
			}
		}

		// :: [DisplayObject]컬러변경
		public static function set_color(target:DisplayObject, color:uint):void
		{
			var t_transform:Transform = target.transform;
			var t_colorTransform:ColorTransform = t_transform.colorTransform;
			t_colorTransform.color = color;
			t_transform.colorTransform = t_colorTransform;
		}

		// :: [DisplayObject]컬러변경 취소
		public static function no_color(target:DisplayObject):void
		{
			var t_transform:Transform = target.transform;
			t_transform.colorTransform = new ColorTransform();
		}
		
	}
}