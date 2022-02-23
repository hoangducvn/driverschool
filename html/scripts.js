// question variables
var questionNumber = 1;
var userAnswer = [];
var goodAnswer = [];
var questionUsed = [];
var nbQuestionToAnswer = 10; // don't forget to change the progress bar max value in html
var nbAnswerNeeded = 5; // out of nbQuestionToAnswer
var nbPossibleQuestions = 10; // number of questions in database questions.js
var lastClick = 0;
var multilang = {};

function getRandomQuestion() {
	var random = Math.floor(Math.random() * nbPossibleQuestions);

	while (true) {
		if (questionUsed.indexOf(random) === -1) {
			break;
		}

		random = Math.floor(Math.random() * nbPossibleQuestions);
	}

	questionUsed.push(random);

	return random;
}

// Partial Functions
function closeMain() {
	$(".home").css("display", "none");
}
function openMain() {
	$(".home").css("display", "block");
}
function closeAll() {
	$(".body").css("display", "none");
}
function openQuestionnaire() {
	
	$(".questionnaire-container").css("display", "block");
	var randomQuestion = getRandomQuestion();

	$("#questionNumero").html(multilang.question + questionNumber);
	$("#question").html(multilang.questionlist[randomQuestion].question);
	$(".answerA").html(multilang.questionlist[randomQuestion].propositionA);
	$(".answerB").html(multilang.questionlist[randomQuestion].propositionB);
	$(".answerC").html(multilang.questionlist[randomQuestion].propositionC);
	$(".answerD").html(multilang.questionlist[randomQuestion].propositionD);
	$('input[name=question]').attr('checked', false);

	goodAnswer.push(multilang.questionlist[randomQuestion].reponse);
	$(".questionnaire-container .progression").val(questionNumber - 1);
}
function openResultGood() {
	$(".resultGood").css("display", "block");
}
function openResultBad() {
	$(".resultBad").css("display", "block");
}
function openContainer() {
	$(".question-container").css("display", "block");
}
function closeContainer() {
	$(".question-container").css("display", "none");
}

// Listen for NUI Events
window.addEventListener('message', function (event) {
	var item = event.data;

	// Open & Close main window
	if (item.openQuestion == true) {
		multilang = item.multilang;
		$("#mtheader").html(multilang.mtheader);
		$("#mlcontent").html(multilang.mlcontent);
		$("#mlbt").html(multilang.mlbt);
		$("#mlprogression").html(multilang.mlprogression);
		$("#mlprogression1").html(multilang.mlprogression);
		$("#mlprogression2").html(multilang.mlprogression);
		$("#mlprogression3").html(multilang.mlprogression);
		$("#mlresultgood").html(multilang.mlresultgood);
		$("#mlresultbad").html(multilang.mlresultbad);
		$("#submit").html(multilang.submit);
		$("#mlclose").html(multilang.mlclose);
		$("#mlclose1").html(multilang.mlclose);
		openContainer();
		openMain();
	}

	if (item.openQuestion == false) {
		multilang = {};
		closeContainer();
		closeMain();
	}

	// Open sub-windows / partials
	if (item.openSection == "question") {
		closeAll();
		openQuestionnaire();
	}
});

// Handle Button Presses
$(".btnQuestion").click(function () {
	$.post('http://driverschool/question', JSON.stringify({}));
});

$(".btnClose").click(function () {
	$.post('http://driverschool/close', JSON.stringify({}));
	userAnswer = [];
	goodAnswer = [];
	questionUsed = [];
	questionNumber = 1;
});

$(".btnKick").click(function () {
	$.post('http://driverschool/kick', JSON.stringify({}));
	userAnswer = [];
	goodAnswer = [];
	questionUsed = [];
	questionNumber = 1;
});

// Handle Form Submits
$("#question-form").submit(function (e) {
	e.preventDefault();

	if (questionNumber != nbQuestionToAnswer) {
		//question 1 to 9: pushing answer in array
		closeAll();
		userAnswer.push($('input[name="question"]:checked').val());
		questionNumber++;
		openQuestionnaire();
	} else {
		// question 10: comparing arrays and sending number of good answers
		userAnswer.push($('input[name="question"]:checked').val());
		var nbGoodAnswer = 0;
		for (i = 0; i < nbQuestionToAnswer; i++) {
			if (userAnswer[i] == goodAnswer[i]) {
				nbGoodAnswer++;
			}
		}

		closeAll();
		if (nbGoodAnswer >= nbAnswerNeeded) {
			openResultGood();
		} else {
			openResultBad();
		}
	}

	return false;
});
