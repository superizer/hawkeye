<%inherit file="/base/base.mako"/> 
<%! import json %>
<%block name='script'>
  <script>
  
  $(function() {
	  
	  $.ajax({
		  type: 'GET',
          url: "${request.config.settings['nokkhum.api.url']}/projects/${project_id}/cameras", 
          datatype: 'json',
          error: function(resp){
        	  console.debug("header-> : "+JSON.stringify(resp.getAllResponseHeaders()));
          },
          success: function(cameraGet){
          		var listCamera = cameraGet.project.cameras;
          		var point = 0;
          		var nextpoint = 0;
          		var data_size = listCamera.length;
          		$("#home").button();
          		$("#prev-views").button({ disabled: true }).click(function(){
          			$("#next-views").button({ disabled: false });
          			point -= nextpoint;
          			if(point <= 0 ){
          				$("#prev-views").button({ disabled: true });
          				point = 0;
          			}
          			generateArea();
          		});
          		$("#next-views").button({ disabled: true }).click(function(){
          			$("#prev-views").button({ disabled: false });
          			point += nextpoint;
          			if(point >= data_size - 1 ){
          				point = data_size - 1 ;
          				$("#next-views").button({ disabled: true });
          			}
          			generateArea();
          		});
          		
          		function generateArea(){
          			$('#ob-area').empty();
          			for(var i=0;i<nextpoint;++i){
          				if(point + i < data_size){
          					$.ajax({
        						  type: 'GET',
        				          url: "${request.config.settings['nokkhum.api.url']}/cameras/"+listCamera[point + i].id, 
        				          datatype: 'json',
        				          error: function(resp){
        				        	  console.debug("header-> : "+JSON.stringify(resp.getAllResponseHeaders()));
        				          },
        				          success: function(urlGet){
        				        	  var url = urlGet.camera.image_url;
        				        	  var imgId = "display-"+urlGet.camera.id;
            						  url = url + "?.jpg";
            						  
            						  var img = document.createElement("IMG");
          		                      switch(nextpoint){
          		                      case 1:
          		                    	 img.className = "append-c c-1";
          		                    	 break;
          		                      case 4:
          		                    	 img.className = "append-c c-2";
          		                    	 break;
          		                      }
          		                      img.id = imgId;
          		                      img.src = url;
          	                    	  document.getElementById('ob-area').appendChild(img);
          	                    	  $("#" + imgId).ready(function(){
        								  function updateImage(tmpId){
        									  var image = document.getElementById(tmpId);
        									  if(image != null){
        								      if(image.complete) {
        								    	  var timestamp = new Date().getTime();
        								    	  var str = url;
        								          image.src = str.substr(0,str.lastIndexOf('.')) + 'data=' +timestamp;
        								        
        								      }
        								      setTimeout(updateImage, 50, tmpId);
        									  }
        								  }
        								  updateImage(imgId);
        							  });
        				          }
        				    });
          				}
          			}
          		}
          		
          		function setArea() {
          	      switch($("#obsize").val()){
          	  		case '1':
          		  		point = 0;
          		  		nextpoint = 1;
          		  		$("#prev-views").button({ disabled: true });
          		  		$("#next-views").button({ disabled: true });
          		  		if(data_size > 1){
          		  			$("#next-views").button({ disabled: false });
          		  		}
          		  		generateArea();
          	  			break;
          	  		case '4':
          		  		point = 0;
          		  		nextpoint = 4;
          		  		$("#prev-views").button({ disabled: true });
          		  		$("#next-views").button({ disabled: true });
          		  		if(data_size > 4){
          		  			$("#next-views").button({ disabled: false });
          		  		}
          		  		generateArea();
          	  			break;
          	  	}
          	}
          	$('#obsize').change(setArea);
          	setArea();
          }
	  });
	  
  });
  </script>
</%block> 
<%block name='menu'>
<div class="menu">
	<button id="prev-views" >Previous</button>
	<button id="next-views" >Next</button>
	<a href="/home" id="home" >Home</a>
	<select id="obsize" class="select ui-widget-content ui-corner-all">
		<option value="1">1 x 1</option>
		<option value="4">2 x 2</option>
	</select>
</div>
</%block>
<div id="ob-area">
</div>