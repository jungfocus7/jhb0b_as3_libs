import flash.display.MovieClip;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.MouseEvent;
import jhb0b.tools.MGeomTool;


var _owner:MovieClip = this;


_owner.stage.align = StageAlign.TOP_LEFT;
_owner.stage.scaleMode = StageScaleMode.NO_SCALE;

var _mc_img:MovieClip = _owner.mc_img;
var _mc_fitArea:MovieClip = _owner.mc_fitArea;
var _targetRect:Object =
{
	x: 		_mc_img.x,
	y: 		_mc_img.y,
	width: 	_mc_img.width,
	height: _mc_img.height
};

MovieClip(_owner.mc_guide).width = _mc_img.width;
MovieClip(_owner.mc_guide).height = _mc_img.height;


function p_resize(evt:MouseEvent):void
{
	var t_rp:Number = _owner.mouseX - 10;
	var t_dp:Number = _owner.mouseY - 10;
	_mc_fitArea.width = t_rp;
	_mc_fitArea.height = t_dp;

	var t_fitSize:Object =
	{
		x: _mc_fitArea.x,
		y: _mc_fitArea.y,
		width: _mc_fitArea.width,
		height: _mc_fitArea.height
	};

	var t_size:Object =
		MGeomTool.get_fitAreaSize(t_fitSize, _targetRect);
	_mc_img.x = t_size.x;
	_mc_img.y = t_size.y;
	_mc_img.width = t_size.width;
	_mc_img.height = t_size.height;

	if (evt != null)
		evt.updateAfterEvent();
}
_owner.stage.addEventListener(MouseEvent.MOUSE_MOVE, p_resize);























/*
import flash.display.MovieClip;
import flash.events.MouseEvent;
import hb.utils.GeomExUtil;


// :: 리사이즈 핸들러
var p_stage_resize:Function = function(event:MouseEvent):void
{

	if (event.type == MouseEvent.MOUSE_MOVE)
	{
		if (event != null)
		{
			var t_rp:Number = owner.mouseX - 10;
			var t_dp:Number = owner.mouseY - 10;
			owner.fitArea_mc.width = t_rp;
			owner.fitArea_mc.height = t_dp;
			trace(owner.mouseX);
		}
	}

	var t_fitSize:Object =
	{
		x: owner.fitArea_mc.x,
		y: owner.fitArea_mc.y,
		width: owner.fitArea_mc.width,
		height: owner.fitArea_mc.height
	};

	var t_size:Object =
		GeomExUtil.get_fitAreaSize(t_fitSize, owner.m_targetRect);


	owner.target_mc.x = t_size.x;
	owner.target_mc.y = t_size.y;
	owner.target_mc.width = t_size.width;
	owner.target_mc.height = t_size.height;

	if (event != null)
		event.updateAfterEvent();
};

// :: 초기화
var p_init:Function = function():void
{
	this.stage.align = StageAlign.TOP_LEFT;
	this.stage.scaleMode = StageScaleMode.NO_SCALE;

	this.m_targetRect =
	{
		x: this.target_mc.x,
		y: this.target_mc.y,
		width: this.target_mc.width,
		height: this.target_mc.height
	};
	this.guide_mc.width = this.target_mc.width;
	this.guide_mc.height = this.target_mc.height;

	this.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.p_stage_resize);
	//this.stage.addEventListener(MouseEvent.MOUSE_DOWN, this.p_stage_resize);
	//this.p_stage_resize(null);
};

var owner:MovieClip = this;
var m_targetRect:Object = null;


this.p_init();
*/