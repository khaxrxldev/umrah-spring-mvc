<%@ include file="content/header.jspf" %>
<body>
	<%@ include file="content/script.jspf" %>
	<%@ include file="content/sidebar_header.jspf" %>
	<div class="row g-0">
	    <div class="col-lg-5 col-12 p-5">
	        <span class="fs-4 fw-bold">AGENCY</span>
            <div id="submit_msg" class="d-none ui message"></div>
	        <form id="agencyFormId" onsubmit="onSubmitAgency()">
		        <div class="mt-3">
		            Name
		            <input type="text" class="d-none" id="agencyId" name="agencyId">
		            <input type="text" class="d-none" id="adminId" name="adminId">
	                <input type="text" class="form-control mt-1 text-uppercase" id="agencyName" name="agencyName" required="required" oninput="this.value = this.value.toUpperCase()">
		        </div>
		        <div class="mt-3">
		            License number
	                <input type="text" class="form-control mt-1" id="agencyLicenseNumber" name="agencyLicenseNumber" required="required">
		        </div>
		        <div class="mt-3">
		            Email address
	                <input type="email" class="form-control mt-1" id="agencyEmail" name="agencyEmail" required="required">
		        </div>
		        <div class="mt-3">
		            Phone number
	                <input type="text" class="form-control mt-1" id="agencyPhoneNum" name="agencyPhoneNum" required="required">
		        </div>
		        <div class="mt-3">
		            Website
	                <input type="text" class="form-control mt-1" id="agencyWebsite" name="agencyWebsite" required="required">
		        </div>
		        <div class="mt-3">
		            Address
              		<textarea style="resize: none;" class="form-control mt-1 text-uppercase" rows="5" id="agencyAddress" name="agencyAddress" oninput="this.value = this.value.toUpperCase()"></textarea>
		        </div>
		        <div class="mt-3" style="text-align: right;">
		            <button type="button" class="small ui right labeled icon button red" data-bs-toggle="modal" data-bs-target="#deleteModal">
			            <i class="ban icon"></i>
			            Delete
		            </button>
		            <button type="button" class="small ui right labeled icon button yellow" onclick="onGetAgency()">
			            <i class="refresh icon"></i>
			            Reset
		            </button>
		            <button type="submit" class="small ui right labeled icon button green">
			            <i class="check icon"></i>
			            Submit
		            </button>
		        </div>
			</form>
	    </div>
	    <div class="col-lg-7 col-12"></div>
	</div>
	<%@ include file="content/sidebar_footer.jspf" %>
	<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-body">Confirm to delete agency?</div>
	            <div class="modal-footer">
	                <button class="small ui negative right labeled icon button" data-bs-dismiss="modal">Cancel <i class="close icon"></i></button>
	                <button class="small ui positive right labeled icon button" onclick="onDeleteAgency()">Confirm <i class="checkmark icon"></i></button>
	            </div>
	        </div>
	    </div>
	</div>
	<script type="text/javascript">
		function onWindowLoad() {
			onGetAgency();
		}
		
		function onGetAgency() {
			$.ajax({
				type: "GET",
		        url: "/agency/admin/" + sessionStorage.getItem("login_id")
		    }).then(function(data) {
			    setForm("agencyFormId", data);
				$("#agencyFormId #adminId").val(sessionStorage.getItem("login_id"));
		    });
		}
		
		function onSubmitAgency() {
			event.preventDefault();
			
			let form = form2js(agencyFormId, null, false);
			let json = JSON.stringify(form);
			
			let formData = new FormData();
			formData.append("agencyRequest", new Blob([json], { type : "application/json" }));
			
			$.ajax({
				type: $("#agencyId").val() ? "PUT" : "POST",
		        url: "/agency",
		        processData: false,
		        contentType: false,
		        cache: false,
		        data: formData
		    }).then(function(data) {
				if (data) {
					onGetAgency();
		        	$("#submit_msg").removeClass("d-none");
		        	$("#submit_msg").addClass("green");
		        	$("#submit_msg").html("Successfully submit.");
				}
		    });
		}
		
		function onDeleteAgency() {
			$('#deleteModal').modal('hide');
			
			$.ajax({
				type: "DELETE",
		        url: "/agency/" + $('#agencyId').val()
		    }).then(function(data) {
				onGetAgency();
		    	if (data) {
		        	$("#submit_msg").removeClass("d-none");
		        	$("#submit_msg").addClass("green");
		        	$("#submit_msg").html("Successfully delete.");
		    	} else {
		        	$("#submit_msg").removeClass("d-none");
		        	$("#submit_msg").addClass("red");
		        	$("#submit_msg").html("Failed to delete.");
		    	}
		    });
		}
	</script>
</body>
<%@ include file="content/footer.jspf" %>