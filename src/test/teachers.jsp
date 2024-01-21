<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Document</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/form2js@1.0.0/src/form2js.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			onGetTeachers();
		});
		
		function onGetTeachers() {
			$('#teacherTable tbody').empty();
			
			$.ajax({
				type: "GET",
		        url: "/user/teachers"
		    }).then(function(dataList) {
		    	for(let data of dataList) {
		    		$('#teacherTable > tbody:last').append($('<tr>')
						.append($('<td>').append(data.teacherEmail))
						.append($('<td>').append(data.teacherPhoneNo))
						.append($('<td>').append(data.teacherName))
						.append($('<td>').append(data.teacherAddress))
						.append($('<td>').append('<a href="/user/teacher/update/'+data.teacherId+'">Edit</a>'))
						.append($('<td>').append('<button onclick="onDeleteTeacher(\''+data.teacherId+'\')">Delete</button>'))
					);
				}
		    });
		}
	</script>
	<style type="text/css">
		table {
			border-collapse: collapse;
			width: 100%;
		}
		th, td {
			padding: 8px;
			text-align: left;
			border: 1px solid #DDD;
		}
	</style>
</head>
<body>
	<a href="/user/teacher/view">TEACHER</a>
	<a href="/user/student/view">STUDENT</a>
	<a href="/user/evaluator/view">EVALUATOR</a>
	<form id="teacherForm" method="post">
		<div>
			<span>teacherEmail</span>
			<input type="text" name="teacherEmail" value=""/>
		</div>
		<div>
			<span>teacherPhoneNo</span>
			<input type="text" name="teacherPhoneNo" value=""/>
		</div>
		<div>
			<span>teacherName</span>
			<input type="text" name="teacherName" value=""/>
		</div>
		<div>
			<span>teacherAddress</span>
			<input type="text" name="teacherAddress" value=""/>
		</div>
		<div>
			<span>teacherPassword</span>
			<input type="text" name="teacherPassword" value=""/>
		</div>
		<button type="button" id="submit_btn">submit</button>
	</form>
	<table id="teacherTable">
		<thead>
			<tr>
				<th>Email</th>
				<th>Phone</th>
				<th>Name</th>
				<th>Address</th>
				<th>UPDATE</th>
				<th>DELETE</th>
		 	</tr>
		</thead>
		<tbody></tbody>
	 </table>
	<script type="text/javascript">
		$('#submit_btn').click(function(event){
			event.preventDefault();
			
			let teacherForm = form2js("teacherForm", null, false);
			let teacherJSON = JSON.stringify(teacherForm);
			
			let formData = new FormData();
			formData.append("teacherRequest", new Blob([teacherJSON], { type : "application/json" }));
			
			$.ajax({
				type: "POST",
		        url: "/user/teacher",
		        processData: false,
		        contentType: false,
		        cache: false,
		        data: formData
		    }).then(function(data) {
		    	onGetTeachers();
		    });
		});
		
		function onDeleteTeacher(teacherId) {
			$.ajax({
				type: "DELETE",
		        url: "/user/teacher/" + teacherId
		    }).then(function(data) {
		    	onGetTeachers();
		    });
		}
	</script>
</body>
</html>