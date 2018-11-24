import hbx.tools.MDebugTool;
import hbx.utils.MNumberUtil;



MDebugTool.test('MNumberUtil.is_float');
MDebugTool.test('10.2: ' + MNumberUtil.is_float(10.2).toString());
MDebugTool.test('10: ' + MNumberUtil.is_float(10).toString());
MDebugTool.test('');
MDebugTool.test('');

MDebugTool.test('MNumberUtil.is_minus');
MDebugTool.test('100: ' + MNumberUtil.is_minus(100).toString());
MDebugTool.test('-500: ' + MNumberUtil.is_minus(-500).toString());
MDebugTool.test('');
MDebugTool.test('');

MDebugTool.test('MNumberUtil.random');
MDebugTool.test('100: ' + MNumberUtil.random(100).toString());
MDebugTool.test('5: ' + MNumberUtil.random(5).toString());
MDebugTool.test('');
MDebugTool.test('');

MDebugTool.test('MNumberUtil.randRange');
MDebugTool.test('1, 2: ' + MNumberUtil.randRange(1, 2).toString());
MDebugTool.test('500, 600: ' + MNumberUtil.randRange(500, 600).toString());
MDebugTool.test('');
MDebugTool.test('');

MDebugTool.test('MNumberUtil.is_odd');
MDebugTool.test('778: ' + MNumberUtil.is_odd(778).toString());
MDebugTool.test('333: ' + MNumberUtil.is_odd(333).toString());
MDebugTool.test('');
MDebugTool.test('');

MDebugTool.test('MNumberUtil.is_even');
MDebugTool.test('241: ' + MNumberUtil.is_even(241).toString());
MDebugTool.test('586: ' + MNumberUtil.is_even(586).toString());
MDebugTool.test('');
MDebugTool.test('');

