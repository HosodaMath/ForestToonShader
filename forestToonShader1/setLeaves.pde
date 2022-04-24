Leaves setLeaves(String modelDataURL, String vertShaderURL, String fragmentShaderURL){
   // leaves
  PShape leavesData = loadShape(modelDataURL);
  PShader leavesShader = loadShader(
    fragmentShaderURL, 
    vertShaderURL
  );

  Leaves leaves = new Leaves(leavesShader, leavesData);

  return leaves;
}
