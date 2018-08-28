
//van 
vw=70;
vh=76;
vwh=56;
vl=166;

//wheel 
wl=31;
wh=13;
ww=8;
wo=37;


cubbie_l=78; //172cm
cubbie_h=16; //36cm
cubbie_w=18; //50cm
//toilet
tw=15+3/4;
th=18;
tl=26+3/8;

//water tank
//TRI-WH-2030-4
//fw=13;
//fh=12;
//fl=46;
//TRI-WH-2031
fw=20;
fh=12;
fl=30;
//TRI-WH-2037  
/*fw=19;
fh=12;
fl=38;*/
//TRI-WH-2030
//gw=20;
//gh=7;
//gl=50;
//TRI-WH-2030-4 # FUCK BOUGHT WRONG TANK!
gw=13;
gh=12;
gl=46;

//webasto
webh=12+1;
//webw=15.4+1;
webw=19+1;
webl=34.6+1;


//bed
beds=55.25;
bedtotal=166-beds;
bedl=96;
bedw1=27; //used to be 50
bedw2=27;
bedh=0.5;
strapl=(bedtotal-bedl)/2;
strapw=2;
bede=strapl+beds+bedl;
seats=105;
seattotal=166-seats;
seatstrapl=(seattotal-bedl/2)/2;
seate=seatstrapl+seats+bedl/2;

//shower pan
//sw=18;
//sh=4;
//sl=35;
//larger shower pan
sw=48;
sh=2.75;
sl=36;

//mattress
bedsplit=32;

//fridge
fridgel=18;
fridgew=18;
fridgeh=22;

//projector
pw=5.7;
pl=3.1;
ph=0.7;

//foldout desk
fol=50;
fow=20;
foldout=0;

//bathroom
bw=tw+sw+1;
bh=vh;
bl=35;

//kitchen
kw=25;
kh=40;
kl=32;
ko=37;
ks=ko;
ke=ko+kl;


module hull() {
    translate([0.05,vw/2,0]) scale([1,1,3.5]) rotate([0,90,0]) cylinder(h = vl-0.1, r1 = vw/2, r2 = vw/2, center = false);
}
module tank(l,w,h) {
    //outlet
    ow=1.25;
    oh=1;
    //inlet
    ih=1;
    iw=1.25;
    //vent
    vh=1;
    vw=0.5;
    //outet
    color("red") translate([0,w/2,ow/2+1]) rotate([0,90,0]) cylinder(h = oh, r1 = ow/2, r2 = ow/2, center = false);
    //vent
    color("red") translate([0,w-vw/2-1,h-vw/2-1]) rotate([0,90,0]) cylinder(h = vh, r1 = vw/2, r2 = vw/2, center = false);
    //inlet
    color("red") translate([0,w/2,h-ih/2-1]) rotate([0,90,0]) cylinder(h = ih, r1 = iw/2, r2 = iw/2, center = false);
    
    translate([ih,0,0]) cube([l,w,h]);
}


module bedleft(bedthick=3) { 
    translate([0,vw/2-bedw1,0]) bedonly(bedthick=bedthick);
    /*intersection() {
        bedonly(bedthick=bedthick);
        cube([200,bedsplit,bedthick]);
    }*/
}
module bedright(bedthick=3) {
    translate([0,-bedsplit,wh]) difference() {
        bedonly(bedthick=bedthick);
        translate([-0.1,0,-0.1]) cube([200+0.2,bedsplit,    bedthick+0.2]);
    }
}
module strap(sp,ep,w=2,h=0.5) {
        points = [
          [  sp[0],  sp[1]-w/2,  sp[2] ],  //0
          [ ep[0],  ep[1]-w/2,  ep[2] ],  //1
          [ ep[0],  ep[1]+w/2,  ep[2] ],  //2
          [  sp[0],  sp[1]+w/2,  sp[2] ],  //3
          [  sp[0],  sp[1]-w/2,  sp[2]+h ],  //4
          [ ep[0],  ep[1]-w/2,  ep[2] +h],  //5
          [ ep[0],  ep[1]+w/2,  ep[2] +h],  //6
          [  sp[0],  sp[1]+w/2,  sp[2] +h]];  //7 
          
        faces = [
          [0,1,2,3],  // bottom
          [4,5,1,0],  // front
          [7,6,5,4],  // top
          [5,6,2,1],  // right
          [6,7,3,2],  // back
          [7,4,0,3]]; // left
        polyhedron( points, faces );
}


