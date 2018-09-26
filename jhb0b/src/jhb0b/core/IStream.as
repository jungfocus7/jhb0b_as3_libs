package jhb0b.core
{
	public interface IStream
	{
		function close():void;

		function open(url:String):void;
	}
}
