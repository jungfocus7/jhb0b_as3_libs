import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.text.TextField;
import jhb0b.events.CBumEvent;
import jhb0b.tools.MDebugTool;
import jhb0b.utils.MTextFieldUtil;
import jhb0b.whats.CBumSlider;


var _owner:MovieClip = this;


function p_slider1_handler(evt:CBumEvent):void
{
	MDebugTool.test(evt.type);
	if (evt.type == CBumSlider.ET_UPDATE)
	{
		MTextFieldUtil.set_text(_owner, 'tf_1', _slider1.get_ratio().toString());
	}
}
var _slider1:CBumSlider = new CBumSlider(_owner.slc_1,
	CBumSlider.TYPE_VERTICAL);
_slider1.addEventListener(CBumSlider.ET_MOUSE_UP, p_slider1_handler);
_slider1.addEventListener(CBumSlider.ET_MOUSE_DOWN, p_slider1_handler);
_slider1.addEventListener(CBumSlider.ET_UPDATE, p_slider1_handler);
TextField(_owner.tf_1).restrict = '0-9.';
TextField(_owner.tf_1).maxChars = 3;
MTextFieldUtil.clear_text(_owner, 'tf_1');
_slider1.dispatchEvent(new CBumEvent(CBumSlider.ET_UPDATE));
SimpleButton(_owner.bt_1).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		var t_v:Number = Number(MTextFieldUtil.get_text(_owner, 'tf_1'));
		_slider1.set_ratio(t_v);
	}
);


function p_slider2_handler(evt:CBumEvent):void
{
	MDebugTool.test(evt.type);
	if (evt.type == CBumSlider.ET_UPDATE)
	{
		MTextFieldUtil.set_text(_owner, 'tf_2', _slider2.get_ratio().toString());
	}
}
var _slider2:CBumSlider = new CBumSlider(_owner.slc_2,
	CBumSlider.TYPE_HORIZONTAL);
_slider2.addEventListener(CBumSlider.ET_MOUSE_UP, p_slider2_handler);
_slider2.addEventListener(CBumSlider.ET_MOUSE_DOWN, p_slider2_handler);
_slider2.addEventListener(CBumSlider.ET_UPDATE, p_slider2_handler);
TextField(_owner.tf_2).restrict = '0-9.';
TextField(_owner.tf_2).maxChars = 3;
MTextFieldUtil.clear_text(_owner, 'tf_2');
_slider2.dispatchEvent(new CBumEvent(CBumSlider.ET_UPDATE));
SimpleButton(_owner.bt_2).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		var t_v:Number = Number(MTextFieldUtil.get_text(_owner, 'tf_2'));
		_slider2.set_ratio(t_v);
	}
);



SimpleButton(_owner.bt_4).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_slider1.set_enabled(!_slider1.get_enabled());
		_slider2.set_enabled(!_slider2.get_enabled());
	}
);