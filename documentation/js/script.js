/* Author:

   Marcio Aguiar
*/
function generateReference(where){
	where = $(where);
	var ref        = $("<div class='reference'></div>");
	    options    = $("<ul class='ref_options'></ul>").appendTo(ref); //.before("<div>Options</div>"),
	    properties = $("<ul class='ref_properties'></ul>").appendTo(ref); //.before("<div>Properties</div>"),
	    methods    = $("<ul class='ref_methods'></ul>").appendTo(ref); //.before("<div>Methods</div>"),
	    callbacks  = $("<ul class='ref_callbacks'></ul>").appendTo(ref); //.before("<div>Callbacks</div>");

	$([ options, properties, methods, callbacks])
	$('"<ul class="tabs"> \
			<li class="active" id="options-tab"><a class="tab-output" hhref="javascript:;">Options</a></li> \
			<li class="" id="methods-tab"><a hhref="javascript:;">API Methods</a></li> \
			<li class="" id="properties-tab"><a hhref="javascript:;">API Properties</a></li> \
			<li class="" id="callbacks-tab"><a hhref="javascript:;">Callbacks</a></li> \
		</ul>').prependTo(ref);

	// sort the parent children
	var sortChildren = function(parent, compareFunction) {
		var children = parent.children();
		// default compareFunction compare attribute data-name
		if (compareFunction==undefined) compareFunction = function(a, b){
			a = $(a).data('name'); b=$(b).data('name');
			return a<b ? -1 : ( a>b ? 1 : 0 );
		}

		Array.prototype.sort.call(children, compareFunction);
		children.appendTo(parent);
	} // sortChildren

	ref.appendTo(where);
	// configuration options
	$(".config").each(function(){
		var s=$(this);
		var section = s.parents('section').find('h2').first().html(),
			name, tipo, def, description, item, cont;
		s.find('dt').each(function(){
			name = $(this).html();
			dds  = $(this).nextUntil('dt');
			tipo = dds.filter('.type').html();
			def  = dds.filter('.default').html();
			description  = dds.not('.type, .default').html();
			if (dds.not('.param, .type, .default').length>1) console.log('tem mais de 1 dd para o option ',name, dds.not('.param, .type, .default'));

			item = $("<li>");
			item.append("<div class='name'>"+name+"</div>").data("name", name);
			item.append("<div class='section'>"+section+"</div>");
			cont = $("<div class='what'></div>").appendTo(item);;
			cont.append("<div class='type'>"+tipo+"</div>");
			cont.append("<div class='default'>"+def+"</div>");
			cont.append("<div class='description'>"+description+"</div>");
			item.appendTo(options);
		});
	});

	// properties
	$(".api").each(function(){
		var s=$(this);
		var section = s.parents('section').find('h2').first().html(),
			name, tipo, def, description, item, cont;
		s.find('dt.property').each(function(){
			name = $(this).html();
			dds  = $(this).nextUntil('dt');
			tipo = dds.filter('.type').html();
			def  = dds.filter('.default').html();
			description  = dds.not('.type, .default').html();
			if (dds.not('.param, .type, .default').length>1) console.log('tem mais de 1 dd para o property ',name, dds.not('.param, .type, .default'));
			item = $("<li>");
			item.append("<div class='name'>"+name+"</div>").data("name", name);
			item.append("<div class='section'>"+section+"</div>");
			cont = $("<div class='what'></div>").appendTo(item);
			cont.append("<div class='type'>"+tipo+"</div>");
			cont.append("<div class='default'>"+def+"</div>");
			cont.append("<div class='description'>"+description+"</div>");
			item.appendTo(properties);
		});
	});

	// methods
	$(".api").each(function(){
		var s=$(this);
		var section = s.parents('section').find('h2').first().html(),
			name, params, description, item, cont, p;
		s.find('dt.method').each(function(){
			var dt=$(this)
			name = dt.html();
			dds  = dt.nextUntil('dt');
			params = dds.filter('.param');
			description  = dds.not('.param').html();
			if (dds.not('.param, .type, .default').length>1) console.log('tem mais de 1 dd para o method ',name, dds);

			item = $("<li>");
			item.append("<div class='name'>"+name+"</div>").data("name", name);
			item.append("<div class='section'>"+section+"</div>");
			cont = $("<div class='what'></div>").appendTo(item);
			if (params.length) p = $("<ul class='params'></ul>").appendTo(cont);
			params.each(function(){
				p.append("<li>"+$(this).html()+"</li>");
			});
			cont.append("<div class='description'>"+description+"</div>");
			item.appendTo(methods);
		});
	});

	// callbacks
	$(".api, .config").each(function(){
		var s=$(this);
		var section = s.parents('section').find('h2').first().html(),
			name, params, description, item, cont, p;
		s.find('dt.callback').each(function(){
			name = $(this).html();
			dds  = $(this).nextUntil('dt');
			params = dds.filter('.param');
			description  = dds.not('.param, .type, .default').html();
			if (dds.not('.param, .type, .default').length>1) console.log('tem mais de 1 dd para o callback ',name
			,dds.not('.param, .type, .default'));
			item = $("<li>");
			item.append("<div class='name'>"+name+"</div>").data("name", name);
			item.append("<div class='section'>"+section+"</div>");
			cont = $("<div class='what'></div>").appendTo(item);
			if (params.length) p = $("<ul class='params'></ul>").appendTo(cont);
			params.each(function(){
				p.append("<li>"+$(this).html()+"</li>");
			});
			cont.append("<div class='description'>"+description+"</div>");
			item.appendTo(callbacks);
		});
	});
	sortChildren(callbacks);
	sortChildren(methods);
	sortChildren(options);
	sortChildren(properties);

	$(callbacks).css('display', 'none');
	$(methods).css('display', 'none');
	$(properties).css('display', 'none');
	$(".tabs li").click(function(){
		var tab=$('.tabs .active'), tab_name = tab[0].id.split("-")[0];
		$(".ref_"+tab_name).css('display', 'none');
		tab.removeClass('active');

		var tab=$(this), tab_name = tab[0].id.split("-")[0];
		$(".ref_"+tab_name).css('display', 'block');
		tab.addClass('active');
	});

};

