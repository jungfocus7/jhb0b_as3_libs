/**
	@Name: ThumbListLogic
	@Author: HobisJung(jhb0b@naver.com)
	@Blog: http://blog.naver.com/jhb0b
	@Date: 2016-05-19
	@Using:
	{
	}
*/
package hbworks.uilogics
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import hb.tools.DebugTool;
	import hbworks.uilogics.ButtonLogic;
	import hbworks.uilogics.core.LogicCore;
	import hbworks.uilogics.events.ThumbListLogicEvent;
	import hbworks.uilogics.subClasses.AlignInfo;


	public class ThumbListLogic extends LogicCore
	{
		public function ThumbListLogic(
									container:DisplayObjectContainer,
									name:String = null,
									thumbProtoName:String = null,
									alignInfo:AlignInfo = null)
		{
			super(container, name);

			if (thumbProtoName == null)
			{
				thumbProtoName = 'ti_proto';
			}

			var t_mc:MovieClip = this._cont[thumbProtoName];
			this._thumbProto = t_mc.constructor;
			this._thumbProto_w = t_mc.width;
			this._thumbProto_h = t_mc.height;
			this._cont.removeChild(t_mc);


			if (alignInfo == null)
			{
				this._alignInfo = new AlignInfo(914, 10, 10);
			}
			else
			{
				this._alignInfo = alignInfo;
			}
		}

		// - 썸네일 아이템의 프로토클립
		private var _thumbProto:Class = null;
		// - 썸네일 아이템의 넓이
		private var _thumbProto_w:Number;
		// - 썸네일 아이템의 높이
		private var _thumbProto_h:Number;

		// -
		private var _alignInfo:AlignInfo = null;
		public function get_alignInfo():AlignInfo
		{
			return _alignInfo;
		}
		public function set_alignInfo(alignInfo:AlignInfo):void
		{
			_alignInfo = alignInfo;
		}


		// - 썸네일 아이템 배열
		private var _thumbInfos:Array = null;
		public function get_thumbInfos():Array
		{
			return _thumbInfos;
		}

		// :: 생성하기
		public function create(thumbInfos:Array, pageThumbLen:int = 6):void
		{
			this.clear();
			this._thumbInfos = thumbInfos;
			this._pageThumbLen = pageThumbLen;
			this.p_pages_create();
		}

		// :: 클리어
		public function clear():void
		{
			if (this._thumbInfos != null)
			{
				this.p_thumbs_cont_clear();
				this._thumbInfos = null;

				this._thumbTotalLen = 0;
				this._pageThumbLen = 0;
				this._pageLen = 0;
				this._pageIndex = -1;
			}
		}


		// - 썸네일의 전채 총 개수
		private var _thumbTotalLen:int;
		// ::
		public function get_thumbTotalLen():int
		{
			return this._thumbTotalLen;
		}

		// - 한페이지에 보여지는 썸네일의 총 개수
		private var _pageThumbLen:int;
		// ::
		public function get_pageThumbLen():int
		{
			return this._pageThumbLen;
		}

		// - 페이지 전체 길이
		private var _pageLen:int;
		// ::
		public function get_pageLen():int
		{
			return this._pageLen;
		}

		// - 페이지 현재 인덱스
		private var _pageIndex:int = -1;
		// ::
		public function get_pageIndex():int
		{
			return this._pageIndex;
		}

		// -
		private var _referIndex:Dictionary = null;

		// :: 현재 페이지 업데이트 후 페이지가 바뀐 여부 반환
		private function p_pages_update(pageIndex:int):Boolean
		{
			var t_rv:Boolean = false;

			if (this._thumbInfos != null)
			{
				if (pageIndex < 0)
				{
					pageIndex = 0;
				}
				else if (pageIndex >= this._pageLen)
				{
					pageIndex = this._pageLen - 1;
				}

				if (pageIndex != this._pageIndex)
				{
					this.dispatchEvent(new ThumbListLogicEvent(
										ThumbListLogicEvent.PAGE_UPDATE_START));

					this._pageIndex = pageIndex;

					//DebugTool.test('p_pages_update');
					//DebugTool.test('this._pageLen: ' + this._pageLen);
					//DebugTool.test('this._pageIndex: ' + this._pageIndex);

					this.p_thumbs_create();

					this.dispatchEvent(new ThumbListLogicEvent(
										ThumbListLogicEvent.PAGE_UPDATE_END));

					t_rv = true;
				}
			}

			return t_rv;
		}

		// :: 썸네일 리스트 페이지와 섬네일 선택
		public function selectPage(pageIndex:int, thumbIndex:int = -1):void
		{
			if (this._thumbInfos != null)
			{
				if (this.p_pages_update(pageIndex))
				{
					this.selectThumb(thumbIndex);
				}
			}
		}

		// :: 썸네일 리스트 이전 페이지
		public function prevPage():void
		{
			if (this._thumbInfos != null)
			{
				if (this.p_pages_update(this._pageIndex - 1))
				{
					this.selectThumb(this._thumbLen - 1);
				}
			}
		}

		// :: 다음 페이지
		public function nextPage():void
		{
			if (this._thumbInfos != null)
			{
				if (this.p_pages_update(this._pageIndex + 1))
				{
					this.selectThumb(0);
				}
			}
		}

		// :: 전체 페이지 구성
		private function p_pages_create():void
		{
			if (this._thumbInfos != null)
			{
				this._thumbTotalLen = this._thumbInfos.length;
				this._pageLen = int(Math.ceil(this._thumbTotalLen / this._pageThumbLen));

				//DebugTool.test('p_pages_create');
				//DebugTool.test('this._thumbTotalLen: ' + this._thumbTotalLen);
				//DebugTool.test('this._pageThumbLen: ' + this._pageThumbLen);
				//DebugTool.test('this._pageLen: ' + this._pageLen);

				if (this.p_pages_update(0))
				{
					this.selectThumb(0);
				}
			}
		}

		// - 현재 페이지에 썸네일 개수
		private var _thumbLen:int;
		// ::
		public function get_thumbLen():int
		{
			return this._thumbLen;
		}

		// - 현재 페이지에 선택한 썸네일 인덱스
		private var _thumbIndex:int = -1;
		// :: 현재 페이지에 썸네일 인덱스 반환
		public function get_thumbIndex():int
		{
			return this._thumbIndex;
		}

		// :: 썸네일의 전체 인덱스 반환
		public function get_index():int
		{
			var t_rv:int = -1;
			if (this._thumbInfos != null)
			{
				t_rv = (this._pageThumbLen * this._pageIndex) + this._thumbIndex;
			}
			return t_rv;
		}

		// :: 썸네일의 전체 넘버 반환
		public function get_num():int
		{
			return this.get_index() + 1;
		}

		// :: 현재 페이지에 썸네일들 참조 반환
		public function get_thumbs():Array
		{
			var t_rv:Array = null;

			if (this._thumbInfos != null)
			{
				var t_la:uint = uint(this._cont.numChildren), i:uint;
				for (i = 0; i < t_la; i++)
				{
					var t_mc:MovieClip = this._cont.getChildAt(i) as MovieClip;
					if (t_mc != null)
					{
						if (t_rv == null)
							t_rv = [];

						t_rv.push(t_mc);
					}
				}
			}

			return t_rv;
		}

		// :: 현재 컨테이너에 썸네일 아이템 제거
		private function p_thumbs_cont_clear():void
		{
			var t_la:uint = uint(this._cont.numChildren), i:uint;
			for (i = 0; i < t_la; i++)
			{
				var t_mc:MovieClip = this._cont.getChildAt(0) as MovieClip;
				if (t_mc != null)
				{
					try
					{
						var t_bl:ButtonLogic = t_mc.d_bl;
						t_bl.removeEventListener(MouseEvent.CLICK, this.p_thumbs_item_click);
						t_bl.dispose();
						t_mc.d_bl = undefined;
					}
					catch (e:Error) {}

					this._cont.removeChild(t_mc);
				}
			}

			this._thumbLen = 0;
			this._thumbIndex = -1;
		}

		// :: 썸네일 리스트 선택해제
		public function unselectThumb():void
		{
			if (this._thumbInfos != null)
			{
				if (this._thumbIndex > -1)
				{
					var t_mc:MovieClip = this._cont.getChildAt(this._thumbIndex) as MovieClip;
					if (t_mc != null)
					{
						try
						{
							var t_bl:ButtonLogic = t_mc.d_bl;
							t_bl.set_selected(false);
							t_bl.set_enabled(true);
						}
						catch (e:Error) {}
					}

					this._thumbIndex = -1;
				}
			}
		}

		// :: 썸네일 리스트 썸네일 선택
		public function selectThumb(thumbIndex:int):void
		{
			if (this._thumbInfos != null)
			{
				if (thumbIndex < 0)
				{
					thumbIndex = 0;
				}
				else if (thumbIndex >= this._thumbLen)
				{
					thumbIndex = this._thumbLen - 1;
				}

				if (thumbIndex != this._thumbIndex)
				{
					var t_mc:MovieClip = this._cont.getChildAt(thumbIndex) as MovieClip;
					if (t_mc != null)
					{
						this.unselectThumb();
						this._thumbIndex = thumbIndex;

						try
						{
							var t_bl:ButtonLogic = t_mc.d_bl;
							t_bl.set_selected(true);
							t_bl.set_enabled(false);
						}
						catch (e:Error) {}
					}

					this.dispatchEvent(new ThumbListLogicEvent(ThumbListLogicEvent.THUMBS_SELECT));
				}
			}
		}

		// :: 썸네일 리스트 전체에서 선택
		public function selectTotal(index:int):void
		{
			if (this._thumbInfos != null)
			{
				if (index < 0)
				{
					index = 0;
				}
				else if (index >= this._thumbTotalLen)
				{
					index = this._thumbTotalLen - 1;
				}


				var t_pageIndex:int = int(Math.floor(index / this._pageThumbLen));
				var t_thumbIndex:int = int(index % this._pageThumbLen);

				//DebugTool.test('selectTotal');
				//DebugTool.test('t_pageIndex: ' + t_pageIndex);
				//DebugTool.test('t_thumbIndex: ' + t_thumbIndex);

				this.p_pages_update(t_pageIndex);
				this.selectThumb(t_thumbIndex);
			}
		}

		// :: 썸네일 리스트 이전 썸네일 선택
		public function prevThumb():void
		{
			this.selectTotal(this.get_index() - 1);
		}

		// :: 썸네일 리스트 다음 썸네일 선택
		public function nextThumb():void
		{
			this.selectTotal(this.get_index() + 1);
		}

		// ::
		private function p_thumbs_item_click(event:MouseEvent):void
		{
			var t_bl:ButtonLogic = event.currentTarget as ButtonLogic;
			var t_mc:MovieClip = t_bl.get_target();
			var t_index:int = t_mc.d_index;

			this.selectThumb(t_index);
		}

		// ::
		private function p_thumbs_create():void
		{
			this.p_thumbs_cont_clear();

			if (this._pageIndex < (this._pageLen - 1))
			{
				this._thumbLen = this._pageThumbLen;
			}
			else
			{
				this._thumbLen = this._thumbTotalLen % this._pageThumbLen;
				if (this._thumbLen == 0)
				{
					this._thumbLen = this._pageThumbLen;
				}
			}

			var t_hl:uint = uint(Math.floor(this._alignInfo.width / this._thumbProto_w));
			//DebugTool.test('t_hl: ' + t_hl);
			for (var i:int = 0; i < this._thumbLen; i++)
			{
				var t_mc:MovieClip = (new _thumbProto()) as MovieClip;
				t_mc.d_index = i;

				var t_bl:ButtonLogic = new ButtonLogic(t_mc, true);
				t_bl.addEventListener(MouseEvent.CLICK, this.p_thumbs_item_click);
				t_mc.d_bl = t_bl;

				t_mc.x = Math.round((this._thumbProto_w + this._alignInfo.marginX) * (i % t_hl));
				t_mc.y = Math.round((this._thumbProto_h + this._alignInfo.marginY) * Math.floor(i / t_hl));

				this._cont.addChild(t_mc);
			}
		}
	}

}
