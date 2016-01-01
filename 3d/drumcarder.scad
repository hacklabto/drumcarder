$fa = 1;
$fs = 1;

acrylic_thickness = 6.35;

side_height = 120;
side_cutaway = 40;
side_length = 300;
bottom_width = 150;
bottom_height_pct = 0.40;
bottom_rotation = -6;

guide_block_length = 30;
// TODO: calculate this
guide_block_height_tweak = -4;

li_drum_dia = 30;
li_drum_length_pct = 0.50;
li_drum_height_pct = 0.50;
li_drum_bump_pct = 1.75;

main_drum_dia = 70;
main_drum_length_pct = 0.75;
main_drum_height_pct = 0.60;
main_drum_bump_pct = 1.25;

axle_length_pct = 1.20;
axle_offset_pct = 1.25;
axle_dia = 10;

pulley_acrylic_thickness = 3;
pulley_gap = 5;

module pulley(t, r) {
    cylinder(h=t/3, r=r);
    translate([0, 0, t/3])
        cylinder(h=t/3, r=r*0.9);
    translate([0, 0, t/3*2])
        cylinder(h=t/3, r=r);
}

rotate([0, 0, $t * 365])
translate([0, -side_length/2, 0])
difference(r=1) {
	// positive things
	union() {
        left_side_pos = -bottom_width/2;
        right_side_pos = bottom_width/2;
        
        // plates
        color([0.8, 0.8, 0.8]) {
            // left side plate
            translate([left_side_pos, 0, 0])
                cube([acrylic_thickness, side_length, side_height-side_cutaway]);

            // right side plate
            translate([right_side_pos, 0, 0])
                cube([acrylic_thickness, side_length, side_height-side_cutaway]);

            // left side main drum bump
            translate([left_side_pos, side_length * main_drum_length_pct, side_height * main_drum_height_pct])
                rotate([0, 90, 0])
                    cylinder(acrylic_thickness, r=main_drum_dia * main_drum_bump_pct / 2);

            // right side main drum bump
            translate([right_side_pos, side_length * main_drum_length_pct, side_height * main_drum_height_pct])
                rotate([0, 90, 0])
                    cylinder(acrylic_thickness, r=main_drum_dia * main_drum_bump_pct / 2);
        
            // left side licker-in drum bump
            translate([left_side_pos, side_length * li_drum_length_pct, side_height * li_drum_height_pct])
                rotate([0, 90, 0])
                    cylinder(acrylic_thickness, r=li_drum_dia * li_drum_bump_pct / 2);

            // right side licker-in drum bump
            translate([right_side_pos, side_length * li_drum_length_pct, side_height * li_drum_height_pct])
                rotate([0, 90, 0])
                    cylinder(acrylic_thickness, r=li_drum_dia * li_drum_bump_pct / 2);

            // bottom plate
            translate([left_side_pos, 0, bottom_height_pct * side_height])
                rotate([bottom_rotation, 0, 0])
                    cube([bottom_width, side_length, acrylic_thickness]);
        }
        
        // guide blocks
        color([0.3, 0.5, 0.5]) {
            guide_block_pos = (side_length * li_drum_length_pct - li_drum_dia/2 - 10) - guide_block_length;
            translate([left_side_pos + acrylic_thickness, guide_block_pos, side_height * bottom_height_pct + guide_block_height_tweak])
                rotate([bottom_rotation, 0, 0])
                    cube([10, guide_block_length, acrylic_thickness * 2]);
            // TODO: why 1.5?
            translate([right_side_pos - acrylic_thickness*1.5, guide_block_pos, side_height * bottom_height_pct + guide_block_height_tweak])
                rotate([bottom_rotation, 0, 0])
                    cube([10, guide_block_length, acrylic_thickness * 2]);
        }
        
        // axles
        color([0.7, 0.7, 0.7]) {
            // licker-in axle
            translate([left_side_pos * axle_offset_pct, side_length * li_drum_length_pct, side_height * li_drum_height_pct])
                rotate([0, 90, 0])
                    cylinder(h=bottom_width*axle_length_pct, r=axle_dia/2);
            // main axle
            translate([left_side_pos * axle_offset_pct, side_length * main_drum_length_pct, side_height * main_drum_height_pct])
                rotate([0, 90, 0])
                    cylinder(h=bottom_width*axle_length_pct + 10, r=axle_dia/2);
        }

        // licker-in axle adjuster
        color([1.0, 1.0, 1.0]) {
            // licker-in axle
            translate([left_side_pos - 1, side_length * li_drum_length_pct, side_height * li_drum_height_pct - 2])
                rotate([0, 90, 0])
                    cylinder(h=bottom_width + 8.5, r=axle_dia);
        }
        
        // pulleys
        color([0.5, 0.3, 0.5]) {
            // licker-in pulley
            translate([left_side_pos-pulley_acrylic_thickness * 3 - pulley_gap, side_length * li_drum_length_pct, side_height * li_drum_height_pct])
                rotate([0, 90, 0])
                    pulley(t = pulley_acrylic_thickness * 3, r=main_drum_dia/2);    
            // main pulley
            translate([left_side_pos-pulley_acrylic_thickness * 3 - pulley_gap, side_length * main_drum_length_pct, side_height * main_drum_height_pct])
                rotate([0, 90, 0])
                    pulley(t = pulley_acrylic_thickness * 3, r=li_drum_dia/2);    
        }
        
        // drums
        color([0.3, 0.3, 0.3]) {
            // licker-in drum
            translate([left_side_pos + acrylic_thickness / 2, side_length * li_drum_length_pct, side_height * li_drum_height_pct])
                rotate([0, 90, 0])
                    cylinder(h=bottom_width, r=li_drum_dia/2);
            // main drum
            translate([left_side_pos + acrylic_thickness / 2, side_length * main_drum_length_pct, side_height * main_drum_height_pct])
                rotate([0, 90, 0])
                    cylinder(h=bottom_width, r=main_drum_dia/2);
        }
        
        // crank
        color([0.7, 0.3, 0.3]) {
            translate([right_side_pos + acrylic_thickness + pulley_gap, side_length * main_drum_length_pct - 14, side_height * main_drum_height_pct])
                rotate([-45, 0, 0])
                    cube([acrylic_thickness, 20, 80]);
            translate([right_side_pos + acrylic_thickness + pulley_gap, side_length * main_drum_length_pct + 40, side_height * main_drum_height_pct + 40])
                rotate([0, 90, 0])
                    cylinder(h=20, r=axle_dia/2);

        }
	}
}

