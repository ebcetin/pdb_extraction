mol load psf dhf-f153s.psf
animate read dcd dhf-f153s-s100-210ns.dcd waitfor all

set nf [molinfo 0 get numframes]

pbc wrap -centersel "protein" -center com -compound fragment -all

for {set l 1} {$l < $nf} {incr l} {
	
			set sel1 [atomselect 0 all frame $l]
			set sel2 [atomselect 0 all frame $l+1]
			set transformation_matrix [measure fit $sel1 $sel2]
			set move_sel [atomselect 0 "all"]
			$move_sel move $transformation_matrix
	
		}
		
for {set i 1} {$i<$nf} {set i [expr {$i + 10}]} {
		set a [atomselect top all frame $i]
		$a writepdb dhf-f153s-$i.pdb
		}