<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">

<!-- Compiled and minified CSS -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">

<style>
body {
	background: rgb(255, 254, 254);
	background: linear-gradient(0deg, rgba(255, 254, 254, 1) 0%,
		rgba(0, 137, 245, 0.4990371148459384) 50%);
	margin: 0;
	background-repeat: no-repeat;
	background-attachment: fixed;
}

.wrapper {
	padding: 25px;
}

.events li {
	display: inline-block;
	padding: 5px;
}
</style>


<title>Impulse Entertainment DJs</title>
</head>

<body>
	<br>
	<br>
	
	<img src="../images/ImpuseEntertainmentLogo.png">
	

	<div class="wrapper">
		<div class="row">
			<div class="col s5">
				<div class="card">
					<div class="card-title center-align">Upload Your CSV</div>
					<div class="card-content">
						<form action="UploadServlet" method="post"
							enctype="multipart/form-data">
							<div class=row>
								<div class="file-field input-field">
									<div class="col s12">
										<div class="file-field input-field">
											<div class="btn">
												<span>File</span> <input type="file" id="fileUpload"
													name="csvFile" onchange="Upload()" required>
											</div>
											<div class="file-path-wrapper">
												<input class="file-path validate" type="text">
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="input-field col s12 ">
									<textarea id="textarea1" class="materialize-textarea" required></textarea>
									<label for="textarea1">Enter the Client's Name</label>
								</div>
							</div>
							


							<ul class="events">
								<li><p>Choose an Event Type:</p></li>
								<li><label> <input onclick="message(this)"
										value="wedding" type="radio" name="events" checked /> <span>Wedding</span>
								</label></li>
								<li><label> <input onclick="message(this)"
										value="corporate" type="radio" name="events" /> <span>Corporate
											Event</span>
								</label></li>
								<li><label> <input onclick="message(this)"
										value=community " type="radio" name="events" /> <span>Community
											Event</span>
								</label></li>
								<li><label> <input onclick="message(this)"
										value=school type="radio" name="events" /> <span>School
											Event</span>
								</label></li>
								<li><label> <input onclick="message(this)"
										value=private type="radio" name="events" /> <span>Private
											Event</span>
								</label></li>
							</ul>
							<div class=row>
								<div class="col s4"></div>
								<div class="col s5">
									<button class="btn waves-effect waves-light" type="submit"
										name="action">
										Submit <i class="material-icons right">send</i>
									</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
			<div class="col s2"></div>
			<div class="col s5">
				<div class="card">
					<div class="card-title center-align">Message Being Sent</div>
					<div class="card-content">
						<blockquote id="initialMessage">
							<p>Wedding Message Here.</p>

						</blockquote>
						<blockquote id="eventMessage"></blockquote>

					</div>
				</div>
			</div>

		</div>
	</div>



	<!-- Compiled and minified JavaScript -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

	<script type="text/javascript">
		function message(myRadio) {
			console.log(myRadio.value);

			switch (myRadio.value) {
			case "wedding":
				var message = "Wedding Message Here.";
				document.getElementById("eventMessage").innerHTML = message;
				document.getElementById("initialMessage").innerHTML = "";
				break;
			case "corporate":
				var message = "Corporate Event Message Here";
				document.getElementById("eventMessage").innerHTML = message;
				document.getElementById("initialMessage").innerHTML = "";

				break;
			case "community":
				var message = "Community Event Message Here";
				document.getElementById("eventMessage").innerHTML = message;
				document.getElementById("initialMessage").innerHTML = "";

				break;
			case "school":
				var message = "School Event Message Here";
				document.getElementById("eventMessage").innerHTML = message;
				document.getElementById("initialMessage").innerHTML = "";

				break;
			case "private":
				var message = "Private Party Message Here";
				document.getElementById("eventMessage").innerHTML = message;
				document.getElementById("initialMessage").innerHTML = "";

				break;
			}

		}

		function Upload() {
			var fileUpload = document.getElementById("fileUpload");
			var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.csv|.txt)$/;
			if (regex.test(fileUpload.value.toLowerCase())) {
				if (typeof (FileReader) != "undefined") {
					var reader = new FileReader();
					reader.onload = function(e) {
						var table = document.createElement("table");
						var rows = e.target.result.split("\n");

						for (var i = 0; i < rows.length; i++) {
							var row = table.insertRow(-1);
							console.log(row);
							var cells = rows[i].split(",");
							console.log(cells);
							for (var j = 0; j < cells.length; j++) {
								var cell = row.insertCell(-1);
								cell.innerHTML = cells[j];
							}
						}
						var dvCSV = document.getElementById("dvCSV");
						dvCSV.innerHTML = "";
						dvCSV.appendChild(table);
					}
					reader.readAsText(fileUpload.files[0]);
				} else {
					alert("This browser does not support HTML5.");
				}
			} else {
				alert("Please upload a valid CSV file.");
			}
		}
	</script>
</body>
</html>