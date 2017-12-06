/**
 * How many steps does it take to reach the exit?
 */

var JUMPS = [
        1,1,0,-1,-3,0,-5,-1,2,0,-1,-3,-9,-5,-1,-9,2,2,-13,-7,-13,-18,0,0,-21,
        -10,-2,-12,-18,-4,-27,-24,-16,-10,-24,-12,-5,-31,-17,-10,-22,-16,-3,
        -10,-5,-37,-16,-4,-8,-1,-44,-12,-38,-42,-27,-9,-52,-13,-12,-36,-26,
        2,-48,-2,-3,-17,1,-51,-47,-68,-42,0,-53,-47,-34,-17,-15,-10,-76,
        -53,-58,-24,-62,-78,-11,-5,-71,-52,-41,-84,-57,-63,-88,-11,-61,-55,-85,
        -61,-87,-57,-46,-94,-19,-31,-84,-60,-7,-31,-25,-90,-108,-79,-25,-41,-96,
        -88,-3,-67,-91,-28,-19,-103,-88,-70,-18,-64,-59,-49,-88,-110,-83,-68,-17,
        -61,-33,-88,-29,-56,-78,-20,-108,-45,-46,-51,-59,-1,-92,-40,-101,-131,-141,
        -59,-35,-26,-14,-22,-52,-108,-47,-70,0,-125,-88,-15,-80,-71,-23,-125,-54,
        -100,-155,-105,-114,-151,-97,-9,-69,-88,-31,-165,-45,-146,-101,-155,-75,-60,-98,
        -90,-125,-19,-97,-166,-12,-55,-99,-86,-42,-111,-189,-134,-36,-3,-103,-10,-32,
        -135,-66,1,-37,-170,-194,-60,-99,-211,-68,-73,-107,-102,0,-11,-110,-202,-136,
        -222,-82,-137,-11,-121,-47,-49,-115,-7,-208,-102,-86,-176,-84,-107,-133,-17,-71,
        -103,-112,-184,-104,-22,-129,-223,-63,-11,-199,-142,-245,-157,-125,-160,-111,-209,-229,
        -88,-233,-137,-149,-204,-223,-93,-198,-123,-167,-250,-166,-234,-114,-1,-265,-144,-86,
        -65,-32,-131,2,-156,-217,-199,-27,-134,-112,-12,-39,-17,-223,-117,-44,-102,-201,
        -21,-156,-8,-5,-266,-133,-63,-279,-296,-92,-154,-100,-10,-123,-293,-66,-142,-128,
        -28,-175,-166,-70,-203,-38,-61,-50,-10,-25,-89,-98,-233,-39,-295,-105,-29,-36,
        -98,-67,-92,-229,-173,-216,-78,-331,-319,-296,-112,-151,-212,-65,-124,-33,-310,-11,
        -22,-32,-227,-23,-2,-208,-165,-217,-22,-207,-203,-277,-49,-342,-23,-148,-191,-42,
        -348,-90,-161,-190,-93,-337,-329,-276,-285,-327,-134,-366,-132,-310,-93,-244,-306,-197,
        -77,-353,-80,-337,-369,-353,-2,-330,0,-212,-167,-318,-61,-272,-369,-51,-294,-363,
        -92,-260,-146,0,-351,-154,-194,-30,-74,-155,-226,-21,-316,-20,-326,-105,-311,-232,
        -223,-250,-35,-308,-14,-93,-17,-422,-354,-377,-283,-413,-19,-245,-152,-179,-173,-97,
        0,-406,-176,-97,-402,-76,-236,-444,-233,-38,-33,-362,-190,-15,-267,-163,-240,-272,
        -449,-163,-415,-416,-1,-12,-103,-150,-238,-464,-461,-351,-64,-198,-318,-246,-157,-449,
        -401,-39,-382,-269,-389,-209,-241,-177,-156,-157,-141,-190,-470,-422,-447,-111,-463,-400,
        -334,-323,-188,-249,-380,-141,-120,-391,-311,-26,-460,-438,-18,-127,-133,-201,-429,-391,
        -99,0,-335,-373,-367,-463,-224,-390,-299,-233,-411,-244,-5,-73,-377,-413,-172,-497,
        -120,-87,-262,-198,-112,-162,-446,-469,-111,-364,-284,-252,-212,-358,-507,-48,-74,-96,
        -518,-34,-290,-234,-472,-294,-5,-334,-355,-462,-334,-494,-549,-121,-482,-548,-14,-340,
        -410,-441,-559,-282,-384,-88,-453,-323,-465,-483,-2,-481,-333,-483,-176,-250,-167,-312,
        -550,-185,-365,-108,-17,-326,-488,-440,-122,-505,-465,-54,-241,-20,-397,-48,-44,-187,
        -548,-174,-461,-238,-581,-409,-582,-140,-191,-60,-147,-538,-5,-116,-62,-165,-334,0,
        -578,-264,-396,-589,-354,-276,-283,-238,-616,-202,-59,-529,-346,-196,-247,-247,-622,-523,
        -65,-525,-563,-210,-211,-569,-340,-391,-211,-324,-515,-234,-241,-576,-478,-392,-307,-202,
        -648,-485,-460,-22,-42,-383,-440,-378,-340,-303,-167,-608,-92,-167,-217,-355,-126,-669,
        -576,-7,-568,-526,-577,-163,-566,-561,-217,-413,-275,-225,-472,-626,-667,-21,-179,-299,
        -204,-73,-172,-8,-373,-344,-551,-487,0,-154,-658,-145,-428,-589,-116,-266,-174,-109,
        -148,-471,-120,-623,-455,-257,-486,-677,-51,-63,-531,-326,-180,-321,-460,-652,-542,-225,
        -574,-362,-195,-422,-200,-479,-302,-573,-652,-543,-77,-202,-96,-265,-717,-715,-587,-710,
        -135,-263,-61,-197,-426,-10,-675,-465,-58,-525,-432,-348,-378,-474,-22,-497,-438,-612,
        -67,-235,-255,-236,-566,-386,-604,-366,-16,-105,-713,-697,-138,-743,-405,-744,-168,-754,
        -627,-201,-38,-121,-252,-240,-756,-350,-678,-507,-780,-647,-136,-644,-404,-722,-680,-326,
        -421,-105,-792,-407,-672,-179,-250,-59,-761,-775,-103,-779,-682,-278,-689,-735,-738,-498,
        -28,-484,-36,-482,-310,-397,-437,-229,-744,-699,-470,-371,-115,-766,-147,-182,-646,-540,
        -40,-202,-322,-289,-828,-784,-121,-366,-220,-36,-646,-567,-301,-168,-26,-190,-138,-390,
        -130,-448,-242,-274,-65,-784,-319,-179,-332,-327,-698,-837,-691,-113,-251,-143,-755,-791,
        -725,-849,-194,-570,-449,-186,-354,-524,-54,-846,-516,-325,-515,-453,-703,-530,-1,-869,
        -401,-503,-641,-822,-694,-667,-537,-285,-711,-73,-746,-764,-737,-475,-476,-456,-845,-556,
        -737,-524,-869,-646,-898,-692,-97,-248,-32,-884,-486,-113,-348,-517,-417,-39,-726,-580,
        0,-858,-370,-672,-726,-599,-475,-87,-336,-384,-619,2,-235,-629,-774,-905,-727,-232,
        -389,-626,-240,-780,-392,-900,-911,-592,-625,-424,-274,-231,-327,-714,-729,-537,-526,-8,
        -468,-809,-566,-786,-798,-245,-958,-652,-610,-703,-207,-727,-930,-883,-959,-204,-976,-568,
        -121,-503,-910,-134,-619,-558,-340,-24,-16,-780,-797,-594,-441,-886,-420,-639,-979,-711,
        -745,-916,-152,-700,-116,-523,0,-756,-194,-609,-151,-14,-133,-768,-630,-917,-46,-60,
        -485,-201,-440,-386,-101,-283,-980,-144,-337,-599,-202,-776,-470,-49,-278,-270,-21,-409,
        -84,-562,-191,-53,-390,-300,-706,-284,-778,-714,-632,-702,-375,-903,-1019,-475,-353,-950,
        -410];

main(List<String> arguments) {
  int programCounter = 0;
  int maxLen = JUMPS.length - 1;
  int steps = 1;

  // While still inside the program space
  bool finished = false;
  while (!finished) {
    // get jump
    int jump = JUMPS[programCounter];

    // Increment jump
    JUMPS[programCounter] = jump + 1;

    programCounter += jump;

    finished = programCounter < 0 || programCounter > maxLen;

    if (!finished) {
      steps++;
    }
  }

  print('Program Counter: $programCounter, Steps: $steps');
}
