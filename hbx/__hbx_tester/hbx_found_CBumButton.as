import flash.display.MovieClip;
import flash.utils.Dictionary;
import hbx.core.CEventCore;
import hbx.tools.MDebugTool;
import hbx.found.CBumButton;


var _thm:MovieClip = this;
var _dic:Dictionary = new Dictionary();


function pp_allHandler(evt:CEventCore):void
{
	MDebugTool.test(evt.type);
	var bbtn:CBumButton = CBumButton(evt.currentTarget);
	var mchk:MovieClip = _dic[bbtn];
	if (mchk != null)
		mchk.gotoAndStop(bbtn.get_mvc().currentFrameLabel);
}


var _bbtn1:CBumButton;
_bbtn1 = new CBumButton(_thm.rect_1, ['#_0', '#_1', '#_2', '#_3', '#_4', '#_5']);
_bbtn1.addEventListener(CBumButton.ET_CLICK, pp_allHandler);
_bbtn1.addEventListener(CBumButton.ET_ROLL_OUT, pp_allHandler);
_bbtn1.addEventListener(CBumButton.ET_ROLL_OVER, pp_allHandler);
_bbtn1.addEventListener(CBumButton.ET_MOUSE_UP, pp_allHandler);
_bbtn1.addEventListener(CBumButton.ET_MOUSE_DOWN, pp_allHandler);
_dic[_bbtn1] = _thm.check_1;

var _bbtn2:CBumButton;
_bbtn2 = new CBumButton(_thm.rect_2, ['#_0', '#_1', '#_2', '#_3', '#_4', '#_5'], true);
_bbtn2.addEventListener(CBumButton.ET_CLICK, pp_allHandler);
_bbtn2.addEventListener(CBumButton.ET_ROLL_OUT, pp_allHandler);
_bbtn2.addEventListener(CBumButton.ET_ROLL_OVER, pp_allHandler);
_bbtn2.addEventListener(CBumButton.ET_MOUSE_UP, pp_allHandler);
_bbtn2.addEventListener(CBumButton.ET_MOUSE_DOWN, pp_allHandler);
_dic[_bbtn2] = _thm.check_2;

var _bbtn3:CBumButton;
_bbtn3 = new CBumButton(_thm.check_3, ['#_0', '#_1', '#_2', '#_3', '#_4', '#_5'], true);
_bbtn3.addEventListener(CBumButton.ET_CLICK, pp_allHandler);
_bbtn3.addEventListener(CBumButton.ET_ROLL_OUT, pp_allHandler);
_bbtn3.addEventListener(CBumButton.ET_ROLL_OVER, pp_allHandler);
_bbtn3.addEventListener(CBumButton.ET_MOUSE_UP, pp_allHandler);
_bbtn3.addEventListener(CBumButton.ET_MOUSE_DOWN, pp_allHandler);
_dic[_bbtn3] = _thm.rect_3;


var _bbtn4:CBumButton;
_bbtn4 = new CBumButton(_thm.bl_1_1);
_bbtn4 = new CBumButton(_thm.bl_1_2, null, true);

trace(_thm.rect_1);






