import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.text.TextField;
import jhb0b.events.CBumEvent;
import jhb0b.frame.CFrameTimer;
import jhb0b.utils.MTextFieldUtil;



var _owner:MovieClip = this;
MTextFieldUtil.clear_text(_owner, 'tf_1');
MTextFieldUtil.clear_text(_owner, 'tf_2');

function p_ftimer_handler(evt:CBumEvent):void
{
	var t_str:String;
	if (evt.type == CFrameTimer.ET_UPDATE)
	{
		t_str = evt.type + ': ' +
			_ftimer.get_currentCount().toString() + '/' +
			_ftimer.get_repeatCount().toString();
		MTextFieldUtil.append_text(_owner, 'tf_1', t_str, true, true);
	}
	else
	if (evt.type == CFrameTimer.ET_END)
	{
		t_str = evt.type;
		MTextFieldUtil.append_text(_owner, 'tf_1', t_str, true, true);
	}
}
var _ftimer:CFrameTimer = new CFrameTimer(10, 10);
_ftimer.addEventListener(CFrameTimer.ET_UPDATE, p_ftimer_handler);
_ftimer.addEventListener(CFrameTimer.ET_END, p_ftimer_handler);



TextField(_owner.tf_3).restrict = '0-9';
TextField(_owner.tf_3).maxChars = 3;
TextField(_owner.tf_4).restrict = '0-9';
TextField(_owner.tf_4).maxChars = 3;
MTextFieldUtil.set_text(_owner, 'tf_3', String(10));
MTextFieldUtil.set_text(_owner, 'tf_4', String(10));
SimpleButton(_owner.bt_1).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_ftimer.start();
		MTextFieldUtil.append_text(_owner, 'tf_2', '_ftimer.start();', true, true);
	}
);
SimpleButton(_owner.bt_2).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_ftimer.stop();
		MTextFieldUtil.append_text(_owner, 'tf_2', '_ftimer.stop();', true, true);
	}
);
SimpleButton(_owner.bt_3).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_ftimer.reset();
		MTextFieldUtil.append_text(_owner, 'tf_2', '_ftimer.reset();', true, true);
	}
);
SimpleButton(_owner.bt_7).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_ftimer.set_delayFrame(int(MTextFieldUtil.get_text(_owner, 'tf_3')));
		_ftimer.set_repeatCount(int(MTextFieldUtil.get_text(_owner, 'tf_4')));
		MTextFieldUtil.append_text(_owner, 'tf_2', '_ftimer.set_delayFrame', true, true);
		MTextFieldUtil.append_text(_owner, 'tf_2', '_ftimer.set_repeatCount', true, true);
	}
);


