/**
	@Name: SimpleVideoEvent
	@Author: HobisJung(jhb0b@naver.com)
	@Date: 2011-11-30
	@Comment:
	{
	}
*/
package hb.media.events
{
	import flash.events.Event;

	public class SimpleVideoEvent extends Event
	{
		public function SimpleVideoEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		
		// - 
		public var bytesLoaded:Number;
		// -
		public var bytesTotal:Number;
		// -
		public var loadedRatio:Number;
				
		// - 현재 포지션
		public var nowPosition:Number;
		// - 끝 포지션
		public var endPosition:Number;
		// - 현재 포지션 비율
		public var positionRatio:Number;
		
		// - 비디오 스트림에러
		public static const VIDEO_STREAM_ERROR:String = 'videoStreamError';
		
		// - 비디오 다운로드 프로그레스
		public static const VIDEO_LOAD_PROGRESS:String = 'videoLoadProgress';
		// - 비디오 다운로드 완료
		public static const VIDEO_LOAD_COMPLETE:String = 'videoLoadComplete';		
		
		// - 비디오 재생준비 (onMetaData이면 실행)
		public static const VIDEO_PLAY_READY:String = 'videoPlayReady';
		// - 비디오 재생정지
		public static const VIDEO_PLAY_STOP:String = 'videoPlayStop';
		
		// - 비디오 포지션 업데이트
		public static const VIDEO_POSITION_UPDATE:String = 'videoPositionUpdate';
	}
}