/**
	@Name: CountTask 넘버 카운팅 하기
	@Author: HobisJung(jhb0b@naver.com)
	@Date: 2016-01-22
	@Comment:
	{
	}
	@Using:
	{
	}
*/
package hb.useful
{
	public class CountTask
	{
		// :: 생성자
		public function CountTask(countBegin:uint, countEnd:uint, plusValue:uint = 1):void
		{
			this._countBegin = countBegin;
			this._countEnd = countEnd;
			this._count = this._countBegin;
			this._plusValue = plusValue;
		}

		// - 카운트 시작
		private var _countBegin:uint;
		public function get_countBegin():uint
		{
			return this._countBegin;
		}

		// - 카운트 엔드
		private var _countEnd:uint;
		public function get_countEnd():uint
		{
			return this._countEnd;
		}

		// - 카운트
		private var _count:uint;
		public function get_count():uint
		{
			return this._count;
		}

		// - 증가값
		private var _plusValue:uint;
		public function get_plusValue():uint
		{
			return this._plusValue;
		}


		// :: 리셋
		public function reset():void
		{
			this._count = this._countBegin;
		}

		// :: 다음 계산
		public function is_last():Boolean
		{
			var t_rv:Boolean = false;

			if (this._count < this._countEnd)
			{
				this._count += this._plusValue;
				if (this._count >= this._countEnd)
				{
					t_rv = true;
				}
			}
			else
			{
				t_rv = true;
			}

			//trace('this._countBegin: ' + this._countBegin);
			//trace('this._countEnd: ' + this._countEnd);
			//trace('this._count: ' + this._count);
			//trace('this._plusValue: ' + this._plusValue);

			return t_rv;
		}

	}
}