module bedloveseatonly(bedheight=0,bedthick=bedh) {
    bedpoints = [
          [  0,  (bedw1-bedw2)/2,  bedheight ],  //0
          [ bedl/2,  0,  bedheight ],  //1
          [ bedl/2,  bedw1,  bedheight ],  //2
          [  0,  bedw1,  bedheight ],  //3
          [  0,  (bedw1-bedw2)/2,  bedthick+bedheight ],  //4
          [ bedl/2,  0,  bedthick+bedheight ],  //5
          [ bedl/2,  bedw1,  bedthick+bedheight ],  //6
          [  0,  bedw1,  bedthick+bedheight ]]; //7
          
        bedfaces = [
          [0,1,2,3],  // bottom
          [4,5,1,0],  // front
          [7,6,5,4],  // top
          [5,6,2,1],  // right
          [6,7,3,2],  // back
          [7,4,0,3]]; // left
    polyhedron( bedpoints, bedfaces );
}



module bedonly(bedheight=0,bedthick=bedh) {
    bedw2=bedw1;
    bedpoints = [
          [  0,  bedw1-bedw2,  bedheight ],  //0
          [ bedl,  0,  bedheight ],  //1
          [ bedl,  bedw1,  bedheight ],  //2
          [  0,  bedw1,  bedheight ],  //3
          [  0,  bedw1-bedw2,  bedthick+bedheight ],  //4
          [ bedl,  0,  bedthick+bedheight ],  //5
          [ bedl,  bedw1,  bedthick+bedheight ],  //6
          [  0,  bedw1,  bedthick+bedheight ]]; //7
          
        bedfaces = [
          [0,1,2,3],  // bottom
          [4,5,1,0],  // front
          [7,6,5,4],  // top
          [5,6,2,1],  // right
          [6,7,3,2],  // back
          [7,4,0,3]]; // left
    polyhedron( bedpoints, bedfaces );
}

module bed(bedheight=0,bedthick=bedh) {
        translate([beds+strapl,vw-bedw1-3,0]) bedonly(bedheight,bedthick);
        
        //back left strap
        strap([beds+strapl,vw-bedw2-3+strapw/2,bedheight],[beds+2,(vw-vwh)/2+strapw+13,vh]);
        //back right
        strap([beds+strapl,vw-3-strapw/2,bedheight],[beds+2,vw-(vw-vwh)/2-strapw,vh]);
        //front right
        strap([bede,vw-3-strapw/2,bedheight],[bede+strapl,vw-(vw-vwh)/2-strapw,vh]);
        //front left
        strap([bede,vw-bedw1-3+strapw/2,bedheight],[bede+strapl,(vw-vwh)/2+strapw+5,vh]);
        
}
//bed(bedheight=35);

module bedloveseat(bedheight=0,bedthick=bedh) {
        translate([seats+seatstrapl,vw-bedw1-3,0]) bedloveseatonly(bedheight,bedthick);
        
        //back left strap
        strap([seats+seatstrapl,vw-bedw2-3+strapw/2,bedheight],[seats+2,(vw-vwh)/2+strapw+13,vh]);
        //back right
        strap([seats+seatstrapl,vw-3-strapw/2,bedheight],[seats+2,vw-(vw-vwh)/2-strapw,vh]);
        //front right
        strap([seate,vw-3-strapw/2,bedheight],[bede+strapl,vw-(vw-vwh)/2-strapw,vh]);
        //front left
        strap([seate,vw-bedw1-3+strapw/2,bedheight],[bede+strapl,(vw-vwh)/2+strapw+5,vh]);
        
}
//bedloveseat(bedheight=30);


//rotate([0,0,$t*360]) translate([-vl/2,-vw/2,0]) {

//beams
intersection() {
    for (x=[9,33.5,55.25,81,105,121.5,143.25,vl-1]){
        translate([x,0,vh-2]) cube([2,vw,2]);
    }
    hull();
}

//Wheel wells
color("grey",0.5) {
    translate([wo,0,0]) cube([wl,ww,wh]);
    translate([wo,vw-ww,0]) cube([wl,ww,wh]);
}

//Toilet 
translate([29-tl,vw-tw,0]) cube([tl,tw,th]);

//fresh water
color("Aquamarine",0.9) translate([70,vw-fw,0]) tank(fl,fw,fh);
//grey water tank
color("SkyBlue",0.9) translate([70-(gl-fl),vw-gw,fh]) tank(gl,gw,gh);

//webasto
translate([0,0,0]) cube([webl,webw,webh]);

//shower pan
translate([0,vw-sw-1,0]) cube([sl,sw,sh]);

//mattress

