package jhb0b.useful
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import jhb0b.core.CMovieClipWrapper;
	import jhb0b.events.CBumEvent;


	public class CPageFrame extends CMovieClipWrapper
	{
		public static const ET_FrameClear:String = 'FrameClear';
		public static const ET_FrameInit:String = 'FrameInit';



		override public function dispose():void
		{
			if (_owner == null) return;
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
			_cfn = _owner.totalFrames;
			_owner.gotoAndStop(_cfn);
		}
		//- ClearFrameNumber
		private var _cfn:int;


		//::
		public function close():void
		{
			var tnfn:int = _owner.currentFrame;
			if (tnfn < _cfn)
			{
				this.dispatchEvent(new CBumEvent(ET_FrameClear));
				_owner.gotoAndStop(_cfn);
			}
		}

		//:: @Params(tpn: PageNumber)
		public function gotop(tpn:int):void
		{
			var tnfn:int = _owner.currentFrame;
			if ((tpn > 0) && (tpn < _cfn) && (tpn != tnfn))
			{
				if (tnfn <_cfn) this.close();
				_owner.gotoAndStop(tpn);
				this.dispatchEvent(new CBumEvent(ET_FrameInit));
			}
		}

		//::
		public function prev():void
		{
			var tnfn:int = _owner.currentFrame;
			if ((tnfn > 1) && (tnfn < _cfn))
			{
				this.gotop(tnfn - 1);
			}
		}

		//::
		public function next():void
		{
			var tnfn:int = _owner.currentFrame;
			if (tnfn < _cfn)
			{
				this.gotop(tnfn + 1);
			}
		}

		//::
		public function refresh():void
		{
			var tnfn:int = _owner.currentFrame;
			if (tnfn < _cfn)
			{
				this.close();
				this.gotop(tnfn);
			}
		}
	}
}
