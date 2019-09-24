// A simple tab to help with recording

void screenshot() {
  save("data/img/img_" + str(round(random(1000, 9999))) + ".png");
}

boolean recording = false;
int framesToSave = 1000;

void record() {
  if ( recording ) {
    saveFrame("data/movie/img#####.tif");
    if ( framesToSave <= 0 ) {
      exit();
    }
    --framesToSave;
  }
}
