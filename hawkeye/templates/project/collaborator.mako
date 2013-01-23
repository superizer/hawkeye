<%inherit file="/base/base.mako"/> 

<%block name='script'>
<script type="text/javascript">
	$(function(){
		var us;
		var ps;
		$("#back").button();
		$("#add").button();
		$.ajax({
			  type: 'GET',
	          url: "${request.config.settings['nokkhum.api.url']}/admin/users/status/active", 
	          datatype: 'json',
	          error: function(){
	        	  alert('Too Bad');
	          },
	          success: function(getUser){
	        	  var listUser = document.getElementById("slUser");
	    		  for(i in getUser.users){
	    			  var option = document.createElement("option");
	    			  option.text = getUser.users[i].email;
	    			  option.value = getUser.users[i].id;
	    			  listUser.add(option,listUser.options[null]);
	    		  }
	    		  $("#slUser").change(function () {
	    			  us = $("#slUser option:selected").val();
	    		  });
	    		  $("#slProject").change(function () {
	    			  ps = $("#slProject option:selected").val();
	    		  });
	          }
		});
		$("#add").click(function() {
			$.ajax({
  			  type: 'POST',
  	          url: "${request.config.settings['nokkhum.api.url']}/projects/"+ps+"/collaborators",
  	          data:JSON.stringify({'collaborator':{'id': parseInt(us)}}),
  	          datatype: 'json',
  	          error: function(){
  	        	  alert('Too Bad');
  	          },
  	          success: function(){
  	        	  document.forms["goback"].submit();
  	          }
  	        });
		});
	});
</script>
</%block>
<%block name='menu'>
<div class="menu">
	<a href="/home" id="back">Back</a>
</div>
</%block>
<div id="colist">
	<div class="clist">
	<div id="selectUser" class="llist">
		<select id="slUser" multiple="multiple" class="alist">
		</select>
	</div>
	<div id="selectProject" class="llist">
		<select id="slProject" multiple="multiple" class="alist">
		% for project in data:
			<option value="${project['id']}">${project['name']}</option>
		% endfor
		</select>
	</div>
	<div class="blist">
	<buttun id="add">Add</buttun>
	</div>
	</div>
</div>
<form id="goback" action="/home" style="display: none;"></form>

