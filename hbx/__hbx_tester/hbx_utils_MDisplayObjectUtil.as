import flash.display.Bitmap;
import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import hbx.utils.MDisplayObjectUtil;
import hbx.utils.MTextFieldUtil;
import hbx.common.CCallback;





var _thm:MovieClip = this;



var bmp:Bitmap = MDisplayObjectUtil.get_thumbBitmap(_thm);
bmp.scaleX = 
bmp.scaleY = 0.2;
bmp.x = 420;
bmp.y = 300;
bmp.filters = [new DropShadowFilter()];
_thm.addChild(bmp);



_thm.scaleX = .2;
_thm.scaleY = .2;
_thm.rotation = 655;
MDisplayObjectUtil.reset(_thm);

MDisplayObjectUtil.set_color(_thm, 0xff0000);
MDisplayObjectUtil.clear_color(_thm);

MDisplayObjectUtil.set_color(_thm.mc_1, 0x776622);

MDisplayObjectUtil.set_color(_thm.bt_4, 0x998822);
//MDisplayObjectUtil.clear_color(_thm.bt_4);

MovieClip(_thm.bmc_1).gotoAndStop(1);
MovieClip(_thm.bmc_2).gotoAndStop(1);
MovieClip(_thm.bmc_3).gotoAndStop(1);
MDisplayObjectUtil.set_desat(_thm.bmc_1, true);
MDisplayObjectUtil.set_desat(_thm.bmc_2, true);
MDisplayObjectUtil.set_desat(_thm.bmc_3, true);
MDisplayObjectUtil.set_desat(_thm.bmc_3, false);




