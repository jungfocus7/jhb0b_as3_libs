package hbx.core
{
    public interface ISelected
    {
		function get_selected():Boolean;

		function set_selected(b:Boolean):void;

		function set_selectedDispatch(b:Boolean):void
    }
}