import flash.display.MovieClip;
import flash.utils.Dictionary;
import flash.text.TextField;
import hbx.core.CEventCore;
import hbx.found.CBumButton;
import hbx.found.CBumCheckList;
import hbx.tools.MDebugTool;
import hbx.utils.MTextFieldUtil;




var _thm:MovieClip = this;
var _dic:Dictionary = new Dictionary();
var _dic2:Dictionary = new Dictionary();


function pp_allHandler(evt:CEventCore):void
{
	MDebugTool.test(evt.type);
	var bcl:CBumCheckList = CBumCheckList(evt.currentTarget);
	if (evt.type == CBumCheckList.ET_CHANGE)
	{
		var tfn:String = _dic[bcl];
		if (tfn != null)
			MTextFieldUtil.set_text(_thm, tfn, bcl.get_selectedIndex().toString());
			
		var bcl2:CBumCheckList = _dic2[bcl];
		if (bcl2 != null) {
			if (bcl.get_selectedIndex() > -1)
				bcl2.set_selectedIndex(bcl.get_selectedIndex());
			else
				bcl2.unselect();
		}
	}
}


var _bcl1:CBumCheckList;/*
_bcl1 = new CBumCheckList([
	_thm.check_0,
	_thm.check_1,
	_thm.check_2,
	_thm.check_3,
	_thm.check_4,
	_thm.check_5], 
	['#_0', '#_1', '#_2', '#_3', '#_4', '#_5']);*/
_bcl1 = CBumCheckList.contLoop(_thm, 'check_', ['#_0', '#_1', '#_2', '#_3', '#_4', '#_5']);	
_bcl1.addEventListener(CBumCheckList.ET_CLICK, pp_allHandler);
_bcl1.addEventListener(CBumCheckList.ET_CHANGE, pp_allHandler);
_dic[_bcl1] = TextField(_thm.tf_1).name;
_bcl1.set_selectedIndexDispatch(0);

var _bcl2:CBumCheckList;
_bcl2 = new CBumCheckList([
	_thm.check2Target_0,
	_thm.check2Target_1,
	_thm.check2Target_2,
	_thm.check2Target_3,
	_thm.check2Target_4], 
	['#_0', '#_1', '#_2', '#_3', '#_4', '#_5']);
_bcl2.set_isToggleMode(true);
_bcl2.addEventListener(CBumCheckList.ET_CLICK, pp_allHandler);
_bcl2.addEventListener(CBumCheckList.ET_CHANGE, pp_allHandler);
_dic[_bcl2] = TextField(_thm.tf_2).name;
var _bcl3:CBumCheckList;
_bcl3 = new CBumCheckList([
	_thm.check3_0,
	_thm.check3_1,
	_thm.check3_2,
	_thm.check3_3,
	_thm.check3_4], 
	['#_0', '#_1', '#_2', '#_3', '#_4', '#_5']);
_bcl3.set_enabled(false);
_bcl3.set_isToggleMode(true);
_dic2[_bcl2] = _bcl3;
_bcl2.set_selectedIndexDispatch(4);

