import flash.display.MovieClip;
import hbx.tools.MDebugTool;
import hbx.utils.MTextFieldUtil;



var _thm:MovieClip = this;

MTextFieldUtil.clear_text(_thm, 'tf_1');

MTextFieldUtil.set_text(_thm, 'tf_1', 'Adobe Flash Player');
MTextFieldUtil.append_text(_thm, 'tf_2', ' aaaa');
MTextFieldUtil.cutting_last(_thm.tf_3, 'Microsoft Windows 10', 300);

MDebugTool.test(MTextFieldUtil.get_text(_thm, 'tf_3'));
