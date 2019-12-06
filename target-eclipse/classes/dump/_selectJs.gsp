<g:javascript>
	
	function ${attrs.id}Update(e) { 
  		if (e) { 	
		<g:if test="${attrs.setId }">

    		var rselect = document.getElementById('${attrs.setId}')
    		var l = rselect.length
    		while (l > 0) {
     			l--
     			rselect.remove(l)
  			}
  			var opt = document.createElement('option');
  			opt.value="${attrs.appendValue}"
  			opt.text="${attrs.appendName}" 
      		try {
    	   		rselect.add(opt, null)
      		} catch(ex) {
  	  			rselect.add(opt)
  			}
    		for (var i=0; i < e.length; i++) {
      			var s = e[i]
      			var opt = document.createElement('option');
      			opt.text = s.name
      			opt.value = s.id
      			try {
    	    		rselect.add(opt, null)
      			} catch(ex) {
  	  				rselect.add(opt)
  				}
  			}
  			</g:if>
  		}
  		
  	}
  	
  	function ${attrs.id}Update1(ee) { 
  		<g:if test="${attrs.setId3 }">
  			var zselect = document.getElementById('${attrs.id}')
  			var zopt = zselect.options[zselect.selectedIndex]
  			$.getJSON('${createLink(controller:"${attrs.controller}", action: "${attrs.action}")}?id='+zopt.value+'&value=${attrs?.triggerWord}&bindid=${attrs?.bindid3}&collectField=${attrs?.collectField3}&filterDisplay=${attrs.filterDisplay}&searchField=${attrs?.searchField3}&domain=${attrs?.domain}&domain2=${attrs?.domain3}&bdomain=${attrs?.domain}&filterbind=${attrs.bindid3}&filter=${attrs.filter}&filter2=${attrs.filter2}',function(e){
			if (e) { 
			    var rselect = document.getElementById('${attrs.setId3}')
			    var l = rselect.length
			    while (l > 0) {
			    	l--
				    rselect.remove(l)
				}
				var opt = document.createElement('option');
				opt.value="${attrs.appendValue}"
				opt.text="${attrs.appendName}" 
					try {
				    	rselect.add(opt, null)
					} catch(ex) {
				  	  	rselect.add(opt)
				  	}
				  	for (var i=0; i < e.length; i++) {
				  		var s = e[i]
				    	var opt = document.createElement('option');
				    	opt.text = s.name
				    	opt.value = s.id
				    	try {
				    		rselect.add(opt, null)
				    	} catch(ex) {
				  	  		rselect.add(opt)
				  		}
				  	}
				}
			});		
    	</g:if>
  	}
  	
  	var zselect = document.getElementById('${attrs.id}')
  	var zopt = zselect.options[zselect.selectedIndex]
  	<% def changeAddon="" %>
  	
  	<g:if test="${attrs.domain3 }">
  		<% changeAddon="&domain3=${attrs.domain3}&bindid3=${attrs.bindid3}&setId3=${attrs.setId3}&searchField3=${attrs.searchField3}&collectField3=${attrs.collectField3}" %>
  		<g:if test="${attrs?.filterController}">
			<g:remoteFunction  controller="${attrs.filterController}"  action="${attrs.filteraction2}" onComplete="'${attrs.id}Update1(data)'"  params= "\'term=${attrs?.term}${changeAddon}&bindid=${attrs.bindid}&filter=${attrs.filter}&filterType=${attrs.filterType}&filterDisplay=${attrs.filterDisplay}&domain=${attrs.domain}&domain2=${attrs.domain3}&primarybind=${attrs.primarybind}&searchField=${attrs.searchField3}&collectField=${attrs.collectField3}&filter2=${attrs.filter2}&filterbind=${attrs?.filterbind}&id=\'+ zopt.value"/>
		</g:if>
		<g:else>	
			<g:remoteFunction  controller="${attrs.controller}"  action="${attrs.action}" onComplete="'${attrs.id}Update1(data)'"  params= "\'term=${attrs?.term}${changeAddon}&bindid=${attrs.bindid}&filter=${attrs.filter}&filterType=${attrs.filterType}&filterDisplay=${attrs.filterDisplay}&domain=${attrs.domain}&domain2=${attrs.domain3}&primarybind=${attrs.primarybind}&searchField=${attrs.searchField3}&collectField=${attrs.collectField3}&filter2=${attrs.filter2}&filterbind=${attrs?.filterbind}&id=\'+ zopt.value"/>        
		</g:else>	        
  	</g:if>
  	
  	<g:else>
  		<g:if test="${attrs?.filterController}">
			<g:remoteFunction  controller="${attrs.filterController}"  action="${attrs.filteraction2}" onComplete="'${attrs.id}Update(data)'"  params= "\'term=${attrs?.term}${changeAddon}&bindid=${attrs.bindid}&filter=${attrs.filter}&filterType=${attrs.filterType}&filterDisplay=${attrs.filterDisplay}&domain=${attrs.domain}&primarybind=${attrs.primarybind}&searchField=${attrs.searchField}&collectField=${attrs.collectField}&filter2=${attrs.filter2}&filterbind=${attrs?.filterbind}&id=\'+ zopt.value"/>
		</g:if>
		<g:else>
			<g:remoteFunction  controller="${attrs.controller}"  action="${attrs.action}" onComplete="'${attrs.id}Update(data)'"  params= "\'term=${attrs?.term}${changeAddon}&bindid=${attrs.bindid}&filter=${attrs.filter}&filterType=${attrs.filterType}&filterDisplay=${attrs.filterDisplay}&domain=${attrs.domain}&primarybind=${attrs.primarybind}&searchField=${attrs.searchField}&collectField=${attrs.collectField}&filter2=${attrs.filter2}&filterbind=${attrs?.filterbind}&id=\'+ zopt.value"/>        
		</g:else>
	</g:else>
		        
</g:javascript>