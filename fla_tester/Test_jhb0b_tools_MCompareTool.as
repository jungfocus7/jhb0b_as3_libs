import jhb0b.tools.MCompareTool;
import jhb0b.tools.MDebugTool;


MDebugTool.test(MCompareTool.compare_int(1, 1).toString());
MDebugTool.test(MCompareTool.compare_int(100, 200).toString());
MDebugTool.test(MCompareTool.compare_int(200, 100).toString());

MDebugTool.test(MCompareTool.compare_uint(1, 1).toString());
MDebugTool.test(MCompareTool.compare_uint(100, 200).toString());
MDebugTool.test(MCompareTool.compare_uint(200, 100).toString());

MDebugTool.test(MCompareTool.compare_Number(1, 1).toString());
MDebugTool.test(MCompareTool.compare_Number(100, 200).toString());
MDebugTool.test(MCompareTool.compare_Number(200, 100).toString());

MDebugTool.test(MCompareTool.equals_Object(1, 1).toString());
