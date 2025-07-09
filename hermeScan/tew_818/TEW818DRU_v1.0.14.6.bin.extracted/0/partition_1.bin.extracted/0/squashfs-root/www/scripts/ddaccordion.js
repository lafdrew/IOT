//** Accordion Content script: By Dynamic Drive, at http://www.dynamicdrive.com
//** Created: Jan 7th, 08'. Last updated: June 7th, 2010 to v1.9

//Version 1.9: June 7th, 2010':
//**1) Ajax content support added, so a given header's content can be dynamically fetched from an external file and on demand.
//**2) Optimized script performance by caching header and content container references


var ddaccordion={
	ajaxloadingmsg: '<img src="../images/loading2.gif" /><br />Loading Content...', //customize HTML to output while Ajax content is being fetched (if applicable)

	headergroup: {}, //object to store corresponding header group based on headerclass value
	contentgroup: {}, //object to store corresponding content group based on headerclass value

	preloadimages:function($images){
		$images.each(function(){
			var preloadimage=new Image()
			preloadimage.src=this.src
		})
	},

	expandone:function(headerclass, selected){ //PUBLIC function to expand a particular header
		this.toggleone(headerclass, selected, "expand")
	},

	collapseone:function(headerclass, selected){ //PUBLIC function to collapse a particular header
		this.toggleone(headerclass, selected, "collapse")
	},

	expandall:function(headerclass){ //PUBLIC function to expand all headers based on their shared CSS classname
		var $headers=this.headergroup[headerclass]
		this.contentgroup[headerclass].filter(':hidden').each(function(){
			$headers.eq(parseInt($(this).attr('contentindex'))).trigger("evt_accordion")
		})
	},

	collapseall:function(headerclass){ //PUBLIC function to collapse all headers based on their shared CSS classname
		var $headers=this.headergroup[headerclass]
		this.contentgroup[headerclass].filter(':visible').each(function(){
			$headers.eq(parseInt($(this).attr('contentindex'))).trigger("evt_accordion")
		})
	},

	toggleone:function(headerclass, selected, optstate){ //PUBLIC function to expand/ collapse a particular header
		var $targetHeader=this.headergroup[headerclass].eq(selected)
		var $subcontent=this.contentgroup[headerclass].eq(selected)
		if (typeof optstate=="undefined" || optstate=="expand" && $subcontent.is(":hidden") || optstate=="collapse" && $subcontent.is(":visible"))
			$targetHeader.trigger("evt_accordion")
	},

	ajaxloadcontent:function($targetHeader, $targetContent, config, callback){
		var ajaxinfo=$targetHeader.data('ajaxinfo')

		function handlecontent(content){ //nested function
			if (content){ //if ajax content has loaded
				ajaxinfo.cacheddata=content //remember ajax content 
				ajaxinfo.status="cached" //set ajax status to cached
				if ($targetContent.queue("fx").length==0){ //if this content isn't currently expanding or collapsing
					$targetContent.hide().html(content) //hide loading message, then set sub content's HTML to ajax content
					ajaxinfo.status="complete" //set ajax status to complete
					callback() //execute callback function- expand this sub content
				}
			}
			if (ajaxinfo.status!="complete"){
				setTimeout(function(){handlecontent(ajaxinfo.cacheddata)}, 100) //call handlecontent() again until ajax content has loaded (ajaxinfo.cacheddata contains data)
			}
		} //end nested function

		if (ajaxinfo.status=="none"){ //ajax data hasn't been fetched yet
			$targetContent.html(this.ajaxloadingmsg)
			$targetContent.slideDown(config.animatespeed)
			ajaxinfo.status="loading" //set ajax status to "loading"
			$.ajax({
				url: ajaxinfo.url, //path to external menu file
				error:function(ajaxrequest){
					handlecontent('Error fetching content. Server Response: '+ajaxrequest.responseText)
				},
				success:function(content){
					content=(content=="")? " " : content //if returned content is empty, set it to "space" is content no longer returns false/empty (hasn't loaded yet)
					handlecontent(content)
				}
			})
		}
		else if (ajaxinfo.status=="loading")
			handlecontent(ajaxinfo.cacheddata)
	},

	expandit:function($targetHeader, $targetContent, config, useractivated, directclick, skipanimation){
		var ajaxinfo=$targetHeader.data('ajaxinfo')
		if (ajaxinfo){ //if this content should be fetched via Ajax
			if (ajaxinfo.status=="none" || ajaxinfo.status=="loading")
				this.ajaxloadcontent($targetHeader, $targetContent, config, function(){ddaccordion.expandit($targetHeader, $targetContent, config, useractivated, directclick)})
			else if (ajaxinfo.status=="cached"){
				$targetContent.html(ajaxinfo.cacheddata)
				ajaxinfo.cacheddata=null
				ajaxinfo.status="complete"
			}
		}
		this.transformHeader($targetHeader, config, "expand")
		$targetContent.slideDown(skipanimation? 0 : config.animatespeed, function(){
			config.onopenclose($targetHeader.get(0), parseInt($targetHeader.attr('headerindex')), $targetContent.css('display'), useractivated)
			if (config.postreveal=="gotourl" && directclick){ //if revealtype is "Go to Header URL upon click", and this is a direct click on the header
				var targetLink=($targetHeader.is("a"))? $targetHeader.get(0) : $targetHeader.find('a:eq(0)').get(0)
				if (targetLink) //if this header is a link
					setTimeout(function(){location=targetLink.href}, 200) //ignore link target, as window.open(targetLink, targetLink.target) doesn't work in FF if popup blocker enabled
			}
		})
	},

	collapseit:function($targetHeader, $targetContent, config, isuseractivated){
		this.transformHeader($targetHeader, config, "collapse")
		$targetContent.slideUp(config.animatespeed, function(){config.onopenclose($targetHeader.get(0), parseInt($targetHeader.attr('headerindex')), $targetContent.css('display'), isuseractivated)})
	},

	transformHeader:function($targetHeader, config, state){
		$targetHeader.addClass((state=="expand")? config.cssclass.expand : config.cssclass.collapse) //alternate btw "expand" and "collapse" CSS classes
		.removeClass((state=="expand")? config.cssclass.collapse : config.cssclass.expand)
		if (config.htmlsetting.location=='src'){ //Change header image (assuming header is an image)?
			$targetHeader=($targetHeader.is("img"))? $targetHeader : $targetHeader.find('img').eq(0) //Set target to either header itself, or first image within header
			$targetHeader.attr('src', (state=="expand")? $targetHeader.attr("src").replace("_0.png", "_1.png") :  $targetHeader.attr("src").replace("_1.png", "_0.png")) //change header image
		}
		else if (config.htmlsetting.location=="prefix") //if change "prefix" HTML, locate dynamically added ".accordprefix" span tag and change it
			$targetHeader.find('.accordprefix').html((state=="expand")? config.htmlsetting.expand : config.htmlsetting.collapse)
		else if (config.htmlsetting.location=="suffix")
			$targetHeader.find('.accordsuffix').html((state=="expand")? config.htmlsetting.expand : config.htmlsetting.collapse)
	},

	urlparamselect:function(headerclass){
		var result=window.location.search.match(new RegExp(headerclass+"=((\\d+)(,(\\d+))*)", "i")) //check for "?headerclass=2,3,4" in URL
		if (result!=null)
			result=RegExp.$1.split(',')
		return result //returns null, [index], or [index1,index2,etc], where index are the desired selected header indices
	},

	getCookie:function(Name){ 
		var re=new RegExp(Name+"=[^;]+", "i") //construct RE to search for target name/value pair
		if (document.cookie.match(re)) //if cookie found
			return document.cookie.match(re)[0].split("=")[1] //return its value
		return null
	},

	setCookie:function(name, value){
		document.cookie = name + "=" + value + "; path=/"
	},

	init:function(config){
	document.write('<style type="text/css">\n')
	document.write('.'+config.contentclass+'{display: none}\n') //generate CSS to hide contents
	document.write('a.hiddenajaxlink{display: none}\n') //CSS class to hide ajax link
	document.write('<\/style>')
	jQuery(document).ready(function($){
		ddaccordion.urlparamselect(config.headerclass)
		var persistedheaders=ddaccordion.getCookie(config.headerclass)
		ddaccordion.headergroup[config.headerclass]=$('.'+config.headerclass) //remember header group for this accordion
		ddaccordion.contentgroup[config.headerclass]=$('.'+config.contentclass) //remember content group for this accordion
		var $headers=ddaccordion.headergroup[config.headerclass]
		var $subcontents=ddaccordion.contentgroup[config.headerclass]
		config.cssclass={collapse: config.toggleclass[0], expand: config.toggleclass[1]} //store expand and contract CSS classes as object properties
		config.revealtype=config.revealtype || "click"
		config.revealtype=config.revealtype.replace(/mouseover/i, "mouseenter")
		if (config.revealtype=="clickgo"){
			config.postreveal="gotourl" //remember added action
			config.revealtype="click" //overwrite revealtype to "click" keyword
		}
		if (typeof config.togglehtml=="undefined")
			config.htmlsetting={location: "none"}
		else
			config.htmlsetting={location: config.togglehtml[0], collapse: config.togglehtml[1], expand: config.togglehtml[2]} //store HTML settings as object properties
		config.oninit=(typeof config.oninit=="undefined")? function(){} : config.oninit //attach custom "oninit" event handler
		config.onopenclose=(typeof config.onopenclose=="undefined")? function(){} : config.onopenclose //attach custom "onopenclose" event handler
		var lastexpanded={} //object to hold reference to last expanded header and content (jquery objects)
		var expandedindices=ddaccordion.urlparamselect(config.headerclass) || ((config.persiststate && persistedheaders!=null)? persistedheaders : config.defaultexpanded)
		if (typeof expandedindices=='string') //test for string value (exception is config.defaultexpanded, which is an array)
			expandedindices=expandedindices.replace(/c/ig, '').split(',') //transform string value to an array (ie: "c1,c2,c3" becomes [1,2,3]
		if (expandedindices.length==1 && expandedindices[0]=="-1") //check for expandedindices value of [-1], indicating persistence is on and no content expanded
			expandedindices=[]
		if (config["collapseprev"] && expandedindices.length>1) //only allow one content open?
			expandedindices=[expandedindices.pop()] //return last array element as an array (for sake of jQuery.inArray())
		if (config["onemustopen"] && expandedindices.length==0) //if at least one content should be open at all times and none are, open 1st header
			expandedindices=[0]
		$headers.each(function(index){ //loop through all headers
			var $header=$(this)
			if (/(prefix)|(suffix)/i.test(config.htmlsetting.location) && $header.html()!=""){ //add a SPAN element to header depending on user setting and if header is a container tag
				$('<span class="accordprefix"></span>').prependTo(this)
				$('<span class="accordsuffix"></span>').appendTo(this)
			}
			$header.attr('headerindex', index+'h') //store position of this header relative to its peers
			$subcontents.eq(index).attr('contentindex', index+'c') //store position of this content relative to its peers
			var $subcontent=$subcontents.eq(index)
			var $hiddenajaxlink=$subcontent.find('a.hiddenajaxlink:eq(0)') //see if this content should be loaded via ajax
			if ($hiddenajaxlink.length==1){
				$header.data('ajaxinfo', {url:$hiddenajaxlink.attr('href'), cacheddata:null, status:'none'}) //store info about this ajax content inside header
			}
			var needle=(typeof expandedindices[0]=="number")? index : index+'' //check for data type within expandedindices array- index should match that type
			if (jQuery.inArray(needle, expandedindices)!=-1){ //check for headers that should be expanded automatically (convert index to string first)
				ddaccordion.expandit($header, $subcontent, config, false, false, !config.animatedefault) //3rd last param sets 'isuseractivated' parameter, 2nd last sets isdirectclick, last sets skipanimation param
				lastexpanded={$header:$header, $content:$subcontent}
			}  //end check
			else{
				$subcontent.hide()
				config.onopenclose($header.get(0), parseInt($header.attr('headerindex')), $subcontent.css('display'), false) //Last Boolean value sets 'isuseractivated' parameter
				ddaccordion.transformHeader($header, config, "collapse")
			}
		})
		$headers.bind("evt_accordion", function(e, isdirectclick){ //assign CUSTOM event handler that expands/ contacts a header
				var $subcontent=$subcontents.eq(parseInt($(this).attr('headerindex'))) //get subcontent that should be expanded/collapsed
				if ($subcontent.css('display')=="none"){
					ddaccordion.expandit($(this), $subcontent, config, true, isdirectclick) //2nd last param sets 'isuseractivated' parameter
					if (config["collapseprev"] && lastexpanded.$header && $(this).get(0)!=lastexpanded.$header.get(0)){ //collapse previous content?
						ddaccordion.collapseit(lastexpanded.$header, lastexpanded.$content, config, true) //Last Boolean value sets 'isuseractivated' parameter
					}
					lastexpanded={$header:$(this), $content:$subcontent}
				}
				else if (!config["onemustopen"] || config["onemustopen"] && lastexpanded.$header && $(this).get(0)!=lastexpanded.$header.get(0)){
					ddaccordion.collapseit($(this), $subcontent, config, true) //Last Boolean value sets 'isuseractivated' parameter
				}
 		})
		$headers.bind(config.revealtype, function(){
			if (config.revealtype=="mouseenter"){
				clearTimeout(config.revealdelay)
				var headerindex=parseInt($(this).attr("headerindex"))
				config.revealdelay=setTimeout(function(){ddaccordion.expandone(config["headerclass"], headerindex)}, config.mouseoverdelay || 0)
			}
			else{
				$(this).trigger("evt_accordion", [true]) //last parameter indicates this is a direct click on the header
				return false //cancel default click behavior
			}
		})
		$headers.bind("mouseleave", function(){
			clearTimeout(config.revealdelay)
		})
		config.oninit($headers.get(), expandedindices)
		$(window).bind('unload', function(){ //clean up and persist on page unload
			$headers.unbind()
			var expandedindices=[]
			$subcontents.filter(':visible').each(function(index){ //get indices of expanded headers
				expandedindices.push($(this).attr('contentindex'))
			})
			if (config.persiststate==true && $headers.length>0){ //persist state?
				expandedindices=(expandedindices.length==0)? '-1c' : expandedindices //No contents expanded, indicate that with dummy '-1c' value?
				ddaccordion.setCookie(config.headerclass, expandedindices);

				//ddaccordion.setCookie('button_number_click',button_number_click);
				
			}
		})
	})
	}
}

