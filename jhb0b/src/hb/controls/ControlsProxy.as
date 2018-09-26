/**
	@Name: ControlsProxy
	@Author: HobisJung(jhb0b@naver.com)
	@Date: 2016-01-20
	@Comment:
	{
	}
*/
package hb.controls
{
	import flash.display.Sprite;

	public final class ControlsProxy
	{
		public static const CT_END:String = 'end';
		public static const CT_UPDATE:String = 'update';
		
		
		public function ControlsProxy()
		{
			throw new Error('Can\'t instanced this class.');
		}

		public static const useSprite:Sprite = new Sprite();
	}

}
