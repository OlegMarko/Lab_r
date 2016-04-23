$(document).ready(function() {
	//alert("Мій перший JS");
	var name = prompt("Як вас звати?");
	window.status = "Відвідайте сторінку Яндекс!";
	if (name) {
		$(".user").text(name);
	} else {
		$(".user").text("....");
	}
});

function onClick() {
	alert("Ви клікнули на кнопку");
};

function focusInput() {
	var Text1 = $(".res").val();
	if (Text1 != "result") {
		$(".res").val("result");
	};
};

function resFunc() {
	var number1 = parseInt($(".number1").val());
	var number2 = parseInt($(".number2").val());
	var number3 = parseInt($(".number3").val());
	if (number1 && number2 && number3) {
		var res = (number1 + number2 + number3) / 3;
		$(".res").val(res);
	};
};

function getResult() {
	
	var planet = new Array(15);
	planet[0] = "Земля";
	planet[1] = "Сатурн";
	planet[2] = "Юпітер";
	planet[3] = "Марс";
	planet[4] = "Плутон";
	planet[5] = "Меркурій";
	planet[6] = "Венера";
	planet[7] = "Уран";
	planet[8] = "Нептун";
	planet[9] = "1RXS1609 b";
	planet[10] = "BD +14 4559 b";
	planet[11] = "HAT-P-22 b";
	planet[12] = "HD 104067 b";
	planet[14] = "GJ 433 b";

	var ras = new Array(15);  
	ras[0] = "149.6 млн. км";
	ras[1] = "14,3 мільярда км";
	ras[2] = "764 800 000 км";
	ras[3] = "228 млн. км";
	ras[4] = "5920 млн км";
	ras[5] = "46 млн.км";
	ras[6] = "107803 млн км";
	ras[7] = "2853 млн. км";
	ras[8] = "4500 млн. км";
	ras[9] = "45 пк";
	ras[10] = "52 пк";
	ras[11] = "82 пк";
	ras[12] = "20.8 пк";
	ras[14] = "9.04 пк";

	var diam = new Array(15);
	diam[0] = "12757 кілометрів";
	diam[1] = "120000 км";
	diam[2] = "142 984 км";
	diam[3] = "6800 км";
	diam[4] = "5500 км";
	diam[5] = "4880 км";
	diam[6] = "12 100 км";
	diam[7] = "60 км";
	diam[8] = "4000 км";
	diam[9] = "242 984 км";
	diam[10] = "1547 км";
	diam[11] = "1440 км";
	diam[12] = "1414 км";
	diam[14] = "1231 км";

	
	var searchCountry = $(".contunent").val();
	for (var i = 0; i < planet.length; i++) {
		if (planet[i] == searchCountry) {
			break;
		}
	}
	var msg = "відстань від" + planet[i] + "до сонця =" + ras[i] + "діаметр планети =" + diam[i];
	alert(msg);
}