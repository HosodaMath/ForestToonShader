/*
  風などのシミュレーションでWoodとLeavesで影響が異なるため分割している
*/
class Tree {
  Wood wood;
  Leaves leaves;
  Tree(Wood wood,  Leaves leaves){
    this.wood = wood;
    this.leaves = leaves;
  }

  void wood(){
    pushMatrix();
    translate(width * 0.5, height - height * 0.25, 200);
    rotateX(radians(-180));
    scale(50);
    shader(this.wood.woodShader);
    shape(this.wood.woodData);
    resetShader();
    popMatrix();
  }

  void leaves(){
    pushMatrix();
    translate(width * 0.5, height - height * 0.25, 200);
    rotateX(radians(-180));
    scale(50);
    shader(this.leaves.leavesShader);
    shape(this.leaves.leavesData);
    resetShader();
    popMatrix();
  }
}