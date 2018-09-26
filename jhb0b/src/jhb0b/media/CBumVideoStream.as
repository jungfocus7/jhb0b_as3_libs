package jhb0b.media
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import jhb0b.core.CEventCore;
	import jhb0b.core.IPlayer;
	import jhb0b.core.IStream;
	import jhb0b.events.CBumEvent;


	public class CBumVideoStream extends CEventCore implements IStream, IPlayer
	{
		//- 스트림에러
		public static const ET_STREAM_ERROR:String = 'videoStreamError';
		//- 다운로드 프로그레스
		public static const ET_LOAD_PROGRESS:String = 'videoLoadProgress';
		//- 다운로드 완료
		public static const ET_LOAD_COMPLETE:String = 'videoLoadComplete';
		//- 재생준비 (onMetaData이면 실행)
		public static const ET_PLAY_READY:String = 'videoPlayReady';
		//- 재생정지
		public static const ET_PLAY_STOP:String = 'videoPlayStop';
		//- 포지션 업데이트
		public static const ET_POSITION_UPDATE:String = 'videoPositionUpdate';
		//- 타임표시 엔터프레임
		public static const ET_ENTER_FRAME:String = Event.ENTER_FRAME;


		//- 플레이 상태
		public static const StatePlaying:String = 'playing';
		//- 일시정지 상태
		public static const StatePaused:String = 'paused';
		//- 완전스톱 상태
		public static const StateStop:String = 'stop';
		//- 스트림 닫힘 상태
        public static const StateClose:String = 'close';





		override public function dispose():void
		{
			if (_NetStream == null) return;
			this.close();

			_UseSprite.removeEventListener(Event.ENTER_FRAME, ppSeekCheck);
			_UseSprite.removeEventListener(Event.ENTER_FRAME, ppEnterFrame);
			_UseSprite = null;

			_Url = null;
			_NowCode = null;
			_MetaData = null;
			_State = null;
			if (_Video != null)
			{
				var tdoc:DisplayObjectContainer = _Video.parent;
				if (tdoc != null)
				{
					tdoc.removeChild(_Video);
				}
				_Video = null;
			}

			_NetStream.removeEventListener(NetStatusEvent.NET_STATUS, ppNetStreamNetStatusHandler);
			_NetStream.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, ppNetStreamAsyncErrorHandler);
			try { _NetStream.close(); } catch (e:Error) { }
			_NetStream.client.onMetaData = null;
			_NetStream = null;

			super.dispose();
		}

		public function CBumVideoStream()
		{
			var tNetConn:NetConnection = new NetConnection();
			tNetConn.addEventListener(NetStatusEvent.NET_STATUS,
				function(event:NetStatusEvent):void
				{
					//p_test(event.type);
				});
			tNetConn.addEventListener(SecurityErrorEvent.SECURITY_ERROR,
				function(event:SecurityErrorEvent):void
				{
					//p_test(event.type);
				});
			tNetConn.connect(null);
			_NetStream = new NetStream(tNetConn);
			_NetStream.checkPolicyFile = true;
			_NetStream.client = { };
			_NetStream.client.onMetaData = ppOnMetaData;
			_NetStream.addEventListener(NetStatusEvent.NET_STATUS, ppNetStreamNetStatusHandler);
			_NetStream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, ppNetStreamAsyncErrorHandler);

			_UseSprite = new Sprite();
		}


		protected var _NetStream:NetStream;
		public function getNetStream():NetStream
		{
			return _NetStream;
		}
		protected function ppOnMetaData(tInfoObj:Object):void
		{
			if (_MetaData == null)
			{
				_MetaData = tInfoObj;
				//for (var tp:String in _MetaData)
				//	p_test(tp + ': ' + _MetaData[tp]);

				//if (this.autoPlay)
				//	this.play();

				var tbe:CBumEvent = new CBumEvent(ET_PLAY_READY);
				this.dispatchEvent(tbe);
			}
		}
		protected function ppNetStreamNetStatusHandler(tEvt:NetStatusEvent):void
		{
			var tCode:String = tEvt.info.code;
			switch (tCode)
			{
				case 'NetStream.Play.Stop':
					if (_State == StatePlaying)
					{
						this.pause();
						this.dispatchEvent(new CBumEvent(ET_PLAY_STOP));
					}
					break;

				case 'NetStream.Play.StreamNotFound':
					this.dispatchEvent(new CBumEvent(ET_STREAM_ERROR));
					break;
			}
		}
		protected function ppNetStreamAsyncErrorHandler(tEvt:AsyncErrorEvent):void
		{
			//p_test('ppNetStreamAsyncErrorHandler');
		}


		protected var _Url:String;
		public function getUrl():String
		{
			return _Url;
		}


		protected var _NowCode:String;
		public function getNowCode():String
		{
			return _NowCode;
		}


		protected var _MetaData:Object;
		public function getMetaData():Object
		{
			return _MetaData;
		}


		protected var _State:String = StateClose;
		public function getState():Object
		{
			return _State;
		}


		protected var _Video:Video = null;
		public function getVideo():Video
		{
			if (_Video == null)
			{
				_Video = new Video();
				_Video.smoothing = true;
				_Video.attachNetStream(_NetStream);
			}
			return _Video;
		}


		protected var _UseSprite:Sprite;
		protected function ppSeekCheck(tEvt:Event):void
		{
			if (_NetStream == null) return;

			if (_MetaData != null)
			{
				this.dispatchEvent(new CBumEvent(ET_POSITION_UPDATE));
			}
		}
		protected function ppEnterFrame(tEvt:Event):void
		{
			if (_NetStream == null) return;

			if (_MetaData != null)
			{
				this.dispatchEvent(tEvt);
			}
		}


		//public var autoPlay:Boolean = false;



		public function getSoundTransform():SoundTransform
		{
			if (_NetStream == null) return null;

			return _NetStream.soundTransform;
		}
		public function setSoundTransform(tstf:SoundTransform):void
		{
			if (_NetStream == null) return;

			_NetStream.soundTransform = tstf;
		}

		public function getDuration():Number
		{
			if (_NetStream == null) return NaN;

			var trv:Number;
			if (_MetaData != null)
				trv = _MetaData.duration;
			return trv;
		}

		public function getPosition():Number
		{
			if (_NetStream == null) return NaN;

			return _NetStream.time;
		}
		public function setPosition(tv:Number):void
		{
			if (_NetStream == null) return;

			var tmin:Number = 0;
			var tmax:Number;
			if (_MetaData != null)
				tmax = _MetaData.duration;
			else
				tmax = 0;

			if (tv < tmin) tv = tmin;
			else
			if (tv > tmax) tv = tmax;

			_NetStream.seek(tv);
		}

		public function getIsClosed():Boolean
		{
			return _State == StateClose;
		}



		public function close():void
		{
			if (_NetStream == null) return;

			if (_State != StateClose)
			{
				_UseSprite.removeEventListener(Event.ENTER_FRAME, ppEnterFrame);

				this.stop();
				_NetStream.close();
				_NetStream.client = { };
				_NetStream.client.onMetaData = ppOnMetaData;
				_Url = null;
				if (_Video != null) _Video.clear();
				_State = StateClose;
			}
		}

		public function open(tUrl:String):void
		{
			if (_NetStream == null) return;

			if (_State == StateClose)
			{
				_Url = tUrl;
				_MetaData = null;
				_NetStream.play(_Url);
				_NetStream.pause();

				_UseSprite.addEventListener(Event.ENTER_FRAME, ppEnterFrame);
				_State = StateStop;
			}
		}


		public function stop():void
		{
			if (_State != StateClose)
			{
				if (_State != StateStop)
				{
					this.pause();
					this.setPosition(0);
					_State = StateStop;
				}
				else
				{
					this.setPosition(0);
				}
			}
		}

		public function play():void
		{
			if (_State != StateClose)
			{
				if (_State != StatePlaying)
				{
					_NetStream.resume();
					_UseSprite.addEventListener(Event.ENTER_FRAME, ppSeekCheck);
					_State = StatePlaying;
				}
			}
		}

		public function pause():void
		{
			if (_State != StateClose)
			{
				if (_State != StatePaused)
				{
					_UseSprite.removeEventListener(Event.ENTER_FRAME, ppSeekCheck);
					_NetStream.pause();
					_State = StatePaused;
				}
			}
		}

	}
}