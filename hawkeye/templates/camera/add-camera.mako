<%inherit file="/base/base.mako"/>
<link media="screen" href="${base_url}/public/theme/style/canvas.css" rel="stylesheet" type="text/css" />
<script>
	var oldoption = undefined;
	var projectid = ${project['id']};
	var userid = ${project['user']['id']};
  $(function(){
	  $.getJSON("${url_api + '/manufactories'}", function(menuGet){
		  var menuFact = document.getElementById("menufactory");
		  menuFact.name = menuGet.manufactories[0].id;
		  for(i in menuGet.manufactories){
			  var option = document.createElement("option");
			  option.text = menuGet.manufactories[i].name;
			  option.value = menuGet.manufactories[i].name;
			  menuFact.add(option,menuFact.options[null]);
		  }
		  $.ajax({
	            type: 'GET',
	            url: "${url_api + '/camera_models'}"+menuGet.manufactories[0].id,
	            success: function(modelGet) {
	            	 var modelist = document.getElementById("model");
	            	 modelist.name = modelGet.camera_models[0].id;
					  for(i in modelGet.camera_models){
						  var option = document.createElement("option");
						  option.text = modelGet.camera_models[i].name;
						  option.value = modelGet.camera_models[i].name;
						  modelist.add(option,modelist.options[null]);
					  }
	            }
	         });
		  
		  $("#menufactory").change(function () {
			  var str = "";
			  var id = "";
			  $("#menufactory option:selected").each(function () {
		            str = $(this).text();
		      });
			  for(i in menuGet.manufactories){
			  	if(str == menuGet.manufactories[i].name){
			  		id = menuGet.manufactories[i].id;
			  		break;
			  	}
			  }
			  menuFact.name = id;
			  $.ajax({
		            type: 'GET',
		            url: "${url_api + '/camera_models'}"+id,
		            success: function(modelGet) {
		            	 var modelist = document.getElementById("model");
						  for(i in modelGet.camera_models){
							  var option = document.createElement("option");
							  option.text = modelGet.camera_models[i].name;
							  option.value = modelGet.camera_models[i].name;
							  modelist.add(option,modelist.options[null]);
						  }
		            }
		         });
			  $("#model").change(function () {
				  var tmpstr = "";
				  $("#model option:selected").each(function () {
			            tmpstr = $(this).text();
			      });
				  $.ajax({
			            type: 'GET',
			            url: "${url_api + '/camera_models'}"+id,
			            success: function(modelGet) {
			            	 var modelist = document.getElementById("model");
							  for(i in modelGet.camera_models){
								  if(tmpstr == modelGet.camera_models[i].name){
									  modelist.name = modelGet.camera_models[i].id;
									  break;
								  }
							  }
			            }
			      });
			  });
		  });
	  });
  });

</script>
<div style="display: none">
	<form>
		<input type="hidden" id="project_id" name="id" value="${project['id']}"/>
	</form>
	<form id="formsave" action="/camera/add" method = "post">
		<input type="hidden" id="camera_json" name="camera_json" value=""/>
	</form>
	<form id="formcancel"action="/home">
	</form>

	<div id="camera-form" title="Edit Camera">
		<form>
			<fieldset> 
				<label for="name">Name</label> <input type="text" name="name" id="name" class="text ui-widget-content ui-corner-all" />  
				<label for="url">Url</label> <input type="text" name="url" id="url" class="text ui-widget-content ui-corner-all" />
				<label for="username">Username</label> <input type="text" name="username" id="username" class="text ui-widget-content ui-corner-all" />
			    <label for="password">Password</label> <input type="text" name="password" id="password" class="text ui-widget-content ui-corner-all" />
				<label for="fps">Fps</label> 
				<select id="fps" class="select ui-widget-content ui-corner-all">
				<%
					tmp = [i for i in range(1,31)]
				%>
				% for x in tmp: 
				  <option value=${x}>${x}</option>
				%endfor:
                </select >
				<label  for="imagesize">Image size</label> 
                <select id="imagesize" class="select ui-widget-content ui-corner-all">
				<%
					tmp = ["320x240","640x480"]
				%>
				% for x in tmp: 
				  <option value=${x}>${x}</option>
				%endfor:
                </select>
				<label for="menufactory">Menufactory</label>
                <select id="menufactory" class="select ui-widget-content ui-corner-all">
                </select>
				<label for="model">Model</label> 
                <select id="model" class="select ui-widget-content ui-corner-all">
                </select>
				<label for="recordstore">Record Store</label> <input type="text" name="recordstore" id="recordstore" class="text ui-widget-content ui-corner-all" /> 
		</fieldset>
		</form>
	</div>

	<div id="Motion-Detector-form" title="Edit Motion Detector">
		<form>
			<fieldset>
				<label for="interval">Interval</label> <input type="text" name="interval" id="interval" class="text ui-widget-content ui-corner-all" /> 
				<label for="resolution">Resolution</label> <input type="text" name="resolution" id="resolution" class="text ui-widget-content ui-corner-all" /> 
				<label for="dropmotion">Drop motion</label> <input type="text" name="dropmotion" id="dropmotion" class="text ui-widget-content ui-corner-all" />
			</fieldset>
		</form>
	</div>

	<div id="Face-Detector-form" title="Edit Face Detector">
		<form>
			<fieldset>
				<label for="interval">Interval</label> <input type="text" name="interval" id="interval" class="text ui-widget-content ui-corner-all" />
			</fieldset>
		</form>
	</div>

	<div id="Video-Recorder-form" title="Edit Video Recorder">
		<form>
			<fieldset>
				<label for="height">Height</label> <input type="text" name="height" id="height" class="text ui-widget-content ui-corner-all" /> 
				<label for="width">Width</label> <input type="text" name="width" id="width" class="text ui-widget-content ui-corner-all" /> 
				<label for="maximumwaitmotion">Maximum wait motion</label> <input type="text" name="maximumwaitmotion" id="maximumwaitmotion" class="text ui-widget-content ui-corner-all" /> 
				<label for="fps">Fps</label> <input type="text" name="fps" id="fps"class="text ui-widget-content ui-corner-all" /> 
				<label for="recordmotion">Record motion</label> <input type="text" name="recordmotion" id="recordmotion" class="text ui-widget-content ui-corner-all" />
			</fieldset>
		</form>
	</div>

	<div id="Image-Recorder-form" title="Edit Image Recorder">
		<form>
			<fieldset>
				<label for="height">Height</label> <input type="text" name="height" id="height" class="text ui-widget-content ui-corner-all" /> 
				<label for="width">Width</label> <input type="text" name="width" id="width" class="text ui-widget-content ui-corner-all" />
			</fieldset>
		</form>
	</div>
</div>
<div id="container"></div>
<script type="text/javascript" src="${base_url}/public/js/kinetic-v4.2.0.min.js"></script>
<script type="text/javascript" src="${base_url}/public/js/editor.js"></script>
