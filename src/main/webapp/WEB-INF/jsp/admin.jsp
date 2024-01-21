<%@ include file="content/header.jspf" %>
<body>
	<%@ include file="content/script.jspf" %>
	<%@ include file="content/sidebar_header.jspf" %>
	<div class="row g-0">
	    <div class="col-lg-5 col-12 p-5">
	        <span class="fs-4 fw-bold">PROFILE</span>
            <div id="update_msg" class="d-none ui message"></div>
	        <form id="adminFormId" onsubmit="onUpdateAdmin()">
		        <div class="mt-3">
		            Full name
		            <input type="text" class="d-none" id="adminId" name="adminId">
	                <input type="text" class="form-control mt-1 text-uppercase" id="adminName" name="adminName" required="required" oninput="this.value = this.value.toUpperCase()">
		        </div>
		        <div class="mt-3">
		            Gender
		            <select class="form-select" id="adminGender" name="adminGender" required="required">
	                    <option selected hidden disabled>Choose Gender</option>
						<option value="MALE">MALE</option>
						<option value="FEMALE">FEMALE</option>
	                </select>
		        </div>
		        <div class="mt-3">
		            Email address
	                <input type="email" class="form-control mt-1" id="adminEmail" name="adminEmail" required="required">
		        </div>
		        <div class="mt-3">
		            Password
	                <input type="password" class="form-control mt-1" id="adminPassword" name="adminPassword" required="required">
		        </div>
		        <div class="mt-3" style="text-align: right;">
		            <button type="button" class="small ui right labeled icon button red" data-bs-toggle="modal" data-bs-target="#deleteModal">
			            <i class="ban icon"></i>
			            Delete
		            </button>
		            <button type="button" class="small ui right labeled icon button yellow" onclick="onGetAdmin()">
			            <i class="refresh icon"></i>
			            Reset
		            </button>
		            <button type="submit" class="small ui right labeled icon button green">
			            <i class="check icon"></i>
			            Update
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
	            <div class="modal-body">Confirm to delete account?</div>
	            <div class="modal-footer">
	                <button class="small ui negative right labeled icon button" data-bs-dismiss="modal">Cancel <i class="close icon"></i></button>
	                <button class="small ui positive right labeled icon button" onclick="onDeleteAdmin()">Confirm <i class="checkmark icon"></i></button>
	            </div>
	        </div>
	    </div>
	</div>
	<script type="text/javascript">
		function onWindowLoad() {
			onGetAdmin();
		}
		
		function onGetAdmin() {
			$.ajax({
				type: "GET",
		        url: "/admin/" + sessionStorage.getItem("login_id")
		    }).then(function(data) {
			    setForm("adminFormId", data);
		    });
		}
		
		function onUpdateAdmin() {
			event.preventDefault();

			let form = form2js(adminFormId, null, false);
			let json = JSON.stringify(form);

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
					onGetAdmin();
		        	$("#update_msg").removeClass("d-none");
		        	$("#update_msg").addClass("green");
		        	$("#update_msg").html("Successfully update.");
				}
			});
		}
		
		function onDeleteAdmin() {
			$.ajax({
				type: "DELETE",
		        url: "/admin/" + sessionStorage.getItem("login_id")
		    }).then(function(data) {
		    	if (data) {
					window.location.href = "/";
		    	}
		    });
		}
	</script>
</body>
<%@ include file="content/footer.jspf" %>