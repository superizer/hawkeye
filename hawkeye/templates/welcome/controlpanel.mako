<%inherit file="/base/base.mako"/> 

<%block name='script'>
<script type="text/javascript">
	$(function(){
		$("#back").button();
		$("#radio").buttonset();
		$("#accordion").accordion({
			collapsible : false,
			heightStyle: "content"
			});
		$.ajax({
			  type: 'GET',
	          url: "${request.config.settings['nokkhum.api.url']}/admin/users/status/active", 
	          datatype: 'json',
	          error: function(){
	        	  alert('Too Bad');
	          },
	          success: function(getUser){
	        	  var listUser = document.getElementById("sActiveUser");
	    		  for(i in getUser.users){
	    			  var option = document.createElement("option");
	    			  option.text = getUser.users[i].email;
	    			  option.value = getUser.users[i].id;
	    			  listUser.add(option,listUser.options[null]);
	    		  }
	    		  $("#sActiveUser").change(function () {
	    			  $.ajax({
	    				  type: 'GET',
	    		          url: "${request.config.settings['nokkhum.api.url']}/admin/users/"+$("#sActiveUser option:selected").val(), 
	    		          datatype: 'json',
	    		          error: function(){
	    		        	  alert('Too Bad');
	    		          },
	    		          success: function(getUser){
	    		     
	    		        	  $("#name").text(getUser.user.first_name);
	    		        	  $("#surname").text(getUser.user.last_name);
	    		        	  $("#email").text(getUser.user.email);
	    		        	  $("#approve").click(function() {
	    		        		  $.ajax({
					    			  type: 'POST',
					    	          url: "${request.config.settings['nokkhum.api.url']}/admin/users/"+getUser.user.id+"/status/active",
					    	          data:JSON.stringify({'tmp':'dummykung'}),
					    	          datatype: 'json',
					    	          error: function(){
					    	        	  alert('Too Bad');
					    	          },
					    	          success: function(){
					    	        	  $('#sInActiveUser').empty();
					    	        	  $('#sActiveUser').empty();
					    	        	  $("#name").text("");
				    		        	  $("#surname").text("");
				    		        	  $("#email").text("");
					    	        	  $.ajax({
					    	    			  type: 'GET',
					    	    	          url: "${request.config.settings['nokkhum.api.url']}/admin/users/status/active", 
					    	    	          datatype: 'json',
					    	    	          error: function(){
					    	    	        	  alert('Too Bad');
					    	    	          },
					    	    	          success: function(getUser){
					    	    	        	  var listUser = document.getElementById("sActiveUser");
					    	    	    		  for(i in getUser.users){
					    	    	    			  var option = document.createElement("option");
					    	    	    			  option.text = getUser.users[i].email;
					    	    	    			  option.value = getUser.users[i].id;
					    	    	    			  listUser.add(option,listUser.options[null]);
					    	    	    		  }
					    	    	          }
					    	    	      });
					    	        	  $.ajax({
					    	    			  type: 'GET',
					    	    	          url: "${request.config.settings['nokkhum.api.url']}/admin/users/status/deactivate", 
					    	    	          datatype: 'json',
					    	    	          error: function(){
					    	    	        	  alert('Too Bad');
					    	    	          },
					    	    	          success: function(getUser){
					    	    	        	  var listUser = document.getElementById("sInActiveUser");
					    	    	    		  for(i in getUser.users){
					    	    	    			  var option = document.createElement("option");
					    	    	    			  option.text = getUser.users[i].email;
					    	    	    			  option.value = getUser.users[i].id;
					    	    	    			  listUser.add(option,listUser.options[null]);
					    	    	    		  }
					    	    	          }
					    	    	      });
					    	          }
					    	      });
	    		        	  });
	    		        	  $("#ban").click(function() {
	    		        		  $.ajax({
					    			  type: 'POST',
					    	          url: "${request.config.settings['nokkhum.api.url']}/admin/users/"+getUser.user.id+"/status/deactivate",
					    	          data:JSON.stringify({'tmp':'dummykung'}),
					    	          datatype: 'json',
					    	          error: function(){
					    	        	  alert('Too Bad');
					    	          },
					    	          success: function(){
					    	        	  $('#sInActiveUser').empty();
					    	        	  $('#sActiveUser').empty();
					    	        	  $("#name").text("");
				    		        	  $("#surname").text("");
				    		        	  $("#email").text("");
					    	        	  $.ajax({
					    	    			  type: 'GET',
					    	    	          url: "${request.config.settings['nokkhum.api.url']}/admin/users/status/active", 
					    	    	          datatype: 'json',
					    	    	          error: function(){
					    	    	        	  alert('Too Bad');
					    	    	          },
					    	    	          success: function(getUser){
					    	    	        	  var listUser = document.getElementById("sActiveUser");
					    	    	    		  for(i in getUser.users){
					    	    	    			  var option = document.createElement("option");
					    	    	    			  option.text = getUser.users[i].email;
					    	    	    			  option.value = getUser.users[i].id;
					    	    	    			  listUser.add(option,listUser.options[null]);
					    	    	    		  }
					    	    	          }
					    	    	      });
					    	        	  $.ajax({
					    	    			  type: 'GET',
					    	    	          url: "${request.config.settings['nokkhum.api.url']}/admin/users/status/deactivate", 
					    	    	          datatype: 'json',
					    	    	          error: function(){
					    	    	        	  alert('Too Bad');
					    	    	          },
					    	    	          success: function(getUser){
					    	    	        	  var listUser = document.getElementById("sInActiveUser");
					    	    	    		  for(i in getUser.users){
					    	    	    			  var option = document.createElement("option");
					    	    	    			  option.text = getUser.users[i].email;
					    	    	    			  option.value = getUser.users[i].id;
					    	    	    			  listUser.add(option,listUser.options[null]);
					    	    	    		  }
					    	    	          }
					    	    	      });
					    	          }
					    	      });
	    		        	  });
	    		        	  $("#delete").click(function() {
	    		        		  $.ajax({
					    			  type: 'POST',
					    	          url: "${request.config.settings['nokkhum.api.url']}/admin/users/"+getUser.user.id+"/status/delete",
					    	          data:JSON.stringify({'tmp':'dummykung'}),
					    	          datatype: 'json',
					    	          error: function(){
					    	        	  alert('Too Bad');
					    	          },
					    	          success: function(){
					    	        	  $('#sInActiveUser').empty();
					    	        	  $('#sActiveUser').empty();
					    	        	  $("#name").text("");
				    		        	  $("#surname").text("");
				    		        	  $("#email").text("");
					    	        	  $.ajax({
					    	    			  type: 'GET',
					    	    	          url: "${request.config.settings['nokkhum.api.url']}/admin/users/status/active", 
					    	    	          datatype: 'json',
					    	    	          error: function(){
					    	    	        	  alert('Too Bad');
					    	    	          },
					    	    	          success: function(getUser){
					    	    	        	  var listUser = document.getElementById("sActiveUser");
					    	    	    		  for(i in getUser.users){
					    	    	    			  var option = document.createElement("option");
					    	    	    			  option.text = getUser.users[i].email;
					    	    	    			  option.value = getUser.users[i].id;
					    	    	    			  listUser.add(option,listUser.options[null]);
					    	    	    		  }
					    	    	          }
					    	    	      });
					    	        	  $.ajax({
					    	    			  type: 'GET',
					    	    	          url: "${request.config.settings['nokkhum.api.url']}/admin/users/status/deactivate", 
					    	    	          datatype: 'json',
					    	    	          error: function(){
					    	    	        	  alert('Too Bad');
					    	    	          },
					    	    	          success: function(getUser){
					    	    	        	  var listUser = document.getElementById("sInActiveUser");
					    	    	    		  for(i in getUser.users){
					    	    	    			  var option = document.createElement("option");
					    	    	    			  option.text = getUser.users[i].email;
					    	    	    			  option.value = getUser.users[i].id;
					    	    	    			  listUser.add(option,listUser.options[null]);
					    	    	    		  }
					    	    	          }
					    	    	      });
					    	          }
					    	      });
	    		        	  });
	    		          }
	    			  });
	    		  });
	          }
	    });
		$.ajax({
			  type: 'GET',
	          url: "${request.config.settings['nokkhum.api.url']}/admin/users/status/deactivate", 
	          datatype: 'json',
	          error: function(){
	        	  alert('Too Bad');
	          },
	          success: function(getUser){
	        	  var listUser = document.getElementById("sInActiveUser");
	    		  for(i in getUser.users){
	    			  var option = document.createElement("option");
	    			  option.text = getUser.users[i].email;
	    			  option.value = getUser.users[i].id;
	    			  listUser.add(option,listUser.options[null]);
	    		  }
	    		  $("#sInActiveUser").change(function () {
	    			  $.ajax({
	    				  type: 'GET',
	    		          url: "${request.config.settings['nokkhum.api.url']}/admin/users/"+$("#sInActiveUser option:selected").val(), 
	    		          datatype: 'json',
	    		          error: function(){
	    		        	  alert('Too Bad');
	    		          },
	    		          success: function(getUser){
	    		     
	    		        	  $("#name").text(getUser.user.first_name);
	    		        	  $("#surname").text(getUser.user.last_name);
	    		        	  $("#email").text(getUser.user.email);
	    		        	  $("#approve").click(function() {
	    		        		  $.ajax({
					    			  type: 'POST',
					    	          url: "${request.config.settings['nokkhum.api.url']}/admin/users/"+getUser.user.id+"/status/active",
					    	          data:JSON.stringify({'tmp':'dummykung'}),
					    	          datatype: 'json',
					    	          error: function(){
					    	        	  alert('Too Bad');
					    	          },
					    	          success: function(){
					    	        	  $('#sInActiveUser').empty();
					    	        	  $('#sActiveUser').empty();
					    	        	  $("#name").text("");
				    		        	  $("#surname").text("");
				    		        	  $("#email").text("");
					    	        	  $.ajax({
					    	    			  type: 'GET',
					    	    	          url: "${request.config.settings['nokkhum.api.url']}/admin/users/status/deactivate", 
					    	    	          datatype: 'json',
					    	    	          error: function(){
					    	    	        	  alert('Too Bad');
					    	    	          },
					    	    	          success: function(getUser){
					    	    	        	  var listUser = document.getElementById("sInActiveUser");
					    	    	    		  for(i in getUser.users){
					    	    	    			  var option = document.createElement("option");
					    	    	    			  option.text = getUser.users[i].email;
					    	    	    			  option.value = getUser.users[i].id;
					    	    	    			  listUser.add(option,listUser.options[null]);
					    	    	    		  }
					    	    	          }
					    	    	      });
					    	        	  $.ajax({
					    	    			  type: 'GET',
					    	    	          url: "${request.config.settings['nokkhum.api.url']}/admin/users/status/active", 
					    	    	          datatype: 'json',
					    	    	          error: function(){
					    	    	        	  alert('Too Bad');
					    	    	          },
					    	    	          success: function(getUser){
					    	    	        	  var listUser = document.getElementById("sActiveUser");
					    	    	    		  for(i in getUser.users){
					    	    	    			  var option = document.createElement("option");
					    	    	    			  option.text = getUser.users[i].email;
					    	    	    			  option.value = getUser.users[i].id;
					    	    	    			  listUser.add(option,listUser.options[null]);
					    	    	    		  }
					    	    	          }
					    	    	      });
					    	          }
					    	      });
	    		        	  });
	    		        	  $("#ban").click(function() {
	    		        		  $.ajax({
					    			  type: 'POST',
					    	          url: "${request.config.settings['nokkhum.api.url']}/admin/users/"+getUser.user.id+"/status/deactivate",
					    	          data:JSON.stringify({'tmp':'dummykung'}),
					    	          datatype: 'json',
					    	          error: function(){
					    	        	  alert('Too Bad');
					    	          },
					    	          success: function(){
					    	        	  $('#sInActiveUser').empty();
					    	        	  $('#sActiveUser').empty();
					    	        	  $("#name").text("");
				    		        	  $("#surname").text("");
				    		        	  $("#email").text("");
					    	        	  $.ajax({
					    	    			  type: 'GET',
					    	    	          url: "${request.config.settings['nokkhum.api.url']}/admin/users/status/deactivate", 
					    	    	          datatype: 'json',
					    	    	          error: function(){
					    	    	        	  alert('Too Bad');
					    	    	          },
					    	    	          success: function(getUser){
					    	    	        	  var listUser = document.getElementById("sInActiveUser");
					    	    	    		  for(i in getUser.users){
					    	    	    			  var option = document.createElement("option");
					    	    	    			  option.text = getUser.users[i].email;
					    	    	    			  option.value = getUser.users[i].id;
					    	    	    			  listUser.add(option,listUser.options[null]);
					    	    	    		  }
					    	    	          }
					    	    	      });
					    	        	  $.ajax({
					    	    			  type: 'GET',
					    	    	          url: "${request.config.settings['nokkhum.api.url']}/admin/users/status/active", 
					    	    	          datatype: 'json',
					    	    	          error: function(){
					    	    	        	  alert('Too Bad');
					    	    	          },
					    	    	          success: function(getUser){
					    	    	        	  var listUser = document.getElementById("sActiveUser");
					    	    	    		  for(i in getUser.users){
					    	    	    			  var option = document.createElement("option");
					    	    	    			  option.text = getUser.users[i].email;
					    	    	    			  option.value = getUser.users[i].id;
					    	    	    			  listUser.add(option,listUser.options[null]);
					    	    	    		  }
					    	    	          }
					    	    	      });
					    	          }
					    	      });
	    		        	  });
	    		        	  $("#delete").click(function() {
	    		        		  $.ajax({
					    			  type: 'POST',
					    	          url: "${request.config.settings['nokkhum.api.url']}/admin/users/"+getUser.user.id+"/status/delete",
					    	          data:JSON.stringify({'tmp':'dummykung'}),
					    	          datatype: 'json',
					    	          error: function(){
					    	        	  alert('Too Bad');
					    	          },
					    	          success: function(){
					    	        	  $('#sInActiveUser').empty();
					    	        	  $('#sActiveUser').empty();
					    	        	  $("#name").text("");
				    		        	  $("#surname").text("");
				    		        	  $("#email").text("");
					    	        	  $.ajax({
					    	    			  type: 'GET',
					    	    	          url: "${request.config.settings['nokkhum.api.url']}/admin/users/status/deactivate", 
					    	    	          datatype: 'json',
					    	    	          error: function(){
					    	    	        	  alert('Too Bad');
					    	    	          },
					    	    	          success: function(getUser){
					    	    	        	  var listUser = document.getElementById("sInActiveUser");
					    	    	    		  for(i in getUser.users){
					    	    	    			  var option = document.createElement("option");
					    	    	    			  option.text = getUser.users[i].email;
					    	    	    			  option.value = getUser.users[i].id;
					    	    	    			  listUser.add(option,listUser.options[null]);
					    	    	    		  }
					    	    	          }
					    	    	      });
					    	        	  $.ajax({
					    	    			  type: 'GET',
					    	    	          url: "${request.config.settings['nokkhum.api.url']}/admin/users/status/active", 
					    	    	          datatype: 'json',
					    	    	          error: function(){
					    	    	        	  alert('Too Bad');
					    	    	          },
					    	    	          success: function(getUser){
					    	    	        	  var listUser = document.getElementById("sActiveUser");
					    	    	    		  for(i in getUser.users){
					    	    	    			  var option = document.createElement("option");
					    	    	    			  option.text = getUser.users[i].email;
					    	    	    			  option.value = getUser.users[i].id;
					    	    	    			  listUser.add(option,listUser.options[null]);
					    	    	    		  }
					    	    	          }
					    	    	      });
					    	          }
					    	      });
	    		        	  });
	    		          }
	    			  });
	    		  });
	          }
	    });
	});
