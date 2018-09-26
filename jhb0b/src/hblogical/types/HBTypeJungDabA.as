package hblogical.types
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	import hblogical.base.HBHerb;
	import jhb0b.events.CBumEvent;
	import jhb0b.whats.CBumButton;


	public class HBTypeJungDabA extends HBHerb
	{
		public static function detect(tcont:DisplayObjectContainer, thandler:Function = null):HBHerb
		{
			var tmc:MovieClip = tcont['mc_hbtjda'];
			if (tmc != null)
			{
				var trv:HBHerb = new HBTypeJungDabA(tmc);
				if (thandler != null)
					trv.addEventListenerAll(thandler);
				return trv;
			}

			return null;
		}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		public static const ET_CLICK:String = CBumButton.ET_CLICK;

		override public function addEventListenerAll(listener:Function,
							useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			this.addEventListener(ET_CLICK, listener, useCapture, priority, useWeakReference);
		}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


		public function HBTypeJungDabA(towner:MovieClip)
		{
			super(towner);

			_dicBumBtn = new Dictionary();

			for (var ti:int = 0, tl:int = _owner.numChildren; ti < tl; ti++)
			{
				var tmc:MovieClip = _owner.getChildAt(ti) as MovieClip;
				if (tmc != null)
				{
					var tnm:String = tmc.name;
					var tbb:CBumButton;

					if (tnm.indexOf('ma_') == 0)
					{
						tbb = new CBumButton(tmc, [1, 2, 3, 4, 5, 6], true);
						tbb.addEventListener(ET_CLICK, ppBumBtnClick);
						_dicBumBtn[tmc] = tbb;
					}
				}
			}
		}

		private var _dicBumBtn:Dictionary;
		public function get_dicBumBtn():Dictionary
		{
			return _dicBumBtn;
		}

		override public function dispose():void
		{
			if (_dicBumBtn == null) return;
			_dicBumBtn == null;
			super.dispose();
		}



		private function ppBumBtnClick(evt:CBumEvent):void
		{
			var tbb:CBumButton = CBumButton(evt.currentTarget);
			var tnm:String = tbb.get_owner().name;
			//test('tnm: ' + tnm);
			if (tnm == 'ma_all')
			{
				//test('전체정답: ' + tbb.get_selected());
				set_selectedDispatchAll(tbb.get_selected());
			}
			else
			{
				//test('개별정답: ' + tbb.get_selected());
				if (is_selectedAll())
				{
					set_selected('ma_all', true);
				}
				else
				{
					set_selected('ma_all', false);
				}
			}

			this.dispatchEvent(new CBumEvent(ET_CLICK, { bb: tbb, nm: tnm }));
		}


		public function set_selected(tnm:String, tb:Boolean):void
		{
			if (_dicBumBtn == null) return;

			for each (var tbb:CBumButton in _dicBumBtn)
			{
				if (tbb.get_owner().name == tnm)
				{
					tbb.set_selected(tb);
					break;
				}
			}
		}

		public function set_selectedDispatchAll(tb:Boolean):void
		{
			if (_dicBumBtn == null) return;

			for each (var tbb:CBumButton in _dicBumBtn)
			{
				if (tbb.get_owner().name != 'ma_all')
				{
					tbb.set_selectedDispatch(tb);
				}
			}
		}

		public function is_selectedAll():Boolean
		{
			if (_dicBumBtn == null) return false;

			var tb:Boolean = false;
			for each (var tbb:CBumButton in _dicBumBtn)
			{
				if (tbb.get_owner().name != 'ma_all')
				{
					tb = tbb.get_selected();
					if (!tb) break;
				}
			}
			return tb
		}



	}
}
