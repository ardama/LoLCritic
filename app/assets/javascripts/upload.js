var champArray = new Array( 
	"Aatrox", "Ahri", "Akali", "Alistar", "Amumu", "Anivia", "Annie", "Ashe",
	"Blitzcrank", "Brand", "Caitlyn", "Cassiopeia", "Cho'gath", "Corki", "Darius", "Diana", "Dr. Mundo", "Draven", "Elise",
	"Evelynn", "Ezreal", "Fiddlesticks", "Fiora", "Fizz", "Galio", "Gangplank", "Garen", 
	"Gragas", "Graves", "Hecarim", "Heimerdinger", "Irelia", "Janna", "Jarvan IV", "Jax", "Jayce",
	"Karma", "Karthus", "Kassadin", "Katarina", "Kayle", "Kennen", "Kha'zix", "Kog'Maw", "LeBlanc", 
	"Lee Sin", "Leona", "Lissandra", "Lucian", "Lulu", "Lux", "Malphite", "Malzahar", "Maokai", "Master Yi", 
	"Miss Fortune", "Mordekaiser", "Morgana", "Nami", "Nasus", "Nautilus", "Nidalee", "Nocturne", 
	"Nunu", "Olaf", "Orianna", "Pantheon", "Poppy", "Quinn", "Rammus", "Renekton", "Rengar", "Riven", "Rumble", 
	"Ryze", "Sejuani", "Shaco", "Shen", "Shyvana", "Singed", "Sion", "Sivir", "Skarner", 
	"Sona", "Soraka", "Swain", "Syndra", "Talon", "Taric", "Teemo", "Thresh", "Tristana", "Trundle", "Trydamere", 
	"Twisted Fate", "Twitch", "Udyr", "Urgot", "Varus", "Vayne", "Veigar", "Vi", "Viktor", 
	"Vladimir", "Volibear", "Warwick", "Wukong", "Xerath", "Xin Zhao", "Yorick", "Zac", "Zed", "Ziggs", "Zilean", "Zyra"
	);
var laneArray = new Array(
	"Top Lane", "Mid Lane", "Jungle", "Bot Lane"
	);
var positionArray = new Array(
	"Tank", "Initiator", "Bruiser", "Assassin", "Support", "Marksman", "Mage"
	);
var focusArray = new Array(
	"Last Hitting", "Zoning", "Harassing", "Warding", "Item Builds", "Invading", "Ganking", "Roaming", 
	"Map Awareness", "Teamfighting", "Positioning", "Taking Objectives", "Initiating", "Tanking",
	"Kiting", "Focusing", "Matchups"
	);	

populateOptions = function(element, optionArray) {

	for (var i = 0; i < optionArray.length; i++) {
		var newOption = "<option value=\"" + optionArray[i] + "\">" + optionArray[i] + "</option>";
		$(element).append(newOption);
	}
}
$( document ).ready(function() {

	populateOptions('#video_champion',champArray);
	populateOptions('#video_opponent',champArray);
	populateOptions('#video_lane',laneArray);
	populateOptions('#video_position',positionArray);
	populateOptions('#video_focus',focusArray);

	$('#video_champion').chosen({allow_single_deselect: true, placeholder_text_single: "What champion were you playing?"});	
	$('#video_opponent').chosen({allow_single_deselect: true, placeholder_text_single: "Who were you laning against?"});	
	$('#video_lane').chosen({allow_single_deselect: true, placeholder_text_single: "What lane were you in?"});	
	$('#video_position').chosen({placeholder_text_multiple: "What was your role on the team?"});	
	$('#video_focus').chosen({placeholder_text_multiple: "What is the focus of this video?"});
});