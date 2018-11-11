package hbx.core
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;


	public interface IContainerObserver
	{
		function get_container():DisplayObjectContainer;

		function get_stage():Stage;
	}
}