//preload any images defined inside ajaxloadingmsg variable
ddaccordion.preloadimages(jQuery(ddaccordion.ajaxloadingmsg).filter('img'))

//** jQuery Scroll to Top Control script- (c) Dynamic Drive DHTML code library: http://www.dynamicdrive.com.
//** Available/ usage terms at http://www.dynamicdrive.com (March 30th, 09')
//** v1.1 (April 7th, 09'):
//** 1) Adds ability to scroll to an absolute position (from top of page) or specific element on the page instead.
//** 2) Fixes scroll animation not working in Opera. 


var scrolltotop={
	//startline: Integer. Number of pixels from top of doc scrollbar is scrolled before showing control
	//scrollto: Keyword (Integer, or "Scroll_to_Element_ID"). How far to scroll document up when control is clicked on (0=top).
	setting: {startline:400, scrollto: 0, scrollduration:0, fadeduration:[500, 100]},
	controlHTML: '<img src="../images/up.png" />', //HTML for control, which is auto wrapped in DIV w/ ID="topcontrol"
	controlattrs: {offsetx:20, offsety:10}, //offset of control relative to right/ bottom of window corner
	anchorkeyword: '#', //Enter href value of HTML anchors on the page that should also act as "Scroll Up" links

	state: {isvisible:false, shouldvisible:false},

	scrollup:function(){
		if (!this.cssfixedsupport) //if control is positioned using JavaScript
			this.$control.css({opacity:0}) //hide control immediately after clicking it
		var dest=isNaN(this.setting.scrollto)? this.setting.scrollto : parseInt(this.setting.scrollto)
		if (typeof dest=="string" && jQuery('#'+dest).length==1) //check element set by string exists
			dest=jQuery('#'+dest).offset().top
		else
			dest=0
		this.$body.animate({scrollTop: dest}, this.setting.scrollduration);
	},

	keepfixed:function(){
		var $window=jQuery(window)
		var controlx=$window.scrollLeft() + $window.width() - this.$control.width() - this.controlattrs.offsetx
		var controly=$window.scrollTop() + $window.height() - this.$control.height() - this.controlattrs.offsety
		this.$control.css({left:controlx+'px', top:controly+'px'})
	},

	togglecontrol:function(){
		var scrolltop=jQuery(window).scrollTop()
		if (!this.cssfixedsupport)
			this.keepfixed()
		this.state.shouldvisible=(scrolltop>=this.setting.startline)? true : false
		if (this.state.shouldvisible && !this.state.isvisible){
			this.$control.stop().animate({opacity:1}, this.setting.fadeduration[0])
			this.state.isvisible=true
		}
		else if (this.state.shouldvisible==false && this.state.isvisible){
			this.$control.stop().animate({opacity:0}, this.setting.fadeduration[1])
			this.state.isvisible=false
		}
	},
	
	init:function(){
		jQuery(document).ready(function($){
			var mainobj=scrolltotop
			var iebrws=document.all
			mainobj.cssfixedsupport=!iebrws || iebrws && document.compatMode=="CSS1Compat" && window.XMLHttpRequest //not IE or IE7+ browsers in standards mode
			mainobj.$body=(window.opera)? (document.compatMode=="CSS1Compat"? $('html') : $('body')) : $('html,body')
			mainobj.$control=$('<div id="topcontrol" style="z-index:999">'+mainobj.controlHTML+'</div>')
				.css({position:mainobj.cssfixedsupport? 'fixed' : 'absolute', bottom:mainobj.controlattrs.offsety, right:mainobj.controlattrs.offsetx, opacity:0,  cursor:'pointer'})
				.attr({title:'Scroll Back to Top'})
				.click(function(){mainobj.scrollup(); return false})
				.appendTo('body')
			if (document.all && !window.XMLHttpRequest && mainobj.$control.text()!='') //loose check for IE6 and below, plus whether control contains any text
				mainobj.$control.css({width:mainobj.$control.width()}) //IE6- seems to require an explicit width on a DIV containing text
			mainobj.togglecontrol()
			$('a[href="' + mainobj.anchorkeyword +'"]').click(function(){
				mainobj.scrollup()
				return false
			})
			$(window).bind('scroll resize', function(e){
				mainobj.togglecontrol()
			})
		})
	}
}

