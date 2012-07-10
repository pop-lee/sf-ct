package
{
	import cn.sftech.www.effect.base.SFEffectBase;
	import cn.sftech.www.effect.viewStackEffect.SFViewStackGradientEffect;
	import cn.sftech.www.event.SFInitializeDataEvent;
	import cn.sftech.www.view.SFApplication;
	import cn.sftech.www.view.SFLogo;
	import cn.sftech.www.view.SFViewStack;
	import htd.util.DataManager;
	
	import com.greensock.data.TweenLiteVars;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	import htd.view.GamePage;
	
	[SWF(width="480",height="320")]
	
	public class SnsGameProject extends SFApplication
	{
		public function SnsGameProject()
		{
			
		}
		private var vs : SFViewStack;
		
		private var gamePage:GamePage;
		
		
		private var initLock : Boolean = false;
		
		private var logo :SFLogo;
		//是否第一次游???		
		//		private var firstFlag : Boolean = true;
		public function CallSns():void{
			this.init();
		}
		
		
		override protected function init():void
		{
			
			if(initLock) {
				return;
			} else {
				initLock = true;
			}
			
						logo = new SFLogo();
						logo.width = this.width;
						logo.height = this.height;
						
						addChild(logo);
						this.backgroundColor = 0x000000;
						this.backgroundAlpha = 1;
			
						DataManager.init(this.stage.root);
			
						SFApplication.application.addEventListener(SFInitializeDataEvent.INITIALIZE_DATA_EVENT,initializedData);
						DataManager.initData();
			
		}
		
		private function initializedData(event : SFInitializeDataEvent) : void
		{
			SFApplication.application.removeEventListener(SFInitializeDataEvent.INITIALIZE_DATA_EVENT,initializedData);
			
			initUI();
			hideLogo();
			setTimeout(hideLogo,1000);
			//			ChangePageEvent.levelNumber = GameValue.GAME_LEVEL.length;
			//			InformationClass.helpWindowCloseFlag = true;
		}
		
		private function hideLogo() : void
		{
			var effect : SFEffectBase = new SFEffectBase();
			effect.target = logo;
			effect.duration = 1.5;
			effect.vars = new TweenLiteVars();
			effect.vars.prop("alpha",0);
			effect.vars.onComplete(
				function removeLogo() :void{
					if(logo)
						removeChild(logo);
				});
			effect.play();
		}
		
		private function onLogout(e:Event):void
		{
			//			MttService.login();
		}
		
		private function initUI() : void
		{
			this.backgroundColor = 0x0000ff;
			this.backgroundAlpha = 1;			
			vs = new SFViewStack();
			vs.percentWidth = this.width;
			vs.percentHeight = this.height;
			vs.backgroundColor = 0x000000;
			vs.backgroundAlpha = 1;
			
			var vsEffect : SFViewStackGradientEffect = new SFViewStackGradientEffect();
			vsEffect.duration = 0.0;
			vs.effect = vsEffect;
			addChildAt(vs,0);
			
			gamePage = new GamePage();
			gamePage.percentWidth = 100;
			gamePage.percentHeight = 100;
			gamePage.backgroundColor = 0x000000;
			gamePage.backgroundAlpha = 1;
//			gamePage.addEventListener(ChangePageEvent.CHANGE_PAGE_EVENT,changePageHandle);
			vs.addItem(gamePage);
			gamePage.init();

			
			//			helpPage = new HelpPage();
			//			helpPage.addEventListener(ChangePageEvent.CHANGE_PAGE_EVENT,changePageHandle);
			//			vs.addItem(helpPage);
		}
		
	
	}
}