<%@ include file="content/header.jspf" %>
<body class="pt-5 bg-light">
	<%@ include file="content/script.jspf" %>
	<div class="row g-0">
	    <div class="col-lg-4 col-12"></div>
	    <div class="col-lg-4 col-12">
	        <div class="ui top attached tabular menu">
	            <a class="item w-50 active" data-tab="signin">Sign In</a>
	            <a class="item w-50" data-tab="signup">Sign Up</a>
	        </div>
	        <div class="ui bottom attached tab segment p-4 active" data-tab="signin">
	            <div id="signin_msg" class="d-none ui mx-5 message"></div>
	            <form id="adminLoginForm" onsubmit="onLogin(event, '/admin/login', 'adminLoginForm')">
	            	<div class="mt-3 px-5">
		                Email address
		                <input type="email" class="form-control mt-1" name="loginUsername" id="loginUsername" required="required">
		            </div>
		            <div class="mt-3 px-5">
		                Password
		                <input type="password" class="form-control mt-1" name="loginPassword" id="loginPassword" required="required">
		            </div>
		            <div class="mt-3 px-5">
		                <button type="submit" class="small ui right labeled icon button teal">
			                <i class="right arrow icon"></i>
			                Login
		                </button>
		            </div>
	            </form>
	        </div>
	        <div class="ui bottom attached tab segment p-4" data-tab="signup">
	            <div id="signup_msg" class="d-none ui mx-5 message"></div>
	            <form id="formId" onsubmit="onSubmitAdmin()">
		            <div class="mt-3 px-5">
		                Email address
		                <input type="email" class="form-control mt-1" id="adminEmail" name="adminEmail" required="required">
		            </div>
		            <div class="mt-3 px-5">
		                Password
		                <input type="password" class="form-control mt-1" id="adminPassword" name="adminPassword" required="required">
		            </div>
		            <div class="mt-3 px-5">
		                Agency name
		                <input type="text" class="form-control mt-1" id="agencyName" name="agencyName" required="required">
		            </div>
		            <div class="mt-3 px-5">
		                Agency license number
		                <input type="text" class="form-control mt-1" id="agencyLicenseNumber" name="agencyLicenseNumber" required="required">
		            </div>
		            <div class="mt-3 px-5">
		                <button type="submit" class="small ui right labeled icon button teal">
			                <i class="right arrow icon"></i>
			                Register
		                </button>
		            </div>
		    	</form>
	        </div>
	    </div>
	    <div class="col-lg-4 col-12"></div>
	</div>
	<script type="text/javascript">
    	$('.menu .item').tab();
		function onWindowLoad() {}
		
		function onLogin(event, loginURL, loginFormId) {
		    event.preventDefault();

		    let loginForm = form2js(loginFormId, null, false);
		    let loginJSON = JSON.stringify(loginForm);

		    let formData = new FormData();
		    formData.append("loginRequest", new Blob([loginJSON], {
		        type: "application/json"
		    }));

		    $.ajax({
		        type: "POST",
		        url: loginURL,
		        processData: false,
		        contentType: false,
		        cache: false,
		        data: formData
		    }).then(function(data) {
		        if (data.loginStatus) {
		            sessionStorage.setItem("login_id", data.loginId);
		            sessionStorage.setItem("login_type", data.loginType);
					switch(data.loginType) {
						case "ADMIN":
				            window.location.href = '/admin/page';
						  break;
						case "SUPERADMIN":
				            window.location.href = '/admins/page';
						  break;
					}
		        } else {
		        	$("#signin_msg").removeClass("d-none");
		        	$("#signin_msg").addClass("red");
		        	$("#signin_msg").html(data.loginError);
		        }
		    });
		}
		
		function onSubmitAdmin() {
		    event.preventDefault();

		    let adminObject = {};
		    adminObject['adminEmail'] = $('#adminEmail').val();
		    adminObject['adminPassword'] = $('#adminPassword').val();
		    
		    let json = JSON.stringify(adminObject);
		    let formData = new FormData();
		    formData.append("adminRequest", new Blob([json], {
		        type: "application/json"
		    }));

		    $.ajax({
		        type: "POST",
		        url: "/admin",
		        processData: false,
		        contentType: false,
		        cache: false,
		        data: formData
		    }).then(function(data) {
		        if (data) {
					onSubmitAgency(data.adminId);
		        }
		    });
		}
		
		function onSubmitAgency(adminId) {
		    let agencyObject = {};
		    agencyObject['agencyName'] = $('#agencyName').val();
		    agencyObject['agencyLicenseNumber'] = $('#agencyLicenseNumber').val();
		    agencyObject['adminId'] = adminId;
		    
		    let json = JSON.stringify(agencyObject);
		    let formData = new FormData();
		    formData.append("agencyRequest", new Blob([json], {
		        type: "application/json"
		    }));

		    $.ajax({
		        type: "POST",
		        url: "/agency",
		        processData: false,
		        contentType: false,
		        cache: false,
		        data: formData
		    }).then(function(data) {
		        if (data) {
		            resetForm('formId');
		        	$("#signup_msg").removeClass("d-none");
		        	$("#signup_msg").addClass("green");
		        	$("#signup_msg").html("Successfully register.");
		        }
		    });
		}
	</script>
</body>
<%@ include file="content/footer.jspf" %>