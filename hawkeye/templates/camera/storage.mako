<%inherit file="/base/base.mako"/>

<div class="ui-overlay">
	<div class="ui-widget-overlay"></div>
	<div class="ui-widget-shadow ui-corner-all storage-set-shadow-style"></div>
</div>
<div class="ui-widget ui-widget-content ui-corner-all storage-set-content-style">
	<div class="ui-dialog-content ui-widget-content storage-set-content-inner-style">
		<div>
			% for file in files:
				% if file['file']:
				${file['name']} <a href="/camera/files?files_url=${file['download']}&camera_id=${camera['id']}">view</a> <a href="/camera/files/delete?files_url=${file['url']}">delete</a><br/>
				% else:
				${file['name']} <a href="/camera/storage?files_url=${file['url']}&camera_id=${camera['id']}">view</a> <a href="/camera/files/delete?files_url=${file['url']}">delete</a><br/>
				% endif
            % endfor
			<div>
			% if route is not None:
				##${route}<br/>
				<a href=${route}><input type="button" value="Back"></a>
			% endif
			<a href="/home"><input type="button"  value="Home"></a>
			</div>
		</div>
	</div>
</div>