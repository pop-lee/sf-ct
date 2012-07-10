package com.qq.openapi
{
    import com.qq.openapi.MttService;
    import com.qq.protocol.ProtocolHelper;
    
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFormatAlign;
    import flash.utils.ByteArray;

    /**
     *  闪游地带开放平台提供用户信息函数。
     *
     *  <p>支持Flash游戏结束后的用户积分上传，以支持游戏积分排行榜、好友积分排行榜的运营。</p>
     *  @author Tencent
     *
     */
	public class MttUser 
	{
        /**
         *  查询当前用户的昵称。
         *  <p>本次请求成功或者失败，以参数形式传入的回调函数callback都将被调用。开发者可在该函数中判断调用结果，并取得当前玩家的昵称数据。</p> 
         *  @param callback 查询昵称的回调函数
         * 
         */
        public static function getUserNick(callback:Function):void
        {
            MttService.sapi(MttService.APPID_SCORE, ProtocolHelper.UserInfoEncode(), onLoadFinish);

            function onLoadFinish(scode:int, data:ByteArray):void
            {
                LoadFinish(scode, data, callback);  
            }
        }

        ///////////////////////////////////////////////////////////////////////////////////////////
        //  查询用户昵称的响应函数
        private static function LoadFinish(scode:int, data:ByteArray, callback:Function):void
        {
            if (scode != 0)
            {
                callback && callback.call(null, { code:scode, desc:"" } );
                return ;
            }
    
			callback && callback.call(null, ProtocolHelper.UserInfoDecode(data));
        }
	}

}