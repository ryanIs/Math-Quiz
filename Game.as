
/* Created by Ryan Isler

Feel free to add more questions. In fact, the more questions that is in
the possibleQuestions Array, the better. It means more possibilites for
the game player. :D

*/

package {
	
	import flash.display.*;
	
	public class Game {
		
		public var totalIncorrect:Number = 0;
		public var totalCorrect:Number = 0;
		public var totalQuestions:Number;
		public var onQuestionNumber:Number = 0;
		public var onQuestion:String;
		public var onAnswer:String;
		public var Difficulty:Number;
		
		private var possibleQuestions:Array = [
			"add",
			"minus",
			"times",
			"divide"
		];
		
		private var possibleAnswers:Array = [
			"math",
			"math",
			"math",
			"math"
		];
		
		public var gameDone:Boolean = false;
		
		public function Game(difficulty:Number, questions:Number) {
			Difficulty = difficulty;
			totalQuestions = questions;
			
			generateQuestion();
		}
		
		public function inputAnswer(answer:String):Boolean {
			var correct:Boolean = false;
			
			if(answer == onAnswer.toString()) {
				correct = true;
				totalCorrect++;
			}
			
			else {
				totalIncorrect++;
			}
			
			return correct;
			
		}
		
		public function gameOver() {
			
			gameDone = true;
			
		}
		
		public function generateQuestion() {
			
			var sideA:String;
			var sideB:String;
			var sideC:String;
			var sideD:String;
			var sideE:String;
			var sideF:String;
			var onAnswerNumber:Number;
			
			var amountOfSides:Number;
			
			if(Difficulty < 2) {
				amountOfSides = 0;
			}
			
			else if(Difficulty == 2 || Difficulty == 3) {
				amountOfSides = random(2);
			}
			
			else if(Difficulty > 3 && Difficulty < 7) {
				amountOfSides = random(3);
			}
			
			else if(Difficulty > 6) {
				amountOfSides = random(5);
			}
			
			var chosenQuestion:Number = random(possibleQuestions.length);
			onQuestion = possibleQuestions[ chosenQuestion ];
			onAnswer = possibleAnswers[ chosenQuestion ];
			
			// Special Cases:
			if(onQuestion == "add") {
				
				if(amountOfSides == 0) {
					
					sideA = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					sideB = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					onQuestion = "What is<br>"+sideA+" + "+sideB;
					onAnswerNumber = parseInt(sideA) + parseInt(sideB);
					onAnswer = onAnswerNumber.toString();
					
					
				} else if(amountOfSides == 1) {
					
					sideA = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					sideB = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					sideC = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					onQuestion = "What is<br>"+sideA+" + "+sideB+" + "+sideC;
					onAnswerNumber = parseInt(sideA) + parseInt(sideB) + parseInt(sideC);
					onAnswer = onAnswerNumber.toString();
					
				} else if(amountOfSides == 2) {
					
					sideA = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					sideB = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					sideC = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					sideD = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					onQuestion = "What is<br>"+sideA+" + "+sideB+" + "+sideC+" + "+sideD;
					onAnswerNumber = parseInt(sideA) + parseInt(sideB) + parseInt(sideC) + parseInt(sideD);
					onAnswer = onAnswerNumber.toString();
				
				} else if(amountOfSides == 3) {
					
					sideA = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					sideB = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					sideC = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					sideD = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					sideE = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					onQuestion = "What is<br>"+sideA+" + "+sideB+" + "+sideC+" + "+sideD+" + "+sideE;
					onAnswerNumber = parseInt(sideA) + parseInt(sideB) + parseInt(sideC) + parseInt(sideD) + parseInt(sideE);
					onAnswer = onAnswerNumber.toString();
				
				} else {
					
					sideA = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					sideB = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					sideC = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					sideD = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					sideE = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					sideF = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					onQuestion = "What is<br>"+sideA+" + "+sideB+" + "+sideC+" + "+sideD+" + "+sideE+" + "+sideF;
					onAnswerNumber = parseInt(sideA) + parseInt(sideB) + parseInt(sideC) + parseInt(sideD) + parseInt(sideE) + parseInt(sideF);
					onAnswer = onAnswerNumber.toString();
				
				}
				
			}
			
			else if(onQuestion == "minus") {
				
				if(amountOfSides == 0) {
					
					sideA = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					sideB = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					onQuestion = "What is<br>"+sideA+" - "+sideB;
					onAnswerNumber = parseInt(sideA) - parseInt(sideB);
					onAnswer = onAnswerNumber.toString();
				
				} else if(amountOfSides == 1) {
					
					sideA = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					sideB = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					sideC = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					onQuestion = "What is<br>"+sideA+" - "+sideB+" - "+sideC;
					onAnswerNumber = parseInt(sideA) - parseInt(sideB) - parseInt(sideC);
					onAnswer = onAnswerNumber.toString();
				
				} else if(amountOfSides == 2) {
					
					sideA = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					sideB = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					sideC = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					sideD = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					onQuestion = "What is<br>"+sideA+" -"+sideB+" - "+sideC+" - "+sideD;
					onAnswerNumber = parseInt(sideA) - parseInt(sideB) - parseInt(sideC) - parseInt(sideD);
					onAnswer = onAnswerNumber.toString();
					
				} else if(amountOfSides == 3) {
					
					sideA = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					sideB = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					sideC = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					sideD = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					sideE = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					onQuestion = "What is<br>"+sideA+" - "+sideB+" - "+sideC+" - "+sideD+" - "+sideE;
					onAnswerNumber = parseInt(sideA) - parseInt(sideB) - parseInt(sideC) - parseInt(sideD) - parseInt(sideE);
					onAnswer = onAnswerNumber.toString();
				
				} else {
					
					sideA = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					sideB = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					sideC = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					sideD = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					sideE = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					sideF = ""+ ( random(20 * Difficulty) + random(Difficulty) );
					onQuestion = "What is<br>"+sideA+" - "+sideB+" - "+sideC+" - "+sideD+" - "+sideE+" + "+sideF;
					onAnswerNumber = parseInt(sideA) - parseInt(sideB) - parseInt(sideC) - parseInt(sideD) - parseInt(sideE) - parseInt(sideF);
					onAnswer = onAnswerNumber.toString();
				
				}
				
			}
			
			else if(onQuestion == "times") {
				
				if(amountOfSides == 0) {
					
					sideA = ""+ ( random(10) );
					sideB = ""+ ( random(10) );
					onQuestion = "What is<br>"+sideA+" * "+sideB;
					onAnswerNumber = parseInt(sideA) * parseInt(sideB);
					onAnswer = onAnswerNumber.toString();
				
				} else if(amountOfSides == 1) {
					sideA = ""+ ( random(10) );
					sideB = ""+ ( random(10) );
					sideC = ""+ ( random(10) );
					onQuestion = "What is<br>"+sideA+" * "+sideB+" * "+sideC;
					onAnswerNumber = parseInt(sideA) * parseInt(sideB) * parseInt(sideC);
					onAnswer = onAnswerNumber.toString();
					
				} else if(amountOfSides == 2) {
					
					sideA = ""+ ( random(10) );
					sideB = ""+ ( random(10) );
					sideC = ""+ ( random(10) );
					sideD = ""+ ( random(10) );
					onQuestion = "What is<br>"+sideA+" * "+sideB+" * "+sideC+" * "+sideD;
					onAnswerNumber = parseInt(sideA) * parseInt(sideB) * parseInt(sideC) * parseInt(sideD);
					onAnswer = onAnswerNumber.toString();
				
				} else if(amountOfSides == 3) {
					
					sideA = ""+ ( random(10) );
					sideB = ""+ ( random(10) );
					sideC = ""+ ( random(10) );
					sideD = ""+ ( random(10) );
					sideE = ""+ ( random(10) );
					onQuestion = "What is<br>"+sideA+" * "+sideB+" * "+sideC+" * "+sideD+" * "+sideE;
					onAnswerNumber = parseInt(sideA) * parseInt(sideB) * parseInt(sideC) * parseInt(sideD) * parseInt(sideE);
					onAnswer = onAnswerNumber.toString();
				
				} else {
					
					sideA = ""+ ( random(10) );
					sideB = ""+ ( random(10) );
					sideC = ""+ ( random(10) );
					sideD = ""+ ( random(10) );
					sideE = ""+ ( random(10) );
					sideF = ""+ ( random(10) );
					onQuestion = "What is<br>"+sideA+" * "+sideB+" * "+sideC+" * "+sideD+" * "+sideE+" * "+sideF;
					onAnswerNumber = parseInt(sideA) * parseInt(sideB) * parseInt(sideC) * parseInt(sideD) * parseInt(sideE) * parseInt(sideF);
					onAnswer = onAnswerNumber.toString();
				
				}
				
			}
			
			else if(onQuestion == "divide") {
				
				sideA = ""+ ( random(6 * Difficulty) + random(Difficulty) );
				sideB = ""+ ( random(3 * Difficulty) + random(Difficulty) );
				
				if(sideA == "0") sideA = "1";
				if(sideB == "0") sideB = "1";
				
				onQuestion = "What is<br>"+sideA+" / "+sideB+"<br>(Round to the nearest whole number)";
				onAnswerNumber = Math.round(parseInt(sideA) / parseInt(sideB));
				onAnswer = onAnswerNumber.toString();
			
			}
			
			onQuestionNumber++;
			
		}
		
		function random(i:Number):Number {
			
			return Math.floor( Math.random() * i );
			
		}
		
	}
	
}