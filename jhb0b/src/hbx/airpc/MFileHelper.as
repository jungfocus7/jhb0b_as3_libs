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
			const treg:RegExp = /\.[^.]*$/i;

			var tnp:String = f.nativePath;
			var tfi:int = tnp.search(treg);
			if (tfi > -1)
			{
				return tnp.substr(tfi + 1);
			}
			else
			{
				return null;
			}
		}



		private static const _sept:String = '\\';

		public static function get_fileName(fp:String):String
		{
			var tss:Array = fp.split(_sept);
			if ((tss != null) && (tss.length > 0))
				return tss.pop();
			else
				return null;
		}

		public static function get_fileNameOnly(fp:String):String
		{
			var tfnm:String = get_fileName(fp);
			if (tfnm != null)
			{
				return tfnm.replace(/\.[^\.]+$/, '');
			}
			else return null;
		}

		public static function get_parentPath(fp:String, li:int = -1):String
		{
			var tss:Array = fp.split(_sept);
			if ((tss != null) && (tss.length > 0))
				return tss.slice(0, li).join(_sept);
			else
				return null;
		}

		public static function get_relativePath(fp:String, li:int = -1):String
		{
			var tss:Array = fp.split(_sept);
			if ((tss != null) && (tss.length > 0))
				return tss.slice(li).join(_sept);
			else
				return null;
		}
	}

}