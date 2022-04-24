Wood setWood(String modelDataURL, String vertShaderURL, String fragmentShaderURL){
  // wood
  PShape woodData = loadShape(modelDataURL);
  PShader woodShader = loadShader(
    fragmentShaderURL, 
    vertShaderURL 
  );

  Wood wood = new Wood(woodShader, woodData);

  return wood;
}