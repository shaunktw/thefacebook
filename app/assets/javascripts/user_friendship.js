window.userFriendships = [];

$(document).ready(function() {
	$.ajax ({
		url: Routes.user_frienships_path
	})
}

$(document).ready(function) {

	$('#add-frienship').click(function(event) {
		event.preventDefault();
		var addFriendshipBtn = $(this);		
		$.ajax({
			url: Routes.user_frienships_path({user_frienship: {friend_id: addFriendshipBtn.data('friendId')}}), 
			dataType: 'json', 
			type: 'POST', 
			success: function(e) {
				addFriendshipBtn.hide();
				$('#friend-status').html("<a href = '#' class='btn btn-success'> Frienship Rquested </a>");
			}
		});
	});

});