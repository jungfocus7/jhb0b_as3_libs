package hbx.prepared
{

public final class MMakeFormat
{
    private static const _reg1:RegExp = /\{#([\s\S]+?)#\}/g;
    private static const _reg2:RegExp = /◀◐◑▶/g;

    private static const _xxwave:String = '{#HobisApp#}yyMMdd{#Work#}hhmmssfff';

    private static var _xxyyzz:String;
    private static var _strtm:String;
    private static var _arr1:Array;


    /**
     * 포맷을 만들어 주는 함수
     * @param xyz 포맷문자열
     */
    public static function make(xyz:String):String
    {
        if (xyz == null)
            _xxyyzz = _xxwave;
        else
            _xxyyzz = xyz;

        _strtm = _xxyyzz.replace(_reg1,
            function():String {
                if (_arr1 == null)
                    _arr1 = [];
                _arr1.push(arguments[1]);							
                return _reg2.source;
            });
        _strtm = MDateFormatter.get_format(_strtm);
        if (_arr1 != null)
        {
            var i:uint = 0;
            _strtm = _strtm.replace(_reg2,
                function():String {
                    return _arr1[i++];
                });							
            _arr1 = null;
        }

        var trv:String = _strtm;
        _xxyyzz = null;
        _strtm = null;
        _arr1 = null;
        return trv;
    }

}


}