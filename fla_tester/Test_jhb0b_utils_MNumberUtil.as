import jhb0b.tools.MDebugTool;
import jhb0b.utils.MNumberUtil;


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

MDebugTool.test('MNumberUtil.is_oddEven');
MDebugTool.test('778: ' + MNumberUtil.is_oddEven(778).toString());
MDebugTool.test('333: ' + MNumberUtil.is_oddEven(333).toString());
MDebugTool.test('');
MDebugTool.test('');

