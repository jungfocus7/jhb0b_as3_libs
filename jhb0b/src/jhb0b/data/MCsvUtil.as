package jhb0b.data
{
	public final class MCsvUtil
	{
		public static function GetRowItemArr(tAllText:String):Array
		{
			var tLineStrArr:Array = GetLineStrArr(tAllText);
			if ((tLineStrArr != null) && (tLineStrArr.length > 0))
			{
				var tRowItemArr:Array = null;
				for each (var tLineStr:String in tLineStrArr)
				{
					var tRowStrArr:Array = GetRowStrArr(tLineStr);
					if (tRowStrArr != null)
					{
						if (tRowItemArr == null)
							tRowItemArr = [];
						tRowItemArr.push(tRowStrArr);
					}
				}
				return tRowItemArr;
			}
			else
			{
				return null;
			}
		}

		public static function GetLineStrArr(tAllText:String):Array
		{
			return tAllText.split(ReturnStr);
		}


		public static var ReturnStr:String;
		public static var EmptyStr:String;
		public static var CrepeStr:String;
		public static var Delimiters:String;
		public static function AttrReset():void
		{
			ReturnStr = '\r\n';
			EmptyStr = '';
			CrepeStr = '"';
			Delimiters = ',';
		}
		{
			AttrReset();
		}

		private static function ppEqualDelimiters(tbc:String):Boolean
		{
			var tb:Boolean = false;
			for (var tl:uint = Delimiters.length, i:uint = 0; i < tl; i++)
			{
				var tac:String = Delimiters.charAt(i);
				if (tac == tbc)
				{
					tb = true;
					break;
				}
			}
			return tb;
		}


		public static function GetRowStrArr(tLineStr:String):Array
		{
			var tRowStrArr:Array = [];
			var tRowStr:String;
			var tState:uint = 0;

			var tpc:String;
			var tcc:String;

			for (var i:uint = 0, tl:uint = tLineStr.length; i < tl; i++)
			{
				tpc = tcc;
				tcc = tLineStr.charAt(i);
				if (tRowStr == null)
				{
					if (tcc == CrepeStr)
					{
						tState = 1;
						tRowStr = EmptyStr;
						tcc = null;
					}
					else
					if (ppEqualDelimiters(tcc))
					{
						tRowStrArr.push(EmptyStr);
						if (i == (tl - 1))
							tRowStrArr.push(EmptyStr);
						tRowStr = null;
					}
					else
					{
						tState = 0;
						tRowStr = tcc;
					}
				}
				else
				{
					if (tState == 0)
					{
						if (ppEqualDelimiters(tcc))
						{
							tRowStrArr.push(tRowStr);
							tRowStr = null;
						}
						else
						if (i == (tl - 1))
						{
							tRowStr += tcc;
							tRowStrArr.push(tRowStr);
							tRowStr = null;
						}
						else
						{
							tRowStr += tcc;
						}
					}
					else
					if (tState == 1)
					{
						if (ppEqualDelimiters(tcc))
						{
							if (tpc == CrepeStr)
							{
								tRowStrArr.push(tRowStr.substr(0, tRowStr.length - 1));
								tRowStr = null;
							}
							else
							{
								tRowStr += tcc;
							}
						}
						else
						if (i == (tl - 1))
						{
							if (tcc == CrepeStr)
							{
								tRowStrArr.push(tRowStr);
								tRowStr = null;
							}
							else
							{
								tRowStr += tcc;
							}
						}
						else
						{
							if ((tpc == CrepeStr) && (tcc == CrepeStr))
							{
								tcc = null;
							}
							else
							{
								if (ppEqualDelimiters(tpc) && ppEqualDelimiters(tcc))
								{
									tRowStrArr.push(EmptyStr);
									tRowStr = null;
								}
								else
								{
									tRowStr += tcc;
								}
							}
						}
					}
				}
			}

			if (tRowStrArr.length > 0)
			{
				return tRowStrArr;
			}
			else
			{
				return null;
			}
		}
	}
}