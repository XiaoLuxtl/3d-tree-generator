//float theta = PI/6;
int maxBranches = 4;
Boolean genTree = true;
float angleRange = PI/3;
color sky = color(216,235,242);
color trunk = color(153,53,17);
color leaves = color(67, 153,41);
float ratio = 0.66;
float lenThresh = 1;
float rotCt = 0;
float crotAmt = 0.01;

PVector[][] lines = {{}};
int instance = int(random(10000));
int saveCount = 0;

PVector everyRoot = new PVector(0,0,0);
PVector everyRot = new PVector(0,0,0);

void setup(){
 size(1024,768,P3D); 
 //narr= append(narr, 1); //init for trunk



}

void draw(){
  background(sky);
  //pushMatrix();

  if(genTree){
  initTree();

    newTree(everyRoot, everyRot, height/3);

    genTree = false;
    println(lines[1]);
    println("TREE GENERATED");
  };
  

drawTree(rotCt);
rotCt += crotAmt;
}

void newTree(PVector root, PVector rotation, float totlen){
  PVector leaf;
 
  float partoflen = totlen * random(1);

  PVector tail = rotAmt(root, rotation, partoflen);
   if(totlen * pow(ratio, 6)<= lenThresh){
leaf = new PVector(1,1,1);
  }
  else{
    leaf = new PVector(0,0,0);
  };

  PVector[] toAdd = {root, tail, leaf};
  lines = (PVector[][])append(lines, toAdd);
   totlen *=ratio;

   if (totlen> lenThresh){
     
     
     int n = int(random(1,maxBranches));

     for(int i =0; i< n; i++){

      float theta1 = random(-1*angleRange, angleRange);
            float theta2 = random(-1*angleRange, angleRange);
      float theta3 = random(-1*angleRange, angleRange);
      PVector newRot = new PVector(rotation.x+theta1, rotation.y+theta2, rotation.z+theta3);

      newTree(tail, newRot, totlen);

     
     }
   };

}



void drawTree(float rot){
// pushMatrix();
  translate(width/2, 9*height/10, 0);
 rotateY(rot);
  for(int i=1; i< lines.length;i++){
    PVector root = lines[i][0];
    PVector tail = lines[i][1];
    PVector leaf = lines[i][2];
    if(leaf.x == 1){
      stroke(leaves);
    }
    else{
      stroke(trunk);
    };
    line(root.x, root.y,root.z, tail.x, tail.y, tail.z);
  };
//  popMatrix();
}






void mousePressed(){
  genTree = true;  
  trunk = color(random(255), random(255), random(255));
    leaves = color(random(255), random(255), random(255));
  sky = color(random(255), random(255), random(255));

  
}

void keyPressed(){
  if (key == 's'){
   String filename = "tree-"+str(instance)+nf(saveCount, 3) + ".tif"; 
   saveFrame(filename);
   saveCount++;
    
  }
    if (key == 'n'){
    genTree = true;  
  trunk = color(random(255), random(255), random(255));
    leaves = color(random(255), random(255), random(255));
  sky = color(random(255), random(255), random(255));
    
  }
};

PVector rotX(PVector ipt, float angle){
  float iptY = cos(angle)*ipt.y-sin(angle)*ipt.z;
  float iptZ = sin(angle)*ipt.y+cos(angle)*ipt.z;

  PVector out = new PVector(ipt.x, iptY, iptZ);
  return out;
};

PVector rotY(PVector ipt, float angle){
  float iptX = cos(angle)*ipt.x + sin(angle)*ipt.z;
  float iptZ = -sin(angle)*ipt.x + cos(angle)*ipt.z;
  PVector out = new PVector(iptX, ipt.y, iptZ);
  return out;
};

PVector rotZ(PVector ipt, float angle){
  float iptX = cos(angle)*ipt.x-sin(angle)*ipt.y;
  float iptY = sin(angle)*ipt.x + cos(angle)*ipt.y;
  PVector out = new PVector(iptX, iptY, ipt.z);
  
  return out;
};

PVector rotXYZ(PVector ipt, PVector rot){
  PVector ret = rotX(rotY(rotZ(ipt, rot.z), rot.y), rot.x);
  return ret;
};

PVector rotAmt(PVector ipt, PVector rot, float amt){
  PVector yVec = new PVector(0, -amt, 0);
    yVec = rotXYZ(yVec, rot);
  yVec.add(ipt);

  return yVec;
  
  
};

void initTree(){
  PVector[][] newLines = {{}}; 

lines = newLines;

  
};
