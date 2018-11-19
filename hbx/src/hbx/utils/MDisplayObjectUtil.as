package hbx.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Transform;



	public final class MDisplayObjectUtil
	{
		/**
		 * 섭네일을 생성하여 반환
		 * <br/>
		 * @param dpo: DisplayObject
		 * @param props: PropertysObject
		 */
		public static function get_thumbBitmap(dpo:DisplayObject, props:Object = null):Bitmap
		{
			if (props == null)
			{
				props = {
					width: dpo.width,
					height: dpo.height,
					transparent: false,
					fillColor: 0xffffffff
				};
			}

			var bmd:BitmapData = new BitmapData(
				props.width, props.height, props.transparent, props.fillColor);
			bmd.draw(dpo);

			return new Bitmap(bmd);
		}


		/**
		 * 기본값으로 설정하기
		 * <br/>
		 * @param dpo: DisplayObject
		 */
		public static function reset(dpo:DisplayObject):void
		{
			dpo.x = 0;
			dpo.y = 0;
			dpo.scaleX = 1;
			dpo.scaleY = 1;
			dpo.rotation = 0;
			dpo.alpha = 1;
		}


		/**
		 * 채도 죽이기, 살리기
		 * <br/>
		 * @param dpo: DisplayObject
		 * @param b: Boolean
		 */
		public static function set_desat(dpo:DisplayObject, b:Boolean = true):void
		{
			// 무채색 적용
			const CMF1:ColorMatrixFilter = new ColorMatrixFilter
			(
				[
					0.308600008487701, 0.609399974346161, 0.0820000022649765, 0, 0,
					0.308600008487701, 0.609399974346161, 0.0820000022649765, 0, 0,
					0.308600008487701, 0.609399974346161, 0.0820000022649765, 0, 0,
					0, 0, 0, 1, 0
				]
			);
			// 무채색 제거
			const CMF2:ColorMatrixFilter = new ColorMatrixFilter
			(
				[
					1, 0, 0, 0, 0,
					0, 1, 0, 0, 0,
					0, 0, 1, 0, 0,
					0, 0, 0, 1, 0
				]
			);

			if (b)
				dpo.filters = [CMF1];
			else
				dpo.filters = [CMF2];
		}


		/**
		 * 색상 넣기
		 * <br/>
		 * @param dpo: DisplayObject
		 * @param color: Color
		 */
		public static function set_color(dpo:DisplayObject, color:uint):void
		{
			var trf:Transform = dpo.transform;
			var ctrf:ColorTransform = trf.colorTransform;
			ctrf.color = color;
			trf.colorTransform = ctrf;
		}


		/**
		 * 색상 빼기
		 * <br/>
		 * @param dpo: DisplayObject
		 */
		public static function clear_color(dpo:DisplayObject):void
		{
			var trf:Transform = dpo.transform;
			trf.colorTransform = new ColorTransform();
		}

	}
}