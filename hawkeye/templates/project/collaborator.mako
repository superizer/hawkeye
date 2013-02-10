<%inherit file="/base/base.mako"/> 

<%block name='script'>
<script type="text/javascript">
	$(function(){
		var us;
		var ps;
		$("#back").button();
		$("#add").button().click(function() {
			document.getElementById("method").value = "add";
			document.forms["gotocoraborator"].submit();
		});
		$("#delete").button().click(function() {
			document.getElementById("method").value = "delete";
			document.forms["gotocoraborator"].submit();
		});
		$("#slUser").change(function () {
		 	$.ajax({
				  type: 'GET',
		          url: "${request.config.settings['nokkhum.api.url']}/users/"+$("#slUser option:selected").val()+"/projects", 
		          datatype: 'json',
		          error: function(){
		        	  alert('Too Bad');
		          },
		          success: function(getUser){
		        	  document.getElementById("u_id").value = $("#slUser option:selected").val();
		        	  getUser = getUser.collaborate_projects;
		        	  var tmp = new Array();
		        	  % for project in data:
		        		  for(i in getUser){
		        			  if ("${project['name']}" == getUser[i].name){
		        				  tmp.push(getUser[i]);
			 					}  
		        		  }
					  % endfor
		        	  var listUser = document.getElementById("splProject");
		    		  for(i in tmp){
		    			  var option = document.createElement("option");
		    			  option.text = tmp[i].name;
		    			  option.value = tmp[i].id;
		    			  listUser.add(option,listUser.options[null]);
		    		  }
		    		 
		    		  $("#splProject").change(function () {
		    			  document.getElementById("p_id").value = $("#splProject option:selected").val();
		    		  });
		          }
			}); 
		});
		 $("#slProject").change(function () {
			  document.getElementById("p_id").value = $("#slProject option:selected").val();
		  });
		/* $("#add").click(function() {
			alert(JSON.stringify({'collaborator':{'id': parseInt(us)}}));
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
		}); */
	});
</script>
</%block>
<%block name='menu'>
<div class="menu">
	<a href="/home" id="back">Back</a>
</div>
</%block>
<div id="colist">
	<ul class="hlist">
    	<li class="tlist">	
    		<select id="slUser" multiple="multiple" class="ulist">
    			% for user in users:
					<option value="${user['id']}">${user['email']}</option>
				% endfor
			</select>
			<select id="slProject" multiple="multiple" class="ulist">
				% for project in data:
					<option value="${project['id']}">${project['name']}</option>
				% endfor
			</select>
			<select id="splProject" multiple="multiple" class="ulist">
			</select>
    	</li>
    	<li class="mlist">
    		<buttun id="add">Add</buttun>
    		<buttun id="delete">Delete</buttun>
    	</li>
  	</ul>
	<!-- <div class="clist">
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
	</div> -->
</div>
<form id="gotocoraborator" action="/collaborator" style="display: none;">
	<input type="hidden" id="method" name="method" value=""/>
	<input type="hidden" id="p_id" name="p_id" value=""/>
	<input type="hidden" id="u_id" name="u_id" value=""/>
</form>

