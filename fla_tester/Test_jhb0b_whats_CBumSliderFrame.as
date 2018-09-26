import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.text.TextField;
import jhb0b.events.CBumEvent;
import jhb0b.tools.MDebugTool;
import jhb0b.utils.MTextFieldUtil;
import jhb0b.whats.CBumSliderFrame;


var _owner:MovieClip = this;


function p_sf1_handler(evt:CBumEvent):void
{
	MDebugTool.test(evt.type);
	if (evt.type == CBumSliderFrame.ET_UPDATE)
	{
		MTextFieldUtil.set_text(_owner, 'tf_1', _sf1.get_ratio().toString());
	}
}
var _sf1:CBumSliderFrame = new CBumSliderFrame(
	_owner.mca_1, CBumSliderFrame.TYPE_HORIZONTAL,
	17, 166);
_sf1.addEventListener(CBumSliderFrame.ET_MOUSE_UP, p_sf1_handler);
_sf1.addEventListener(CBumSliderFrame.ET_MOUSE_DOWN, p_sf1_handler);
_sf1.addEventListener(CBumSliderFrame.ET_UPDATE, p_sf1_handler);
TextField(_owner.tf_1).restrict = '0-9.';
TextField(_owner.tf_1).maxChars = 3;
MTextFieldUtil.clear_text(_owner, 'tf_1');
_sf1.dispatchEvent(new CBumEvent(CBumSliderFrame.ET_UPDATE));
SimpleButton(_owner.bt_1).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		var t_v:Number = Number(MTextFieldUtil.get_text(_owner, 'tf_1'));
		_sf1.set_ratio(t_v);
	}
);


function p_sf2_handler(evt:CBumEvent):void
{
	MDebugTool.test(evt.type);
	if (evt.type == CBumSliderFrame.ET_UPDATE)
	{
		MTextFieldUtil.set_text(_owner, 'tf_2', _sf2.get_ratio().toString());
	}
}
var _sf2:CBumSliderFrame = new CBumSliderFrame(
	_owner.mca_2, CBumSliderFrame.TYPE_VERTICAL,
	-173, 166);
_sf2.addEventListener(CBumSliderFrame.ET_MOUSE_UP, p_sf2_handler);
_sf2.addEventListener(CBumSliderFrame.ET_MOUSE_DOWN, p_sf2_handler);
_sf2.addEventListener(CBumSliderFrame.ET_UPDATE, p_sf2_handler);
TextField(_owner.tf_2).restrict = '0-9.';
TextField(_owner.tf_2).maxChars = 3;
MTextFieldUtil.clear_text(_owner, 'tf_2');
_sf2.dispatchEvent(new CBumEvent(CBumSliderFrame.ET_UPDATE));
SimpleButton(_owner.bt_2).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		var t_v:Number = Number(MTextFieldUtil.get_text(_owner, 'tf_2'));
		_sf2.set_ratio(t_v);
	}
);


function p_sf3_handler(evt:CBumEvent):void
{
	MDebugTool.test(evt.type);
	if (evt.type == CBumSliderFrame.ET_UPDATE)
	{
		MTextFieldUtil.set_text(_owner, 'tf_3', _sf3.get_ratio().toString());
	}
}
var _sf3:CBumSliderFrame = new CBumSliderFrame(
	_owner.mcb_1, CBumSliderFrame.TYPE_VERTICAL,
	12, 290);
_sf3.addEventListener(CBumSliderFrame.ET_MOUSE_UP, p_sf3_handler);
_sf3.addEventListener(CBumSliderFrame.ET_MOUSE_DOWN, p_sf3_handler);
_sf3.addEventListener(CBumSliderFrame.ET_UPDATE, p_sf3_handler);
TextField(_owner.tf_3).restrict = '0-9.';
TextField(_owner.tf_3).maxChars = 3;
MTextFieldUtil.clear_text(_owner, 'tf_3');
_sf3.dispatchEvent(new CBumEvent(CBumSliderFrame.ET_UPDATE));
SimpleButton(_owner.bt_3).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		var t_v:Number = Number(MTextFieldUtil.get_text(_owner, 'tf_3'));
		_sf3.set_ratio(t_v);
	}
);


SimpleButton(_owner.bt_4).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_sf1.set_enabled(!_sf1.get_enabled());
		_sf2.set_enabled(!_sf2.get_enabled());
		_sf3.set_enabled(!_sf3.get_enabled());
	}
);
