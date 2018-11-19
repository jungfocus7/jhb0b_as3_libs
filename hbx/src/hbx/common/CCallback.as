package hbx.common
{
    public class CCallback
    {
        public function CCallback(func:Function, funcParams:Array = null, funcScope:Object = null)
        {
            _func = func;
            _funcParams = funcParams;
            _funcScope = funcScope;
        }

        private var _func:Function;
        public function get_func():Function
        {
            return _func;
        }

        private var _funcParams:Array;
        public function get_funcArgs():Array
        {
            return _funcParams;
        }

        private var _funcScope:Object;
        public function get_funcScope():Object
        {
            return _funcScope;
        }


        public function invoke(params:Array):Boolean
        {
            var args:Array;
            if (params != null)
                if (_funcParams != null)
                    args = params.concat(_funcParams);
                else
                    args = params;
            else
                args = _funcParams;

            var rv:Boolean = _func.apply(_funcScope, args);
            return rv;
        }

    }
}