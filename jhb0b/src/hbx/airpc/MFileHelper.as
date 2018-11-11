package hbx.airpc
{
	import flash.filesystem.File;

	
	public final class MFileHelper
	{
		//:: 어플리케이션 디렉토리
		public static function get_applicationDirectory():File
		{
			return new File(File.applicationDirectory.nativePath);
		}

		//:: 어플리케이션 디렉토리 - 덧붙임 경로
		public static function get_applicationDirectoryResolve(rp:String):File
		{
			return new File(File.applicationDirectory.resolvePath(rp).nativePath);
		}

		//:: 확장자명 반환
		public static function get_ext(f:File):String
		{
			const t_reg:RegExp = /\.[^.]*$/i;

			var t_np:String = f.nativePath;
			var t_fi:int = t_np.search(t_reg);
			if (t_fi > -1)
			{
				return t_np.substr(t_fi + 1);
			}
			else
			{
				return null;
			}
		}
		
		
		
		private static const _sept:String = '\\';

		public static function get_fileName(tfp:String):String
		{
			var tss:Array = tfp.split(_sept);
			if ((tss != null) && (tss.length > 0))
				return tss.pop();
			else
				return null;
		}

		public static function get_fileNameOnly(tfp:String):String
		{
			var tfnm:String = get_fileName(tfp);
			if (tfnm != null)
			{
				return tfnm.replace(/\.[^\.]+$/, '');
			}
			else return null;
		}

		public static function get_parentPath(tfp:String, tli:int = -1):String
		{
			var tss:Array = tfp.split(_sept);
			if ((tss != null) && (tss.length > 0))
				return tss.slice(0, tli).join(_sept);
			else
				return null;
		}

		public static function get_relativePath(tfp:String, tli:int = -1):String
		{
			var tss:Array = tfp.split(_sept);
			if ((tss != null) && (tss.length > 0))
				return tss.slice(tli).join(_sept);
			else
				return null;
		}		
	}

}