<?php
/* Set e-mail recipient */
$myemail = "peter@peteraldhous.com";
$subject = "Answers to quiz";

/* Check all form inputs using check_input function */
$name = check_input($_POST['inputName'], "Your Name");
$email = check_input($_POST['inputEmail'], "Your E-mail Address");
$q1 = check_input($_POST['inputQ1'], "Q1: Answer here");
$q2 = check_input($_POST['inputQ2'], "Q2: Answer here");
$q3 = check_input($_POST['inputQ3'], "Q3: Answer here");
$q4 = check_input($_POST['inputQ4'], "Q4: Answer here");
$q5 = check_input($_POST['inputQ5'], "Q5: Answer here");
$q6 = check_input($_POST['inputQ6'], "Q6: Answer here");
$q7 = check_input($_POST['inputQ7'], "Q7: Answer here");
$q8 = check_input($_POST['inputQ8'], "Q8: Answer here");
$q9 = check_input($_POST['inputQ9'], "Q9: Answer here");
$q10 = check_input($_POST['inputQ10'], "Q10: Answer here");

/* Concatenate inputs into single variable */
$answers = "A1:	".$q1. "\r\n\r\n" . "A2:	".$q2. "\r\n\r\n" . "A3:	".$q3. "\r\n\r\n" . "A4:	".$q4. "\r\n\r\n" . "A5:	".$q5. "\r\n\r\n" . "A6:	".$q6. "\r\n\r\n" . "A7:	".$q7. "\r\n\r\n" . "A8:	".$q8. "\r\n\r\n" . "A9:	".$q9. "\r\n\r\n" . "A10:	".$q10. "\r\n\r\n"; 

/* If e-mail is not valid show error message */
if (!preg_match("/([\w\-]+\@[\w\-]+\.[\w\-]+)/", $email))
{
show_error("Invalid e-mail address");
}

/* Prepare the message */

$message = "

Submission from class website:

Name: $name
Email: $email
Subject: $subject

Message:
$answers

" ;

/* Send the message using mail() function */
mail($myemail, $subject, $message);
mail($email, $subject, $message);

/* Redirect user to confirmation page */
header("Location: ../confirm.html");
exit();

/* Functions used */
function check_input($data, $problem="")
{
$data = trim($data);
$data = stripslashes($data);
$data = htmlspecialchars($data);
if ($problem && strlen($data) == 0)
{
show_error($problem);
}
return $data;
}

function show_error($myError)
{
?>
<html>
<!DOCTYPE html>

<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <title>Answers submitted</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="../../../css/bootstrap.min.css" rel="stylesheet"> 
  <link href="../../../css/custom.css" rel="stylesheet">
</head>

<body class="markdown clearness">

	<header class="navbar-inverse navbar-fixed-top">
		<div class="container">
			<nav role="navigation">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<a href="../index.html" class="navbar-brand">Intro Data Viz</a>
				</div> <!-- /.navbar-header -->
				<!-- Collect the nav links, forms, and other content for toggling -->
				<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav">
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">Students <b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a href="../name1.html">Mark Boyer</a></li>
								<li><a href="../name2.html">Jennifer Chaussee</a></li>
								<li><a href="../name4.html">Andy Mannix</a></li>
								<li><a href="../name5.html">Juan Martinez</a></li>
								<li><a href="../name6.html">Jake Nicol</a></li>
								<li><a href="../name7.html">Jason Paladino</a></li>
								<li><a href="../name8.html">Joaquin Palomino</a></li>
								<li><a href="../name9.html">Christopher Schodt</a></li>
								<li><a href="../name11.html">Xavier Malina</a></li>
								<li><a href="../name12.html">Shubham Goel</a></li>
							</ul>
						</li>
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">Class notes<b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a href="../week1.html">What is data?</a></li>
								<li><a href="../week2.html">Data visualization: basic principles</a></li>
								<li><a href="../week3.html">Interviewing data: exploratory graphical analysis</a></li>
								<li><a href="../week4.html">Interviewing data: using databases</a></li>
								<li><a href="../week5.html">Acquiring, cleaning and formatting data</a></li>
								<li><a href="../week6.html">Making static graphics</a></li>
								<li><a href="../week7.html">Polishing static graphics</a></li>
								<li><a href="../week8.html">Principles of mapping</a></li>
								<li><a href="../week9.html">Making static maps and processing geodata</a></li>
								<li><a href="../week11.html">Making interactive maps</a></li>
								<li><a href="../week12.html">Visualizing networks</a></li>
								<li><a href="../week13.html">Coding interactive graphics</a></li>									
							</ul>
						</li>
						<li>
						<li><a href="../software.html">Software</a></li>
						<li><a href="../datasets.html">Data</a></li>
						<li><a href="mailto:peter@peteraldhous.com">Email instructor</a></li>					
					</ul>
				</div><!-- /.navbar-collapse -->
			</nav>
		</div> <!-- /.navbar-header -->
	</header>

	<div class="container all">

		<div class="alert alert-danger">
			<a href="#" class="close" data-dismiss="alert">&times;</a>
			<p>Please correct the following error:</p>
			<p><strong><?php echo $myError; ?></strong></p>
			<p>Hit the back button and try again.</p>
		</div>

	</div> <!-- /.container all -->
	<script src="http://code.jquery.com/jquery.min.js"></script>
	<script src="../../../js/bootstrap.min.js"></script>
</body>
</html>

<?php
exit();
}
?>