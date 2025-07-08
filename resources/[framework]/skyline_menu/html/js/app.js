(function(){

	let MenuTpl =
		'<div id="menu_{{_namespace}}_{{_name}}" class="menu{{#align}} align-{{align}}{{/align}}">' +
			'<div class="head"><span class="title">{{{title}}}</span></div>' +
				'<div class="menu-items">' + 
					'{{#elements}}' +
						'<div class="menu-item">' +
							'<div class="border"><div class="text {{#selected}}selected{{/selected}}">{{{label}}}{{#isSlider}} : &lt;{{{sliderLabel}}}&gt;{{/isSlider}}</div></div>' +
						'</div>' +
					'{{/elements}}' +
				'</div>'+
			'</div>' +
		'</div>'
	;
	window.SKYLINE_MENU       = {};
	SKYLINE_MENU.ResourceName = 'skyline_menu';
	SKYLINE_MENU.opened       = {};
	SKYLINE_MENU.focus        = [];
	SKYLINE_MENU.pos          = {};

	SKYLINE_MENU.open = function(namespace, name, data) {

		if (typeof SKYLINE_MENU.opened[namespace] == 'undefined') {
			SKYLINE_MENU.opened[namespace] = {};
		}

		if (typeof SKYLINE_MENU.opened[namespace][name] != 'undefined') {
			SKYLINE_MENU.close(namespace, name);
		}

		if (typeof SKYLINE_MENU.pos[namespace] == 'undefined') {
			SKYLINE_MENU.pos[namespace] = {};
		}

		for (let i=0; i<data.elements.length; i++) {
			if (typeof data.elements[i].type == 'undefined') {
				data.elements[i].type = 'default';
			}
		}

		data._index     = SKYLINE_MENU.focus.length;
		data._namespace = namespace;
		data._name      = name;

		for (let i=0; i<data.elements.length; i++) {
			data.elements[i]._namespace = namespace;
			data.elements[i]._name      = name;
		}

		SKYLINE_MENU.opened[namespace][name] = data;
		SKYLINE_MENU.pos   [namespace][name] = 0;

		for (let i=0; i<data.elements.length; i++) {
			if (data.elements[i].selected) {
				SKYLINE_MENU.pos[namespace][name] = i;
			} else {
				data.elements[i].selected = false;
			}
		}

		SKYLINE_MENU.focus.push({
			namespace: namespace,
			name     : name
		});
		
		SKYLINE_MENU.render();
		$('#menu_' + namespace + '_' + name).find('.text.selected')[0].scrollIntoView();
	};

	SKYLINE_MENU.close = function(namespace, name) {
		
		delete SKYLINE_MENU.opened[namespace][name];

		for (let i=0; i<SKYLINE_MENU.focus.length; i++) {
			if (SKYLINE_MENU.focus[i].namespace == namespace && SKYLINE_MENU.focus[i].name == name) {
				SKYLINE_MENU.focus.splice(i, 1);
				break;
			}
		}

		SKYLINE_MENU.render();

	};

	SKYLINE_MENU.render = function() {

		let menuContainer       = document.getElementById('menus');
		let focused             = SKYLINE_MENU.getFocused();
		menuContainer.innerHTML = '';

		$(menuContainer).hide();

		for (let namespace in SKYLINE_MENU.opened) {
			for (let name in SKYLINE_MENU.opened[namespace]) {

				let menuData = SKYLINE_MENU.opened[namespace][name];
				let view     = JSON.parse(JSON.stringify(menuData));

				for (let i=0; i<menuData.elements.length; i++) {
					let element = view.elements[i];

					switch (element.type) {
						case 'default' : break;

						case 'slider' : {
							element.isSlider    = true;
							element.sliderLabel = (typeof element.options == 'undefined') ? element.value : element.options[element.value];

							break;
						}

						default : break;
					}

					if (i == SKYLINE_MENU.pos[namespace][name]) {
						element.selected = true;
					}
				}

				let menu = $(Mustache.render(MenuTpl, view))[0];
				$(menu).hide();
				menuContainer.appendChild(menu);
			}
		}

		if (typeof focused != 'undefined') {
			$('#menu_' + focused.namespace + '_' + focused.name).show();
		}

		$(menuContainer).show();

	};

	SKYLINE_MENU.submit = function(namespace, name, data) {
		$.post('https://' + SKYLINE_MENU.ResourceName + '/menu_submit', JSON.stringify({
			_namespace: namespace,
			_name     : name,
			current   : data,
			elements  : SKYLINE_MENU.opened[namespace][name].elements
		}));
	};

	SKYLINE_MENU.cancel = function(namespace, name) {
		$.post('https://' + SKYLINE_MENU.ResourceName + '/menu_cancel', JSON.stringify({
			_namespace: namespace,
			_name     : name
		}));
	};

	SKYLINE_MENU.change = function(namespace, name, data) {
		$.post('https://' + SKYLINE_MENU.ResourceName + '/menu_change', JSON.stringify({
			_namespace: namespace,
			_name     : name,
			current   : data,
			elements  : SKYLINE_MENU.opened[namespace][name].elements
		}));
	};

	SKYLINE_MENU.getFocused = function() {
		return SKYLINE_MENU.focus[SKYLINE_MENU.focus.length - 1];
	};

	window.onData = (data) => {

		switch (data.action) {

			case 'openMenu': {
				SKYLINE_MENU.open(data.namespace, data.name, data.data);
				break;
			}

			case 'closeMenu': {
				SKYLINE_MENU.close(data.namespace, data.name);
				break;
			}

			case 'controlPressed': {

				switch (data.control) {

					case 'ENTER': {
						let focused = SKYLINE_MENU.getFocused();

						if (typeof focused != 'undefined') {
							let menu    = SKYLINE_MENU.opened[focused.namespace][focused.name];
							let pos     = SKYLINE_MENU.pos[focused.namespace][focused.name];
							let elem    = menu.elements[pos];

							if (menu.elements.length > 0) {
								SKYLINE_MENU.submit(focused.namespace, focused.name, elem);
							}
						}

						break;
					}

					case 'BACKSPACE': {
						let focused = SKYLINE_MENU.getFocused();

						if (typeof focused != 'undefined') {
							SKYLINE_MENU.cancel(focused.namespace, focused.name);
						}

						break;
					}

					case 'TOP': {

						let focused = SKYLINE_MENU.getFocused();

						if (typeof focused != 'undefined') {

							let menu = SKYLINE_MENU.opened[focused.namespace][focused.name];
							let pos  = SKYLINE_MENU.pos[focused.namespace][focused.name];

							if (pos > 0) {
								SKYLINE_MENU.pos[focused.namespace][focused.name]--;
							} else {
								SKYLINE_MENU.pos[focused.namespace][focused.name] = menu.elements.length - 1;
							}

							let elem = menu.elements[SKYLINE_MENU.pos[focused.namespace][focused.name]];

							for (let i=0; i<menu.elements.length; i++) {
								if (i == SKYLINE_MENU.pos[focused.namespace][focused.name]) {
									menu.elements[i].selected = true;
								} else {
									menu.elements[i].selected = false;
								}
							}

							SKYLINE_MENU.change(focused.namespace, focused.name, elem);
							SKYLINE_MENU.render();

							$('#menu_' + focused.namespace + '_' + focused.name).find('.text.selected')[0].scrollIntoView();
						}

						break;

					}

					case 'DOWN' : {

						let focused = SKYLINE_MENU.getFocused();

						if (typeof focused != 'undefined') {
							let menu   = SKYLINE_MENU.opened[focused.namespace][focused.name];
							let pos    = SKYLINE_MENU.pos[focused.namespace][focused.name];
							let length = menu.elements.length;

							if (pos < length - 1) {
								SKYLINE_MENU.pos[focused.namespace][focused.name]++;
							} else {
								SKYLINE_MENU.pos[focused.namespace][focused.name] = 0;
							}

							let elem = menu.elements[SKYLINE_MENU.pos[focused.namespace][focused.name]];

							for (let i=0; i<menu.elements.length; i++) {
								if (i == SKYLINE_MENU.pos[focused.namespace][focused.name]) {
									menu.elements[i].selected = true;
								} else {
									menu.elements[i].selected = false;
								}
							}

							SKYLINE_MENU.change(focused.namespace, focused.name, elem);
							SKYLINE_MENU.render();

							$('#menu_' + focused.namespace + '_' + focused.name).find('.text.selected')[0].scrollIntoView();
						}

						break;
					}

					case 'LEFT' : {

						let focused = SKYLINE_MENU.getFocused();

						if (typeof focused != 'undefined') {
							let menu = SKYLINE_MENU.opened[focused.namespace][focused.name];
							let pos  = SKYLINE_MENU.pos[focused.namespace][focused.name];
							let elem = menu.elements[pos];

							switch(elem.type) {
								case 'default': break;

								case 'slider': {
									let min = (typeof elem.min == 'undefined') ? 0 : elem.min;

									if (elem.value > min) {
										elem.value--;
										SKYLINE_MENU.change(focused.namespace, focused.name, elem);
									}

									SKYLINE_MENU.render();
									break;
								}

								default: break;
							}

							$('#menu_' + focused.namespace + '_' + focused.name).find('.text.selected')[0].scrollIntoView();
						}

						break;
					}

					case 'RIGHT' : {

						let focused = SKYLINE_MENU.getFocused();

						if (typeof focused != 'undefined') {
							let menu = SKYLINE_MENU.opened[focused.namespace][focused.name];
							let pos  = SKYLINE_MENU.pos[focused.namespace][focused.name];
							let elem = menu.elements[pos];

							switch(elem.type) {
								case 'default': break;

								case 'slider': {
									if (typeof elem.options != 'undefined' && elem.value < elem.options.length - 1) {
										elem.value++;
										SKYLINE_MENU.change(focused.namespace, focused.name, elem);
									}

									if (typeof elem.max != 'undefined' && elem.value < elem.max) {
										elem.value++;
										SKYLINE_MENU.change(focused.namespace, focused.name, elem);
									}

									SKYLINE_MENU.render();
									break;
								}

								default: break;
							}

							$('#menu_' + focused.namespace + '_' + focused.name).find('.text.selected')[0].scrollIntoView();
						}

						break;
					}

					default : break;

				}

				break;
			}

		}

	};

	window.onload = function(e){
		window.addEventListener('message', (event) => {
			onData(event.data);
		});
	};

})();