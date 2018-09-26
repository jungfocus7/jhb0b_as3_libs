package hobis.airpc
{
	import flash.filesystem.File;

	/**
	 * ...
	 * @author Hobis
	 */
	public final class MFileHelper
	{
		public function MFileHelper()
		{
		}

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
	}

}