</script>
</%block>
<%block name='menu'>
<div class="menu">
	<a href="/home" id="back">Back</a>
</div>
</%block>
<div id="controlpanel">
	<div id="list-user">
		<div id="accordion" class="accord">
			<h3>ActiveUser</h3>
			<div id="divActiveUser" class="dlistuser">
				<select id="sActiveUser" multiple="multiple" class="slistuser">
				</select>
			</div>
			<h3>InActiveUser</h3>
			<div id="divInActiveUser" class="dlistuser">
				<select id="sInActiveUser" multiple="multiple" class="slistuser">
				</select>
			</div>
		</div>
	</div>
	<div id="sprofile-user">
		<div class="centered">
		<dl>
			<dt>
				<label for="name">Name :</label>
			</dt>
			<dd><label id="name"></label></dd>
		</dl>
		<dl>
			<dt>
				<label for="surname">Surname :</label>
			</dt>
			<dd><label id="surname"></label></dd>
		</dl>
		<dl>
			<dt>
				<label for="email">Email :</label>
			</dt>
			<dd><label id="email"></label></dd>
		</dl>
		<div id="radio" class="bcentered">
			<button id="approve">Approve</button>
			<button id="ban">Ban</button>
			<button id="delete">Delete</button>
		</div>
		</div>
	</div>
</div>
