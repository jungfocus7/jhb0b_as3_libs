import jhb0b.useful.CCountTask;
import jhb0b.utils.MStringUtil;
import jhb0b.tools.MDebugTool;


var _ct:CCountTask = new CCountTask(0, 10, 1);
while (!_ct.is_last())
{
	MDebugTool.test('Count: ' + MStringUtil.rmfill(_ct.get_count().toString(), '00') + ' / ' +
					'CountEnd: ' + _ct.get_countEnd());
}