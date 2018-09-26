import flash.display.MovieClip;
import jhb0b.tools.MDebugTool;
import jhb0b.utils.MTextFieldUtil;



var _owner:MovieClip = this;

MTextFieldUtil.set_text(_owner, 'tf_1', 'Adobe Flash Player');
MTextFieldUtil.append_text(_owner, 'tf_2', ' aaaa');
MTextFieldUtil.cutting_last(_owner.tf_3, 'Microsoft Windows 10', 300);

MDebugTool.test(MTextFieldUtil.get_text(_owner, 'tf_3'));