package hb.winforms
{
	
/**
	@Name: Winform으로 통신하는 유틸
	@Author: HobisJung
	@Date: 2016-04-04-18:24
	@Comment: {

		// 윈도우창 닫기
		FrmProxy.call('Frm_Close');
		
		// 학습창 열기
		FrmProxy.addCallback('openContents', openContents);
		function openContents(url:String):void {
			//여기에서 학습창 열기
		}	
	}
*/	
	import hb.winforms.tools.QueryStringTool;	
	import flash.external.ExternalInterface;
	

	public final class FrmProxy
	{
		public function FrmProxy()
		{
		}
		
		/**
		 *  오브젝트로 인자 보낼수 있게 수정...
			FrmProxy.call_o("FRM_SEND_EBOOK_PAGE", {page: getValueNumber(ModuleName.EBOOK, Value.LEFT_PAGE)});
			trace("@@ send hnEndPlayer FrmProxy.call");
		 * */
		public static function call_o(funcName:String, pObj:Object):*
		{
			if (ExternalInterface.available)
				return ExternalInterface.call(funcName, QueryStringTool.toString(pObj));
			else
				return null;
		}		
		
		public static function call(funcName:String, ...args):*
		{
			if (ExternalInterface.available)
				return ExternalInterface.call(funcName, args);
			else
				return null;				
		}
		
		public static function addCallback(funcName:String, closure:Function):void
		{
			if (ExternalInterface.available)
				ExternalInterface.addCallback(funcName, closure);
		}
		
		public static function get_available():Boolean
		{
			return ExternalInterface.available;
		}
	}	
}
