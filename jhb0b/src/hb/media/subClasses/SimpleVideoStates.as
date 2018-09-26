/**
*/
package hb.media.subClasses
{
	public final class SimpleVideoStates
	{
        public function SimpleVideoStates()
        {
        }

		// - UI 조작상태
        public static const UI_LEVEL:String = 'uiLevel';
		// - 버퍼링 상태
        public static const BUFFERING:String = 'buffering';
		// - 플레이 상태
		public static const PLAYING:String = 'playing';
		// - 일시정지 상태
		public static const PAUSED:String = 'paused';
		// - 완전스톱 상태
		public static const STOP:String = 'stop';
		// - 스트림 닫힘 상태 (재사용 가능 상태)
        public static const CLOSE:String = 'close';
	}
}
