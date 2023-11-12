$fn = $preview ? 16 : 32;

// General
intersectMargin=0.01;

pp45Tolerance = 0.1; // extra space in all dimensions for PowerPole to fit

// Panel Hole
holeWidth = 24.5;
holeHeightInner = 25.5;
tabHeight = 1;
tabWidth = 9.5;
flangeSize = 8;

holeHeightOuter = holeHeightInner + 2*tabHeight;

// Front Plate
coverPlateWidth = holeWidth + 2;
coverPlateHeight = holeHeightOuter + 2;
coverPlateThickness = 3;

screwHoleDistance = 35;
screwHoleDiameter = 3;

// PowerPole
ppSize = 7.9;
ppLength = 24.6;

retentionPinDiameter = 2.5;
retentionPinPosition = 10;

clipHeight = 0.7;
clipWidth = 3.4;
clipLength = 12.2;

// ----

module holeShape(){
    module halfPlate(){
        difference(){
            square([holeWidth, holeHeightOuter/2]);
            translate([holeWidth/2 - (tabWidth/2), holeHeightOuter/2-tabHeight]){square([tabWidth, tabHeight]);};
        }
    }
    translate([-holeWidth/2,0]){
        halfPlate();
        mirror([0,1,0]){halfPlate();};
    }
}

module coverPlate(){
    
    module flange(){
        straightPartLength = 6;
        translate([coverPlateWidth/2, screwHoleDistance/2]){
            circle(d=flangeSize);
            translate([-flangeSize/2, -straightPartLength])
                square([flangeSize, straightPartLength]);
        }
    }
    
    module halfPlateShape() {
        difference(){
            union(){
                square([coverPlateWidth, coverPlateHeight/2]); // main square
                flange();
            };
            translate([coverPlateWidth/2, screwHoleDistance/2])
                circle(d=screwHoleDiameter);
        };
    };
    
    module halfPlate() {
        difference(){
            linear_extrude(coverPlateThickness){
                halfPlateShape();
            }
            translate([coverPlateWidth/2, screwHoleDistance/2, -intersectMargin]) cylinder(1.8, 3, 1.5); // countersink hole
        }
    }

    translate([-coverPlateWidth/2, 0]){
        halfPlate();
        mirror([0, 1, 0]){
            halfPlate();
        }
    }
}

module pp45(){
    module pin(){
        translate([0,(ppSize+intersectMargin)/2,0])
            rotate([90,0,0])
            cylinder(h=ppSize+intersectMargin,d=retentionPinDiameter);
    }
    
    module clip(){
        translate([-clipWidth/2,ppSize/2-intersectMargin, ppLength-clipLength])
            cube([clipWidth, clipHeight, clipLength]);
    }

    difference(){
        union(){
            translate([-ppSize/2, -ppSize/2, 0])
                cube([ppSize, ppSize, ppLength]);
            
            for(i = [0:90:270]){
                rotate([0,0,i]) clip();
            }
        };
        translate([ppSize/2,0,retentionPinPosition])
            pin();
        translate([-ppSize/2,0,retentionPinPosition])
            pin();
    }
}



//pp45();


module part(){
    difference(){
        union(){
            coverPlate();

            translate([0,0,coverPlateThickness])
            {
                linear_extrude(21){
                    holeShape();
                };
            }
        };
        translate([-20,8,5]) cube([40,20,50]);
        translate([-20,-27.9,5]) cube([40,20,50]);
        
        minkowski(){
            translate([-7.9/2, 0, -intersectMargin]){
                pp45();
                translate([7.9-intersectMargin,0,0]) pp45();
            };
            sphere(r=pp45Tolerance);
        };
    }
}

module splitShape(){
    translate([-15,0,2]) cube([30,25,40]);
    module key(){
        translate([10.5, -4,2]) linear_extrude(40){
            square([4,4+intersectMargin]);
        };
    }
    key();
    mirror([1,0,0]) key();
}


//part();

//color("red")
//splitShape();

difference(){
    part();
    splitShape();
};

translate([27, 0, -2]){
    intersection(){
        part();
        splitShape();
    };
}

