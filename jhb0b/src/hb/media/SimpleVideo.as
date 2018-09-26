/**
	@Name: SimpleVideo
	@Author: HobisJung(jhb0b@naver.com)
	@Date: 2013-07-23
	@Using:
	{

		import hb.media.SimpleVideo;
		import hb.media.events.SimpleVideoEvent;
		import hbworks.uilogics.ButtonLogic;

		function p_init_once():void
		{
			this.m_sv = new SimpleVideo();
			this.m_sv.load('http://dvod.jjanglive.com/jjangpod/2011/12/06/18/24/1323163481030/400x300.flv');

			var t_video:Video = this.m_sv.video;
			t_video.smoothing = true;
			t_video.width = this.stage.stageWidth;
			t_video.height = this.stage.stageHeight;
			this.addChildAt(t_video, 0);
		}

		this.p_init_once();

	}
*/
package hb.media
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import hb.media.core.IPlayer;
	import hb.media.events.SimpleVideoEvent;
	import hb.media.subClasses.SimpleVideoStates;
	import hb.tools.DebugTool;

	public final class SimpleVideo extends EventDispatcher implements IPlayer
	{
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		////	Initialize
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// :: 넷스트림 상태변경 핸들러
		private function p_netStatusHandler(event:NetStatusEvent):void
		{
			var t_event:SimpleVideoEvent = null;

			var t_code:String = event.info.code;

			switch(t_code)
			{
				case 'NetStream.Play.Stop':
				{
					if (this.m_state == SimpleVideoStates.PLAYING)
					{
						this.pause();

						t_event = new SimpleVideoEvent(SimpleVideoEvent.VIDEO_PLAY_STOP);
						this.dispatchEvent(t_event);
					}

					break;
				}
				case 'NetStream.Play.StreamNotFound':
				{
					this.m_useSprite.removeEventListener(Event.ENTER_FRAME, this.p_downLoadCheck);

					t_event = new SimpleVideoEvent(SimpleVideoEvent.VIDEO_STREAM_ERROR);
					this.dispatchEvent(t_event);

					break;
				}
			}

			//DebugUtil.test('p_netStatusHandler');
		}

		// :: 넷스트림 에러 핸들러
		private function p_asyncErrorHandler(event:AsyncErrorEvent):void
		{
			//DebugUtil.test('p_asyncErrorHandler');
		}

		// :: 넷스트림 메타데이터 콜백 핸들러
		private function p_onMetaData(info:Object):void
		{
			if (this.m_metaData == null)
			{
				this.m_metaData = info;

				//for (var t_p:String in this.m_metaData)
				//	DebugUtil.test(t_p + ': ' + this.m_metaData[t_p]);

				if (this.autoPlay)
					this.play();

				var t_event:SimpleVideoEvent =
					new SimpleVideoEvent(SimpleVideoEvent.VIDEO_PLAY_READY);
				this.dispatchEvent(t_event);
			}

			//DebugUtil.test('p_onMetaData');
		}

		// :: 다운로드 체크 엔터프레임
		private function p_downLoadCheck(event:Event):void
		{
			var t_type:String = null;
			var t_bytesLoaded:Number = m_ns.bytesLoaded;
			var t_bytesTotal:Number = m_ns.bytesTotal;
			var t_ratio:Number = t_bytesLoaded / t_bytesTotal;

			if (t_ratio >= 1)
			{
				this.m_useSprite.removeEventListener(Event.ENTER_FRAME, this.p_downLoadCheck);

				t_type = SimpleVideoEvent.VIDEO_LOAD_COMPLETE;
			}
			else
			{
				t_type = SimpleVideoEvent.VIDEO_LOAD_PROGRESS;
			}

			var t_event:SimpleVideoEvent = new SimpleVideoEvent(t_type);
			t_event.bytesLoaded = t_bytesLoaded;
			t_event.bytesTotal = t_bytesTotal;
			t_event.loadedRatio = t_ratio;
			this.dispatchEvent(t_event);

			//DebugUtil.test('p_downLoadCheck');
			//DebugUtil.test('t_ratio: ' + t_ratio);
		}

		private function p_seekCheck(event:Event):void
		{
			if (this.m_metaData != null)
			{
				var t_nowPos:Number = this.m_ns.time;
				var t_endPos:Number = this.m_metaData.duration;
				var t_posRatio:Number = t_nowPos / t_endPos;
				var t_event:SimpleVideoEvent = null;
				t_event = new SimpleVideoEvent(SimpleVideoEvent.VIDEO_POSITION_UPDATE);
				t_event.nowPosition = t_nowPos;
				t_event.endPosition = t_endPos;
				t_event.positionRatio = t_posRatio;
				this.dispatchEvent(t_event);
			}

/*			DebugUtil.test('p_seekCheck');
			DebugUtil.test('t_nowPos: ' + t_nowPos);
			DebugUtil.test('t_endPos: ' + t_endPos);
			DebugUtil.test('t_posRatio: ' + t_posRatio);*/
		}

		// :: 생성자
		public function SimpleVideo()
		{
			var t_nc:NetConnection = new NetConnection();
			t_nc.addEventListener(NetStatusEvent.NET_STATUS,
				function(event:NetStatusEvent):void
				{
					DebugTool.test(event.type);
				});
			t_nc.addEventListener(SecurityErrorEvent.SECURITY_ERROR,
				function(event:SecurityErrorEvent):void
				{
					DebugTool.test(event.type);
				});
			t_nc.connect(null);

			this.m_ns = new NetStream(t_nc);
			this.m_ns.checkPolicyFile = true;
			this.m_ns.client = new Object();
			this.m_ns.client.onMetaData = this.p_onMetaData;
			this.m_ns.addEventListener(NetStatusEvent.NET_STATUS, this.p_netStatusHandler);
			this.m_ns.addEventListener(AsyncErrorEvent.ASYNC_ERROR, this.p_asyncErrorHandler);

			this.m_useSprite = new Sprite();

			//DebugUtil.test('SimpleVideo');
		}

		// :: 객체 해제
		private function p_dispose():void
		{
			this.m_useSprite.removeEventListener(Event.ENTER_FRAME, this.p_downLoadCheck);
			this.m_useSprite.removeEventListener(Event.ENTER_FRAME, this.p_seekCheck);

			this.m_ns.removeEventListener(NetStatusEvent.NET_STATUS, this.p_netStatusHandler);
			this.m_ns.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, this.p_asyncErrorHandler);
			this.m_ns.close();
			this.m_ns.client.onMetaData = null;
			this.m_ns = null;

			this.m_metaData = null;

			if (this.m_video != null)
			{
				var t_doc:DisplayObjectContainer = this.m_video.parent;
				if (t_doc != null)
				{
					t_doc.removeChild(this.m_video);
				}

				this.m_video = null;
			}

			this.m_state = SimpleVideoStates.CLOSE;
			this.m_video = null;
			this.autoPlay = true;

			//DebugUtil.test('p_dispose');
		}
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////


		////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		////	Public Member
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// {{{{ IPlayer Implements
		// :: 사운드 로드하여 재생하기
		public function load(url:String):void
		{
			if (this.m_state == SimpleVideoStates.CLOSE)
			{
				this.m_url = url;
				this.m_metaData = null;
				this.m_ns.play(this.m_url);
				this.m_ns.pause();

				this.m_useSprite.addEventListener(Event.ENTER_FRAME, this.p_downLoadCheck);
				this.m_state = SimpleVideoStates.STOP;
			}
			else
			{
				DebugTool.test('close로 열린 스트림을 닫아주세요.');
			}

			//DebugUtil.test('load');
		}

		// :: 재생하기
		public function play():void
		{
			if (this.m_state != SimpleVideoStates.CLOSE)
			{
				if (this.m_state != SimpleVideoStates.PLAYING)
				{
					this.m_ns.resume();
					this.m_useSprite.addEventListener(Event.ENTER_FRAME, this.p_seekCheck);
					this.m_state = SimpleVideoStates.PLAYING;
				}
			}

			//DebugUtil.test('play');
		}

		// :: 재생중인 비디오 완전정지
		public function stop():void
		{
			if (this.m_state != SimpleVideoStates.CLOSE)
			{
				if (this.m_state != SimpleVideoStates.STOP)
				{
					this.pause();
					this.position = 0;
					this.m_state = SimpleVideoStates.STOP;
				}
				else
				{
					this.position = 0;
				}
			}

			//DebugUtil.test('stop');
		}

		// :: 재생중인 사운드 일시정지
		public function pause():void
		{
			if (this.m_state != SimpleVideoStates.CLOSE)
			{
				if (this.m_state != SimpleVideoStates.PAUSED)
				{
					this.m_useSprite.removeEventListener(Event.ENTER_FRAME, this.p_seekCheck);
					this.m_ns.pause();
					this.m_state = SimpleVideoStates.PAUSED;
				}
			}

			//DebugUtil.test('pause');
		}

		// :: 현재 열려있는 스트림 닫기
		public function close():void
		{
			if (this.m_state != SimpleVideoStates.CLOSE)
			{
				this.m_useSprite.removeEventListener(Event.ENTER_FRAME, this.p_downLoadCheck);
				this.stop();
				this.m_ns.close();
				this.m_ns.client = new Object();
				this.m_ns.client.onMetaData = this.p_onMetaData;
				this.m_url = null;
				this.m_state = SimpleVideoStates.CLOSE;

				//trace('this.m_state: ' + this.m_state);
			}

			//DebugUtil.test('close');
		}

		// :: 객체 해제(재 사용 불가 객체 패기)
		public function dispose():void
		{
			this.p_dispose();

			//DebugUtil.test('dispose');
		}
		// }}}}

		// :: 넷스트림 객체 변환
		public function get netStream():NetStream
		{
			return this.m_ns;
		}

		// :: 현재 비디오 Url
		public function get url():String
		{
			return this.m_url;
		}

		// :: 현재 NetStatus 상태 코드
		public function get nowCode():String
		{
			return this.m_nowCode;
		}

		// :: 로드된 메타데이터 반환
		public function get metaData():Object
		{
			return this.m_metaData;
		}

		// :: 플레이어 상태 반환
		public function get state():String
		{
			return this.m_state;
		}

		// :: 현재 비디오 사운드변환 객체 반환
		public function get soundTransform():SoundTransform
		{
			return this.m_ns.soundTransform;
		}

		// :: 현재 비디오 사운드변환 객체 저장
		public function set soundTransform(stf:SoundTransform):void
		{
			this.m_ns.soundTransform = stf;
		}

		// :: 현재 비디오 전체 포지션 길이
		public function get duration():Number
		{
			var t_rv:Number;

			if (this.m_metaData != null)
				t_rv = this.m_metaData.duration;

			return t_rv;
		}

		// :: 현재 비디오 포지션(seek) 반환
		public function get position():Number
		{
			return this.m_ns.time;
		}

		// :: 현재 비디오 포지션(seek) 변경
		public function set position(v:Number):void
		{
			var t_max:Number;

			if (this.m_metaData != null)
				t_max = this.m_metaData.duration;
			else
				t_max = 0;

			if (v > t_max)
				v = t_max;
			else if (v < 0)
				v = 0;

			this.m_ns.seek(v);

/*			DebugUtil.test('position');
			DebugUtil.test('v: ' + v);
			DebugUtil.test('t_max: ' + t_max);
			DebugUtil.test('this.m_metaData.duration: ' + this.m_metaData.duration);*/
		}

		// :: 객체로 부터 비디오객체를 요구하면 생성해서 반환
		public function get video():Video
		{
			if (this.m_video == null)
			{
				this.m_video = new Video();
				this.m_video.attachNetStream(this.m_ns);
			}

			return this.m_video;
		}
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////


		////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		////	Member Vars
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// :: 넷스트림 객체
		private var m_ns:NetStream = null;
		// :: 재생할 비디오 경로
		private var m_url:String = null;
		// :: 현재 상태 타입
		private var m_nowCode:String = null;
		// :: 메타데이터
		private var m_metaData:Object = null;
		// :: 현재 플레이어 상태
		private var m_state:String = SimpleVideoStates.CLOSE;
		// :: 비디오 객체
		private var m_video:Video = null;
		// :: 재생중 반복 엔터프래임 생성용
		private var m_useSprite:Sprite = null;

		// :: 로딩후 바로 재생 할 것인지 여부
		public var autoPlay:Boolean = true;
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////


		////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		////	Static
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}
