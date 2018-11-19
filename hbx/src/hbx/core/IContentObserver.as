package hbx.core
{
	import flash.display.DisplayObject;
	import flash.display.Stage;


	public interface IContentObserver
	{
		function get_content():DisplayObject;

		function get_stage():Stage;
	}
}
