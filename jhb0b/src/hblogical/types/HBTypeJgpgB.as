package hblogical.types
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import hblogical.base.HBHerb;
	import hobis.helper.MContainerHelper;
	import jhb0b.events.CBumEvent;
	import jhb0b.whats.CBumButton;



	public class HBTypeJgpgB extends HBHerb
	{
		public static function detect(tcont:DisplayObjectContainer, thandler:Function = null):HBHerb
		{
			var towner:MovieClip = tcont['mc_jgpga'];
			if (towner != null)
			{
				var tpumc:MovieClip = tcont['mc_jgpga_pu'];
				if (tpumc != null)
				{
					var trv:HBHerb = new HBTypeJgpgB(towner, tpumc);
					if (thandler != null)
						trv.addEventListenerAll(thandler);
					return trv;
				}
			}

			return null;
		}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		public static const ET_CLOSE:String = Event.CLOSE;
		public static const ET_OPEN:String = Event.OPEN;

		override public function addEventListenerAll(listener:Function,
							useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			this.addEventListener(ET_CLOSE, listener, useCapture, priority, useWeakReference);
			this.addEventListener(ET_OPEN, listener, useCapture, priority, useWeakReference);
		}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


		public function HBTypeJgpgB(towner:MovieClip, tpumc:MovieClip)
		{
			super(towner);

			_pumc = tpumc;
			_pumc.visible = false;
			_btnClose = _pumc['close_btn'];
			_btnClose.addEventListener(MouseEvent.CLICK, pp_btnCloseClick);
			_bb = new CBumButton(_owner, [1, 2, 3, 4, 5, 6], true);
			_bb.addEventListener(CBumButton.ET_CLICK, ppThisClick);


			_mmdArr = MContainerHelper.GetChildArr(_pumc, 'mt_', 'x');
			for (var tp:String in _mmdArr)
			{
				var tm:MovieClip = _mmdArr[tp];
				tm.mouseChildren = false;
				tm.buttonMode = true;
				tm.addEventListener(MouseEvent.CLICK, ppRollClicks);
			}
		}

		private var _pumc:MovieClip;
		private var _btnClose:SimpleButton;

		private var _bb:CBumButton;

		private var _mmdArr:Array;
		private var _mmd:MovieClip;


		private function pp_btnCloseClick(evt:MouseEvent):void
		{
			_bb.set_selectedDispatch(false);
		}

		private function ppThisClick(evt:CBumEvent):void
		{
			if (_bb.get_selected())
			{
				_pumc.visible = true;
				this.dispatchEvent(new CBumEvent(ET_CLOSE));
			}
			else
			{
				_pumc.visible = false;
				this.dispatchEvent(new CBumEvent(ET_OPEN));
			}
		}

		private function ppRollClicks(evt:MouseEvent):void
		{
			var ti:uint, tl:uint;
			var tmc:MovieClip;

			_mmd = MovieClip(evt.currentTarget);
			var tarr:Array = _mmd.name.split('_');
			if (tarr.length >= 2)
			{
				var tnm:String = tarr[0];
				var tnb:int = int(tarr[1]);
				if (_mmd.currentFrame == 1)
				{
					for (ti = 0, tl = _mmdArr.length; ti < tl; ti++)
					{
						tmc = _mmdArr[ti];
						if (ti < tnb)
						{
							tmc.gotoAndStop(2);
						}
						else
						{
							tmc.gotoAndStop(1);
						}
					}
				}
				else
				{
					for (ti = 0, tl = _mmdArr.length; ti < tl; ti++)
					{
						tmc = _mmdArr[ti];
						if (ti >= (tnb - 1))
						{
							tmc.gotoAndStop(1);
						}
					}
				}
			}
		}

	}
}









