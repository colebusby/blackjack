$(document).ready(function() {
	player_hit();
	player_stay();
});

function player_hit(){
	$(document).on('click', '#hit_button', function(){
		$.ajax({
			type: 'POST',
			url: '/game/player/hit'
		}).done(function(msg){
			$('#game').html(msg);
		});
		return false;
	});
};

function player_stay(){
	$(document).on('click', '#stay_button', function(){
		$.ajax({
			type: 'POST',
			url: '/game/player/stay'
		}).done(function(msg){
			$('#game').html(msg);
		});
		return false;
	});
};