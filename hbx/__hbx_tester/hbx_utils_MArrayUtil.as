import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import hbx.utils.MArrayUtil;
import hbx.utils.MTextFieldUtil;
import hbx.common.CCallback;




var _thm:MovieClip = this;


trace('# MArrayUtil.is_empty');
var t_arr:Array = ['배열있음'];
trace(MArrayUtil.is_empty(t_arr));
trace(MArrayUtil.is_empty(null));
trace(MArrayUtil.is_empty(undefined));
trace(MArrayUtil.is_empty([]));
trace(MArrayUtil.is_empty(new Array()));
trace('');
trace('');


trace('# MArrayUtil.is_contains');
trace(MArrayUtil.is_contains([1, 2, 3, this], this));
trace(MArrayUtil.is_contains(['100', '200', this], String(200)));
trace('');
trace('');


trace('# MArrayUtil.is_equals1');
trace(MArrayUtil.is_equals1([1, 2, 3, this], [1, 2, 3, this]));
trace(MArrayUtil.is_equals1([this, '1', '2', '3'], ['1', '2', '3', this]));
trace('');
trace('');


trace('# MArrayUtil.is_equals2');
trace(MArrayUtil.is_equals2([this, '1', '2', '3'], ['1', '2', '3', this, 1]));
trace(MArrayUtil.is_equals2([1, 2, 3, this], [1, 2, this]));
trace('');
trace('');


trace('# MArrayUtil.get_totalLength');
trace(MArrayUtil.get_totalLength(['jhb0b', 1, 2, 3, 500, ['pook61', '79', 1004, [1, 2, 3]]]));
trace('');
trace('');


trace('# MArrayUtil.shuffle');
var t_arr2:Array = ['jhb0b', 1, 2, 3, 500, ['pook61', '79', 1004, [1, 2, 3]]];
trace(t_arr2);
MArrayUtil.shuffle(t_arr2);
trace(t_arr2);
trace('');
trace('');


trace('# MArrayUtil.copy');
trace(MArrayUtil.copy(['inof79', 'pook61', 'jhb0b']));
trace('');
trace('');


trace('# MArrayUtil.forEach');
MArrayUtil.forEach(
	['inof79', 'pook61', 'jhb0b'],
	new CCallback(
		function(eo:Object, i:uint):void
		{
			trace('eo: ' + eo);
			trace('i: ' + i);
		})
);
trace('');
trace('');


trace('# MArrayUtil.remove');
var t_arr3:Array = ['jhb0b', 1, 2, 3, 500, ['pook61', '79', 1004, [1, 2, 3]]];
trace(t_arr3);
MArrayUtil.remove(t_arr3, 'jhb0b');
trace(t_arr3);
MArrayUtil.remove(t_arr3, 3);
trace(t_arr3);
trace('');
trace('');


trace('# MArrayUtil.removeAt');
var t_arr4:Array = ['Hobis_1', 'Hobis_2', 'Hobis_3', 'Hobis_4', 'Hobis_5'];
trace(t_arr4);
MArrayUtil.removeAt(t_arr4, 3);
trace(t_arr4);
trace('');
trace('');


trace('# MArrayUtil.get_index');
var t_arr5:Array = ['Hobis_1', 'Hobis_2', 'Hobis_3', 'Hobis_4', 'Hobis_5'];
trace(MArrayUtil.get_index(t_arr5, 'Hobis_5'));
trace(MArrayUtil.get_index(t_arr5, 'NoElement'));
trace('');
trace('');


trace('# MArrayUtil.distinct');
var t_arr6:Array = ['Hobis_1', 'Hobis_2', 'Hobis_3', 'Hobis_4', 'Hobis_5', 'Hobis_3', 'Hobis_4'];
trace(MArrayUtil.distinct(t_arr6));
trace('');
trace('');







//MTextFieldUtil.clear_text(_thm, 'tf_1');
//SimpleButton(_thm.btn_1).addEventListener(MouseEvent.CLICK,
//	function(evt:MouseEvent):void
//	{
//		MTextFieldUtil.clear_text(_thm, 'tf_1');
//
//		
//		//
//		//~~~~~~~~
//		MTextFieldUtil.append_text(_thm, 'tf_1',
//			'is_empty([]) : ' + MArrayUtil.is_empty([]),
//			true, true);
//			
//		MTextFieldUtil.append_text(_thm, 'tf_1',
//			'is_empty(null) : ' + MArrayUtil.is_empty(null),
//			true, true);
//			
//			
//		//
//		//~~~~~~~~
//		MTextFieldUtil.append_text(_thm, 'tf_1',
//			'is_contains([1, 2, 3, 4], 3) : ' + MArrayUtil.is_contains([1, 2, 3, 4], 3),
//			true, true);
//			
//		MTextFieldUtil.append_text(_thm, 'tf_1',
//			'is_contains([\'a\', \'b\', \'c\'], \'d\') : ' + MArrayUtil.is_contains(['a', 'b', 'c'], 'd'),
//			true, true);
//			
//		MTextFieldUtil.append_text(_thm, 'tf_1',
//			'is_equals1([\'apple\', \'orange\', \'mango\'], [\'apple\', \'orange\', \'mango\']) : ' + MArrayUtil.is_equals1(['apple', 'orange', 'mango'], ['apple', 'orange', 'mango']),
//			true, true);
//			
//		MTextFieldUtil.append_text(_thm, 'tf_1',
//			'is_equals1([\'apple\', \'orange\', \'mango\'], [\'apple\', \'orange\', \'mango\']) : ' +
//			MArrayUtil.is_equals2(
//				[1, 2, 3, 4]
//				['apple', 'orange', 'mango'],
//				['apple', 'orange', 'mango']),
//			true, true);
//			

//			
//			
//			
//			
//			
//			
//			
//	});