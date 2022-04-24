/*
  @todo 3Dモデルを分割して読み込む
  @todo ToonShaderとはなにか？
  @todo ToonShader + colorPallet
*/

// import peasy.*;
// PeasyCam cam;

// tree
Tree tree;

void setup() {
  size(1024, 1024, P3D);
  noStroke();
  /*
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);
  */

  // tree
  Wood wood = setWood(
    "./assets/model/tree/wood.obj",
    "./shader/material/tree/wood.vert", 
    "./shader/material/tree/wood.frag"
  );

  Leaves leaves = setLeaves(
    "./assets/model/tree/leaves.obj",
    "./shader/material/tree/leaves.vert",
    "./shader/material/tree/leaves.frag"
    );
  
  tree = new Tree(wood, leaves);
}


void draw() {
  // float uTime = frameCount * 0.005;
  background(0, 0, 0);

  float dirX = (mouseX / float(width) - 0.5) * 2.0;
  float dirY = (mouseY / float(height) - 0.5) * 2.0;
  directionalLight(200, 200, 200, -dirX, -dirY, -1);
  
  tree.wood();
  tree.leaves();
}
