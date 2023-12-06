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
							<img src="../img/1.jpg" alt="img01" />
						</div>
						<figcaption>
							<h2><span>소리 작품</span></h2>
							<div><p>New York City, 2009, by <a href="http://www.flickr.com/photos/thomasclaveirole">Thomas Claveirole</a></p></div>
						</figcaption>
					</figure>
					<figure>
						<div>
							<img src="../img/2.jpg" alt="img02" />
						</div>
						<figcaption>
							<h2><span>American Museum of Natural History #1</span></h2>
							<div><p>New York City, 2009, by <a href="http://www.flickr.com/photos/thomasclaveirole">Thomas Claveirole</a></p></div>
						</figcaption>
					</figure>
					<figure>
						<div>
							<img src="../img/3.jpg" alt="img03" />
						</div>
						<figcaption>
							<h2><span>NYC Marathon in Harlem #4</span></h2>
							<div><p>New York City, 2009, by <a href="http://www.flickr.com/photos/thomasclaveirole">Thomas Claveirole</a></p></div>
						</figcaption>
					</figure>
					<figure>
						<div>
							<img src="../img/4.jpg" alt="img04" />
						</div>
						<figcaption>
							<h2><span>Cathedral Church of Saint John the Divine #3</span></h2>
							<div><p>New York City, 2009, by <a href="http://www.flickr.com/photos/thomasclaveirole">Thomas Claveirole</a></p></div>
						</figcaption>
					</figure>
					<figure>
						<div>
							<img src="../img/5.jpg" alt="img01" />
						</div>
						<figcaption>
							<h2><span>SoHo</span></h2>
							<div><p>New York City, 2009, by <a href="http://www.flickr.com/photos/thomasclaveirole">Thomas Claveirole</a></p></div>
						</figcaption>
					</figure>
					<figure>
						<div>
							<img src="../img/imgBg.jpg" alt="img02" />
						</div>
						<figcaption>
							<h2><span>Manhattan Downtown/Wall St. Heliport</span></h2>
							<div><p>New York City, 2009, by <a href="http://www.flickr.com/photos/thomasclaveirole">Thomas Claveirole</a></p></div>
						</figcaption>
					</figure>
					<figure>
						<div>
							<img src="../img/imgBg.jpg" alt="img03" />
						</div>
						<figcaption>
							<h2><span>Musée National du Moyen Âge</span></h2>
							<div><p>Paris, 2009, by <a href="http://www.flickr.com/photos/thomasclaveirole">Thomas Claveirole</a></p></div>
						</figcaption>
					</figure>
					<figure>
						<div>
							<img src="../img/imgBg.jpg" alt="img08" />
						</div>
						<figcaption>
							<h2><span>Métro Jussieu</span></h2>
							<div><p>Paris, 2009, by <a href="http://www.flickr.com/photos/thomasclaveirole">Thomas Claveirole</a></p>
						</figcaption>
					</figure>
					<figure>
						<div>
							<img src="../img/imgBg.jpg" alt="img09" />
						</div>
						<figcaption>
							<h2><span>Rose Main Reading Room, New York Public Library</span></h2>
							<div><p>New York City, 2009, by <a href="http://www.flickr.com/photos/thomasclaveirole">Thomas Claveirole</a></p></div>
						</figcaption>
					</figure>
					<figure>
						<div>
							<img src="../img/imgBg.jpg" alt="img10" />
						</div>
						<figcaption>
							<h2><span>Midtown Manhattan</span></h2>
							<div><p>New York City, 2009, by <a href="http://www.flickr.com/photos/thomasclaveirole">Thomas Claveirole</a></p></div>
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
					layout : [3,2,3,2]
				} );

			});
		</script>
	</body>
</html>
    