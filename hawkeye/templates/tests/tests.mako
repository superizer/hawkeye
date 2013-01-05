<%inherit file="/base/base.mako"/>

<form action="/camera/edit" method = "put">
Add Camera to Project ${project['name']}<br/>
Name : ${form.name} <br/>
Url :  ${form.url} <br/>
Username : ${form.username} </br>
Password : ${form.password} </br>
Fps : ${form.fps()} </br> 
Image size : ${form.image_size()}  </br>
Menufactory : ${form.manufactory()} </br>
Model : ${form.model()} </br>
Record Store : ${form.record_store} </br> 
<input type="hidden" name="camera_id" value="${camera['id']}"/>
<input type="hidden" name="project_id" value="${project['id']}"/>
<input type="submit" value="Save">
<input type="reset"   value="Reset"> 
<a href="/home"><input type="button"  value="Cancel"></a>
</form>

<div id="container"></div>
<script type="text/javascript" src="public/js/kinetic-v4.2.0.min.js"></script>
<script type="text/javascript" src="public/js/editor.js"></script>

<style>
body {
	font-size: 62.5%;
}

label,input {
	display: block;
}

input.text {
	margin-bottom: 12px;
	width: 95%;
	padding: .4em;
}

fieldset {
	padding: 0;
	border: 0;
	margin-top: 25px;
}

h1 {
	font-size: 1.2em;
	margin: .6em 0;
}

div#users-contain {
	width: 350px;
	margin: 20px 0;
}

div#users-contain table {
	margin: 1em 0;
	border-collapse: collapse;
	width: 100%;
}

div#users-contain table td,div#users-contain table th {
	border: 1px solid #eee;
	padding: .6em 10px;
	text-align: left;
}

.ui-dialog .ui-state-error {
	padding: .3em;
}

.validateTips {
	border: 1px solid transparent;
	padding: 0.3em;
}
</style>
<div style="display: none">
	<div id="camera-form" title="Edit Camera">
		<form>
			<fieldset>
				<label for="id">ID</label> <input type="text" name="id" id="id"
					class="text ui-widget-content ui-corner-all" /> <label for="name">Name</label>
				<input type="text" name="name" id="name"
					class="text ui-widget-content ui-corner-all" /> <label for="url">Url</label>
				<input type="text" name="url" id="url"
					class="text ui-widget-content ui-corner-all" /> <label
					for="height">Height</label> <input type="text" name="height"
					id="height" class="text ui-widget-content ui-corner-all" /> <label
					for="width">Width</label> <input type="text" name="width"
					id="width" class="text ui-widget-content ui-corner-all" /> <label
					for="fps">Fps</label> <input type="text" name="fps" id="fps"
					class="text ui-widget-content ui-corner-all" /> <label for="model">Model</label>
				<input type="text" name="model" id="model"
					class="text ui-widget-content ui-corner-all" /> <label
					for="username">Username</label> <input type="text" name="username"
					id="username" value="" class="text ui-widget-content ui-corner-all" />
				<label for="password">Password</label> <input type="password"
					name="password" id="password" value=""
					class="text ui-widget-content ui-corner-all" />
			</fieldset>
		</form>
	</div>

	<div id="Motion-Detector-form" title="Edit Motion Detector">
		<form>
			<fieldset>
				<label for="name">Name</label> <input type="text" name="name"
					id="name" class="text ui-widget-content ui-corner-all" /> <label
					for="interval">Interval</label> <input type="text" name="interval"
					id="interval" class="text ui-widget-content ui-corner-all" /> <label
					for="resolution">Resolution</label> <input type="text"
					name="resolution" id="resolution"
					class="text ui-widget-content ui-corner-all" /> <label
					for="dropmotion">Drop motion</label> <input type="text"
					name="dropmotion" id="dropmotion"
					class="text ui-widget-content ui-corner-all" />
			</fieldset>
		</form>
	</div>

	<div id="Face-Detector-form" title="Edit Face Detector">
		<form>
			<fieldset>
				<label for="name">Name</label> <input type="text" name="name"
					id="name" class="text ui-widget-content ui-corner-all" /> <label
					for="interval">Interval</label> <input type="text" name="interval"
					id="interval" class="text ui-widget-content ui-corner-all" />
			</fieldset>
		</form>
	</div>

	<div id="Video-Recorder-form" title="Edit Video Recorder">
		<form>
			<fieldset>
				<label for="name">Name</label> <input type="text" name="name"
					id="name" class="text ui-widget-content ui-corner-all" /> <label
					for="height">Height</label> <input type="text" name="height"
					id="height" class="text ui-widget-content ui-corner-all" /> <label
					for="width">Width</label> <input type="text" name="width"
					id="width" class="text ui-widget-content ui-corner-all" /> <label
					for="maximumwaitmotion">Maximum wait motion</label> <input
					type="text" name="maximumwaitmotion" id="maximumwaitmotion"
					class="text ui-widget-content ui-corner-all" /> <label for="fps">Fps</label>
				<input type="text" name="fps" id="fps"
					class="text ui-widget-content ui-corner-all" /> <label
					for="recordmotion">Record motion</label> <input type="text"
					name="recordmotion" id="recordmotion"
					class="text ui-widget-content ui-corner-all" />
			</fieldset>
		</form>
	</div>

	<div id="Image-Recorder-form" title="Edit Image Recorder">
		<form>
			<fieldset>
				<label for="name">Name</label> <input type="text" name="name"
					id="name" class="text ui-widget-content ui-corner-all" /> <label
					for="height">Height</label> <input type="text" name="height"
					id="height" class="text ui-widget-content ui-corner-all" /> <label
					for="width">Width</label> <input type="text" name="width"
					id="width" class="text ui-widget-content ui-corner-all" />
			</fieldset>
		</form>
	</div>
</div>