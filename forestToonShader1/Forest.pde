/*
  風などのシミュレーションでWoodとLeavesで影響が異なるため分割している
*/
class Forest {
  Wood wood;
  Leaves leaves;
  Forest(Wood wood,  Leaves leaves){
    this.wood = wood;
    this.leaves = leaves;
  }

  void wood(){
    pushMatrix();
    shader(this.wood.woodShader);
    for(int count = 0; count < 10; count++){
      pushMatrix();
      translate(count * 200, height - height * 0.25, 200);
      rotateX(radians(-180));
      scale(50);
      shape(this.wood.woodData);
      popMatrix();
    }
    resetShader(); 
    popMatrix();
  }

  void leaves(){
    pushMatrix();
    shader(this.leaves.leavesShader);
    for(int count = 0; count < 10; count++){
      pushMatrix();
      translate(count * 200, height - height * 0.25, 200);
      rotateX(radians(-180));
      scale(50);
      shape(this.leaves.leavesData);
      popMatrix();
    }
    resetShader(); 
    popMatrix();
  }
}