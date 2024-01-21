<%@ include file="content/header.jspf" %>
<body>
	<div class="w-100 border border-0 border-bottom border-top bg-light d-inline-block">
	    <div style="margin-top: 8px !important;" class="float-start fs-4 fw-bold my-2 mx-5">UMRAH SYSTEM</div>
	    <div class="border-start float-end">
	        <button class="small ui button blue m-2" onclick="window.location.href='/admin/login/page'">Admin</button>
	    </div>
	</div>
	<div class="row g-0">
	    <div class="col-lg-2 col-12"></div>
	    <div class="col-lg-8 col-12 text-center">
	        <div class="border p-3 bg-light">
	            <div id="carousels" class="carousel slide" data-bs-ride="carousel">
	                <div class="carousel-indicators">
	                    <button type="button" data-bs-target="#carousels" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
	                    <button type="button" data-bs-target="#carousels" data-bs-slide-to="1" aria-label="Slide 2"></button>
	                    <button type="button" data-bs-target="#carousels" data-bs-slide-to="2" aria-label="Slide 3"></button>
	                </div>
	                <div class="carousel-inner">
	                    <div class="carousel-item active" data-bs-interval="5000">
	                        <img src="/image/Slide1.PNG" class="d-block w-100">
	                        <div class="carousel-caption d-none d-md-block">
	                            <h5>First slide label</h5>
	                            <p>Some representative placeholder content for the first slide.</p>
	                        </div>
	                    </div>
	                    <div class="carousel-item" data-bs-interval="5000">
	                        <img src="/image/Slide2.PNG" class="d-block w-100">
	                        <div class="carousel-caption d-none d-md-block">
	                            <h5>Second slide label</h5>
	                            <p>Some representative placeholder content for the second slide.</p>
	                        </div>
	                    </div>
	                    <div class="carousel-item" data-bs-interval="5000">
	                        <img src="/image/Slide3.PNG" class="d-block w-100">
	                        <div class="carousel-caption d-none d-md-block">
	                            <h5>Third slide label</h5>
	                            <p>Some representative placeholder content for the third slide.</p>
	                        </div>
	                    </div>
	                </div>
	                <button class="carousel-control-prev" type="button" data-bs-target="#carousels" data-bs-slide="prev">
		                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
		                <span class="visually-hidden">Previous</span>
	                </button>
	                <button class="carousel-control-next" type="button" data-bs-target="#carousels" data-bs-slide="next">
		                <span class="carousel-control-next-icon" aria-hidden="true"></span>
		                <span class="visually-hidden">Next</span>
	                </button>
	            </div>
	        </div>
	        <div class="border border-top-0 p-2 bg-light">
	            <button class="small ui right labeled icon button purple" onclick="window.location.href='/filter'">
		            <i class="search icon"></i>
		            Umrah Packages
	            </button>
	        </div>
	    </div>
	    <div class="col-lg-2 col-12"></div>
	</div>
	<script type="text/javascript">
		function onWindowLoad() {}
	</script>
</body>
<%@ include file="content/footer.jspf" %>