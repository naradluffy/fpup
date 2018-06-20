<!-- Menu Horizontal -->
				<ul class="menu">
					<li class="current"><a href="<?php echo base_url(); ?>">Daftar Item</a></li>
					<li><a href="<?php echo base_url().'index.php/build'; ?>">Pembuatan Item Set</a></li>
					<li><a href="<?php echo base_url().'index.php/viewresult'; ?>">Hasil Rekomendasi</a></li>
				</ul>
			</div>
			<div class="col_12" id="bg">
				<div id="message">
					<?php if ($count !== NULL){ if ($count == 0){ ?>
					<div id="url1" class="notice error"><i class="icon-remove-sign icon-large"></i> Tidak ada menu yang ditambahkan.
					<a href="#close" class="icon-remove"></a></div>
					<?php } else { ?>
					<div id="url2" class="notice success"><i class="icon-ok icon-large"></i> 
					<a href="#close" class="icon-remove"></a> <?php echo $count.' item sudah berhasil ditambahkan.'; ?> </div>
					<?php } } ?>
				
				</div>
				
				<?php echo form_open('menu/refresh'); ?>

					  <div style="margin-top:10px">
						<input type="submit" class="btn" name="Submit" value="Refresh" id="submit" />
						<hr class="alt1" />
						
					  </div>
				
				<?php echo form_close(); ?>
				<section class="">
				  <div class="container">
					<table>
					  <thead>
						<tr class="header" style>
						  <th>
							No
							<div>No</div>
						  </th>
						  <th>
							NamaMenu
							<div>NamaMenu</div>
						  </th>
						</tr>
					  </thead>
					  <tbody>
					  <?php $i = 1;
						foreach ($menu as $menu_item): ?>
							<tr>
							<td><?php echo $i?></td>
							<td><?php echo $menu_item['nama_menu']; ?></td>
							</tr>							
					<?php $i=$i+1;
						endforeach; ?>
						</tbody>
					</table>
				  </div>
				</section>
			</div>