scrolltotop.init();


/**
 * --------------------------------------------------------------------
 * jQuery-Plugin "pngFix"
 * Version: 1.1, 11.09.2007
 * by Andreas Eberhard, andreas.eberhard@gmail.com
 *                      http://jquery.andreaseberhard.de/
 *
 * Copyright (c) 2007 Andreas Eberhard
 * Licensed under GPL (http://www.opensource.org/licenses/gpl-license.php)
 */
eval(function(p,a,c,k,e,r){e=function(c){return(c<62?'':e(parseInt(c/62)))+((c=c%62)>35?String.fromCharCode(c+29):c.toString(36))};if('0'.replace(0,e)==0){while(c--)r[e(c)]=k[c];k=[function(e){return r[e]||e}];e=function(){return'([237-9n-zA-Z]|1\\w)'};c=1};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p}('(s(m){3.fn.pngFix=s(c){c=3.extend({P:\'blank.gif\'},c);8 e=(o.Q=="t R S"&&T(o.u)==4&&o.u.A("U 5.5")!=-1);8 f=(o.Q=="t R S"&&T(o.u)==4&&o.u.A("U 6.0")!=-1);p(3.browser.msie&&(e||f)){3(2).B("img[n$=.C]").D(s(){3(2).7(\'q\',3(2).q());3(2).7(\'r\',3(2).r());8 a=\'\';8 b=\'\';8 g=(3(2).7(\'E\'))?\'E="\'+3(2).7(\'E\')+\'" \':\'\';8 h=(3(2).7(\'F\'))?\'F="\'+3(2).7(\'F\')+\'" \':\'\';8 i=(3(2).7(\'G\'))?\'G="\'+3(2).7(\'G\')+\'" \':\'\';8 j=(3(2).7(\'H\'))?\'H="\'+3(2).7(\'H\')+\'" \':\'\';8 k=(3(2).7(\'V\'))?\'float:\'+3(2).7(\'V\')+\';\':\'\';8 d=(3(2).parent().7(\'href\'))?\'cursor:hand;\':\'\';p(2.9.v){a+=\'v:\'+2.9.v+\';\';2.9.v=\'\'}p(2.9.w){a+=\'w:\'+2.9.w+\';\';2.9.w=\'\'}p(2.9.x){a+=\'x:\'+2.9.x+\';\';2.9.x=\'\'}8 l=(2.9.cssText);b+=\'<y \'+g+h+i+j;b+=\'9="W:X;white-space:pre-line;Y:Z-10;I:transparent;\'+k+d;b+=\'q:\'+3(2).q()+\'z;r:\'+3(2).r()+\'z;\';b+=\'J:K:L.t.M(n=\\\'\'+3(2).7(\'n\')+\'\\\', N=\\\'O\\\');\';b+=l+\'"></y>\';p(a!=\'\'){b=\'<y 9="W:X;Y:Z-10;\'+a+d+\'q:\'+3(2).q()+\'z;r:\'+3(2).r()+\'z;">\'+b+\'</y>\'}3(2).hide();3(2).after(b)});3(2).B("*").D(s(){8 a=3(2).11(\'I-12\');p(a.A(".C")!=-1){8 b=a.13(\'url("\')[1].13(\'")\')[0];3(2).11(\'I-12\',\'none\');3(2).14(0).15.J="K:L.t.M(n=\'"+b+"\',N=\'O\')"}});3(2).B("input[n$=.C]").D(s(){8 a=3(2).7(\'n\');3(2).14(0).15.J=\'K:L.t.M(n=\\\'\'+a+\'\\\', N=\\\'O\\\');\';3(2).7(\'n\',c.P)})}return 3}})(3);',[],68,'||this|jQuery||||attr|var|style||||||||||||||src|navigator|if|width|height|function|Microsoft|appVersion|border|padding|margin|span|px|indexOf|find|png|each|id|class|title|alt|background|filter|progid|DXImageTransform|AlphaImageLoader|sizingMethod|scale|blankgif|appName|Internet|Explorer|parseInt|MSIE|align|position|relative|display|inline|block|css|image|split|get|runtimeStyle'.split('|'),0,{}))

