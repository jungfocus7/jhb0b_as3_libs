package hbx.useful
{
	import flash.display.MovieClip;

	import hbx.core.CEventCore;
	import hbx.core.CMovieClipWrapper;


	public class CPageFrame extends CMovieClipWrapper
	{
		public static const ET_FrameClear:String = 'FrameClear';
		public static const ET_FrameInit:String = 'FrameInit';



		override public function dispose():void
		{
			if (_mvc == null) return;
			this.close();
			super.dispose();
		}

		public function CPageFrame(tmc:MovieClip)
		{
			super(tmc);
			if (tmc.totalFrames < 2)
			{
				throw new Error('The target movie clip must have a total frame of 2 or more.');
			}
			_cfn = _mvc.totalFrames;
			_mvc.gotoAndStop(_cfn);
		}
		//- ClearFrameNumber
		private var _cfn:int;


		//::
		public function close():void
		{
			var tnfn:int = _mvc.currentFrame;
			if (tnfn < _cfn)
			{
				this.dispatchEvent(new CEventCore(ET_FrameClear));
				_mvc.gotoAndStop(_cfn);
			}
		}

		//:: @Params(tpn: PageNumber)
		public function gotop(tpn:int):void
		{
			var tnfn:int = _mvc.currentFrame;
			if ((tpn > 0) && (tpn < _cfn) && (tpn != tnfn))
			{
				if (tnfn <_cfn) this.close();
				_mvc.gotoAndStop(tpn);
				this.dispatchEvent(new CEventCore(ET_FrameInit));
			}
		}

		//::
		public function prev():void
		{
			var tnfn:int = _mvc.currentFrame;
			if ((tnfn > 1) && (tnfn < _cfn))
			{
				this.gotop(tnfn - 1);
			}
		}

		//::
		public function next():void
		{
			var tnfn:int = _mvc.currentFrame;
			if (tnfn < _cfn)
			{
				this.gotop(tnfn + 1);
			}
		}

		//::
		public function refresh():void
		{
			var tnfn:int = _mvc.currentFrame;
			if (tnfn < _cfn)
			{
				this.close();
				this.gotop(tnfn);
			}
		}
	}
}
