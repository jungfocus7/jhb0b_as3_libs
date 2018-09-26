import flash.display.DisplayObject;
import flash.display.SimpleButton;
import flash.display.MovieClip;
import flash.events.MouseEvent;
import jhb0b.utils.MDisplayObjectContainerUtil;






var _owner:MovieClip = this;


	
SimpleButton(_owner.bt_1).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void {
		//컨테이너 룹핑
		MDisplayObjectContainerUtil.contLoop(_owner,
			function(tcdo:DisplayObject, ti:int):void {
				trace(this, tcdo.name, ti);
			}, null, _owner);
	});

SimpleButton(_owner.bt_2).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void {
		//컨테이너 룹핑 (정규식)
		MDisplayObjectContainerUtil.contLoop_reg(_owner, /^mc_/,
			function(tcdo:DisplayObject, ti:int):void {
				trace(this, tcdo.name, ti);
			}, null, _owner);
	});
	
SimpleButton(_owner.bt_3).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void {
		//컨테이너 룹핑 (문자열 접두사)
		MDisplayObjectContainerUtil.contLoop_io(_owner, 'tf_',
			function(tcdo:DisplayObject, ti:int):void {
				trace(this, tcdo.name, ti);
			}, null, _owner);		
	});
	
SimpleButton(_owner.bt_4).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void {
		//컨테이너 비우면서 콜백함수 실행
		MDisplayObjectContainerUtil.contLoop_clear(_owner, false,
			function(tcdo:DisplayObject):void {
				trace(this, tcdo.name);
			}, null, _owner);
		
	});





















//import flash.display.DisplayObject;
//import flash.display.MovieClip;

/*
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.text.TextField;
import jhb0b.utils.MDisplayObjectContainerUtil;


var _owner:MovieClip = this;


MDisplayObjectContainerUtil.contLoop(_owner, 'mc_',
	function(cdo:DisplayObject, idx:int, na:int, nb:int):void
	{
		var t_mc:MovieClip = cdo as MovieClip;
		if (t_mc != null)
		{
			t_mc.mouseChildren = false;
			t_mc.buttonMode = true;
			trace(na, nb);
		}
	},
	[1, 2]
);

MDisplayObjectContainerUtil.contLoop_b(_owner, 'bt_',
	function(cdo:DisplayObject, idx:int, na:int, nb:int):Boolean
	{
		var t_bt:SimpleButton = cdo as SimpleButton;
		if (t_bt != null)
		{
			t_bt.mouseEnabled = false;
			t_bt.alpha = .6;
			trace(na, nb);
		}
		
		return false;
	},
	[1, 2]
);

MDisplayObjectContainerUtil.contLoop_ba(_owner,
	function(cdo:DisplayObject, idx:int, na:int, nb:int):Boolean
	{
		var t_nm:String = cdo.name;
		if (t_nm.indexOf('tf_') > -1)
		{
			var t_tf:TextField = TextField(cdo);
			if (t_tf != null)
			{
				t_tf.text = 'yy';
			}
		}
		else
		if (t_nm == 'bt_1')
		{
			var t_bt:SimpleButton = cdo as SimpleButton;
			if (t_bt != null)
			{
				t_bt.mouseEnabled = true;
				t_bt.alpha = 1;
			}
		}
		
		return false;
	},
	[1, 2]
);
*/


//function contLoop(
//				tcont:DisplayObjectContainer,	// Loop DisplayObjectContainer
//				tlf:Function,					// Loop Function
//				tlfpa:Array = null,				// Loop Function Parameter Array
//				tlfs:Object = null):void		// Loop Function Scope
//{
//	for (var tl:int = tcont.numChildren, ti:int = 0; ti < tl; ti++)
//	{
//		var tcdo:DisplayObject = tcont.getChildAt(ti);
//		if (tlfpa != null) {
//			if (tlf.apply(tlfs, [tcdo, ti].concat(tlfpa)))
//				break;
//		}
//		else {
//			if (tlf.apply(tlfs, [tcdo, ti]))
//				break;
//		}
//	}
//}
//function contLoop_reg(
//				tcont:DisplayObjectContainer,	// Loop DisplayObjectContainer
//				treg:RegExp,					// Search Regular Express
//				tlf:Function,					// Loop Function
//				tlfpa:Array = null,				// Loop Function Parameter Array
//				tlfs:Object = null):void		// Loop Function Scope
//{
//	for (var tl:int = tcont.numChildren, ti:int = 0; ti < tl; ti++)
//	{
//		var tcdo:DisplayObject = tcont.getChildAt(ti);
//		if (treg.test(tcdo.name)) {
//			if (tlfpa != null) {
//				if (tlf.apply(tlfs, [tcdo, ti].concat(tlfpa)))
//					break;
//			}
//			else {
//				if (tlf.apply(tlfs, [tcdo, ti]))
//					break;
//			}
//		}
//	}
//}
//function contLoop_io(
//				tcont:DisplayObjectContainer,	// Loop DisplayObjectContainer
//				tsprf:String,					// Search prefix
//				tlf:Function,					// Loop Function
//				tlfpa:Array = null,				// Loop Function Parameter Array
//				tlfs:Object = null):void		// Loop Function Scope
//{
//	for (var tl:int = tcont.numChildren, ti:int = 0; ti < tl; ti++)
//	{
//		var tcdo:DisplayObject = tcont.getChildAt(ti);		
//		if (tcdo.name.indexOf(tsprf) > -1) {
//			if (tlfpa != null) {
//				if (tlf.apply(tlfs, [tcdo, ti].concat(tlfpa)))
//					break;
//			}
//			else {
//				if (tlf.apply(tlfs, [tcdo, ti]))
//					break;
//			}
//		}
//	}
//}
//
//
//var _owner:MovieClip = this;


//contLoop(_owner,
//	function(tdo:DisplayObject, ti:int):Boolean {
//		//trace(arguments, this);
//		var tmc:MovieClip = tdo as MovieClip;
//		if (tmc != null) {
//			trace(tmc, tmc.name);
//		}
//		return false;
//	}, null, _owner);
//contLoop_reg(_owner, /^tf_/,
//	function(tdo:DisplayObject, ti:int):Boolean {
//		trace(arguments, this);
//		return false;
//	}, [1, 2, 3, 4], _owner);
//contLoop_io(_owner, 'mc_',
//	function(tdo:DisplayObject, ti:int, tn1:int, tn2:int, tn3:int, tn4:int):Boolean {
//		trace(tdo.name, ti, tn1, tn2, tn3, tn4, this);
//		return false;
//	}, [1, 2, 3, 4], _owner);