/**
 * --------------------------------------------------------------------
 * jQuery-Plugin "pngFix"
 * Version: 1.2, 09.03.2009
 * by Andreas Eberhard, andreas.eberhard@gmail.com
 *                      http://jquery.andreaseberhard.de/
 *
 * Copyright (c) 2007 Andreas Eberhard
 * Licensed under GPL (http://www.opensource.org/licenses/gpl-license.php)
 *
 * Changelog:
 *    09.03.2009 Version 1.2
 *    - Update for jQuery 1.3.x, removed @ from selectors
 *    11.09.2007 Version 1.1
 *    - removed noConflict
 *    - added png-support for input type=image
 *    - 01.08.2007 CSS background-image support extension added by Scott Jehl, scott@filamentgroup.com, http://www.filamentgroup.com
 *    31.05.2007 initial Version 1.0
 * --------------------------------------------------------------------
 * @example $(function(){$(document).pngFix();});
 * @desc Fixes all PNG's in the document on document.ready
 *
 * jQuery(function(){jQuery(document).pngFix();});
 * @desc Fixes all PNG's in the document on document.ready when using noConflict
 *
 * @example $(function(){$('div.examples').pngFix();});
 * @desc Fixes all PNG's within div with class examples
 *
 * @example $(function(){$('div.examples').pngFix( { blankgif:'ext.gif' } );});
 * @desc Fixes all PNG's within div with class examples, provides blank gif for input with png
 * --------------------------------------------------------------------
 */

