import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import hbx.common.CCallback;
import hbx.utils.MDisplayObjectContainerUtil;
import hbx.utils.MTextFieldUtil;



var _thm:MovieClip = this;


MTextFieldUtil.clear_text(_thm, 'tf_1');




SimpleButton(_thm.bt_1).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		MTextFieldUtil.clear_text(_thm, 'tf_1');
		MDisplayObjectContainerUtil.contLoop(_thm,
			new CCallback(function(dpo:DisplayObject, i:int, a:String, b:String, c:String):void
			{
				trace(this, dpo.name, i, a, b, c);				
				MTextFieldUtil.append_text(_thm, 'tf_1', dpo.name + ', ' + i, true, true);
			},
			['a', 'b', 'c'], _thm));
	});
	
SimpleButton(_thm.bt_2).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		MTextFieldUtil.clear_text(_thm, 'tf_1');
		MDisplayObjectContainerUtil.contLoop_io(_thm, 'mvc_',
			new CCallback(function(dpo:DisplayObject, i:int, a:String, b:String, c:String):void
			{
				trace(this, dpo.name, i, a, b, c);
				MTextFieldUtil.append_text(_thm, 'tf_1', dpo.name + ', ' + i, true, true);
			}, ['a', 'b', 'c'], _thm));
	});
SimpleButton(_thm.bt_3).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		MTextFieldUtil.clear_text(_thm, 'tf_1');
		MDisplayObjectContainerUtil.contLoop_reg(_thm, /^btn_/,
			new CCallback( function(dpo:DisplayObject, i:int, a:String, b:String, c:String):void
			{
				trace(this, dpo.name, i, a, b, c);
				MTextFieldUtil.append_text(_thm, 'tf_1', dpo.name + ', ' + i, true, true);
			}, ['a', 'b', 'c'], _thm));
	});
SimpleButton(_thm.bt_4).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		MTextFieldUtil.clear_text(_thm, 'tf_1');
		MDisplayObjectContainerUtil.contLoop_reg(_thm, /^txf_/,
			new CCallback( function(dpo:DisplayObject, i:int, a:String, b:String, c:String):void
			{
				trace(this, dpo.name, i, a, b, c);
				MTextFieldUtil.append_text(_thm, 'tf_1', dpo.name + ', ' + i, true, true);
			}, ['a', 'b', 'c'], _thm));
	});
	
	
	
	
SimpleButton(_thm.bt_5).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		MTextFieldUtil.clear_text(_thm, 'tf_1');
		var arr:Array = MDisplayObjectContainerUtil.get_childArr(
			_thm, MDisplayObjectContainerUtil.SORT_TYPE_NAME, true);
		for each (var dpo:DisplayObject in arr)
		{
			MTextFieldUtil.append_text(_thm, 'tf_1', dpo.name, true, true);
		}
	});
	
SimpleButton(_thm.bt_6).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		MTextFieldUtil.clear_text(_thm, 'tf_1');
		var arr:Array = MDisplayObjectContainerUtil.get_childArr_io(
			_thm, 'mvc_', MDisplayObjectContainerUtil.SORT_TYPE_Y, true);
		for each (var dpo:DisplayObject in arr)
		{
			MTextFieldUtil.append_text(_thm, 'tf_1', dpo.name, true, true);
		}
	});
	
SimpleButton(_thm.bt_7).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		MTextFieldUtil.clear_text(_thm, 'tf_1');
		var arr:Array = MDisplayObjectContainerUtil.get_childArr_reg(
			_thm, /^btn/, MDisplayObjectContainerUtil.SORT_TYPE_Y, true);
		for each (var dpo:DisplayObject in arr)
		{
			MTextFieldUtil.append_text(_thm, 'tf_1', dpo.name, true, true);
		}
	});
	
SimpleButton(_thm.bt_8).addEventListener(MouseEvent.CLICK,
	function(evt:MouseEvent):void
	{
		MTextFieldUtil.clear_text(_thm, 'tf_1');
		var arr:Array = MDisplayObjectContainerUtil.get_childArr_reg(
			_thm, /^txf/, MDisplayObjectContainerUtil.SORT_TYPE_Y, true);
		for each (var dpo:DisplayObject in arr)
		{
			MTextFieldUtil.append_text(_thm, 'tf_1', dpo.name, true, true);
		}
	});
	
	
	
	
	