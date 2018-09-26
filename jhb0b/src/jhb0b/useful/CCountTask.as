package jhb0b.useful
{
	import jhb0b.core.CObjectCore;


	public class CCountTask extends CObjectCore
	{
		//:: 생성자
		public function CCountTask(countStart:uint, countEnd:uint, plusValue:uint = 1):void
		{
			_countStart = countStart;
			_countEnd = countEnd;
			_count = _countStart;
			_plusValue = plusValue;
		}

		//- 카운트 시작
		private var _countStart:uint;
		public function get_countStart():uint
		{
			return _countStart;
		}

		//- 카운트 엔드
		private var _countEnd:uint;
		public function get_countEnd():uint
		{
			return _countEnd;
		}

		//- 카운트
		private var _count:uint;
		public function get_count():uint
		{
			return _count;
		}

		//- 증가값
		private var _plusValue:uint;
		public function get_plusValue():uint
		{
			return _plusValue;
		}


		//:: 리셋
		public function reset():void
		{
			_count = _countStart;
		}

		//:: 다음 계산
		public function is_last():Boolean
		{
			if (_count < _countEnd)
			{
				var t_c:uint = _count + _plusValue;
				if (t_c > _countEnd)
				{
					return true;
				}
				else
				{
					_count = t_c;
					return false;
				}
			}
			else
			{
				return true;
			}
		}

	}
}
