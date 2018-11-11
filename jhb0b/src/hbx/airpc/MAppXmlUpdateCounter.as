package hbx.airpc
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;


	public final class MAppXmlUpdateCounter
	{
		private static const _rx1:RegExp = /<id>([^<]+?)<\/id>/;
		
		
		private static var _replacedString:String = 'HobisApp180929Work124925172';
		private static var _appXmlFile:File;		

		public static function update(tReplacedString:String = null):void
		{
			if (tReplacedString != null) _replacedString = tReplacedString;
			
			_appXmlFile = new File(File.applicationDirectory.nativePath);
			_appXmlFile = _appXmlFile.resolvePath('META-INF\\AIR\\application.xml');
			if (_appXmlFile.exists)
			{
				_appXmlFile.addEventListener(Event.COMPLETE, ppOpened);
				_appXmlFile.load();
			}
			else
			{
				_appXmlFile = null;
			}
		}		
		
		private static function ppOpened(evt:Event):void
		{
			var tLoadXmlStr:String = _appXmlFile.data.toString();
			if (_rx1.test(tLoadXmlStr))
			{
				var tNewXmlStr:String = tLoadXmlStr.replace(_rx1,
					function():String {
						var tstr1:String = arguments[0];
						var tstr2:String = arguments[1];
						return tstr1.replace(tstr2, _replacedString);
					});
				ppSaveFile(tNewXmlStr);
			}
			_appXmlFile = null;
		}

		private static function ppSaveFile(val:String):void
		{
			var tfs:FileStream;
			try
			{
				tfs = new FileStream();
				tfs.openAsync(_appXmlFile, FileMode.WRITE);
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
