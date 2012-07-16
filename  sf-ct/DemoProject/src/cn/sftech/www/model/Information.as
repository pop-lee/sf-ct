package cn.sftech.www.model
{
	public class Information
	{
		public static const timeSymbol_x:int = 45;
		public static const timeSymbol_y:int = 16;
		public static const goldNumberSymbol_x:int = 203;
		public static const goldNumberSymbol_y:int = 16;
		public static const heartNumberSymbol_x:int = 336;
		public static const heartNumberSymbol_y:int = 16;
		
		public static const gameBackButton_Xpos : int= 430;
		public static const gameMealButton_Xpos : int= 146; 
		public static const gameMealButton_Ypos : int= 197; 
		public static const gameViceButton_Ypos : int= 237; 
		public static const gamePropButton_Ypos : int= 277; 
		public static const gameRestartPlateButton_Xpos : int= 52; 
		public static const gameRestartPlateButton_Ypos : int= 284; 
		public static const foodBaseX:int = 235;
		public static const foodBaseY:int = 235;
		public static const foodWidth:int = 94;
		public static const foodHeight:int = 59;
		//食物堆栈的长度
		public static const foodBufferNum : int = 6;
		public static const foodPaneBaseX : int = 190;
		public static const foodPaneBaseY : int = 200;
		public static const foodPaneWidth : int = 90;
		public static const foodPaneHeight : int = 63;		
		public static const selectMaxNum :int = 4;
		public static const servePanBaseX : int = 25;
		public static const servePanBaseY : int = 205;
		public static const servePanWidth : int = 56;
		public static const servePanHeight : int = 37;
		public static const serveFoodWidth : int = 48;
		public static const serveFoodHeight : int = 29;
		public static const moveAblePositionX:int =20;
		public static const moveAblePositionY:int =215;
		public static const moveAblePositionWidth:int =100;
		public static const moveAblePositionHeight:int =55;
		public static const Easy_TIME_LINE:int = 120;
		//游戏时间长度（单位：秒）
		public static const Random_TIME_LINE:int = 60;
		
		public static const moneyNumberSymbol_x:int = 64;
		public static const moneyNumberSymbol_y:int = 168;
		public static const popularityScoreSymbol_x:int = 125;
		public static const popularityScoreSymbol_y:int = 70;
		public static const coinScoreSymbol_x:int = 125;
		public static const coinScoreSymbol_y:int = 106;
		public static const ExperienceScoreSymbol_x:int = 125;
		public static const ExperienceScoreSymbol_y:int = 142;
		public static const levelLetterSymbol_x : int = 160;
		public static const levelLetterSymbol_y : int = 60;
		
		
		public static const dollarPanWidth : int = 26;
		
		public static var canGofirstPlace:Boolean =true;
		public static var canGosecondPlace:Boolean =true;
		public static var canGothirdPlace:Boolean =true;
		
		public static var CanClickMouse:Boolean =false;
		
		public static var CustomerCharacterIndex:int =-1;
		
		public static const personCharaterY:int = 28;
		
		public static const personCharaterX:int = 500;
		
		public static var customHappy:Boolean = false;
		
		public static const characterInSpeed:int = 300;
		
		public static const characterExitSpeed:int = 600;
		
		//// game over state
		
		public static var isGameOver:Boolean =false;
		
		
//		///// food price
//		public static const gamePrice:Array=[1,2,5,8,11,15];
		
		
		
		/////  game mode 
		public static const EasyGameMode   : uint =0;
		public static const RandomGameMode : uint =1;
		public static var  GameMode : uint =  1;
		
		
		///// in easy mode comming speed
		public static const EasyFrontTime : int = 500;
		public static const EasyBackTime : int = 1000;
		
		
		
		public static const CalulateTime : int = 200;
		
		/// in Random mode   comming speed 
		public static const RandomFrontTime : int = 800;
		public static const RandomBackTime : int = 800;
		
		public static const talkBoxWidth:int  =70;
		public static const talkBoxHeight:int = 92;
		
		public static const easy_mod_firstPosOffset : int = 50;
	//	public static const Random_Time : int = 300;
		
		////// this is time for waiting
		public static const first_girl_waitingTime  : int = 30000;
		public static const second_girl_waitingTime : int = 20000;
		public static const first_boy_waitingTime : int = 5000;
		public static const second_boy_waitingTime : int = 10000;
		
		
		public function Information()
		{
			
		}
		
	}
}