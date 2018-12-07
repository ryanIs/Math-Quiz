
/* 

	Created by Ryan Isler - Started 
	
	Goal: Create a good looking, AS3 Math Quiz. In this math quiz, there will be 
	solvable problems with all four: addition, subtraction, multiplcation, and 
	divison. 

*/

package {
	
	import flash.display.*;
	import flash.events.*;
	import fl.controls.*;
	import flash.ui.*;
	import flash.media.*;
	import flash.net.SharedObject;
	import flash.net.SharedObjectFlushStatus;
	import Achievement;
	
	public class Main extends MovieClip {
		
		// 0: So easy a CaveMan could do it, 1: Very very Easy, 2: Very Easy, 3: Easy, 4: Low Medium, 
		// 5: Medium, 6: High Medium, 7: The Easy Hard, 8: Hard, 9: Really Hard, 10: Impossibly hard.
		public var difficulty:Number = 0;
		
		public var questions:Number = 25;
		
		private var cycle:Number = 0;
		private var milliseconds:Number = 0;
		private var seconds:Number = 0;
		private var minutes:Number = 0;
		private var hours:Number = 0;
		
		private var fps:Number = 60;
		private var MFCount:Number = 0;
		private var menu:ContextMenu = new ContextMenu();
		private var loader:LoadBar;
		private var currentGame:Game;
		private var gamePending:Boolean = false;
		
		// Sound
		private var mathQuiz:Sound;
		private var mathQuizQuiz:Sound;
		private var mathQuizIncorrect:Sound;
		private var mathQuizCorrect:Sound;
		private var achieved:Sound;
		private var soundTrans:SoundTransform;
		
		public var difficultiesCompleted:Array = new Array(false,false,false,false,false,false,false,false,false,false,false);
		public var difficultiesQuestions:Array = new Array(0,0,0,0,0,0,0,0,0,0,0);
		
		private var sharedObject:SharedObject;
		private var saveId:Number = 0;
		private var loadId:Number = 0;
		
		// Achievements
		//private var achievement:Achievement = new Achievement();
		private var achi_10Questions:Boolean = false;
		private var achi_20Questions:Boolean = false;
		private var achi_30Questions:Boolean = false;
		private var achi_40Questions:Boolean = false;
		private var achi_50Questions:Boolean = false;
		private var achi_60Questions:Boolean = false;
		private var achi_70Questions:Boolean = false;
		private var achi_80Questions:Boolean = false;
		private var achi_90Questions:Boolean = false;
		private var achi_100Questions:Boolean = false;
		
		private var achi_allRedNumbers:Boolean = false;
		private var achi_allYellowNumbers:Boolean = false;
		private var achi_allGreenNumbers:Boolean = false;
		
		private var achi_caveManSpeed:Boolean = false;
		private var achi_caveManSuperSpeed:Boolean = false;
		private var achi_caveManLightSpeed:Boolean = false;
		private var achi_caveManTimeWarp:Boolean = false;
		
		private var achi_AonEasyDifficulty:Boolean = false;
		private var achi_AonMediumDifficulty:Boolean = false;
		private var achi_AonHardDifficulty:Boolean = false;
		
		private var achi_fail:Boolean = false;
		private var achi_extremeFail:Boolean = false;
		private var achi_epicFail:Boolean = false;
		private var achi_worstFailEver:Boolean = false;
		
		private var achi_slowStyle:Boolean = false;
		private var achi_turtleStyle:Boolean = false;
		private var achi_mathQuizComplete:Boolean = false;
		
		private var achi_fastAndSmart:Boolean = false;
		private var achi_fastAndBrillant:Boolean = false;
		private var achi_fastAndIntelligent:Boolean = false;
		
		public function Main() {
			stop(); 
			this.stop();
			
			loader = new LoadBar();
			loader.x = 5; 
			loader.y = 375;
			
			stage.addChild(loader);
			
			function LoadGame(e:ProgressEvent) {
				loader.loadBar_mc.scaleX = e.bytesLoaded / e.bytesTotal;
				
				if(loader.loadBar_mc.scaleX >= 1) {
					
					gotoAndStop("title"); 
					titleFrame();
					stage.removeChild(loader);
					//this.loaderInfo.removeEventListener(ProgressEvent.PROGRESS, LoadGame);
				
				}
				
			}
			this.loaderInfo.addEventListener(ProgressEvent.PROGRESS, LoadGame);
			
			// Context Menu
			menu.hideBuiltInItems();
			contextMenu = menu;
			var RI_cmi:ContextMenuItem = new ContextMenuItem("Created by Ryan Isler", false, false, true);
			menu.customItems.push(RI_cmi);
			
			// Script
			
			mathQuiz = new MathQuiz();
			mathQuizQuiz = new MathQuizQuiz();
			mathQuizIncorrect = new MathQuizIncorrect();
			mathQuizCorrect = new MathQuizCorrect();
			achieved = new Achieved();
			soundTrans = new SoundTransform(.1, 0);
			flash.media.SoundMixer.soundTransform = soundTrans;
			
			mathQuiz.play(0,100);
			function gotoFrame(frameString:String) {
				
				fade_mc.gotoAndPlay(1);
				gotoAndStop(frameString);
				
				if(frameString == "title") titleFrame();
				
				else if(frameString == "difficulty") difficultyFrame();
				
				else if(frameString == "game") {
					gameFrame();
					background_mc.addEventListener(Event.ENTER_FRAME, EFThree);
				}
				
				else if(frameString == "options") {
					optionsFrame();
				}
				
				else if(frameString == "how") {
					howFrame();
				}
				
				else if(frameString == "achievements") {
					achievementsFrame();
				}
				
			}
			
			function EFThree() {
				cycle++;
				milliseconds += 16;
				
				if(cycle > fps / 1.5) {
					
					var side:Number = Math.round( Math.random() * 4 ); // 0 = top, 1 = right, 2 = bottom, 3 = left;
					var mathFlyer:MovieClip = new MathFlyer(side);
					mathFlyer.addEventListener(Event.ENTER_FRAME, mathFlyer.handleThis);
					background_mc.mathHolder_mc.addChild(mathFlyer);
					cycle = 0;
					MFCount++;
					
				}
				
				if(milliseconds >= 1000) {
					
					seconds++;
					milliseconds = 0;
					
				}
				
				if(seconds >= 60) {
					
					minutes++;
					seconds = 0;
					
				}
				
				if(minutes >= 60) {
					
					hours++;
					minutes = 0;
					
				}
				
				time_txt.text = hours+" : "+minutes+" : "+seconds+" : "+milliseconds;
				
			}
			
			function backBTN(e:MouseEvent) {
				
				gotoFrame("title");
				
			}
			
			function playBTN(e:MouseEvent) {
				
				gotoFrame("difficulty");
				
			}
			
			function optionsBTN(e:MouseEvent) {
				
				gotoFrame("options");
				
			}
			
			function difficultyCBX(e:Event) {
				difficulty = e.currentTarget.value;
			}
			
			function qualityCBX(e:Event) {
				if(e.currentTarget.value == 1) {
					stage.quality = "LOW";
				} else if(e.currentTarget.value == 2) {
					stage.quality = "MEDIUM";
				} else if(e.currentTarget.value == 3) {
					stage.quality = "HIGH";
				}
			}
			
			function questionsSLD(e:Event) {
				
				questions =  e.currentTarget.value;
				questions_txt.htmlText = "<b>"+questions.toString()+"</b>";
				
			}
			
			function resetGame() {
				
				currentGame = undefined;
				gamePending = false;
				
			}
			
			function updateGameFrame(game:Game) {
				
				question_txt.htmlText = "<p align='center'>"+game.onQuestion+"</p>";
				progress_sld.value = Math.round( (game.onQuestionNumber / game.totalQuestions) * 100 );
				progress_txt.text = game.onQuestionNumber+" / "+ game.totalQuestions;
				answer_txt.text = "";
				
			}
			
			function doGoals() {
				var Difficulty = difficulty - 1;
				
				if(currentGame.totalCorrect >= Math.ceil( (currentGame.totalQuestions / 4) * 3 ) ) {
							
					difficultiesCompleted[Difficulty] = true;
					
					if( currentGame.totalCorrect > difficultiesQuestions[Difficulty] ) {
						
						difficultiesQuestions[Difficulty] = currentGame.totalQuestions;
					
					}
							
				}
				
			}
			
			function submitBTN(e) {
				
				if(answer_txt.text != "")
				{ 
				
				if(gamePending == false) {
				
					if(currentGame.inputAnswer(answer_txt.text) == true) {
					
						mathQuizCorrect.play(0);
						result_mc.gotoAndStop("correct");
					
					} else {
						
						mathQuizIncorrect.play(0);
						result_mc.gotoAndStop("incorrect");
					
					}
				
				gamePending = true;
				submit_btn.label = "Next";
				
				} else if(gamePending == true) {
					
					if(currentGame.onQuestionNumber >= currentGame.totalQuestions) {
						
						currentGame.gameOver();
						question_txt.htmlText = "<p align='center'><b>Game Over!<br>Questions Correct: <font color='#00aa00'>"+currentGame.totalCorrect+"</font><br>Questions Incorrect: <font color='#aa0000'>"+currentGame.totalIncorrect+"</font></b></p>";
						progress_sld.value = questions;
						progress_txt.text = currentGame.totalQuestions+" / "+currentGame.totalQuestions;
						answer_txt.text = "";
						answer_txt.focusRect = false;
						exit_btn.visible = true;
						submit_btn.visible = false;
						background_mc.removeEventListener(Event.ENTER_FRAME, EFThree);
						stage.removeEventListener(KeyboardEvent.KEY_DOWN, spaceDown);
						doGoals();
						doAchievements();
						resetGame();
						resetTime();
						
					}
					
					else {
						
						result_mc.gotoAndStop("none");
						currentGame.generateQuestion();
						submit_btn.label = "Submit";
						gamePending = false;
						updateGameFrame(currentGame);
					
					}
					
				}
				
				}
				
			}
			
			function beginBTN(e:MouseEvent) {
				
				if(difficulty > 0) {
					
					gotoFrame("game");
					currentGame = new Game(difficulty, questions);
					updateGameFrame(currentGame);
					
				} else {
					
					notice("<b>You must select a <font color='#550000'>difficulty</font> before you begin!</b>");
					
				}
				
			}
			
			function spaceDown(e:KeyboardEvent) {
				
				if(e.keyCode == 13) {
					
					submitBTN(e);
					
				}
				
			}
			
			function exitBTN(e:MouseEvent) {
				
				flash.media.SoundMixer.stopAll();
				mathQuiz.play(0,100);
				gotoFrame("difficulty");
				
			}
			
			function howNextBTN(e:MouseEvent) {
				
				how_mc.nextFrame();
				
			}
			
			function howPreviousBTN(e:MouseEvent) {
				
				how_mc.prevFrame();
				
			}
			
			function howBTN(e:MouseEvent) {
				
				gotoFrame("how");
				
			}
			
			function saveStatesLIS(e:Event) {
				
				save_btn.visible = true;
				load_btn.visible = true;
				rename_btn.visible = true;
				delete_btn.visible = true;
				loadId = e.currentTarget.selectedItem.Id;
				
			}
			
			function achievementsBTN(e:MouseEvent) {
				
				gotoFrame("achievements");
				
			}
			
			function resetTime() {
				
				milliseconds = 0;
				seconds = 0;
				minutes = 0;
				hours = 0;
				
			}
			
			// Listeners
			
			function loadFrame() {
				
			}
			
			function titleFrame() {
				play_btn.addEventListener(MouseEvent.CLICK, playBTN);
				achievements_btn.addEventListener(MouseEvent.CLICK, achievementsBTN);
				options_btn.addEventListener(MouseEvent.CLICK, optionsBTN);
				how_btn.addEventListener(MouseEvent.CLICK, howBTN);
				
			}
			function difficultyFrame() {
				
				difficulty_cbx.addEventListener(Event.CHANGE, difficultyCBX);
				questions_sld.addEventListener(Event.CHANGE, questionsSLD);
				back_btn.addEventListener(MouseEvent.CLICK, backBTN);
				begin_btn.addEventListener(MouseEvent.CLICK, beginBTN);
				questions_sld.value = questions;
				questions_txt.htmlText = "<b>"+questions+"</b>";
				
				for(var i = 1; i < difficultiesCompleted.length; i++) {
					
					if(difficultiesCompleted[i] == true) {
						
						goals_mc["mark"+i].gotoAndStop("C");
						
					}
					
					// Font colors for the All (color) Difficulty Achievements.
					if(difficultiesQuestions[i] == 0) {
						goals_mc["questions"+i].htmlText = "<b><font color='#000000'>"+difficultiesQuestions[i].toString()+"</font></b>";
					}
					else if(difficultiesQuestions[i] < 33) {
						goals_mc["questions"+i].htmlText = "<b><font color='#990000'>"+difficultiesQuestions[i].toString()+"</font></b>";
					}
					
					else if(difficultiesQuestions[i] > 32 && difficultiesQuestions[i] < 66) {
						goals_mc["questions"+i].htmlText = "<b><font color='#999900'>"+difficultiesQuestions[i].toString()+"</font></b>";
					}
					
					else if(difficultiesQuestions[i] > 65) {
						goals_mc["questions"+i].htmlText = "<b><font color='#009900'>"+difficultiesQuestions[i].toString()+"</font></b>";
					}
					
				}
				
			}
			
			function gameFrame() {
				
				flash.media.SoundMixer.stopAll();
				mathQuizQuiz.play(0,100);
				stage.addEventListener(KeyboardEvent.KEY_DOWN, spaceDown);
				submit_btn.addEventListener(MouseEvent.CLICK, submitBTN);
				exit_btn.addEventListener(MouseEvent.CLICK, exitBTN);
			
			}
			
			function optionsFrame() {
				
				loadSaves();
				saveGameAs_txt.text = "Math Quiz Saved Game # "+ (saveId + 1);
				quality_cbx.addEventListener(Event.CHANGE, qualityCBX);
				back_btn.addEventListener(MouseEvent.CLICK, backBTN);
				saveStates_lis.addEventListener(Event.CHANGE, saveStatesLIS);
				saveGameAs_btn.addEventListener(MouseEvent.CLICK, saveGameAsBTN);
				load_btn.addEventListener(MouseEvent.CLICK, loadBTN);
				save_btn.addEventListener(MouseEvent.CLICK, saveBTN);
				rename_btn.addEventListener(MouseEvent.CLICK, renameBTN);
				delete_btn.addEventListener(MouseEvent.CLICK, deleteBTN);
				
			}
			
			function howFrame() {
				
				back_btn.addEventListener(MouseEvent.CLICK, backBTN);
				how_mc.next_btn.addEventListener(MouseEvent.CLICK, howNextBTN);
				how_mc.previous_btn.addEventListener(MouseEvent.CLICK, howPreviousBTN);
				
			}
			
			function achievementsFrame() {
				
				back_btn.addEventListener(MouseEvent.CLICK, backBTN);
				back_mc.addEventListener(MouseEvent.MOUSE_OVER, function(e) { description_txt.text = ""; });
				displayAchievements();
				
			}
			
		} // End of Main() function
			
		public function doAchievements() {
			
			if(!achi_mathQuizComplete) {5
				
				var mathQuizCompleted:Boolean = true;
			
				for(var i = 1; i < difficultiesQuestions.length; i++) {
				
					if(difficultiesQuestions[i] < 100) {
					
						mathQuizCompleted = false;
					
					}
				
				}
			
				if(mathQuizCompleted) {
					
					showAchievement("<p align='center'><u><b>Congratulations!</b></u><br>You have completed the 'Math Quiz Completed' Achievement! You are now the most honored, Math Quiz King/Queen!</p>");
					achi_mathQuizComplete = true;
					
				}
				
			}
			
			// 0% Correct
			if(currentGame.totalCorrect < 1) {
				
				if(questions >= 100 && minutes < 1 && seconds <= 25 && !achi_worstFailEver) {
					
					showAchievement("<p align='center'><u><b>Congratulations!</b></u><br>You have completed the 'Worst Fail Ever' Achievement! You are impressivly amazing at failing!</p>");
					achi_worstFailEver = true;
					
				}
				
				if(questions >= 75 && minutes < 1 && seconds <= 20 && !achi_epicFail) {
					
					showAchievement("<p align='center'><u><b>Congratulations!</b></u><br>You have completed the 'Epic Fail' Achievement! Nice failing! Now try to do your worst!</p>");
					achi_epicFail = true;
					
				}
				
				if(questions >= 50 && minutes < 1 && seconds <= 15 && !achi_extremeFail) {
					
					showAchievement("<p align='center'><u><b>Congratulations!</b></u><br>You have completed the 'Extreme Fail' Achievement! Next try to epicly fail.</p>");
					achi_extremeFail = true;
					
				}
				
				if(questions >= 25 && minutes < 1 && seconds <= 10 && !achi_fail) {
					
					showAchievement("<p align='center'><u><b>Congratulations!</b></u><br>You have completed the 'Fail' Achievement! Now you're ready to perform an Extreme Fail!</p>");
					achi_fail = true;
					
				}
				
			}
			
			// 25% Correct
			if(currentGame.totalCorrect >= Math.floor(currentGame.totalQuestions / 4)) {
				
				var red:Boolean = true;
				var yellow:Boolean = true;
				var green:Boolean = true;
				
				for(i = 1; i < difficultiesQuestions.length; i++) {
					
					if(difficultiesQuestions[i] < 66) {
						
						green = false;
						
					}
					
					if(difficultiesQuestions[i] < 33) {
						
						yellow = false;
						
					}
					
					if(difficultiesQuestions[i] < 1) {
						
						red = false;
						
					}
					
				}
				
				if(green == true && !achi_allGreenNumbers) {
					
					showAchievement("<p align='center'><u><b>Congratulations!</b></u><br>You have completed the 'All Green Difficulties' Achievement! You sure can quiz well and long!</p>");
					achi_allGreenNumbers = true;
					achi_allYellowNumbers = true;
					achi_allRedNumbers = true;
					
				}
				
				else if(yellow == true && !achi_allYellowNumbers) {
					
					showAchievement("<p align='center'><u><b>Congratulations!</b></u><br>You have completed the 'All Yellow Difficulties' Achievement! Now try to complete the All Green achievement!</p>");
					achi_allYellowNumbers = true;
					achi_allRedNumbers = true;
					
				}
				
				else if(red == true && !achi_allRedNumbers) {
					
					showAchievement("<p align='center'><u><b>Congratulations!</b></u><br>You have completed the 'All Red Difficulties' Achievement! Now try to complete the All Yellow achievement!</p>");
					achi_allRedNumbers = true;
					
				}
				
			}
			
			// 50% Correct
			if(currentGame.totalCorrect >= Math.ceil(currentGame.totalQuestions / 2)) {
				
				
				
				if(hours >= 3 && achi_turtleStyle == false) {
					
					showAchievement("<p align='center'><u><b>Congratulations!</b></u><br>You have completed the 'Turtle Style' Achievement! You sure can wait!</p>");
					achi_turtleStyle = true;
					achi_slowStyle = true;
					
				}
				
				else if(hours >= 1 && achi_slowStyle == false) {
					
					showAchievement("<p align='center'><u><b>Congratulations!</b></u><br>You have completed the 'Slow Style' Achievement! You're pretty slow! Now try turtle speed!</p>");
					achi_slowStyle = true;
					
				}
				
				if(questions == 100 && achi_100Questions == false) {
					
					showAchievement("<p align='center'><u><b>Congratulations!</b></u><br>You have completed the '100 Question Marathon' Achievement!</p>");
					achi_100Questions = true;
					achi_90Questions = true;
					achi_80Questions = true;
					achi_70Questions = true;
					achi_60Questions = true;
					achi_50Questions = true;
					achi_40Questions = true;
					achi_30Questions = true;
					achi_20Questions = true;
					achi_10Questions = true;
				
				}
				
				else if(questions >= 90 && achi_90Questions == false) {
					
					showAchievement("<p align='center'><u><b>Congratulations!</b></u><br>You have completed the '90 Question Marathon' Achievement! Can you take the 100 Questions Finale!?</p>");
					achi_90Questions = true;
					achi_80Questions = true;
					achi_70Questions = true;
					achi_60Questions = true;
					achi_50Questions = true;
					achi_40Questions = true;
					achi_30Questions = true;
					achi_20Questions = true;
					achi_10Questions = true;
				
				}
				
				else if(questions >= 80 && achi_80Questions == false) {
					
					showAchievement("<p align='center'><u><b>Congratulations!</b></u><br>You have completed the '80 Question Marathon' Achievement! Do you stand a chance against 90 Questions? Try it and find out!</p>");
					achi_80Questions = true;
					achi_70Questions = true;
					achi_60Questions = true;
					achi_50Questions = true;
					achi_40Questions = true;
					achi_30Questions = true;
					achi_20Questions = true;
					achi_10Questions = true;
				
				}
				
				else if(questions >= 70 && achi_70Questions == false) {
					
					showAchievement("<p align='center'><u><b>Congratulations!</b></u><br>You have completed the '70 Question Marathon' Achievement! You've got skills, but can you take on 80 Questions?</p>");
					achi_70Questions = true;
					achi_60Questions = true;
					achi_50Questions = true;
					achi_40Questions = true;
					achi_30Questions = true;
					achi_20Questions = true;
					achi_10Questions = true;
				
				}
				
				else if(questions >= 60 && achi_60Questions == false) {
					
					showAchievement("<p align='center'><u><b>Congratulations!</b></u><br>You have completed the '60 Question Marathon' Achievement! Now try 70 Questions! Good luck.</p>");
					achi_60Questions = true;
					achi_50Questions = true;
					achi_40Questions = true;
					achi_30Questions = true;
					achi_20Questions = true;
					achi_10Questions = true;
				
				}
				
				else if(questions >= 50 && achi_50Questions == false) {
					
					showAchievement("<p align='center'><u><b>Congratulations!</b></u><br>You have completed the '50 Question Marathon' Achievement! Next up is 60 questions! Go and try it!</p>");
					achi_50Questions = true;
					achi_40Questions = true;
					achi_30Questions = true;
					achi_20Questions = true;
					achi_10Questions = true;
				
				}
				
				else if(questions >= 40 && achi_40Questions == false) {
					
					showAchievement("<p align='center'><u><b>Congratulations!</b></u><br>You have completed the '40 Question Marathon' Achievement! Go for 50 Questions next!</p>");
					achi_40Questions = true;
					achi_30Questions = true;
					achi_20Questions = true;
					achi_10Questions = true;
				
				}
				
				else if(questions >= 30 && achi_30Questions == false) {
					
					showAchievement("<p align='center'><u><b>Congratulations!</b></u><br>You have completed the '30 Question Marathon' Achievement! Now try to complete 40 Questions!</p>");
					achi_30Questions = true;
					achi_20Questions = true;
					achi_10Questions = true;
				
				}
				
				else if(questions >= 20 && achi_20Questions == false) {
					
					showAchievement("<p align='center'><u><b>Congratulations!</b></u><br>You have completed the '20 Question Marathon' Achievement! Take a shot at 30 Questions!</p>");
					achi_20Questions = true;
					achi_10Questions = true;
				
				}
				
				else if(questions >= 10 && achi_10Questions == false) {
					
					showAchievement("<p align='center'><u><b>Congratulations!</b></u><br>You have completed the '10 Question Marathon' Achievement! Think you can do 20 Questions? try it!</p>");
					achi_10Questions = true;
				
				}
			}
			
			// 75% Correct
			if(currentGame.totalCorrect >= (Math.ceil(currentGame.totalQuestions / 4) * 3) && questions >= 30) {
				
				if(difficulty == 6 && questions >= 30 && minutes < 1) {
					
					showAchievement("<p align='center'><u><b>Congratulations!</b></u><br>You have completed the 'Fast And Smart' Achievement! Nice Brains! But are you brillant?'</p>");
					achi_fastAndSmart = true;
					
				}
				
				if(difficulty == 8 && questions >= 30 && minutes < 2) {
					
					showAchievement("<p align='center'><u><b>Congratulations!</b></u><br>You have completed the 'Fast And Brillant' Achievement! Nice Brains! But are you Intelligent?'</p>");
					achi_fastAndBrillant = true;
					
				}
				
				if(difficulty == 10 && questions >= 30 && minutes < 3) {
					
					showAchievement("<p align='center'><u><b>Congratulations!</b></u><br>You have completed the 'Fast And Intelligent' Achievement! You've got some nice Brains there!'</p>");
					achi_fastAndIntelligent = true;
					
				}
				
				if(minutes < 1 && seconds <= 20 && !achi_caveManTimeWarp) {
					
					showAchievement("<p align='center'><u><b>Congratulations!</b></u><br>You have completed the 'CaveMan Warp Speed' Achievement! Impressive! You can travel warp speed at Caveman level!'</p>");
					achi_caveManTimeWarp = true;
					achi_caveManLightSpeed = true;
					achi_caveManSuperSpeed = true;
					achi_caveManSpeed = true;
					
				}
				
				else if(minutes < 1 && seconds <= 35 && !achi_caveManLightSpeed) {
					
					showAchievement("<p align='center'><u><b>Congratulations!</b></u><br>You have completed the 'CaveMan Light Speed' Achievement! You can go the speed of light, can you warp?'</p>");
					achi_caveManLightSpeed = true;
					achi_caveManSuperSpeed = true;
					achi_caveManSpeed = true;
					
				}
				
				else if(minutes < 1 && seconds <= 50 && !achi_caveManSuperSpeed) {
					
					showAchievement("<p align='center'><u><b>Congratulations!</b></u><br>You have completed the 'CaveMan Super Speed' Achievement! You're super! Try going CaveMan Light Speed!'</p>");
					achi_caveManSuperSpeed = true;
					achi_caveManSpeed = true;
					
				}
				
				else if(minutes < 2 && seconds <= 15 && !achi_caveManSpeed) {
					
					showAchievement("<p align='center'><u><b>Congratulations!</b></u><br>You have completed the 'CaveMan Speed' Achievement! Next comes the 'CaveMan Super Speed!'</p>");
					achi_caveManSpeed = true;
					
				}
				
			}
			
			// 90% Correct
			if(currentGame.totalCorrect >= (Math.ceil(currentGame.totalQuestions / 10) * 9)) {
				
				if(difficulty == 3 && currentGame.totalQuestions >= 40 && !achi_AonEasyDifficulty) {
					
					showAchievement("<p align='center'><u><b>Congratulations!</b></u><br>You have completed the 'Grade A on Easy' Achievement! Now shoot for the an A on Medium!</p>");
					achi_AonEasyDifficulty = true;
					
				}
				
				if(difficulty == 5 && currentGame.totalQuestions >= 35 && !achi_AonMediumDifficulty) {
					
					showAchievement("<p align='center'><u><b>Congratulations!</b></u><br>You have completed the 'Grade A on Medium' Achievement! Now shoot for the an A on Hard!</p>");
					achi_AonMediumDifficulty = true;
					
				}
				
				if(difficulty == 8 && currentGame.totalQuestions >= 30 && !achi_AonHardDifficulty) {
					
					showAchievement("<p align='center'><u><b>Congratulations!</b></u><br>You have completed the 'Grade A on Hard' Achievement! Nice math skills!</p>");
					achi_AonHardDifficulty = true;
					
				}
				
			}
		}
		
		private function displayAchievements():void {
			
			// Displaying
			for(var i = 10; i < 101 ; i += 10) {
					
				
				if(root["achi_"+i+"Questions"] == true) {
						
					root["achievement"+i].achieved_mc.gotoAndStop("true");
						
				}
				
			}
			
			if(achi_allRedNumbers)
			allRedNumbers.achieved_mc.gotoAndStop("true");
			
			if(achi_allYellowNumbers)
			allYellowNumbers.achieved_mc.gotoAndStop("true");
			
			if(achi_allGreenNumbers)
			allGreenNumbers.achieved_mc.gotoAndStop("true");
			
			
			
			if(achi_caveManSpeed)
			caveManSpeed.achieved_mc.gotoAndStop("true");
			
			if(achi_caveManSuperSpeed)
			caveManSuperSpeed.achieved_mc.gotoAndStop("true");
			
			if(achi_caveManLightSpeed)
			caveManLightSpeed.achieved_mc.gotoAndStop("true");
			
			if(achi_caveManTimeWarp)
			caveManTimeWarp.achieved_mc.gotoAndStop("true");
			
			if(achi_AonEasyDifficulty)
			AonEasy.achieved_mc.gotoAndStop("true");
			
			if(achi_AonMediumDifficulty)
			AonMedium.achieved_mc.gotoAndStop("true");
			
			if(achi_AonHardDifficulty)
			AonHard.achieved_mc.gotoAndStop("true");
			
			if(achi_fail)
			fail.achieved_mc.gotoAndStop("true");
			
			if(achi_extremeFail)
			extremeFail.achieved_mc.gotoAndStop("true");
			
			if(achi_epicFail)
			epicFail.achieved_mc.gotoAndStop("true");
			
			if(achi_worstFailEver)
			worstFailEver.achieved_mc.gotoAndStop("true");
			
			if(achi_slowStyle)
			slowStyle.achieved_mc.gotoAndStop("true");
			
			if(achi_turtleStyle)
			turtleStyle.achieved_mc.gotoAndStop("true");
			
			if(achi_mathQuizComplete)
			mathQuizComplete.achieved_mc.gotoAndStop("true");
			
			if(achi_fastAndSmart)
			slowStyle.achieved_mc.gotoAndStop("true");
			
			if(achi_fastAndBrillant)
			turtleStyle.achieved_mc.gotoAndStop("true");
			
			if(achi_fastAndIntelligent)
			mathQuizComplete.achieved_mc.gotoAndStop("true");
			
			// Function
		
			achievement10.addEventListener(MouseEvent.MOUSE_OVER, function(e) {
				description_txt.htmlText = Achievement.get10Description();
			});
			achievement20.addEventListener(MouseEvent.MOUSE_OVER, function(e) {
				description_txt.htmlText = Achievement.get20Description();
			});
			achievement30.addEventListener(MouseEvent.MOUSE_OVER, function(e) {
				description_txt.htmlText = Achievement.get30Description();
			});
			achievement40.addEventListener(MouseEvent.MOUSE_OVER, function(e) {
				description_txt.htmlText = Achievement.get40Description();
			});
			achievement50.addEventListener(MouseEvent.MOUSE_OVER, function(e) {
				description_txt.htmlText = Achievement.get50Description();
			});
			achievement60.addEventListener(MouseEvent.MOUSE_OVER, function(e) {
				description_txt.htmlText = Achievement.get60Description();
			});
			achievement70.addEventListener(MouseEvent.MOUSE_OVER, function(e) {
				description_txt.htmlText = Achievement.get70Description();
			});
			achievement80.addEventListener(MouseEvent.MOUSE_OVER, function(e) {
				description_txt.htmlText = Achievement.get80Description();
			});
			achievement90.addEventListener(MouseEvent.MOUSE_OVER, function(e) {
				description_txt.htmlText = Achievement.get90Description();
			});
			achievement100.addEventListener(MouseEvent.MOUSE_OVER, function(e) {
				description_txt.htmlText = Achievement.get100Description();
			});
			
			allRedNumbers.addEventListener(MouseEvent.MOUSE_OVER, function(e) {
				description_txt.htmlText = Achievement.getAllRedDescription();
			});
			allYellowNumbers.addEventListener(MouseEvent.MOUSE_OVER, function(e) {
				description_txt.htmlText = Achievement.getAllYellowDescription();
			});
			allGreenNumbers.addEventListener(MouseEvent.MOUSE_OVER, function(e) {
				description_txt.htmlText = Achievement.getAllGreenDescription();
			});
			
			caveManSpeed.addEventListener(MouseEvent.MOUSE_OVER, function(e) {
				description_txt.htmlText = Achievement.getCaveManSpeed();
			});
			caveManSuperSpeed.addEventListener(MouseEvent.MOUSE_OVER, function(e) {
				description_txt.htmlText = Achievement.getCaveManSuperSpeed();
			});
			caveManLightSpeed.addEventListener(MouseEvent.MOUSE_OVER, function(e) {
				description_txt.htmlText = Achievement.getCaveManLightSpeed();
			});
			caveManTimeWarp.addEventListener(MouseEvent.MOUSE_OVER, function(e) {
				description_txt.htmlText = Achievement.getCaveManTimeWarp();
			});
			
			AonEasy.addEventListener(MouseEvent.MOUSE_OVER, function(e) {
				description_txt.htmlText = Achievement.getAonEasyDescription();
			});
			AonMedium.addEventListener(MouseEvent.MOUSE_OVER, function(e) {
				description_txt.htmlText = Achievement.getAonMediumDescription();
			});
			AonHard.addEventListener(MouseEvent.MOUSE_OVER, function(e) {
				description_txt.htmlText = Achievement.getAonHardDescription();
			});
			
			fail.addEventListener(MouseEvent.MOUSE_OVER, function(e) {
				description_txt.htmlText = Achievement.getFailDescription();
			});
			extremeFail.addEventListener(MouseEvent.MOUSE_OVER, function(e) {
				description_txt.htmlText = Achievement.getExtremeFailDescription();
			});
			epicFail.addEventListener(MouseEvent.MOUSE_OVER, function(e) {
				description_txt.htmlText = Achievement.getEpicFailDescription();
			});
			worstFailEver.addEventListener(MouseEvent.MOUSE_OVER, function(e) {
				description_txt.htmlText = Achievement.getWorstFailEverDescription();
			});
			
			slowStyle.addEventListener(MouseEvent.MOUSE_OVER, function(e) {
				description_txt.htmlText = Achievement.getSlowStyleDescription();
			});
			turtleStyle.addEventListener(MouseEvent.MOUSE_OVER, function(e) {
				description_txt.htmlText = Achievement.getTurtleStyleDescription();
			});
			mathQuizComplete.addEventListener(MouseEvent.MOUSE_OVER, function(e) {
				description_txt.htmlText = Achievement.getMathQuizCompleteDescription();
			});
			
			fastAndSmart.addEventListener(MouseEvent.MOUSE_OVER, function(e) {
				description_txt.htmlText = Achievement.getFastAndSmartDescription();
			});
			fastAndBrillant.addEventListener(MouseEvent.MOUSE_OVER, function(e) {
				description_txt.htmlText = Achievement.getFastAndBrillantDescription();
			});
			fastAndIntelligent.addEventListener(MouseEvent.MOUSE_OVER, function(e) {
				description_txt.htmlText = Achievement.getFastAndIntelligentDescription();
			});
			
		}
		
		public function showAchievement(achievementStr:String):void {
			
			// Don't forget to make it look pretty! ... With html :D.
			var box:AchievementBox = new AchievementBox(achievementStr);
			addChild(box);
			box.x = 275;
			box.y = 200;
			achieved.play(0);
			
		}
		
		// Loading and Saving Game
		
		private function loadSaves():void {
			
			saveId = 0;
			sharedObject = SharedObject.getLocal("MathQuiz_"+saveId);
			
			saveStates_lis.removeAll();
			
			while(sharedObject.data.defined != undefined) {
			
				var obj:Object = new Object();
				obj.label = sharedObject.data.Name;
				obj.value = "MathQuiz_"+saveId;
				obj.Id = saveId;
				saveStates_lis.addItemAt(obj, saveId);
				
				saveId++;
				sharedObject = SharedObject.getLocal("MathQuiz_"+saveId);
				if(sharedObject.data.defined == undefined) break;
			}
			
		}
		
		private function saveGame() {
			var flushStatus:String = null;
			
			// Achievements
			sharedObject.data.achi_100Questions = achi_100Questions;
			sharedObject.data.achi_90Questions = achi_90Questions;
			sharedObject.data.achi_80Questions = achi_80Questions;
			sharedObject.data.achi_70Questions = achi_70Questions;
			sharedObject.data.achi_60Questions = achi_60Questions;
			sharedObject.data.achi_50Questions = achi_50Questions;
			sharedObject.data.achi_40Questions = achi_40Questions;
			sharedObject.data.achi_30Questions = achi_30Questions;
			sharedObject.data.achi_20Questions = achi_20Questions;
			sharedObject.data.achi_10Questions = achi_10Questions;
			
			sharedObject.data.achi_allGreenNumbers = achi_allGreenNumbers;
			sharedObject.data.achi_allYellowNumbers = achi_allYellowNumbers;
			sharedObject.data.achi_allRedNumbers = achi_allRedNumbers;
			
			sharedObject.data.achi_caveManSpeed = achi_caveManSpeed;
			sharedObject.data.achi_caveManSuperSpeed = achi_caveManSuperSpeed;
			sharedObject.data.achi_caveManLightSpeed = achi_caveManLightSpeed;
			sharedObject.data.achi_caveManTimeWarp = achi_caveManTimeWarp;
			
			sharedObject.data.achi_AonEasyDifficulty = achi_AonEasyDifficulty;
			sharedObject.data.achi_AonMediumDifficulty = achi_AonMediumDifficulty;
			sharedObject.data.achi_AonHardDifficulty = achi_AonHardDifficulty;
			
			sharedObject.data.achi_fail = achi_fail;
			sharedObject.data.achi_extremeFail = achi_extremeFail;
			sharedObject.data.achi_epicFail = achi_epicFail;
			sharedObject.data.achi_worstFailEver = achi_worstFailEver;
			
			sharedObject.data.achi_slowStyle = achi_slowStyle;
			sharedObject.data.achi_turtleStyle = achi_turtleStyle;
			sharedObject.data.achi_mathQuizComplete = achi_mathQuizComplete;
			
			sharedObject.data.achi_fastAndSmart = achi_fastAndSmart;
			sharedObject.data.achi_fastAndBrillant = achi_fastAndBrillant;
			sharedObject.data.achi_fastAndIntelligent = achi_fastAndIntelligent;
			
			// Goals
			for(var i = 0; i < difficultiesCompleted.length; i++) {
					
				sharedObject.data.difficultiesCompleted += difficultiesCompleted[i]+",";
					
			}
				
			for(i = 0; i < difficultiesQuestions.length; i++) {
					
				sharedObject.data.difficultiesQuestions += difficultiesQuestions[i]+",";
					
			}
			
			try {
               	flushStatus = sharedObject.flush(2500);
			}
				
			catch (error:Error) {
				trace("Function saveGameAsBTN Error: Could not flush sharedObject: "+flushStatus);
            }
			
			notice("<b><font color='#005500'>Successfully saved "+sharedObject.data.Name+".</font></b>");
			loadSaves();
			
		}
		
		private function saveGameAsBTN(e:MouseEvent) {
			sharedObject = SharedObject.getLocal("MathQuiz_"+saveId);
			sharedObject.data.defined = true;
			sharedObject.data.Id = saveId;
			sharedObject.data.difficultiesCompleted = "";
			sharedObject.data.difficultiesQuestions = "";
			sharedObject.data.Name = saveGameAs_txt.text;
			
			saveGame();
			
			var txtCheck:Array = saveGameAs_txt.text.split("#");
			if(txtCheck[0] == "Math Quiz Saved Game ") {
				
				saveGameAs_txt.text = "Math Quiz Saved Game # "+ (saveId + 1);
				
			}
			
		}
			
		private function saveBTN(e:MouseEvent) {
				
			var flushStatus:String = null;
			sharedObject = SharedObject.getLocal("MathQuiz_"+loadId);
			sharedObject.data.difficultiesCompleted = "";
			sharedObject.data.difficultiesQuestions = "";
				
			saveGame();
			//loadSaves();
			
			saveStates_lis.selectedItem = null;
			load_btn.visible = false;
			save_btn.visible = false;
			rename_btn.visible = false;
			delete_btn.visible = false;
				
		}
			
		private function loadBTN(e:MouseEvent) {
				
			sharedObject = SharedObject.getLocal("MathQuiz_"+loadId);
				
			if(sharedObject.data.defined == true) {
					
				var DifficultiesCompleted:Array = sharedObject.data.difficultiesCompleted.split(",");
				var DifficultiesQuestions:Array = sharedObject.data.difficultiesQuestions.split(",");
				
				// Deletes that extra variable made by the saveGameAsBTN() Function ( In the For loop )
				DifficultiesCompleted.pop();
				DifficultiesQuestions.pop();
				
				// Achievements
				achi_100Questions = sharedObject.data.achi_100Questions;
				achi_90Questions = sharedObject.data.achi_90Questions;
				achi_80Questions = sharedObject.data.achi_80Questions;
				achi_70Questions = sharedObject.data.achi_70Questions;
				achi_60Questions = sharedObject.data.achi_60Questions;
				achi_50Questions = sharedObject.data.achi_50Questions;
				achi_40Questions = sharedObject.data.achi_40Questions;
				achi_30Questions = sharedObject.data.achi_30Questions;
				achi_20Questions = sharedObject.data.achi_20Questions;
				achi_10Questions = sharedObject.data.achi_10Questions;
			
				achi_allGreenNumbers = sharedObject.data.achi_allGreenNumbers;
				achi_allYellowNumbers = sharedObject.data.achi_allYellowNumbers;
				achi_allRedNumbers = sharedObject.data.achi_allRedNumbers;
			
				achi_caveManSpeed = sharedObject.data.achi_caveManSpeed;
				achi_caveManSuperSpeed = sharedObject.data.achi_caveManSuperSpeed;
				achi_caveManLightSpeed = sharedObject.data.achi_caveManLightSpeed;
				achi_caveManTimeWarp = sharedObject.data.achi_caveManTimeWarp;
			
				achi_AonEasyDifficulty = sharedObject.data.achi_AonEasyDifficulty;
				achi_AonMediumDifficulty = sharedObject.data.achi_AonMediumDifficulty;
				achi_AonHardDifficulty = sharedObject.data.achi_AonHardDifficulty;
				
				achi_fail = sharedObject.data.achi_fail;
				achi_extremeFail = sharedObject.data.achi_extremeFail;
				achi_epicFail = sharedObject.data.achi_epicFail;
				achi_worstFailEver = sharedObject.data.achi_worstFailEver;
				
				achi_slowStyle = sharedObject.data.achi_slowStyle;
				achi_turtleStyle = sharedObject.data.achi_turtleStyle;
				achi_mathQuizComplete = sharedObject.data.achi_mathQuizComplete;
				
				achi_fastAndSmart = sharedObject.data.achi_fastAndSmart;
				achi_fastAndBrillant = sharedObject.data.achi_fastAndBrillant;
				achi_fastAndIntelligent = sharedObject.data.achi_fastAndIntelligent;
			
				for(var i = 0; i < DifficultiesCompleted.length; i++) {
					
					if(DifficultiesCompleted[i] == "true")
					difficultiesCompleted[i] = true;
					else
					difficultiesCompleted[i] = false;
					
					difficultiesQuestions[i] = parseInt(DifficultiesQuestions[i]);
						
				}
				
				notice("<b><font color='#005522'>Successfully loaded "+sharedObject.data.Name+".</font></b>");
				
			}
			
			saveStates_lis.selectedItem = null;
			load_btn.visible = false;
			save_btn.visible = false;
			rename_btn.visible = false;
			delete_btn.visible = false;
			
		}
		
		private function renameBTN(e:MouseEvent) {
			
			sharedObject = SharedObject.getLocal("MathQuiz_"+loadId);
			sharedObject.data.Name = saveGameAs_txt.text;
			notice("<b>Successfully renamed "+sharedObject.data.Name+".</b>");
			loadSaves();
			
			saveStates_lis.selectedItem = null;
			load_btn.visible = false;
			save_btn.visible = false;
			rename_btn.visible = false;
			delete_btn.visible = false;
		}
		
		public function deleteBTN(e:MouseEvent) {
			
			// Placing slots higher in the index lower, to fill in the deleted index # gap.
			for(var i = loadId; i < saveId; i++) {
				
				var nextSharedObject:SharedObject = SharedObject.getLocal("MathQuiz_"+(i+1));
				sharedObject = SharedObject.getLocal("MathQuiz_"+i);
				
				if(nextSharedObject.data.defined != undefined) {
					sharedObject.data.Name = nextSharedObject.data.Name;
					sharedObject.data.difficultiesCompleted = nextSharedObject.data.difficultiesCompleted;
					sharedObject.data.difficultiesQuestions = nextSharedObject.data.difficultiesQuestions;
				} else {
					sharedObject.clear();
				}
				
			}
			
			loadSaves();
			saveStates_lis.selectedItem = null;
			load_btn.visible = false;
			save_btn.visible = false;
			rename_btn.visible = false;
			delete_btn.visible = false;
			
		}
		
		public function notice(message:String) {
			
			notice_mc.gotoAndPlay(2);
			notice_mc.notice_txt.htmlText = message;
			
		}
		
	}
	
}