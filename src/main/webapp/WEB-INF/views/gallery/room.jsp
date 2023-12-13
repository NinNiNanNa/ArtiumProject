<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<!DOCTYPE html>
<html lang="en" class="no-js">
	<head>
		<meta charset="UTF-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
		<meta name="viewport" content="width=device-width, initial-scale=1.0"> 
		<title>ONLINE GALLERY</title>
		<meta name="description" content="Add a description" />
		<meta name="keywords" content="Add keywords" />
		<meta name="author" content="Codrops" />
		<link rel="shortcut icon" href="../favicon.ico"> 
		<link rel="stylesheet" type="text/css" href="../css/default.css" />
		<link rel="stylesheet" type="text/css" href="../css/component.css" />
		<script src="../js/modernizr.custom.js"></script>
	</head>
	<body>
		<div class="container">	
			<!-- Codrops top bar -->
			<div class="codrops-top clearfix">
				<a href="#"><strong>Welcome to the online gallery :D</strong></a>
			</div><!--/ Codrops top bar -->


			<div id="gr-gallery" class="gr-gallery">
				<div class="gr-main">
					<figure>
						<div>
							<img src="./uploads/${galleryDTO.art_image1 }" alt="img01" />
						</div>
						<figcaption>
							<h2><span>${galleryDTO.art_title1 }</span></h2>
							<div>
							<span style="margin-right:10px">${galleryDTO.art_date1 }</span>
							<span>${galleryDTO.user_name }</span>
							<p>${galleryDTO.art_content1 }</p>
							</div>
						</figcaption>
					</figure>
					<figure>
						<div>
							<img src="./uploads/${galleryDTO.art_image2 }" alt="img01" />
						</div>
						<figcaption>
							<h2><span>${galleryDTO.art_title2 }</span></h2>
							<div>
							<span style="margin-right:10px">${galleryDTO.art_date2 }</span>
							<span>${galleryDTO.user_name }</span>
							<p>${galleryDTO.art_content2 }</p>
							</div>
						</figcaption>
					</figure>
					<figure>
						<div>
							<img src="./uploads/${galleryDTO.art_image3 }" alt="img01" />
						</div>
						<figcaption>
							<h2><span>${galleryDTO.art_title3 }</span></h2>
							<div>
							<span style="margin-right:10px">${galleryDTO.art_date3 }</span>
							<span>${galleryDTO.user_name }</span>
							<p>${galleryDTO.art_content3 }</p>
							</div>
						</figcaption>
					</figure>
					<figure>
						<div>
							<img src="./uploads/${galleryDTO.art_image4 }" alt="img01" />
						</div>
						<figcaption>
							<h2><span>${galleryDTO.art_title4 }</span></h2>
							<div>
							<span style="margin-right:10px">${galleryDTO.art_date5 }</span>
							<span>${galleryDTO.user_name }</span>
							<p>${galleryDTO.art_content5 }</p>
							</div>
						</figcaption>
					</figure>
					<figure>
						<div>
							<img src="./uploads/${galleryDTO.art_image5 }" alt="img01" />
						</div>
						<figcaption>
							<h2><span>${galleryDTO.art_title5 }</span></h2>
							<div>
							<span style="margin-right:10px">${galleryDTO.art_date5 }</span>
							<span>${galleryDTO.user_name }</span>
							<p>${galleryDTO.art_content5 }</p>
							</div>
						</figcaption>
					</figure>
				</div>
			</div>
		</div><!-- /container -->


		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
		<script src="../js/wallgallery.js"></script>
		<script>
			$(function() {
				Gallery.init( {
					layout : [3,2]
				} );
			});
		</script>
	</body>
</html>
    