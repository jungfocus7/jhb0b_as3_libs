package jhb0b.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Transform;


	public final class MDisplayObjectUtil
	{
		//:: 섭네일을 생성하여 반환
		public static function get_thumbBitmap(tdo:DisplayObject, props:Object = null):Bitmap
		{
			if (props == null)
			{
				props = new Object();
				props.width = tdo.width;
				props.height = tdo.height;
				props.transparent = false;
				props.fillColor = 0xffffffff;
			}

			var t_bitmapData:BitmapData = new BitmapData(
				props.width, props.height, props.transparent, props.fillColor);
			t_bitmapData.draw(tdo);

			return new Bitmap(t_bitmapData);
		}

		//:: 기본값으로 설정하기
		public static function reset(tdo:DisplayObject):void
		{
			tdo.x = 0;
			tdo.y = 0;
			tdo.scaleX = 1;
			tdo.scaleY = 1;
			tdo.rotation = 0;
			tdo.alpha = 1;
		}

		//:: 채도 죽이기, 살리기
		public static function set_desat(tdo:DisplayObject, b:Boolean = true):void
		{
			//- 무채색 적용
			const t_CMF1:ColorMatrixFilter = new ColorMatrixFilter
			(
				[
					0.308600008487701, 0.609399974346161, 0.0820000022649765, 0, 0,
					0.308600008487701, 0.609399974346161, 0.0820000022649765, 0, 0,
					0.308600008487701, 0.609399974346161, 0.0820000022649765, 0, 0,
					0, 0, 0, 1, 0
				]
			);
			//- 무채색 제거
			const t_CMF2:ColorMatrixFilter = new ColorMatrixFilter
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
				tdo.filters = [t_CMF1];
			}
			else
			{
				tdo.filters = [t_CMF2];
			}
		}

		//:: 컬러넣기
		public static function set_color(tdo:DisplayObject, color:uint):void
		{
			var t_transform:Transform = tdo.transform;
			var t_colorTransform:ColorTransform = t_transform.colorTransform;
			t_colorTransform.color = color;
			t_transform.colorTransform = t_colorTransform;
		}

		//:: 컬러빼기
		public static function clear_color(tdo:DisplayObject):void
		{
			var t_transform:Transform = tdo.transform;
			t_transform.colorTransform = new ColorTransform();
		}

	}
}