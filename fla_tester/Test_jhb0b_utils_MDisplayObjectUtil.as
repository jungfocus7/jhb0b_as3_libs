import flash.display.MovieClip;
import jhb0b.utils.MDisplayObjectUtil;


var _owner:MovieClip = this;

//this.addChild(MDisplayObjectUtil.get_thumbBitmap(_owner));

_owner.scaleX = .2;
_owner.scaleY = .2;
_owner.rotation = 655;
MDisplayObjectUtil.reset(_owner);

//MDisplayObjectUtil.set_color(_owner, 0xff0000);

MDisplayObjectUtil.set_color(_owner.mc_1, 0x776622);

MDisplayObjectUtil.set_color(_owner.bt_4, 0x998822);
//MDisplayObjectUtil.clear_color(_owner.bt_4);

MovieClip(_owner.bmc_1).gotoAndStop(1);
MovieClip(_owner.bmc_2).gotoAndStop(1);
MovieClip(_owner.bmc_3).gotoAndStop(1);
MDisplayObjectUtil.set_desat(_owner.bmc_1, true);
MDisplayObjectUtil.set_desat(_owner.bmc_2, true);
MDisplayObjectUtil.set_desat(_owner.bmc_3, true);
MDisplayObjectUtil.set_desat(_owner.bmc_3, false);