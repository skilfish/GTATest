(function(){

let MenuTpl =
		'<div id="menu_{{_namespace}}_{{_name}}" class="dialog {{#isBig}}big{{/isBig}}">' +
		'<p class="desc">EINGABE</p>' +
			'{{#isDefault}}<input name="value" id="inputText" type="text" placeholder="Gebe etwas ein..." />{{/isDefault}}' +
				'{{#isBig}}<textarea name="value"/>{{/isBig}}' +
				'<button type="button" name="submit">Bestätigen</button>' +
				'<button type="button" name="cancel">Abbrechen</button>'
			'</div>' +
		'</div>'
	;

	window.SKYLINE_MENU       = {};
	SKYLINE_MENU.ResourceName = 'skyline_dialog';
	SKYLINE_MENU.opened       = {};
	SKYLINE_MENU.focus        = [];
	SKYLINE_MENU.pos          = {};

	SKYLINE_MENU.open = function(namespace, name, data) {

		if(typeof SKYLINE_MENU.opened[namespace] == 'undefined')
			SKYLINE_MENU.opened[namespace] = {};

		if(typeof SKYLINE_MENU.opened[namespace][name] != 'undefined')
			SKYLINE_MENU.close(namespace, name);

		if(typeof SKYLINE_MENU.pos[namespace] == 'undefined')
			SKYLINE_MENU.pos[namespace] = {};

		if(typeof data.type == 'undefined')
			data.type = 'default';

		if(typeof data.align == 'undefined')
			data.align = 'top-left';

		data._index     = SKYLINE_MENU.focus.length;
		data._namespace = namespace;
		data._name      = name;

		SKYLINE_MENU.opened[namespace][name] = data;
		SKYLINE_MENU.pos   [namespace][name] = 0;

		SKYLINE_MENU.focus.push({
			namespace: namespace,
			name     : name
		});

		document.onkeyup = function (key) {
			if (key.which == 27) { // Escape key
				$.post('https://' + SKYLINE_MENU.ResourceName + '/menu_cancel', JSON.stringify(data));
			} else if (key.which == 13) { // Enter key
				$.post('https://' + SKYLINE_MENU.ResourceName + '/menu_submit', JSON.stringify(data));
			}
		};

		SKYLINE_MENU.render();
	}

	SKYLINE_MENU.close = function(namespace, name) {
		
		delete SKYLINE_MENU.opened[namespace][name];

		for(let i=0; i<SKYLINE_MENU.focus.length; i++){
			if(SKYLINE_MENU.focus[i].namespace == namespace && SKYLINE_MENU.focus[i].name == name){
				SKYLINE_MENU.focus.splice(i, 1);
				break;
			}
		}

		SKYLINE_MENU.render();
	}

	SKYLINE_MENU.render = function() {

		let menuContainer = $('#menus')[0];
		
		$(menuContainer).find('button[name="submit"]').unbind('click');
		$(menuContainer).find('button[name="cancel"]').unbind('click');
		$(menuContainer).find('[name="value"]')       .unbind('input propertychange');

		menuContainer.innerHTML = '';

		$(menuContainer).hide();

		for(let namespace in SKYLINE_MENU.opened){
			for(let name in SKYLINE_MENU.opened[namespace]){

				let menuData = SKYLINE_MENU.opened[namespace][name];
				let view     = JSON.parse(JSON.stringify(menuData));

				switch(menuData.type){

					case 'default' : {
						view.isDefault = true;
						break;
					}

					case 'big' : {
						view.isBig = true;
						break;
					}

					default : break;
				}

				let menu = $(Mustache.render(MenuTpl, view))[0];

				$(menu).css('z-index', 1000 + view._index);

				$(menu).find('button[name="submit"]').click(function() {
					SKYLINE_MENU.submit(this.namespace, this.name, this.data);
				}.bind({namespace: namespace, name: name, data: menuData}));

				$(menu).find('button[name="cancel"]').click(function() {
					SKYLINE_MENU.cancel(this.namespace, this.name, this.data);
				}.bind({namespace: namespace, name: name, data: menuData}));

				$(menu).find('[name="value"]').bind('input propertychange', function(){
					this.data.value = $(menu).find('[name="value"]').val();
					SKYLINE_MENU.change(this.namespace, this.name, this.data);
				}.bind({namespace: namespace, name: name, data: menuData}));

				if(typeof menuData.value != 'undefined')
					$(menu).find('[name="value"]').val(menuData.value);

				menuContainer.appendChild(menu);
			}
		}

		$(menuContainer).show();
		$("#inputText").focus();
	}

	SKYLINE_MENU.submit = function(namespace, name, data) {
		$.post('https://' + SKYLINE_MENU.ResourceName + '/menu_submit', JSON.stringify(data));
	}

	SKYLINE_MENU.cancel = function(namespace, name, data) {
		$.post('https://' + SKYLINE_MENU.ResourceName + '/menu_cancel', JSON.stringify(data));
	}

	SKYLINE_MENU.change = function(namespace, name, data) {
		$.post('https://' + SKYLINE_MENU.ResourceName + '/menu_change', JSON.stringify(data));
	}

	SKYLINE_MENU.getFocused = function() {
		return SKYLINE_MENU.focus[SKYLINE_MENU.focus.length - 1];
	}

	window.onData = (data) => {

		switch(data.action){

			case 'openMenu' : {
				SKYLINE_MENU.open(data.namespace, data.name, data.data);
				break;
			}

			case 'closeMenu' : {
				SKYLINE_MENU.close(data.namespace, data.name);
				break;
			}

		}

	}

	window.onload = function(e){
		window.addEventListener('message', (event) => {
			onData(event.data)
		});
	}

})()