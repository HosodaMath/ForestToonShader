/*
  風などのシミュレーションでWoodとLeavesで影響が異なるため分割している
*/
class Forest {
  Wood wood;
  Leaves leaves;
  ArrayList<PVector> woodsPosition;
  ArrayList<PVector> leavesPosition;
  Forest(Wood wood,  Leaves leaves){
    this.wood = wood;
    this.leaves = leaves;
    this.woodsPosition = new ArrayList<PVector>();
    this.leavesPosition = new ArrayList<PVector>();
  }

  void setPosition(int maxCount){
    for(int count = 0; count  < maxCount; count++){
      float positionX = random(0, width);
      float positionY = height - height * 0.25;
      float positionZ = random(-width, 100);
      PVector position = new PVector(positionX, positionY, positionZ);
      this.woodsPosition.add(position);
      this.leavesPosition.add(position);
    }
  }

  void wood(){
    pushMatrix();
    shader(this.wood.woodShader);
    for(int count = 0; count < this.woodsPosition.size(); count++){
      pushMatrix();
      translate(woodsPosition.get(count).x, woodsPosition.get(count).y, woodsPosition.get(count).z);
      rotateX(radians(-180));
      scale(40);
      shape(this.wood.woodData);
      popMatrix();
    }
    resetShader(); 
    popMatrix();
  }

  void leaves(){
    pushMatrix();
    shader(this.leaves.leavesShader);
    for(int count = 0; count < this.leavesPosition.size(); count++){
      pushMatrix();
      translate(leavesPosition.get(count).x, leavesPosition.get(count).y, leavesPosition.get(count).z);
      rotateX(radians(-180));
      scale(40);
      shape(this.leaves.leavesData);
      popMatrix();
    }
    resetShader(); 
    popMatrix();
  }
}