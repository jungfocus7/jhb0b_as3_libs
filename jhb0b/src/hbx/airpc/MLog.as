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

		public static function setting(tba:Boolean, tbb:Boolean = false):void
		{
			if (_adp == null)
			{
				_adp = File.applicationDirectory.nativePath;
			}

			if (tba)
			{
				if (_lf == null)
				{
					try
					{
						_lf = new File(_adp);
						if (tbb)
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

		public static function write(tv:String):void
		{
			if (_lfs == null) return;
			_lfs.writeUTFBytes(tv + '\r\n');
		}

	}

}

