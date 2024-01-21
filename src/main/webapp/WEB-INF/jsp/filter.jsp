<%@ include file="content/header.jspf" %>
<body class="pt-5 bg-light">
   	<div id="loading" class="loading">
		<img id="loading-image" class="loading-image" src="/image/loader.png" alt="Loading..." />
	</div>
	<%@ include file="content/script.jspf" %>
    <div class="w-100 text-center">
    	<div id="popupId" class="ui grey label copy-popup">Copied.</div>
    </div>
	<form class="row g-2" id="filterForm" method="post">
	    <div class="col-lg-1 col-12"></div>
	    <div class="col-lg-2 col-12 border border-end-0 bg-white p-3">
	        <select class="form-select mt-1" id="filterStartPrice"></select>
	    </div>
	    <div class="col-lg-2 col-12 border border-end-0 bg-white p-3">
	        <select class="form-select mt-1" id="filterEndPrice"></select>
	    </div>
	    <div class="col-lg-2 col-12 border border-end-0 bg-white p-3">
	        <select class="form-select mt-1" id="filterSeason"></select>
	    </div>
	    <div class="col-lg-2 col-12 border border-end-0 bg-white p-3">
	        <select class="form-select mt-1" id="filterDuration"></select>
	    </div>
	    <div class="col-lg-2 col-12 border p-3 bg-white" style="font-size: 0;">
	        <button onclick="onGetData(null)" type="button" class="small ui right labeled icon button d-inline-block w-50 fs-6 m-0 border border-1 border-light grey">
		        <i class="refresh icon"></i>
		        Reset
	        </button>
	        <button type="submit" class="small ui right labeled icon button d-inline-block w-50 fs-6 m-0 border border-1 border-light purple">
		        <i class="search icon"></i>
		        Search
	        </button>
	    </div>
	    <div class="col-lg-1 col-12"></div>
	</form>
	<div class="row g-2">
	    <div class="col-lg-1 col-12"></div>
	    <div class="col-lg-10 col-12 text-center border border-top-0 bg-white" id="filtersId"></div>
	    <div class="col-lg-1 col-12"></div>
	</div>
	<div class="row g-2 mt-4">
	    <div class="col-lg-1 col-12"></div>
	    <div class="col-lg-10 col-12">
	        <div class="row row-cols-1 row-cols-md-4 g-3" id="packagesId"></div>
	    </div>
	    <div class="col-lg-1 col-12"></div>
	</div>
	<script type="text/javascript">
    	$('.menu .item').tab();
    	
		function onWindowLoad() {
			onGetData(null);
		}
		
		function copyToClipboard(text) {
			displayPopup();
			navigator.clipboard.writeText(text).then(function() {
				console.log('Async: Copying to clipboard was successful!');
				setTimeout(function() {
					hidePopup();
				}, 4000);
			}, function(err) {
				console.error('Async: Could not copy text: ', err);
			});
		}
		
		function onGetData(filterData) {
		    $('#loading').show();
		    $('#packagesId').empty();
            $('#filtersId').empty();
            resetForm('filterForm');

            if (filterData) {
            	if (filterData.filterSeason) {
            		let divLabel = $('<div>').addClass('ui label blue mx-1 my-3').append('Season <div class="detail">'+filterData.filterSeason+'</div>');
                    $('#filtersId').append(divLabel);
				}
				if (filterData.filterDuration) {
            		let divLabel = $('<div>').addClass('ui label blue mx-1 my-3').append('Duration <div class="detail">'+filterData.filterDuration+'</div>');
                    $('#filtersId').append(divLabel);
				}
				if (filterData.filterStartPrice) {
            		let divLabel = $('<div>').addClass('ui label blue mx-1 my-3').append('Min. Price <div class="detail">'+ 'RM ' + (+filterData.filterStartPrice).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,') +'</div>');
                    $('#filtersId').append(divLabel);
				}
				if (filterData.filterEndPrice) {
            		let divLabel = $('<div>').addClass('ui label blue mx-1 my-3').append('Max. Price <div class="detail">'+ 'RM ' + (+filterData.filterEndPrice).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,') +'</div>');
                    $('#filtersId').append(divLabel);
				}
            } else {
                $('#filtersId').html('&nbsp;');
            }
            
		    $.ajax({
		        type: 'GET',
		        // beforeSend: function(request) {
			  	// 	request.setRequestHeader("ngrok-skip-browser-warning", true)
				// },
		        url: 'http://localhost:5000/umrah'
		    }).then(function(dataList) {
		        let seasons = [];
		        let durations = [];

		        for (const data of dataList.result) {
		            for (const season of data.seasons) {
		                for (const room of season.rooms) {
		                    if (season.name) {
		                        if (seasons.indexOf(season.name) < 0) {
		                            seasons.push(season.name);
		                        }
		                    }
		                    if (data.duration) {
		                        if (durations.indexOf(data.duration) < 0) {
		                            durations.push(data.duration);
		                        }
		                    }
		                    
		                    let status = true;

		                    if (filterData) {
		                    	if (filterData.filterSeason && filterData.filterSeason !== season.name) {
									status = false;
								}
								if (filterData.filterDuration && filterData.filterDuration !== data.duration) {
									status = false;
								}
								if (filterData.filterStartPrice && room.room_price < filterData.filterStartPrice) {
									status = false;
								}
								if (filterData.filterEndPrice && room.room_price > filterData.filterEndPrice) {
									status = false;
								}
		                    }
		                    
		                    if (status) {
		                    	let shareContent = '<i class="copy outline icon"></i> Share';
			                    let shareBtn = $('<button>').addClass('small ui right labeled icon button teal').click(function() { copyToClipboard(data.url); }).append(shareContent);
			                    
			                    let visitContent = '<i class="right arrow icon"></i> Visit Website';
			                    let visitBtn = $('<a>').addClass('small ui right labeled icon button violet').attr("href", data.url).attr( 'target','_blank' ).append(visitContent);
			                    
			                    let divFooter = $('<div>').addClass('extra content').append(shareBtn).append(visitBtn);
			                    
			                    let li1 = $('<li>').html(data.duration);
			                    let li2 = $('<li>').html(room.room_name);
			                    let li3 = $('<li>').html('RM ' + (+room.room_price).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,'));
			                    
			                    let ul = $('<ul>').addClass('m-0').append(li1).append(li2).append(li3);
			                    
			                    let divDesc = $('<div>').addClass('description').append(ul);
			                    let divMeta = $('<div>').addClass('meta').html(season.name);
			                    let divHeader = $('<div>').addClass('header').append(data.name.toUpperCase());
	
			                    let divContent = $('<div>').addClass('content').append(divHeader).append(divMeta).append(divDesc);
			                    let divCard = $('<div>').addClass('ui card w-100').append(divContent).append(divFooter);
			                    let divCol = $('<div>').addClass('col').append(divCard);
			                    
			                    $('#packagesId').append(divCol);
		                    }
		                }
		            }
		        }
		        
		        $("#filterStartPrice").empty();
		        $("#filterStartPrice").append($("<option>", {
		            value: "",
		            text: "Minimum Price"
		        }).attr('selected', 'selected').attr('disabled', 'disabled').attr('hidden', 'hidden'));
		        $("#filterStartPrice").append($("<option>", { value: "5000", text: "RM 5,000.00" }));
		        $("#filterStartPrice").append($("<option>", { value: "10000", text: "RM 10,000.00" }));
		        $("#filterStartPrice").append($("<option>", { value: "15000", text: "RM 15,000.00" }));
		        $("#filterStartPrice").append($("<option>", { value: "20000", text: "RM 20,000.00" }));
		        $("#filterStartPrice").append($("<option>", { value: "25000", text: "RM 25,000.00" }));
		        
		        $("#filterEndPrice").empty();
		        $("#filterEndPrice").append($("<option>", {
		            value: "",
		            text: "Maximum Price"
		        }).attr('selected', 'selected').attr('disabled', 'disabled').attr('hidden', 'hidden'));
		        $("#filterEndPrice").append($("<option>", { value: "5000", text: "RM 5,000.00" }));
		        $("#filterEndPrice").append($("<option>", { value: "10000", text: "RM 10,000.00" }));
		        $("#filterEndPrice").append($("<option>", { value: "15000", text: "RM 15,000.00" }));
		        $("#filterEndPrice").append($("<option>", { value: "20000", text: "RM 20,000.00" }));
		        $("#filterEndPrice").append($("<option>", { value: "25000", text: "RM 25,000.00" }));
		        
		        $("#filterSeason").empty();
		        $("#filterSeason").append($("<option>", {
		            value: "",
		            text: "Season"
		        }).attr('selected', 'selected').attr('disabled', 'disabled').attr('hidden', 'hidden'));
		        
		        $.each(seasons, function(i, season) {
		            $("#filterSeason").append($("<option>", {
		                value: season,
		                text: season
		            }));
		        });

		        $("#filterDuration").empty();
		        $("#filterDuration").append($("<option>", {
		            value: "",
		            text: "Duration"
		        }).attr('selected', 'selected').attr('disabled', 'disabled').attr('hidden', 'hidden'));
		        
		        $.each(durations, function(i, duration) {
		            $("#filterDuration").append($("<option>", {
		                value: duration,
		                text: duration
		            }));
		        });

		        $('#loading').hide();
		    });
		}
		
		$('#filterForm').submit(function(event) {
		    event.preventDefault();

		    let filterData = {};
		    filterData['filterStartPrice'] = $('#filterStartPrice').val();
		    filterData['filterEndPrice'] = $('#filterEndPrice').val();
		    filterData['filterSeason'] = $('#filterSeason').val();
		    filterData['filterDuration'] = $('#filterDuration').val();

		    let filterObject = {};
		    filterObject['filterStartPriceStatus'] = ($('#filterStartPrice').val()) ? 1 : 0;
		    filterObject['filterStartPriceValue'] = $('#filterStartPrice').val();
		    filterObject['filterEndPriceStatus'] = ($('#filterEndPrice').val()) ? 1 : 0;
		    filterObject['filterEndPriceValue'] = $('#filterEndPrice').val();
		    filterObject['filterSeasonStatus'] = ($('#filterSeason').val()) ? 1 : 0;
		    filterObject['filterSeasonValue'] = $('#filterSeason').val();
		    filterObject['filterDurationStatus'] = ($('#filterDuration').val()) ? 1 : 0;
		    filterObject['filterDurationValue'] = $('#filterDuration').val();

		    onGetData(filterData);

		    let json = JSON.stringify(filterObject);
		    let formData = new FormData();
		    formData.append("filterRequest", new Blob([json], {
		        type: "application/json"
		    }));

		    $.ajax({
		        type: "POST",
		        url: "/filter",
		        processData: false,
		        contentType: false,
		        cache: false,
		        data: formData
		    }).then(function(data) {
		        console.log(data);
		    });
		});
	</script>
</body>
<%@ include file="content/footer.jspf" %>