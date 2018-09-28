package hobis.airpc
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;


	public final class MAppXmlUpdateCounter
	{
		private static const _rx1:RegExp = /<id>([^<]+?)<\/id>/;
		
		
		private static var _ReplacedString:String = 'HobisApp180929Work124925172';
		private static var _AppXmlFile:File;		

		public static function Update(tReplacedString:String = null):void
		{
			if (tReplacedString != null) _ReplacedString = tReplacedString;
			
			_AppXmlFile = new File(File.applicationDirectory.nativePath);
			_AppXmlFile = _AppXmlFile.resolvePath('META-INF\\AIR\\application.xml');
			if (_AppXmlFile.exists)
			{
				_AppXmlFile.addEventListener(Event.COMPLETE, ppOpened);
				_AppXmlFile.load();
			}
			else
			{
				_AppXmlFile = null;
			}
		}			
		private static function ppOpened(evt:Event):void
		{
			var tLoadXmlStr:String = _AppXmlFile.data.toString();
			if (_rx1.test(tLoadXmlStr))
			{
				var tNewXmlStr:String = tLoadXmlStr.replace(_rx1,
					function():String {
						var tstr1:String = arguments[0];
						var tstr2:String = arguments[1];
						return tstr1.replace(tstr2, _ReplacedString);
					});
				ppSaveFile(tNewXmlStr);
			}
			_AppXmlFile = null;
		}

		private static function ppSaveFile(val:String):void
		{
			var tfs:FileStream;
			try
			{
				tfs = new FileStream();
				tfs.openAsync(_AppXmlFile, FileMode.WRITE);
				var tba:ByteArray = new ByteArray();
				tba.writeUTFBytes(val);
				tfs.writeBytes(tba);
				tba.clear();
			}
			catch (e:Error) { }
			try
			{
				tfs.close();
			}
			catch (e:Error) { }
		}
	}
}
