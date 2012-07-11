package cn.sftech.www.model
{
//	import cn.sftech.sns.model.TxMenu;
//	import cn.sftech.sns.model.TxUser;
	
	
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;

	//
	
	//
	public class ModelLocator extends GamingModel
	{
		private static var _model : ModelLocator = new ModelLocator();
		
		public function ModelLocator()
		{
			if(_model != null) {
				throw new IllegalOperationError("这是一个单例类，请使用getInstance方法来获取对象");
			}
		}
		
		public static function getInstance() : ModelLocator
		{
			return _model;
		}
	}
}