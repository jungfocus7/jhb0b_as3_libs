import flash.display.MovieClip;
import flash.utils.Dictionary;
import flash.text.TextField;
import jhb0b.events.CBumEvent;
import jhb0b.tools.MDebugTool;
import jhb0b.utils.MTextFieldUtil;
import jhb0b.whats.CBumButton;
import jhb0b.whats.CBumCheckList;


var _owner:MovieClip = this;
var _dicRefer:Dictionary = new Dictionary();
var _dicRefer2:Dictionary = new Dictionary();


function p_allHandler(evt:CBumEvent):void
{
	MDebugTool.test(evt.type);
	var t_bcl:CBumCheckList = CBumCheckList(evt.currentTarget);
	if (evt.type == CBumCheckList.ET_CHANGE)
	{
		var t_tfn:String = _dicRefer[t_bcl];
		if (t_tfn != null)
			MTextFieldUtil.set_text(_owner, t_tfn, t_bcl.get_selectedIndex().toString());
			
		var t_bcl2:CBumCheckList = _dicRefer2[t_bcl];
		if (t_bcl2 != null) {
			if (t_bcl.get_selectedIndex() > -1)
				t_bcl2.set_selectedIndex(t_bcl.get_selectedIndex());
			else
				t_bcl2.unselect();
		}
	}
}


var _bcl1:CBumCheckList;/*
_bcl1 = new CBumCheckList([
	_owner.check_0,
	_owner.check_1,
	_owner.check_2,
	_owner.check_3,
	_owner.check_4,
	_owner.check_5], 
	['#_0', '#_1', '#_2', '#_3', '#_4', '#_5']);*/
_bcl1 = CBumCheckList.contLoop(_owner, 'check_', ['#_0', '#_1', '#_2', '#_3', '#_4', '#_5']);	
_bcl1.addEventListener(CBumCheckList.ET_CLICK, p_allHandler);
_bcl1.addEventListener(CBumCheckList.ET_CHANGE, p_allHandler);
_dicRefer[_bcl1] = TextField(_owner.tf_1).name;
_bcl1.set_selectedIndexDispatch(0);

var _bcl2:CBumCheckList;
_bcl2 = new CBumCheckList([
	_owner.check2Target_0,
	_owner.check2Target_1,
	_owner.check2Target_2,
	_owner.check2Target_3,
	_owner.check2Target_4], 
	['#_0', '#_1', '#_2', '#_3', '#_4', '#_5']);
_bcl2.set_isToggleMode(true);
_bcl2.addEventListener(CBumCheckList.ET_CLICK, p_allHandler);
_bcl2.addEventListener(CBumCheckList.ET_CHANGE, p_allHandler);
_dicRefer[_bcl2] = TextField(_owner.tf_2).name;
var _bcl3:CBumCheckList;
_bcl3 = new CBumCheckList([
	_owner.check3_0,
	_owner.check3_1,
	_owner.check3_2,
	_owner.check3_3,
	_owner.check3_4], 
	['#_0', '#_1', '#_2', '#_3', '#_4', '#_5']);
_bcl3.set_enabled(false);
_bcl3.set_isToggleMode(true);
_dicRefer2[_bcl2] = _bcl3;
_bcl2.set_selectedIndexDispatch(4);

