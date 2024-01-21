<%@ include file="content/header.jspf" %>
<body>
   	<div id="loading" class="loading d-none">
		<img id="loading-image" class="loading-image" src="/image/loader.png" alt="Loading..." />
	</div>
	<%@ include file="content/script.jspf" %>
	<%@ include file="content/sidebar_header.jspf" %>
	<div class="w-100">
        <div class="fs-4 fw-bold w-100 py-3 px-4 border border-0 border-bottom">ADMINISTRATIONS</div>
        <div class="w-100 p-2">
        	<div class="w-100 ui card">
		        <div class="fs-6 fw-bold p-2 header bg-light">ADMIN LIST</div>
			    <div class="content">
					<table id="tableId" class="table table-striped compact" style="width:100%">
						<thead>
							<tr>
								<th>Name</th>
								<th>Email</th>
								<th>Agency</th>
								<th>License number</th>
								<th>Status</th>
						 	</tr>
						</thead>
						<tbody></tbody>
					</table>
			    </div>
			</div>
		</div>
	</div>
	<%@ include file="content/sidebar_footer.jspf" %>
	<script type="text/javascript">
		function onWindowLoad() {
			onGetTableData();
		}
		
		function onGetTableData() {
			$.ajax({
				type: "GET",
		        url: "/admins"
		    }).then(function(dataList) {
		    	for(let data of dataList) {
		    		let option1 = $("<option>", { value: "PENDING", text: "PENDING" });
		    		let option2 = $("<option>", { value: "APPROVED", text: "APPROVED" });
		    		let select = $('<select>').addClass('form-select').append(option1).append(option2).change(function () {
		    		    $('#loading').removeClass('d-none');
		    			onUpdate(event, data.adminId);
					});
		    		
		    		if (data.adminStatus) {
		    			select.val(data.adminStatus);
		    		}
		    		
		    		let link = '';
		    		if (data.agency) {
		    			link = $('<a>').attr('href', data.agency.agencyWebsite).attr( 'target','_blank' ).html(data.agency.agencyName);
		    		}
		    		
		    		if (data.adminType === 'ADMIN') {
		    			$('#tableId > tbody:last').append($('<tr>')
							.append($('<td>').append(data.adminName))
							.append($('<td>').append(data.adminEmail))
							.append($('<td>').append(link))
							.append($('<td>').append(data.agency ? data.agency.agencyLicenseNumber : ''))
							.append($('<td>').append(select))
						);
		    		}
				}
		    	
				$('#tableId').dataTable(<%@ include file="content/datatable_options.jspf" %>);
		    });
		}
		
		function onUpdate(evt, adminIdText) {
			let admin = { adminId: adminIdText, adminStatus: evt.target.value };
			let json = JSON.stringify(admin);

			let formData = new FormData();
			formData.append("adminRequest", new Blob([json], {
				type: "application/json"
			}));

			$.ajax({
				type: "PUT",
				url: "/admin",
				processData: false,
				contentType: false,
				cache: false,
				data: formData
			}).then(function(data) {
				if (data) {
					$('#tableId').DataTable().clear().destroy();
					onGetTableData();
	    		    $('#loading').addClass('d-none');
				}
			});
		}
	</script>
</body>
<%@ include file="content/footer.jspf" %>