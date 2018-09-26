/**
	@Name: SimpleSound
	@Author: HobisJung(jhb0b@naver.com)
	@Date: 2012-10-22
	@Using:
	{

		import hb.media.SimpleSound;
		import hb.media.events.SimpleSoundEvent;
		import flash.events.MouseEvent;
		import flash.events.IOErrorEvent;

		var t_ss:SimpleSound = new SimpleSound();
		t_ss.autoPlay = true;
		t_ss.volume = 1;
		t_ss.afterDispose = false;
		t_ss.name = 'ss';
		t_ss.addEventListener(IOErrorEvent.IO_ERROR,
			function(event:IOErrorEvent):void
			{
				trace(event.type);
			}
		);
		t_ss.addEventListener(SimpleSoundEvent.SOUND_LOAD_COMPLETE,
			function(event:SimpleSoundEvent):void
			{
				trace(event.type);
			}
		);
		t_ss.addEventListener(SimpleSoundEvent.SOUND_PLAY_COMPLETE,
			function(event:SimpleSoundEvent):void
			{
				trace(event.type);
			}
		);
		t_ss.load('http://jvod.jjanglive.com/jjangpod/2011/11/10/17/34/1320914056914/467893dc-395e-431d-99c8-1f998e517d25.mp3');

	}
*/
package hb.media
{
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	import hb.media.core.IPlayer;
	import hb.media.events.SimpleSoundEvent;
	import hb.tools.DebugTool;


	public class SimpleSound extends EventDispatcher implements IPlayer
	{
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		////	Private Members
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// :: 생성자
		public function SimpleSound()
		{
		}

		// :: 사운드 로드 에러
		private function p_sound_ioError(event:IOErrorEvent):void
		{
			this.dispatchEvent(event);
		}
		// :: 사운드 로드 완료(재생준비완료)
		private function p_sound_load_complete(event:Event):void
		{
			if (this.autoPlay)
				this.play();
			this.dispatchEvent(new SimpleSoundEvent(SimpleSoundEvent.SOUND_LOAD_COMPLETE));
		}
		// :: 사운드 재생 완료
		private function p_sc_play_complete(event:Event):void
		{
			if (this.afterDispose)
			{
				this.p_dispose_all();
			}
			else
			{
				this.stop();
			}

			this.dispatchEvent(new SimpleSoundEvent(SimpleSoundEvent.SOUND_PLAY_COMPLETE));
		}

		// :: 사운드 객체 생성
		private function p_new_sound():void
		{
			if (this.m_sound == null)
			{
				this.m_sound = new Sound();
				this.m_sound.addEventListener(Event.COMPLETE, this.p_sound_load_complete);
				this.m_sound.addEventListener(IOErrorEvent.IO_ERROR, this.p_sound_ioError);
			}
		}

		// :: 사운드 해제
		private function p_dispose_sound():void
		{
			if (this.m_sound != null)
			{
				this.m_sound.removeEventListener(Event.COMPLETE, this.p_sound_load_complete);
				this.m_sound.removeEventListener(IOErrorEvent.IO_ERROR, this.p_sound_ioError);
				try
				{
					this.m_sound.close();
				}
				catch (e:IOError)
				{
				}
				this.m_sound = null;
			}
		}
		// :: 사운드 채널 객체 해제
		private function p_dispose_sc():void
		{
			if (this.m_sc != null)
			{
				this.m_sc.removeEventListener(Event.SOUND_COMPLETE, this.p_sc_play_complete);
				this.m_sc.stop();
				this.m_sc = null;
			}
		}
		// :: 객체 해제
		private function p_dispose_all():void
		{
			this.p_dispose_sound();
			this.p_dispose_sc();
			this.m_pausePosition = NaN;
		}

		// :: 사운드 볼륨 업데이트
		private function p_volume_update():void
		{
			if (this.m_sc != null)
			{
				var t_st:SoundTransform = this.m_sc.soundTransform;
				t_st.volume = this.m_volume;
				this.m_sc.soundTransform = t_st;
			}
		}


		// :: 사운드 객체
		private var m_sound:Sound = null;
		// :: 사운드 채널 객체
		private var m_sc:SoundChannel = null;
		// :: 재생중 사운드 채널의 일시정지 포지션
		private var m_pausePosition:Number;
		// :: 사운드볼륨
		private var m_volume:Number = 1;

		private static function p_trace_msg(type:String):void
		{
			if (type == 'NoStream')
				DebugTool.test('열려있는 스트림이 없습니다.');
			else if (type == 'OpendStream')
				DebugTool.test('스트림이 이미 열려 있습니다.');
		}
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////


		////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		////	Public Members
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		// {{{ IPlayer Implements
		//
		// :: 컨텐트 스트림 닫기
		public function close():void
		{
			if (this.m_sound != null)
			{
				this.p_dispose_all();
			}
			else
			{
				p_trace_msg('NoStream');
			}
		}

		// :: 컨텐트 로그
		public function load(url:String):void
		{
			if (this.m_sound == null)
			{
				this.p_new_sound();
				this.m_sound.load(new URLRequest(url), null);
			}
			else
			{
				p_trace_msg('OpendStream');
			}
		}

		// :: 컨텐트 재생중지
		public function stop():void
		{
			if (this.m_sound != null)
			{
				if
				(
					(this.m_sc != null) ||
					(!isNaN(this.m_pausePosition))
				)
				{
					this.m_pausePosition = NaN;
					this.p_dispose_sc();
				}
			}
			else
			{
				p_trace_msg('NoStream');
			}
		}

		// :: 컨텐트 플레이
		public function play():void
		{
			if (this.m_sound != null)
			{
				if (this.m_sc == null)
				{
					var t_startTime:Number = isNaN(this.m_pausePosition) ? 0 : this.m_pausePosition;
					this.m_sc = this.m_sound.play(t_startTime, this.loops);
					this.p_volume_update();
					this.m_sc.addEventListener(Event.SOUND_COMPLETE, this.p_sc_play_complete);
				}
			}
			else
			{
				p_trace_msg('NoStream');
			}
		}

		// :: 컨텐트 일시정지
		public function pause():void
		{
			if (this.m_sound != null)
			{
				if (this.m_sc != null)
				{
					this.m_pausePosition = this.m_sc.position;
					this.p_dispose_sc();
				}
			}
			else
			{
				p_trace_msg('NoStream');
			}
		}
		//
		// }}}
		//

		// :: 사운드 객체 반환
		public function getSound():Sound
		{
			return this.m_sound;
		}

		// :: 사운드채널 객체 반환
		public function getSoundChannel():SoundChannel
		{
			return this.m_sc;
		}

		// :: 현재 재생중인 포지션(재생위치) 반환
		public function getPosition():Number
		{
			var t_rv:Number;

			if (this.m_sc != null)
			{
				t_rv = this.m_sc.position;
			}

			return t_rv;
		}

		// :: 현재 재생중인 포지션(재생위치) 변경
		public function setPosition(v:Number):void
		{
			this.m_pausePosition = v;
			this.p_dispose_sc();
			this.play();
		}

		// :: 사운드 볼륨 반환
		public function get volume():Number
		{
			return this.m_volume;
		}

		// :: 사운드 볼륨 적용
		public function set volume(v:Number):void
		{
			if (v < 0)
				v = 0;
			else if (v > 1)
				v = 1;

			this.m_volume = v;
			this.p_volume_update();
		}


		// :: 사운드 로딩완료후 바로 재생 할 것인지 여부
		public var autoPlay:Boolean = false;
		// :: 사운드 반복횟수
		public var loops:int = 0;
		// :: 재생후 객체제거
		public var afterDispose:Boolean = false;
		// :: 객체 식별이름
		public var name:String = null;
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////


		public static function ac_clear():void
		{
			_ac = null;
			_acps = null;
		}
		private static var _ss:SimpleSound = null;
		private static var _ac:Function = null;
		private static var _acps:Array = null;
		// :: 사운드 로드 에러
		private static function p_sound_ioError(event:IOErrorEvent):void
		{
			ac_clear();
		}
		private static function p_ss_playEnd(event:SimpleSoundEvent):void
		{
			stop();

			if (_ac != null)
			{
				if (_acps != null)
					_ac.apply(null, _acps);
				else
					_ac();
			}
		}
		public static function stop():void
		{
			if (_ss != null)
			{
				_ss.removeEventListener(IOErrorEvent.IO_ERROR, p_sound_ioError);
				_ss.removeEventListener(SimpleSoundEvent.SOUND_PLAY_COMPLETE, p_ss_playEnd);
				_ss.close();
				_ss = null;
			}
		}
		public static function play(
									url:String,
									volume:Number = 1,
									loops:int = 0,
									ac:Function = null,
									acps:Array = null):SimpleSound
		{
			stop();

			_ss = new SimpleSound();
			_ss.autoPlay = true;
			_ss.volume = volume;
			_ss.loops = loops;
			_ss.afterDispose = true;
			_ss.addEventListener(SimpleSoundEvent.SOUND_PLAY_COMPLETE, p_ss_playEnd);
			_ac = ac;
			_acps = acps;
			_ss.load(url);

			return _ss;
		}
	}
}
