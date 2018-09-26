import flash.display.MovieClip;
import flash.utils.Dictionary;
import jhb0b.events.CBumEvent;
import jhb0b.tools.MDebugTool;
import jhb0b.whats.CBumButton;


var _owner:MovieClip = this;
var _dicRefer:Dictionary = new Dictionary();


function p_allHandler(evt:CBumEvent):void
{
	MDebugTool.test(evt.type);
	var t_bbtn:CBumButton = CBumButton(evt.currentTarget);
	var t_mchk:MovieClip = _dicRefer[t_bbtn];
	if (t_mchk != null)
		t_mchk.gotoAndStop(t_bbtn.get_owner().currentFrameLabel);
}


var _bbtn1:CBumButton;
_bbtn1 = new CBumButton(_owner.rect_1, ['#_0', '#_1', '#_2', '#_3', '#_4', '#_5']);
_bbtn1.addEventListener(CBumButton.ET_CLICK, p_allHandler);
_bbtn1.addEventListener(CBumButton.ET_ROLL_OUT, p_allHandler);
_bbtn1.addEventListener(CBumButton.ET_ROLL_OVER, p_allHandler);
_bbtn1.addEventListener(CBumButton.ET_MOUSE_UP, p_allHandler);
_bbtn1.addEventListener(CBumButton.ET_MOUSE_DOWN, p_allHandler);
_dicRefer[_bbtn1] = _owner.check_1;

var _bbtn2:CBumButton;
_bbtn2 = new CBumButton(_owner.rect_2, ['#_0', '#_1', '#_2', '#_3', '#_4', '#_5'], true);
_bbtn2.addEventListener(CBumButton.ET_CLICK, p_allHandler);
_bbtn2.addEventListener(CBumButton.ET_ROLL_OUT, p_allHandler);
_bbtn2.addEventListener(CBumButton.ET_ROLL_OVER, p_allHandler);
_bbtn2.addEventListener(CBumButton.ET_MOUSE_UP, p_allHandler);
_bbtn2.addEventListener(CBumButton.ET_MOUSE_DOWN, p_allHandler);
_dicRefer[_bbtn2] = _owner.check_2;

var _bbtn3:CBumButton;
_bbtn3 = new CBumButton(_owner.check_3, ['#_0', '#_1', '#_2', '#_3', '#_4', '#_5'], true);
_bbtn3.addEventListener(CBumButton.ET_CLICK, p_allHandler);
_bbtn3.addEventListener(CBumButton.ET_ROLL_OUT, p_allHandler);
_bbtn3.addEventListener(CBumButton.ET_ROLL_OVER, p_allHandler);
_bbtn3.addEventListener(CBumButton.ET_MOUSE_UP, p_allHandler);
_bbtn3.addEventListener(CBumButton.ET_MOUSE_DOWN, p_allHandler);
_dicRefer[_bbtn3] = _owner.rect_3;


var _bbtn4:CBumButton;
_bbtn4 = new CBumButton(_owner.bl_1_1);
_bbtn4 = new CBumButton(_owner.bl_1_2, null, true);








