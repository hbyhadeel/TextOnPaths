class TextCurve {
  ArrayList<Letter> pos = new ArrayList<Letter>();
  String str;
  String newStr = "";
  float arcAngle;

  float cx, cy;
  float x, y;

  float radius, minR;
  float aoff;

  color col;
  TextCurve(String _str, float _radius, float _arcAngle) {
    str = _str;
    radius = _radius;
    arcAngle = _arcAngle;

    minR = 30;
    aoff = -PI;

    cx = width/2;
    cy = height/2;

    col = cols[(int)random(cols.length)];

    if (radius < minR) printError("radius must be above minimum radius of " + minR + "px");
  }

  void setMinRadius(float minRadius) {
    if (minR < 30) printError("minumum radius must be above 30px");
    else minR = minRadius;
  }

  void setArcAngleOff(float arcAngleOff) {
    aoff = arcAngleOff;
  }

  int getStrLength() {
    return newStr.length();
  }

  int calculate() {
    float textW = 0;
    int i = 0;
    while (i < str.length() && radius >= minR) {
      float tw = textWidth(str.charAt(i));
      textW += tw;
      if (textW >= arcAngle*radius) {
        newStr = str.substring(0, str.substring(0, i).lastIndexOf(' '));
        return newStr.length();
      } else {
        newStr = str;
        i++;
      }
    }
    return 0;
  }

  void addPoints() {
    float charArcLength = 0;
    float charAngle = 0;
    for (int i = 0; i < newStr.length(); i++) {
      float tw = textWidth(newStr.charAt(i));

      charArcLength += tw/2;
      charAngle = aoff + charArcLength/radius;

      float xoff = 0;
      float yoff = 0;

      x = cx + cos(charAngle) * (radius+random(-xoff, xoff));
      y = cy + sin(charAngle) * (radius+random(-yoff, yoff));

      pos.add(new Letter(newStr.charAt(i), x, y, charAngle));

      charArcLength += tw/2;
    }
  }

  void drawCurve() {
    push();
    stroke(col);
    beginShape();
    curveVertex(pos.get(0).x, pos.get(0).y);
    for (int i = 0; i < newStr.length(); i++) {
      curveVertex(pos.get(i).x, pos.get(i).y);
    }
    curveVertex(pos.get(pos.size()-1).x, pos.get(pos.size()-1).y);
    endShape();
    pop();
  }

  void drawText() {
    for (int i = 0; i < pos.size(); i++) {
      push();
      fill(bgCol);
      translate(pos.get(i).x, pos.get(i).y);
      rotate(pos.get(i).angle+PI/2);
      text(pos.get(i).c, 0, 0);
      pop();
    }
  }

  void updatePoints() {
    for (Letter c : pos) {
      c.update();
    }
  }

  void printError(String message) {
    System.err.println("TextCurve Error: " + message);
  }
}
