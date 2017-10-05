PImage[] s = new PImage[8];
void setup() {
  size(1500, 1500);
  for (int i = 0; i<8; i++)s[i] = loadImage("Terrain/Suelo"+(i+1)+".jpg");
}

HashMap<String, Float> hMap = new HashMap<String, Float>();
float amplitude, frequency, noiseHeight;
int mapSize = 150, mapSquareSize = 10, octaves;
float noiseScale = 0.2, persistance, lacunarity;
int noiseS;
float sampleX, sampleY;
void draw() {

  noiseSeed(noiseS);
  if (noiseScale <= 0)noiseScale = 0.0001f;
  float maxNoiseHeight = pow(2, -149);
  float minNoiseHeight = (2-pow(2, 23)*pow(2, 127));
  sampleX = 0;
  for (int x = 0; x<mapSize; x++) {
    sampleY = 0;
    for (int y = 0; y<mapSize; y++) {

      amplitude = 1;
      frequency = 1;
      noiseHeight = 0;

      for (int k = 0; k<octaves; k++) {
        //float sampleX = x/noiseScale * frequency;
        //float sampleY = y/noiseScale * frequency;

        float perlinValue = noise(sampleX, sampleY)*2-1;
        noiseHeight += perlinValue * amplitude;
        amplitude *= persistance;
        frequency *= lacunarity;
      }
      sampleY += noiseScale * frequency;
      hMap.put("X"+x+"Y"+y, map(noiseHeight, -1, 1, 0, 1));
      if (noiseHeight > maxNoiseHeight)maxNoiseHeight = noiseHeight;
      else if (noiseHeight < minNoiseHeight)minNoiseHeight = noiseHeight;
    }
    sampleX += noiseScale * frequency;
  }
  for (int i = 0; i<mapSize; i++) {
    for (int j = 0; j<mapSize; j++) {
      if (map(hMap.get("X"+i+"Y"+j), 0, 1, 0, 80)<80)image(s[0], i*mapSquareSize, j*mapSquareSize, mapSquareSize, mapSquareSize);
      if (map(hMap.get("X"+i+"Y"+j), 0, 1, 0, 80)<75)image(s[1], i*mapSquareSize, j*mapSquareSize, mapSquareSize, mapSquareSize);
      if (map(hMap.get("X"+i+"Y"+j), 0, 1, 0, 80)<70)image(s[2], i*mapSquareSize, j*mapSquareSize, mapSquareSize, mapSquareSize);
      if (map(hMap.get("X"+i+"Y"+j), 0, 1, 0, 80)<65)image(s[3], i*mapSquareSize, j*mapSquareSize, mapSquareSize, mapSquareSize);
      if (map(hMap.get("X"+i+"Y"+j), 0, 1, 0, 80)<40)image(s[4], i*mapSquareSize, j*mapSquareSize, mapSquareSize, mapSquareSize);
      if (map(hMap.get("X"+i+"Y"+j), 0, 1, 0, 80)<15)image(s[5], i*mapSquareSize, j*mapSquareSize, mapSquareSize, mapSquareSize);
      if (map(hMap.get("X"+i+"Y"+j), 0, 1, 0, 80)<10)image(s[6], i*mapSquareSize, j*mapSquareSize, mapSquareSize, mapSquareSize);
      if (map(hMap.get("X"+i+"Y"+j), 0, 1, 0, 80)<5)image(s[7], i*mapSquareSize, j*mapSquareSize, mapSquareSize, mapSquareSize);
    }
  }
}
void mouseClicked() {
  if (key == 'p')persistance+=0.1;
  if (key == 'P')persistance-=0.1;
  if (key == 'l')lacunarity++;
  if (key == 'L')lacunarity--;
  if (key == 'o')octaves++;
  if (key == 'O')octaves--;
  if (key == 's')noiseS++;
  if (key == 'S')noiseS--;
  println("persistance"+persistance, "lacunarity"+lacunarity, "octaves"+octaves, "noiseS"+noiseS);
}