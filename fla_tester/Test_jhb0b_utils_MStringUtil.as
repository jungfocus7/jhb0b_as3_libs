import jhb0b.utils.MStringUtil;


trace('# MStringUtil.is_empty');
var t_str:String;
trace(MStringUtil.is_empty(t_str));
trace(MStringUtil.is_empty(null));
trace(MStringUtil.is_empty(undefined));
trace(MStringUtil.is_empty(''));
trace(MStringUtil.is_empty(' '));
trace(MStringUtil.is_empty('	'));
trace('');
trace('');

trace('# MStringUtil.clear_whiteSpace');
var t_str2:String = '		clear_whiteSpace		';
trace(MStringUtil.clear_whiteSpace(t_str2, 'b'));
trace(MStringUtil.clear_whiteSpace(t_str2, 'e'));
trace(MStringUtil.clear_whiteSpace(t_str2));
trace('');
trace('');

trace('# MStringUtil.add_token');
trace(MStringUtil.add_token('3', 3));
trace('');
trace('');

trace('# MStringUtil.rmfill');
trace(MStringUtil.rmfill('3', '00'));
trace(MStringUtil.rmfill('170', '0000'));
trace(MStringUtil.rmfill('1', '???'));
trace('');
trace('');

trace('# MStringUtil.replace');
trace(MStringUtil.replace('Microsoft Windows 10 Home Edition', 'Home Edition', 'Professional Edition'));
trace('');
trace('');

trace('# MStringUtil.get_lastNum');
trace(MStringUtil.get_lastNum('mc_1', '_'));
trace(MStringUtil.get_lastNum('bum-445', '-'));
trace(MStringUtil.get_lastNum2('mc_1_2_3', 0));
trace(MStringUtil.get_lastNum2('mc_1_2_3', 1));
trace(MStringUtil.get_lastNum2('mc_1_2_3', 2));
trace('');
trace('');

trace('# MStringUtil.get_thisUrl');
trace(MStringUtil.get_thisUrl(this.loaderInfo.url));
trace(MStringUtil.get_thisName(MStringUtil.get_thisUrl(this.loaderInfo.url)));
trace(MStringUtil.get_baseUrl(MStringUtil.get_thisUrl(this.loaderInfo.url)));
trace('');
trace('');











/*
function makeFill(tstr:String, astr:String):String
{	
	var t_la:uint = tstr.length;
	var t_lb:uint = astr.length;
	if (t_la < t_lb)
	{
		var t_l:uint = t_lb - t_la;
		var t_nstr:String = astr.substr(0, t_l) + tstr;
		return t_nstr;
	}
	else
	{
		return tstr;
	}
}
*/

//xxx('5589', '9123000^0000');
//trace(xxx('7777', '0000'));

//trace(100['toFixed']);
//xxx(String(9982), '9123000^0000');
//var a:String = uint(100).toString();
//trace(a.toString());
//trace(100.toString());
/*
//trace(add_token('4', 3));
var t_a:uint = 100;
var t_b:uint = 1000;
var t_c:int = t_a - t_a - 1;
trace(t_a - t_b);
trace(t_c);
trace(uint.MAX_VALUE);*/