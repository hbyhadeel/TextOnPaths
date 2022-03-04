class Letter extends PVector {
  char c;
  float angle;
  int dir = 1;
  Letter(char _c, float x, float y, float _angle) {
    super(x, y);
    c = _c;
    angle = _angle;
  }

  void update() {
    float a = noise(x/1000, y/1000) * 10;
    x += cos(a) * 2 * dir;
    y += sin(a) * 2 * dir;
    
    bounds();

  }

  void bounds() {
    if (x > width-strokeW/2-margin || x < strokeW/2+margin ||
      y < strokeW/2+margin || y > height-strokeW/2-margin) {
        dir = -dir;
        noLoop();
      }
    x = constrain(x, strokeW/2+margin, width-strokeW/2-margin);
    y = constrain(y, strokeW/2+margin, width-strokeW/2-margin);
  }

  String toString() {
    return "[x: " + x + ", y: " + y + ", angle: " + angle + "]";
  }
}
