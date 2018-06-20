<!DOCTYPE html>

<html>
	<head>
		<!-- META -->
		<title>FUFP Tree Application</title>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
		<meta name="description" content="" />
		
		<!-- CSS -->
		<link rel="stylesheet" type="text/css" href="<?php echo base_url('assets/css/kickstart.css'); ?>" media="all" />
		<link rel="stylesheet" type="text/css" href="<?php echo base_url('assets/css/style.css'); ?>" media="all" /> 
		<style>
			#bg {
				padding: 20px;
				background-color:white;
				border: 1px solid #B5BBBD;
			}
			section {
			  position: relative;
			  border: 1px solid #000;
			  padding-top: 37px;
			  background: #500;
			  width:420px;
			}
			section.positioned {
			  position: absolute;
			  top:100px;
			  left:100px;
			  width:500px;
			  box-shadow: 0 0 15px #333;
			}
			.container {
				background: #FFFFFF;
			  overflow-y: auto;
			  height: 200px;
			}
			table {
			  border-spacing: 0;
			  width:100%;
			}
			td + td {
			  border-left:1px solid #eee;
			}
			td, th {
			  border-bottom:1px solid #eee;
			  background: #ddd;
			  color: #000;
			  padding: 10px 25px;
			}
			th {
			  height: 0;
			  line-height: 0;
			  padding-top: 0;
			  padding-bottom: 0;
			  color: transparent;
			  border: none;
			  white-space: nowrap;
			}
			th div{
			  position: absolute;
			  background: transparent;
			  color: #fff;
			  padding: 9px 25px;
			  top: 0;
			  margin-left: -25px;
			  line-height: normal;
			  border-left: 1px solid #800;
			}
			th:first-child div{
			  border: none;
			}
			
			#table1, #table2, #table3{
				display: none;
			}
		</style>
		
		<!-- Javascript -->
		<script type="text/javascript" src="<?php echo base_url('assets/js/jquery.min.js'); ?>"></script>
		<script type="text/javascript" src="<?php echo base_url('assets/js/kickstart.js'); ?>"></script>
	</head>
	<body>
		<div class="grid">
			<div class="col_12" style="margin-top:20px">
				<div id="logo">
					<a href = "#"><img class="logo" src="<?php echo base_url('assets/css/img/copy-copy-logo.png'); ?>" alt="Ngopi Doeloe" height="150" width="150"></a>
					<h5>Aplikasi FPUP Tree</h5>
					<h6>Ketahui item-item favorit yang dibeli pelanggan secara mudah!</h6>
				</div>
			</div>
	
			<!-- Tabs Left -->
			<div class="col_12">
