package hbx.airpc
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	import hbx.utils.MStringUtil;


	public final class MLog
	{
		//-AppDirectoryPath:
		private static var _adp:String;

		//-LogFile
		private static var _lf:File;

		//-LogFileStream
		private static var _lfs:FileStream;


		private static function ppDateTimeStamp(dt:Date = null):String
		{
			if (dt == null) dt = new Date();

			var yy:Number = dt.fullYear;
			var mm:Number = dt.month + 1;
			var dd:Number = dt.date;
			var hh:Number = dt.hours;
			var mi:Number = dt.minutes;
			var ss:Number = dt.seconds;
			var ms:Number = dt.milliseconds;

			var rv:String	=
				MStringUtil.add_token(yy.toString().substr(2, 2), 2) +
				MStringUtil.add_token(mm.toString(), 2) +
				MStringUtil.add_token(dd.toString(), 2) +
				MStringUtil.add_token(hh.toString(), 2) +
				MStringUtil.add_token(mi.toString(), 2) +
				MStringUtil.add_token(ss.toString(), 2) +
				MStringUtil.add_token(ms.toString(), 3);
			return rv;
		}

		public static function setting(ba:Boolean, bb:Boolean = false):void
		{
			if (_adp == null)
			{
				_adp = File.applicationDirectory.nativePath;
			}

			if (ba)
			{
				if (_lf == null)
				{
					try
					{
						_lf = new File(_adp);
						if (bb)
							_lf = _lf.resolvePath('Log-' + ppDateTimeStamp() + '.txt');
						else
							_lf = _lf.resolvePath('Log.txt');
						if (_lf.exists)
							_lf.deleteFile();
						_lfs = new FileStream();
						_lfs.open(_lf, FileMode.APPEND);
					}
					catch (e:Error)
					{
						setting(false);
					}
				}
			}
			else
			{
				if (_lf == null) return;
				_lf = null;
				if (_lfs != null)
				{
					try
					{
						_lfs.close();
					}
					catch (e:Error) {}
					_lfs = null;
				}
			}
		}

		public static function write(v:String):void
		{
			if (_lfs == null) return;
			_lfs.writeUTFBytes(v + '\r\n');
		}

	}

}

