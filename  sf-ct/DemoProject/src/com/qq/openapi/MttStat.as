package com.qq.openapi
{
    import com.qq.openapi.MttService;
    import com.qq.protocol.ProtocolHelper;
    import flash.utils.ByteArray;

    /**
     *  闪游地带开发平台数据统计接口。
     *
     *  @author Tencent
     */
    public class MttStat
    {
        public static function report(info:String, callback:Function):void
        {
            MttService.sapi(MttService.APPID_STAT, ProtocolHelper.StatReportEncode(info), onLoadFinish);

            function onLoadFinish(scode:int, data:ByteArray):void
            {
                ReportLoadFinish(scode, data, callback);
            }
        }

        private static function ReportLoadFinish(scode:int, data:ByteArray, callback:Function):void
        {
            if (scode != 0)
            {
                callback && callback.call(null, {code:scode, desc:""});
                return ;
            }

            callback && callback.call(null, ProtocolHelper.StatReportDecode(data));
        }
    }
}
