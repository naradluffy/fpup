<!-- Menu Horizontal -->
				<ul class="menu">
					<li><a href="<?php echo base_url(); ?>">Daftar Item</a></li>
					<li class="current"><a href="<?php echo base_url().'index.php/build'; ?>">Pembuatan Item Set</a></li>
					<li><a href="<?php echo base_url().'index.php/viewresult'; ?>">Hasil Rekomendasi</a></li>
				</ul>
			</div>
			  
			  <div class="col_12" id="bg" >
			  <div>
				<?php echo $tanggal; ?>
			  </div>
			  <div id="message">
					<?php if ($count !== NULL){ if ($count == 0){ ?>
					<div id="url1" class="notice error"><i class="icon-remove-sign icon-large"></i> 
					<?php echo $message; ?>
					<?php echo form_error('minsup'); ?>
					<?php echo form_error('date1'); ?>
					<?php echo form_error('date2'); ?>
					<a href="#close" class="icon-remove"></a></div>
					<?php } else { ?>
					<div id="url2" class="notice success"><i class="icon-ok icon-large"></i> 
					<a href="#close" class="icon-remove"></a> <?php echo 'Item Set sudah berhasil dibuat.'; ?> </div>
					<?php } } ?>
					
				</div>
								 
			  <div class="col_3">
				<?php echo form_open('build/index'); ?>
				 <label for="minsup">Minimum Support <span>1-10</span></label><br>
				  <input id="minsup" name="minsup" type="text"><br>
				  <br>
				  <label for="date1">Tanggal Mulai <span>YYYY-MM-DD</span></label><br>
				  <input id="date1" name="date1" type="text"><br>
				  <br>
				  <label for="date2">Tanggal Akhir <span>YYYY-MM-DD</span></label><br>
				  <input id="date2" name="date2" type="text"><br>
				  <br>
				  <input type="submit" value="Build">
				<?php echo form_close(); ?>
			  </div>
      
				  <hr class="alt1">
				</div>