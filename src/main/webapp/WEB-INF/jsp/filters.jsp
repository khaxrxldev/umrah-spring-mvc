<%@ include file="content/header.jspf" %>
<body>
	<%@ include file="content/script.jspf" %>
	<%@ include file="content/sidebar_header.jspf" %>
	<div class="w-100">
        <div class="fs-4 fw-bold w-100 py-3 px-4 border border-0 border-bottom">FILTER VISUALIZATION</div>
        <div class="w-100 p-2">
        	<div class="w-100 ui card">
		        <div class="fs-6 fw-bold p-2 header bg-light">SEASON</div>
			    <div class="content pe-5">
	        		<div id="seasonChartId"></div>
			    </div>
			</div>
        	<div class="w-100 ui card">
		        <div class="fs-6 fw-bold p-2 header bg-light">DURATION</div>
			    <div class="content pe-5">
	        		<div id="durationChartId"></div>
			    </div>
			</div>
        	<div class="w-100 ui card">
		        <div class="fs-6 fw-bold p-2 header bg-light">MINIMUM PRICE</div>
			    <div class="content pe-5">
	        		<div id="minPriceChartId"></div>
			    </div>
			</div>
        	<div class="w-100 ui card">
		        <div class="fs-6 fw-bold p-2 header bg-light">MAXIMUM PRICE</div>
			    <div class="content pe-5">
	        		<div id="maxPriceChartId"></div>
			    </div>
			</div>
		</div>
	</div>
	
	<%@ include file="content/sidebar_footer.jspf" %>
	<script type="text/javascript">
		function onWindowLoad() {
			onGetFilters();
		}
		
		function onGetFilters() {
			$.ajax({
				type: "GET",
		        url: "/filters"
		    }).then(function(dataList) {
				let seasons = [];
				let durations = [];
				let minPrices = [];
				let maxPrices =[];
				
				if (dataList.length) {
					for (let data of dataList) {
						if (+data.filterSeasonStatus) {
							if (seasons.indexOf(data.filterSeasonValue) < 0) {
								seasons.push(data.filterSeasonValue);
							}
						}
					}
				}
				
				if (dataList.length) {
					for (let data of dataList) {
						if (+data.filterDurationStatus) {
							if (durations.indexOf(data.filterDurationValue) < 0) {
								durations.push(data.filterDurationValue);
							}
						}
					}
				}
				
				if (dataList.length) {
					for (let data of dataList) {
						if (+data.filterStartPriceStatus) {
							if (minPrices.indexOf(data.filterStartPriceValue) < 0) {
								minPrices.push(data.filterStartPriceValue);
							}
						}
					}
				}
				if (dataList.length) {
					for (let data of dataList) {
						if (+data.filterEndPriceStatus) {
							if (maxPrices.indexOf(data.filterEndPriceValue) < 0) {
								maxPrices.push(data.filterEndPriceValue);
							}
						}
					}
				}
				
				let seasonArrayList = [];
				let columnSeasonArray = []; 
				columnSeasonArray[0] = 'Season';
				columnSeasonArray[1] = 'Total';
				seasonArrayList.push(columnSeasonArray);
				
				for (let season of seasons) {
					let seasonArray = []; 
					let total = 0;
					for (let data of dataList) {
						if (+data.filterSeasonStatus) {
							if (data.filterSeasonValue === season) {
								total++;
							}
						}
					}
					seasonArray[0] = season;
					seasonArray[1] = total;
					seasonArrayList.push(seasonArray);
				}
				
				let durationArrayList = [];
				let columnDurationArray = []; 
				columnDurationArray[0] = 'Duration';
				columnDurationArray[1] = 'Total';
				durationArrayList.push(columnDurationArray);
				
				for (let duration of durations) {
					let durationArray = []; 
					let total = 0;
					for (let data of dataList) {
						if (+data.filterDurationStatus) {
							if (data.filterDurationValue === duration) {
								total++;
							}
						}
					}
					durationArray[0] = duration;
					durationArray[1] = total;
					durationArrayList.push(durationArray);
				}
				
				let minPriceArrayList = [];
				let columnMinPriceArray = []; 
				columnMinPriceArray[0] = 'Minimum Prices';
				columnMinPriceArray[1] = 'Total';
				minPriceArrayList.push(columnMinPriceArray);
				
				for (let minPrice of minPrices) {
					let minPriceArray = []; 
					let total = 0;
					for (let data of dataList) {
						if (+data.filterStartPriceStatus) {
							if (+data.filterStartPriceValue === minPrice) {
								total++;
							}
						}
					}
					minPriceArray[0] = minPrice.toString();
					minPriceArray[1] = total;
					minPriceArrayList.push(minPriceArray);
				}
				
				let maxPriceArrayList = [];
				let columnMaxPriceArray = []; 
				columnMaxPriceArray[0] = 'Maximum Prices';
				columnMaxPriceArray[1] = 'Total';
				maxPriceArrayList.push(columnMaxPriceArray);
				
				for (let maxPrice of maxPrices) {
					let maxPriceArray = []; 
					let total = 0;
					for (let data of dataList) {
						if (+data.filterEndPriceStatus) {
							if (+data.filterEndPriceValue === maxPrice) {
								total++;
							}
						}
					}
					maxPriceArray[0] = maxPrice.toString();
					maxPriceArray[1] = total;
					maxPriceArrayList.push(maxPriceArray);
				}
				
				onDrawSeasonChart(seasonArrayList, 'seasonChartId', 'Season', 'Total');
				onDrawSeasonChart(durationArrayList, 'durationChartId', 'Duration', 'Total');
				onDrawSeasonChart(minPriceArrayList, 'minPriceChartId', 'Minimum Prices (RM)', 'Total');
				onDrawSeasonChart(maxPriceArrayList, 'maxPriceChartId', 'Maximum Prices (RM)', 'Total');
		    });
		}
		
		function onDrawSeasonChart(dataArray, chartId, hAxisText, vAxisText) {
			google.charts.load('current', { 'packages': ['bar'] });
			google.charts.setOnLoadCallback(drawStuff);
			
			function drawStuff() {
				let data = new google.visualization.arrayToDataTable(dataArray);

		        let options = {
		          	height: 280,
		          	hAxis: {title: hAxisText},
		          	vAxis: {title: vAxisText},
					legend: {position: 'none'}
		        };
			
				let chart = new google.charts.Bar(document.getElementById(chartId));
				chart.draw(data, google.charts.Bar.convertOptions(options));
			};
		}
	</script>
</body>
<%@ include file="content/footer.jspf" %>