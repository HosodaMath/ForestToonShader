/*
  @todo 3Dモデルを分割して読み込む
  @todo ToonShaderとはなにか？
  @todo ToonShader + colorPallet
*/

// import peasy.*;
// PeasyCam cam;

// forest
Forest forest;

// background
PShader cloudShader;
void setup() {
  size(1024, 1024, P3D);
  noStroke();
  /*
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);
  */

  cloudShader = loadShader( 
    "./shader/material/cloud/cloud.frag", 
    "./shader/material/cloud/cloud.vert"
  );

  // wood
  Wood wood = setWood(
    "./assets/model/tree/wood.obj",
    "./shader/material/tree/wood.vert", 
    "./shader/material/tree/wood.frag"
  );

  // leaves
  Leaves leaves = setLeaves(
    "./assets/model/tree/leaves.obj",
    "./shader/material/tree/leaves.vert",
    "./shader/material/tree/leaves.frag"
    );
  
  forest = new Forest(wood, leaves);
  forest.setPosition(30);
}


void draw() {
  float uTime = frameCount * 0.005;
  background(0, 0, 0);

  float dirX = (mouseX / float(width) - 0.5) * 2.0;
  float dirY = (mouseY / float(height) - 0.5) * 2.0;
  directionalLight(200, 200, 200, -dirX, -dirY, -1);
  
  pushMatrix();
  translate(width * 0.5, height * 0.5, 0);
  scale(5);
  shader(cloudShader);
  cloudShader.set("uTime", uTime);
  sphere(200);
  popMatrix();

  forest.wood();
  forest.leaves();

  saveFrame("frames/#######.png");
}
