(() => {

	SKYLINE = {};
	SKYLINE.HUDElements = [];

	SKYLINE.setHUDDisplay = function (opacity) {
		$('#hud').css('opacity', opacity);
	};

	SKYLINE.insertHUDElement = function (name, index, priority, html, data) {
		SKYLINE.HUDElements.push({
			name: name,
			index: index,
			priority: priority,
			html: html,
			data: data
		});

		SKYLINE.HUDElements.sort((a, b) => {
			return a.index - b.index || b.priority - a.priority;
		});
	};

	SKYLINE.updateHUDElement = function (name, data) {
		for (let i = 0; i < SKYLINE.HUDElements.length; i++) {
			if (SKYLINE.HUDElements[i].name == name) {
				SKYLINE.HUDElements[i].data = data;
			}
		}

		SKYLINE.refreshHUD();
	};

	SKYLINE.deleteHUDElement = function (name) {
		for (let i = 0; i < SKYLINE.HUDElements.length; i++) {
			if (SKYLINE.HUDElements[i].name == name) {
				SKYLINE.HUDElements.splice(i, 1);
			}
		}

		SKYLINE.refreshHUD();
	};

	SKYLINE.refreshHUD = function () {
		$('#hud').html('');

		for (let i = 0; i < SKYLINE.HUDElements.length; i++) {
			let html = Mustache.render(SKYLINE.HUDElements[i].html, SKYLINE.HUDElements[i].data);
			$('#hud').append(html);
		}
	};

	SKYLINE.inventoryNotification = function (add, label, count) {
		let notif = '';

		if (add) {
			notif += '+';
		} else {
			notif += '-';
		}

		if (count) {
			notif += count + ' ' + label;
		} else {
			notif += ' ' + label;
		}

		let elem = $('<div>' + notif + '</div>');
		$('#inventory_notifications').append(elem);

		$(elem).delay(3000).fadeOut(1000, function () {
			elem.remove();
		});
	};

	window.onData = (data) => {
		switch (data.action) {
			case 'inventoryNotification': {
				SKYLINE.inventoryNotification(data.add, data.item, data.count);
			}
		}
	};

	window.onload = function (e) {
		window.addEventListener('message', (event) => {
			onData(event.data);
		});
	};

})();