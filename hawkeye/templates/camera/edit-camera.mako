<%inherit file="/base/base.mako"/>
<link media="screen" href="${base_url}/public/theme/style/canvas.css" rel="stylesheet" type="text/css" />
<div id="container"></div>
<script type="text/javascript" src="${base_url}/public/js/kinetic-v4.2.0.min.js"></script>
<script type="text/javascript" src="${base_url}/public/js/editor.js"></script>

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





