package hb.tools
{
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	
	/**
	 * ...
	 * @author Hobis
	 */
	public final class FlaTracer 
	{		
		public function FlaTracer() 
		{
		}
		
		private static var _lconn:LocalConnection = null;
		public static function get_lc():LocalConnection
		{
			return _lconn;
		}
		
		public static function stop():void
		{
			if (_lconn == null) return;
			
			_connectionName = null;
			_methodName = null;
			try
			{
				_lconn.close();
			}
			catch (e:Error) {}
			_lconn = null;
		}
		
		//private static var _connectionName:String = 'app#__FlaTracer__';
		//private static var _methodName:String = 'p_trace';
		private static var _connectionName:String = null;
		private static var _methodName:String = null;
		public static function start(connectionName:String, methodName:String = null):void
		{
			if (!LocalConnection.isSupported) return;
			
			if (_lconn == null)
			{
				_connectionName = connectionName;
				_methodName = methodName;
				if (_methodName == null) _methodName = 'p_trace';
				_lconn = new LocalConnection();
				_lconn.addEventListener(StatusEvent.STATUS, p_lconn_status);
			}
		}
		
		private static function p_lconn_status(event:StatusEvent):void
		{/*
            switch (event.level) {
                case 'status':
                    trace('LocalConnection.send() succeeded');
                    break;
                case 'error':
                    trace('LocalConnection.send() failed');
                    break;
            }*/
		}
		
		
		public static function log(v:String):void
		{
			if (_lconn == null) return;
			_lconn.send(_connectionName, _methodName, v);
		}
		
	}

}