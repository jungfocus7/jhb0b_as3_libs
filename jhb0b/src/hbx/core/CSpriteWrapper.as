﻿package hbx.core
{
	import flash.display.Sprite;


	public class CSpriteWrapper extends CDisplayObjectWrapper
	{
		public function CSpriteWrapper(sprt:Sprite)
		{
			super(sprt);
			_sprt = sprt;
		}

		protected var _sprt:Sprite;
		public function get_sprt():Sprite
		{
			return _sprt;
		}


		public override function dispose():void
		{
			if (_sprt == null) return;
			_sprt = null;
			super.dispose();
		}

	}

}