translate([ke,vw-bedsplit-2,27]) rotate([0,0,0]) translate([0,0,0]) bedleft();

//fridge
//color("orange") translate([vl-fridgel-4,vw-fridgew-5,0]) cube([fridgel,fridgew,fridgeh]);

//projector
//color("red") translate([166-40,vw-pw-24,vh-14-ph]) cube([3.1,pw,0.7]);
color("red") translate([166-40,44,vh-14-ph]) cube([3.1,pw,0.7]);

//fold out desk by door
//color("green",0.3) translate([166-57-fol-4,2,40]) rotate([80*(1-foldout),0,0]) cube([fol,fow,0.5]);

//bed(bedheight=35);

//back storage
/*color("green",0.2)  intersection() {
    translate([0,0,webh]) cube([wo+wl-16,webw,vh-webh]);
    hull();
}*/

//Dometic CFX75DZW
//fridge
dom_l=19.5;
dom_h=18.58;
dom_w=32.7;
//cfx-65dz
//dom_h=22;
//dom_w=28.5;
//dom_l=17.9;
//cfx-50w
//dom_l=17.9;
//dom_h=18.5;
//dom_w=28.5;

//dometic fridge 
color("blue") translate([ko,dom_w-vw/2+4,16]) cube([dom_w,dom_l,dom_h]);

//extra seats
es_l=30;
es_w=15;
es_h=40;
//color("red") translate([ke+6,0,0]) cube([es_l,es_w,es_h]); //folded
//color("red") translate([ke+6,0,0]) cube([es_l,es_h,es_w]); //unfolded


//side storage
/*color("green",0.2)  intersection() {
    translate([ke,vw-30,0]) cube([bedl,30,21]);
    hull();
}*/

//up storage
color("green",0.2)  intersection() {
    translate([ke+bedl-cubbie_l,vw-cubbie_w,vh-cubbie_h]) cube([cubbie_l,cubbie_w,cubbie_h]);
    
    hull();
}
//color("red") translate([ke+bedl-cubbie_l,vw-20,vh-cubbie_h]) cube([cubbie_l,12,cubbie_h]);

//bathroom
color("blue",0.25) intersection() {
    translate([0,vw-bw,0]) cube([bl,bw,bh]);
    hull();
}
//https://www.amazon.com/Zuhne-Modena-28-Undermount-Stainless/dp/B01AFSJ8I6/ref=pd_cp_60_3?_encoding=UTF8&pd_rd_i=B01JZ7N0IW&pd_rd_r=9GME060D13MWRATM5V4G&pd_rd_w=kLLhS&pd_rd_wg=ROiXU&refRID=9GME060D13MWRATM5V4G&th=1
//SINK Zuhne Modena Undermount Single Bowl 15 x 17 Inch 16 Gauge Stainless Steel Kitchen Sink, Bar or Prep Kitchen Sinks
sink_w=15;
sink_d=17;
sink_h=10;

//Ruvati 15 x 15 inch Drop-in Topmount Bar Prep Sink 16 Gauge Stainless Steel Single Bowl - RVH8115
sink_w=15;
sink_d=15;
sink_h=9;

//https://www.amazon.com/dp/B0183W4MTQ/ref=psdc_3754691_t1_B0183W4MZK
//Kraus KHU15 Pax Zero-Radius 14 1/2 18 Gauge Handmade Undermount Single Bowl Stainless Steel Bar/Prep Sink
sink_w=14.5;
sink_d=18.5;
sink_h=9;

//https://www.amazon.com/VAPSINT-Recommended-Stainless-Brushed-Sprayer/dp/B01N6RR1HY/ref=sr_1_6?s=hi&ie=UTF8&qid=1528740184&sr=1-6&keywords=faucet++Pull+Down+Sprayer
//VAPSINT Well Recommended Stainless Steel Spring Brushed Nickel Mixer Pre Rinse Pull Down Sprayer Single Handle Kitchen Faucet, Pull Out Kitchen Sink Faucet


/*sink_w=21;
sink_d=18;
sink_h=9;*/
color("red") intersection() {
    translate([ko+2,vw-kw+3,kh-10]) cube([sink_w,sink_d,sink_h]);
    hull();
}
//kitchen
color("red",0.3) intersection() {
    translate([ko,vw-kw,0]) cube([kl,kw,kh]);
    hull();
}
//subtract out slide door
color("grey",0.2) intersection() {
    intersection() {
        translate([-0.1,0,0]) cube([vl+0.2,vw,vh]);
        hull();
    } 
    translate([vl-57,0,-1]) cube([57+0.1,10,vh+2]); 
}

//}
