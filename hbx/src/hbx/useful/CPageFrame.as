package hbx.useful
{
	import flash.display.MovieClip;

	import hbx.common.CMovieClipWrapper;
	import hbx.core.CEventCore;



	public class CPageFrame extends CMovieClipWrapper
	{
		public static const ET_FrameClear:String = 'FrameClear';
		public static const ET_FrameInit:String = 'FrameInit';


		/**
		 * 생성자
		 * <br/>
		 * @param mvc: MovieClip
		 */
		public function CPageFrame(mvc:MovieClip)
		{
			super(mvc);
			if (_mvc.totalFrames < 2)
			{
				throw new Error('The target movie clip must have a total frame of 2 or more.');
			}
			_cfn = _mvc.totalFrames;
			_mvc.gotoAndStop(_cfn);
		}

		//-- ClearFrameNumber
		private var _cfn:int;



		/** */
		public override function dispose():void
		{
			if (_mvc == null) return;
			this.close();
			super.dispose();
		}


		/** */
		public function close():void
		{
			var cfn:int = _mvc.currentFrame;
			if (cfn < _cfn)
			{
				this.dispatchEvent(new CEventCore(ET_FrameClear));
				_mvc.gotoAndStop(_cfn);
			}
		}


		/**
		 * GotoPage
		 * <br/>
		 * @param pn: PageNumber
		 */
		public function gotop(pn:int):void
		{
			var cfn:int = _mvc.currentFrame;
			if ((pn > 0) && (pn < _cfn) && (pn != cfn))
			{
				if (cfn <_cfn) this.close();
				_mvc.gotoAndStop(pn);
				this.dispatchEvent(new CEventCore(ET_FrameInit));
			}
		}


		/**
		 * PrevPage
		 * <br/>
		 */
		public function prev():void
		{
			var cfn:int = _mvc.currentFrame;
			if ((cfn > 1) && (cfn < _cfn))
			{
				this.gotop(cfn - 1);
			}
		}


		/**
		 * NextPage
		 * <br/>
		 */
		public function next():void
		{
			var cfn:int = _mvc.currentFrame;
			if (cfn < _cfn)
			{
				this.gotop(cfn + 1);
			}
		}


		/**
		 * RefreshPage
		 * <br/>
		 */
		public function refresh():void
		{
			var cfn:int = _mvc.currentFrame;
			if (cfn < _cfn)
			{
				this.close();
				this.gotop(cfn);
			}
		}

	}
}
