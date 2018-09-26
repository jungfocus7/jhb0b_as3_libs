package hobis.airpc
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import jhb0b.utils.MArrayUtil;


	public final class MAppXmlUpdateCounter
	{
		private static var _AppXmlFile:File;

		public static function Update():void
		{
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
			const trx1:RegExp = /<id>[\s\S]*?<\/id>/;
			const trx2:RegExp = /<([^>]+)>/g;

			var tXmlStr:String = _AppXmlFile.data.toString();
			var tMatArr:Array = tXmlStr.match(trx1);
			if (!MArrayUtil.is_empty(tMatArr))
			{
				var tIdTagStr:String = tMatArr[0];
				var tIdValStr:String = tIdTagStr.replace(trx2, '');

				var tOriVal:String;
				var tNumVal:uint;
				var tStrArr:Array = tIdValStr.split('-');
				if (tStrArr != null)
				{
					if (tStrArr.length == 2)
					{
						tOriVal = tStrArr[0];
						tNumVal = int(tStrArr[1]);
					}
					else
					if (tStrArr.length == 1)
					{
						tOriVal = tStrArr[0];
						tNumVal = 0;
					}
					tNumVal++;

					var tIdNewStr:String = '<id>' + tOriVal + '-' + tNumVal + '<\/id>';
					var tNewXmlStr:String = tXmlStr.replace(tIdTagStr, tIdNewStr);
					ppSaveFile(tNewXmlStr);
				}
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
