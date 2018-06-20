<!-- Menu Horizontal -->
			<ul class="menu">
					<li><a href="<?php echo base_url(); ?>">Daftar Item</a></li>
					<li><a href="<?php echo base_url().'index.php/build'; ?>">Pembuatan Item Set</a></li>
					<li class="current"><a href="<?php echo base_url().'index.php/viewresult'; ?>">Hasil Rekomendasi</a></li>
			</ul>
			</div>
			<div class="col_12" id="bg">
				<div id="message">
					<?php if ($count !== NULL){ if ($count == 0){ ?>
					<div id="url1" class="notice error"><i class="icon-remove-sign icon-large"></i> <?php echo $message;?>
					<a href="#close" class="icon-remove"></a></div>
					<?php } else { ?>
					<div id="url2" class="notice success"><i class="icon-ok icon-large"></i> 
					<a href="#close" class="icon-remove"></a> <?php echo $message; ?> </div>
					<?php } } ?>
				
				</div>
				
				  <form method="post" action="<?php echo base_url(). 'index.php/import/importcsv'; ?>" enctype="multipart/form-data">
					  Pilih file:
						  <input name="userfile" type="file"/>
						  <div style="margin-top:10px">
						  <input type="submit" class="btn" name="Submit" value="Submit" id="submit" />
							<hr class="alt1" />
							
						  </div>
					</form>
				
			</div>