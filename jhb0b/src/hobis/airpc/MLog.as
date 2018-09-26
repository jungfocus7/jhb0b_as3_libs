package hobis.airpc
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import jhb0b.utils.MStringUtil;


	public final class MLog
	{
		private static var _AppDirectoryPath:String;
		private static var _LogFile:File;
		private static var _LogFileStream:FileStream;

		// ::
		private static function ppDateTimeStamp(d:Date = null):String
		{
			var t_d:Date = (d == null) ? new Date() : d;

			var t_yy:Number = t_d.fullYear;
			var t_mm:Number = t_d.month + 1;
			var t_dd:Number = t_d.date;
			var t_tt:Number = t_d.hours;
			var t_mi:Number = t_d.minutes;
			var t_ss:Number = t_d.seconds;
			var t_ms:Number = t_d.milliseconds;

			var t_ds:String	=
				MStringUtil.add_token(t_yy.toString().substr(2, 2), 2) +
				MStringUtil.add_token(t_mm.toString(), 2) +
				MStringUtil.add_token(t_dd.toString(), 2) +
				MStringUtil.add_token(t_tt.toString(), 2) +
				MStringUtil.add_token(t_mi.toString(), 2) +
				MStringUtil.add_token(t_ss.toString(), 2) +
				MStringUtil.add_token(t_ms.toString(), 3);
			return t_ds;
		}

		public static function ffSet(tba:Boolean, tbb:Boolean = false):void
		{
			if (_AppDirectoryPath == null)
			{
				_AppDirectoryPath = File.applicationDirectory.nativePath;
			}

			if (tba)
			{
				if (_LogFile == null)
				{
					try
					{
						_LogFile = new File(_AppDirectoryPath);
						if (tbb)
							_LogFile = _LogFile.resolvePath('Log-' + ppDateTimeStamp() + '.txt');
						else
							_LogFile = _LogFile.resolvePath('Log.txt');
						if (_LogFile.exists)
							_LogFile.deleteFile();
						_LogFileStream = new FileStream();
						_LogFileStream.open(_LogFile, FileMode.APPEND);
					}
					catch (e:Error)
					{
						ffSet(false);
					}
				}
			}
			else
			{
				if (_LogFile == null) return;
				_LogFile = null;
				if (_LogFileStream != null)
				{
					try
					{
						_LogFileStream.close();
					}
					catch (e:Error) {}
					_LogFileStream = null;
				}
			}
		}

		public static function ffWrite(v:String):void
		{
			if (_LogFileStream == null) return;
			_LogFileStream.writeUTFBytes(v + '\r\n');
		}

	}

}

