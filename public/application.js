$(document).ready(function() {
	player_hit();
	split_hit();
	player_double_down();
	split_double_down();
	player_split();
	player_stay();
	split_stay();
	dealer_hit();
});

function player_hit(){
	$(document).on('click', '#hit_button', function(){
		$.ajax({
			type: 'POST',
			url: '/game/player/hit'
		}).done(function(msg){
			$('#game').replaceWith(msg);
		});
		return false;
	});
};

function split_hit(){
	$(document).on('click', '#split_hit_button', function(){
		$.ajax({
			type: 'POST',
			url: '/game/split/hit'
		}).done(function(msg){
			$('#game').replaceWith(msg);
		});
		return false;
	});
};

function player_double_down(){
	$(document).on('click', '#double_down_button', function(){
		$.ajax({
			type: 'POST',
			url: '/game/player/double_down'
		}).done(function(msg){
			$('#game').replaceWith(msg);
		});
		return false;
	});
};

function split_double_down(){
	$(document).on('click', '#split_down_button', function(){
		$.ajax({
			type: 'POST',
			url: '/game/split/double_down'
		}).done(function(msg){
			$('#game').replaceWith(msg);
		});
		return false;
	});
};

function player_split(){
	$(document).on('click', '#split_button', function(){
		$.ajax({
			type: 'POST',
			url: '/game/player/split'
		}).done(function(msg){
			$('#game').replaceWith(msg);
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
			$('#game').replaceWith(msg);
		});
		return false;
	});
};

function split_stay(){
	$(document).on('click', '#split_stay_button', function(){
		$.ajax({
			type: 'POST',
			url: '/game/split/stay'
		}).done(function(msg){
			$('#game').replaceWith(msg);
		});
		return false;
	});
};

function dealer_hit(){
	$(document).on('click', '#dealer_hit_button', function(){
		$.ajax({
			type: 'POST',
			url: '/game/dealer/hit'
		}).done(function(msg){
			$('#game').replaceWith(msg);
		});
		return false;
	});
};