$(function(){

	function generateId(index, elem){
		var id = elem.id;
		if (id) return;
		id = $(elem).text().toLowerCase().replace(" ", "-", "g").replace(/[.?'!]/, "", "g");
		var count="";
		while( $('#'+id+count).length ) count++;
		elem.id = id+count;
	} // generateId

	// Generate navigation
	var cur = $("<ul id='sections' data-level='H2'></ul>").appendTo( $("#nav") );
	var uls = [];
		hs = $("h2, h3, h4, h5, h6");
	var li, id;
	hs.each(generateId).each(function(i,e){
		while (e.tagName < cur.data("level")) {
			cur = uls.pop();
		}
		if (e.tagName > cur.data("level")) {
			uls.push(cur);
			$("<span class='toggler'></span>").appendTo(li);
			cur = $("<ul></ul>").appendTo(li).data('level', e.tagName);
		}
		e = $(e);
		id = e.attr("id");
		li = $("<li><a href='#"+id+"'>"+e.html()+"</a></li>").appendTo(cur);
	});

	$("dt").each(generateId)

	$(".toggler").click(function(){
		$(this).toggleClass("collapsed").next("ul").slideToggle();
	}).click();

	$("aa").click(function(){
		var a=this, e=$(a.hash), p=e.offset();
		console.log(a.hash, e, p);
		$('html,body').animate({scrollTop:p.top-$('header').outerHeight()-30}, 500, function(){
		//	window.location.hash=a.hash;
		});
		return false;
	});

	//
	// Syntax highlight
	//
	cleanupLoadedCode = function(code){
		if (code===null || code===undefined) return code;
		//code.replace(/^(\r\n|[\r\n])/, '').replace(/(\r\n|[\r\n])$/, '');
		code = code.replace(/^(\r\n|[\r\n])/, '').replace(/\s*$/, '');
		var lines = code.split("\n"),
			INT_MAX = 9007199254740992,
			min = INT_MAX,
			m,
			regex = /^\t+\S/;
		// FIXME : use only 1 global regex and iterate over matches
		for(var i=0,l=lines.length;i<l;i++){
			if (m=lines[i].match(regex)) {
				if (m[0].length-1 < min) min=m[0].length-1;
				//console.log(m, m[0].length-1, min);
			}
		}
		if (min!=INT_MAX) {
			var unindent = new RegExp("^\t{"+min+"}", "gm");
			code = code.replace(unindent, "");
		}
		return code;
	} // cleanupLoadedCode

	// console.log( CodeMirror.listModes() );
	var code, e;
	$("textarea").replaceWith(function(){
		var e = $(this);
		code = e.text();
		return "<pre data-mode='htmlmixed'>"+$(this).html()+"</pre>";
	});

	$("pre, textarea").addClass('cm-s-default code').each(function(i,e){
		e = $(e);
		code = (e.data("mode")=='htmlmixed') ? e.text() : e.html();
		CodeMirror.runMode(cleanupLoadedCode( code ), $(e).data("mode") || "htmlmixed", e[0]);
	});

	generateReference($("#reference_container").parent());

	// se tiver location.hash, vai pra ele (pq o elemento pode/deve ter sido criado por esse script
	var hash=window.location.hash.slice(1);
	if (hash){
		hash = "#"+hash;
		$(hash)[0].scrollIntoView();
		var a = $('#nav a[href="'+hash+'"]');
		a.parents("ul").siblings(".toggler").click()
	}
});