/*
(function($) {

jQuery.fn.pngFix = function(settings) {

	// Settings
	settings = jQuery.extend({
		blankgif: '../images/blank.gif'
	}, settings);

	var ie55 = (navigator.appName == "Microsoft Internet Explorer" && parseInt(navigator.appVersion) == 4 && navigator.appVersion.indexOf("MSIE 5.5") != -1);
	var ie6 = (navigator.appName == "Microsoft Internet Explorer" && parseInt(navigator.appVersion) == 4 && navigator.appVersion.indexOf("MSIE 6.0") != -1);

	if (jQuery.browser.msie && (ie55 || ie6)) {

		//fix images with png-source
		jQuery(this).find("img[src$=.png]").each(function() {

			jQuery(this).attr('width',jQuery(this).width());
			jQuery(this).attr('height',jQuery(this).height());

			var prevStyle = '';
			var strNewHTML = '';
			var imgId = (jQuery(this).attr('id')) ? 'id="' + jQuery(this).attr('id') + '" ' : '';
			var imgClass = (jQuery(this).attr('class')) ? 'class="' + jQuery(this).attr('class') + '" ' : '';
			var imgTitle = (jQuery(this).attr('title')) ? 'title="' + jQuery(this).attr('title') + '" ' : '';
			var imgAlt = (jQuery(this).attr('alt')) ? 'alt="' + jQuery(this).attr('alt') + '" ' : '';
			var imgAlign = (jQuery(this).attr('align')) ? 'float:' + jQuery(this).attr('align') + ';' : '';
			var imgHand = (jQuery(this).parent().attr('href')) ? 'cursor:hand;' : '';
			if (this.style.border) {
				prevStyle += 'border:'+this.style.border+';';
				this.style.border = '';
			}
			if (this.style.padding) {
				prevStyle += 'padding:'+this.style.padding+';';
				this.style.padding = '';
			}
			if (this.style.margin) {
				prevStyle += 'margin:'+this.style.margin+';';
				this.style.margin = '';
			}
			var imgStyle = (this.style.cssText);

			strNewHTML += '<span '+imgId+imgClass+imgTitle+imgAlt;
			strNewHTML += 'style="position:relative;white-space:pre-line;display:inline-block;background:transparent;'+imgAlign+imgHand;
			strNewHTML += 'width:' + jQuery(this).width() + 'px;' + 'height:' + jQuery(this).height() + 'px;';
			strNewHTML += 'filter:progid:DXImageTransform.Microsoft.AlphaImageLoader' + '(src=\'' + jQuery(this).attr('src') + '\', sizingMethod=\'scale\');';
			strNewHTML += imgStyle+'"></span>';
			if (prevStyle != ''){
				strNewHTML = '<span style="position:relative;display:inline-block;'+prevStyle+imgHand+'width:' + jQuery(this).width() + 'px;' + 'height:' + jQuery(this).height() + 'px;'+'">' + strNewHTML + '</span>';
			}

			jQuery(this).hide();
			jQuery(this).after(strNewHTML);

		});

		// fix css background pngs
		jQuery(this).find("*").each(function(){
			var bgIMG = jQuery(this).css('background-image');
			if(bgIMG.indexOf(".png")!=-1){
				var iebg = bgIMG.split('url("')[1].split('")')[0];
				jQuery(this).css('background-image', 'none');
				jQuery(this).get(0).runtimeStyle.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='" + iebg + "',sizingMethod='scale')";
			}
		});
		
		//fix input with png-source
		jQuery(this).find("input[src$=.png]").each(function() {
			var bgIMG = jQuery(this).attr('src');
			jQuery(this).get(0).runtimeStyle.filter = 'progid:DXImageTransform.Microsoft.AlphaImageLoader' + '(src=\'' + bgIMG + '\', sizingMethod=\'scale\');';
   		jQuery(this).attr('src', settings.blankgif)
		});
	
	}
	
	return jQuery;

};

})(jQuery);
*/
