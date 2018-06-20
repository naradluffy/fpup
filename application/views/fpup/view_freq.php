<!-- Menu Horizontal -->
				<ul class="menu">
					<li><a href="<?php echo base_url(); ?>">Daftar Item</a></li>
					<li><a href="<?php echo base_url().'index.php/build'; ?>">Pembuatan Item Set</a></li>
					<li class="current"><a href="<?php echo base_url().'index.php/viewresult'; ?>">Hasil Rekomendasi</a></li>
				</ul>
			</div>
			  
			<div class="col_12" id="bg" >
			  <div id="message">
					<?php 
					if ($count !== NULL){ if ($count == 0){ ?>
					<div id="url1" class="notice error"><i class="icon-remove-sign icon-large"></i> 
					<?php echo form_error('mincon'); ?>

					<a href="#close" class="icon-remove"></a></div>
					<?php } } ?>
					
				</div>
								 
			  	<?php echo form_open('viewresult/index'); ?>
		  
					  <label for="text5">Minimum Confidence <span>1-100%</span></label><br>
					  <input id="mincon" type="text" name="mincon" /><br><br>
					
					  <input type="submit" value="Build"/>
				<?php echo form_close(); ?>
		<hr />
		<?php 
		
		if ($count == 1){
			
			//echo "<a href=".base_url().'index.php/viewresult/freq/'.$mincon.">Click Here for json file</a> <hr />";
			
			echo "Ketika pelanggan membeli:</br>";
			$no = 1;
			echo "<ul>";
			
			foreach ($items as $item){
				
				$query = $this->db->query("select distinct a.frequent, a.no_itemset, 
							a.id_menu, b.frequent  as support, (a.frequent/b.frequent) as confidence 
							from itemset_detail a, header b where a.id_menu = b.id_menu 
							and (a.frequent/b.frequent)>=".$mincon." and a.id_menu = ".$item["id_menu"]." 
							order by a.frequent desc");
				$row = $query->result_array();
				
				$query2 = $this->db->query("select count(x.no_itemset) as cou 
							from (select distinct a.no_itemset from itemset_detail a, 
							header b where a.id_menu = b.id_menu 
							and (a.frequent/b.frequent)>".$mincon." 
							and a.id_menu =  ".$item["id_menu"].") x");
				
				$row2 = $query2->row();
				
				$i = 1;
				echo "<li><b>", $item["nama_menu"], "</b><br> pelanggan juga membeli: ";
					echo "<ul>";
					
					foreach($row as $isi){
						$query3 = $this->db->query("select distinct a.item, b.nama_menu 
								from itemset_detail a, menu b, header c 
								where a.id_menu = ".$item["id_menu"]." 
								and a.no_itemset = ".$isi["no_itemset"]." 
								and a.item = b.id_menu and a.item = c.id_menu 
								order by c.frequent desc");
						$row3 = $query3->result_array();
						
						$query4 = $this->db->query("select count(a.item) as cou from itemset_detail a 
								where a.id_menu = ".$item["id_menu"]." 
								and a.no_itemset = ".$isi["no_itemset"]."");
						$row4 = $query4->row();
						
						echo "<li>";
						foreach($row3 as $isi2) {
							echo $isi2["nama_menu"], ", ";
						}
						echo "</li>";
					}
					
					$no = $no + 1;
					echo "</ul>";
				
			}
			echo "</ul>";	
		}
	?>
	</div>