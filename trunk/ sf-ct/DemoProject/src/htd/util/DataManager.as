package htd.util
{
	import cn.sftech.www.event.SFInitializeDataEvent;
//	import cn.sftech.www.model.GameLevelModel;
//	import cn.sftech.www.model.GameValue;
	import cn.sftech.www.util.ByteArrayObjectTranslator;
	import cn.sftech.www.view.SFApplication;
	
	import com.qq.openapi.MttGameData;
	import com.qq.openapi.MttScore;
	import com.qq.openapi.MttService;
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	public class DataManager
	{
		private static var manageLock : Boolean = false;
		
		private static var isInitialized : Boolean = false;
		
		private static var manageFuncArr : Vector.<Object> = new Vector.<Object>();
		
		private static const LEVEL_DATA : String = "levelData";
		
		public function DataManager()
		{
		}
		
		public static function init(root : Object) : void
		{
			MttService.initialize(root, "D5FE393C02DB836FFDE413B8794056ED","1400");
			MttService.addEventListener(MttService.ETLOGOUT, 
				function onLogout(event : Event) : void
				{
					MttService.login();
				}
			);
		}
		
		public static function initData() : void
		{
			var dm : DataManager = new DataManager
//			actionFunction(dm.queryLevelData);
			actionFunction(dm.initFinished);
		}
		
		public static function saveScore(score : Number) : void
		{
			var dm : DataManager = new DataManager();
			actionFunction(dm.saveScoreHandle,score);
		}
		public static function saveLevelData(levelData : Object) : void
		{
			var dm : DataManager = new DataManager();
			actionFunction(dm.saveLevelDataHandle,levelData);
		}
		private function saveLevelDataHandle(levelData : Object) : void
		{
			var dataObejct : ByteArray = new ByteArray();
			dataObejct.writeObject(levelData);
			dataObejct.position = 0;
			MttGameData.put(LEVEL_DATA,dataObejct,saveLevelDataResult);
		}
		private function saveLevelDataResult(result : Object) : void
		{
			outList();
			if(result.code == 0) {
				trace("success");
			} else {
				trace(result.code);
			}
		}
		
		private function saveScoreHandle(score : Number) : void
		{
			MttScore.submit(score,submitScoreResult);
		}
		private function submitScoreResult(result : Object) : void
		{
			outList();
			if(result.code == 0) {
				trace("success");
			} else {
				trace(result.code);
			}
		}
		private function queryLevelData() : void
		{
			MttGameData.get(LEVEL_DATA,queryLevelDataResult);
		}
		private function queryLevelDataResult(result : Object) : void
		{
//			outList();
//			if(result.code == 0) {
//				var obj : Vector.<Object> = result.value.readObject() as Vector.<Object>;
//				if(obj) {
//					for(var i : int = 0;i < obj.length;i++) {
//						var glm : GameLevelModel = new GameLevelModel(obj[i].goldCounter,obj[i].silverCounter,obj[i].levelScore);
//						GameValue.GAME_LEVEL.push(glm);
//					}
//				}
//				
//				GameValue.getSumScore();
//				
//			} else {
//				trace(result.code);
//			}
		}
		
		//------------------------------------------------
		
		public static function actionFunction(func : Function, ...parameters) : void
		{
			if(manageLock) {
				if(parameters.length == 0) {
					manageFuncArr.push({func:func,param:null});
				} else {
					manageFuncArr.push({func:func,param:parameters});
				}
			} else {
				manageLock = true;
				
				func.apply(null,parameters);
			}
		}
		
		private function outList() : void
		{
			
			manageLock = false;
			if(manageFuncArr.length == 0) return;
			
			var func : Function = manageFuncArr[0].func;
			var param : Array = manageFuncArr[0].param;
			manageFuncArr.splice(0,1);
			if(manageFuncArr.length>=0) {
				if(param == null) {
					actionFunction(func);
				} else {
					actionFunction(func,param);
				}
			}
		}
		
		private function initFinished() : void
		{
			isInitialized = true;
			//			LogManager.print("初始化成功");
			
			manageLock = false;
			
			SFApplication.application.dispatchEvent(new SFInitializeDataEvent());
			//			LogManager.hideLog();
			
		}
	}
}