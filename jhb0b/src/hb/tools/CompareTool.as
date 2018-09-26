/**
	@Name: IComparer
	@Author: HobisJung(jhb0b@naver.com)
	@Date: 2016-01-20
	@Comment:
	{
	}
*/
package hb.tools
{
	public final class CompareTool
	{
		public function CompareTool()
		{			
		}		
		
		public static function compare_int(va:int, vb:int):int
		{
			if (va > vb) {
				return 1;
			}
			else 
			if (va < vb) {
				return -1;
			}
			else {
				return 0;
			}
		}
		
		public static function compare_uint(va:uint, vb:uint):int
		{
			if (va > vb) {
				return 1;
			}
			else 
			if (va < vb) {
				return -1;
			}
			else {
				return 0;
			}
		}
		
		public static function compare_Number(va:Number, vb:Number):int
		{
			if (va > vb) {
				return 1;
			}
			else 
			if (va < vb) {
				return -1;
			}
			else {
				return 0;
			}
		}
		
		public static function equals_Object(va:Object, vb:Object):Boolean
		{
			return (va === vb);
		}		
	}
}
