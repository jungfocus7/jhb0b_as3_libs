import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.text.TextField;
import jhb0b.events.CBumEvent;
import jhb0b.frame.CFrameHelper;
import jhb0b.utils.MTextFieldUtil;


var _owner:MovieClip = this;
var _fhelp:CFrameHelper = new CFrameHelper(_owner.mc_ani);
_fhelp.addEventListener(CFrameHelper.ET_END,
	function(evt:CBumEvent):void
	{
		MTextFieldUtil.append_text(_owner, 'tf_1', evt.type, true, true);
	}
);
_fhelp.addEventListener(CFrameHelper.ET_UPDATE,
	function(evt:CBumEvent):void
	{
		var t_ani:MovieClip = _fhelp.get_owner();
		MTextFieldUtil.set_text(t_ani, 'tf_1', _fhelp.get_currentFrame().toString());
		MTextFieldUtil.set_text(t_ani, 'tf_2', String(_fhelp.get_currentFrameLabel()));

		MTextFieldUtil.append_text(_owner, 'tf_1', evt.type, true, true);
	}
);
_fhelp.dispatchEvent(new CBumEvent(CFrameHelper.ET_UPDATE));


MTextFieldUtil.clear_text(_owner, 'tf_1');

MTextFieldUtil.clear_text(_owner, 'tfa_1');
MTextFieldUtil.clear_text(_owner, 'tfa_2');
MTextFieldUtil.clear_text(_owner, 'tfa_4_1');
MTextFieldUtil.clear_text(_owner, 'tfa_4_2');
MTextFieldUtil.clear_text(_owner, 'tfa_5_1');
MTextFieldUtil.clear_text(_owner, 'tfa_5_2');
MTextFieldUtil.clear_text(_owner, 'tfa_6');
MTextFieldUtil.clear_text(_owner, 'tfa_7');

MTextFieldUtil.set_text(_owner, 'tfa_1', '125');
MTextFieldUtil.set_text(_owner, 'tfa_2', '#07');
MTextFieldUtil.set_text(_owner, 'tfa_4_1', '60');
MTextFieldUtil.set_text(_owner, 'tfa_4_2', '120');
MTextFieldUtil.set_text(_owner, 'tfa_5_1', '#08');
MTextFieldUtil.set_text(_owner, 'tfa_5_2', '#11');
MTextFieldUtil.set_text(_owner, 'tfa_6', '196');
MTextFieldUtil.set_text(_owner, 'tfa_7', '#06');


SimpleButton(_owner.bt_1).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		var t_ef:int = int(MTextFieldUtil.get_text(_owner, 'tfa_1'));
		_fhelp.gotoStop(t_ef);
		_fhelp.dispatchEvent(new CBumEvent(CFrameHelper.ET_UPDATE));
	}
);
SimpleButton(_owner.bt_2).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		var t_efl:String = MTextFieldUtil.get_text(_owner, 'tfa_2');
		_fhelp.gotoStopLabel(t_efl);
		_fhelp.dispatchEvent(new CBumEvent(CFrameHelper.ET_UPDATE));
	}
);


SimpleButton(_owner.bt_3).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_fhelp.playStop();
	}
);
SimpleButton(_owner.bt_4).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		var t_bf:int = int(MTextFieldUtil.get_text(_owner, 'tfa_4_1'));
		var t_ef:int = int(MTextFieldUtil.get_text(_owner, 'tfa_4_2'));
		_fhelp.playGotoEnd(t_bf, t_ef);
	}
);
SimpleButton(_owner.bt_5).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		var t_bfl:String = MTextFieldUtil.get_text(_owner, 'tfa_5_1');
		var t_efl:String = MTextFieldUtil.get_text(_owner, 'tfa_5_2');
		_fhelp.playGotoEndLabel(t_bfl, t_efl);
	}
);
SimpleButton(_owner.bt_6).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		var t_ef:int = int(MTextFieldUtil.get_text(_owner, 'tfa_6'));
		_fhelp.playEnd(t_ef);
	}
);/*
SimpleButton(_owner.bt_7).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		var t_efl:String = MTextFieldUtil.get_text(_owner, 'tfa_7');
		_fhelp.playEndLabel(t_efl);
	}
);*/
SimpleButton(_owner.bt_8).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		_fhelp.play();
	}
);









/*
_fhelp.gotoStop();
_fhelp.gotoStopLabel();
_fhelp.playStop();
_fhelp.playGotoEnd();
_fhelp.playGotoEndLabel();
_fhelp.playEnd();
_fhelp.play();*/
