/**
  Copyright (C) 2012-2022 by Autodesk, Inc.
  All rights reserved.

  HAAS post processor configuration.

  $Revision: 44021 01c96fb7b052896b517cbbe46c5314505d9f4cfc $
  $Date: 2025-03-28 19:37:00 $

  FORKID {241E0993-8BE0-463b-8888-47968B9D7F9F}
*/
VSCODE_DEBUGGING = false;  // set to true for debugging

if (VSCODE_DEBUGGING) {
  programComment = "Using tool T10"
}
description = "HAAS (pre-NGC)";
vendor = "Haas Automation";
vendorUrl = "https://www.haascnc.com";
legal = "Copyright (C) 2012-2022 by Autodesk, Inc.";
certificationLevel = 2;
minimumRevision = 45821;

longDescription = "Generic post for use with all common HAAS mills like the DM, VF, Office Mill, and Mini Mill series. This post is for the pre-Next Generation Control. By default positioning moves will be output as high feed G1s instead of G0s. You can turn on the property 'useG0' to force G0s but be careful as the CNC will follow a dogleg path rather than a direct path.";

extension = "nc";
programNameIsInteger = true;
setCodePage("ascii");

capabilities = CAPABILITY_TURNING | CAPABILITY_MACHINE_SIMULATION;
tolerance = spatial(0.002, MM);

minimumChordLength = spatial(0.25, MM);
minimumCircularRadius = spatial(0.01, MM);
maximumCircularRadius = spatial(1000, MM);
minimumCircularSweep = toRad(0.01);
maximumCircularSweep = toRad(355);
allowHelicalMoves = true;
allowedCircularPlanes = undefined; // allow any circular motion
allowSpiralMoves = true;
highFeedrate = (unit == IN) ? 500 : 5000;

// user-defined properties
properties = {
  writeMachine: {
    title: "Write machine",
    description: "Output the machine settings in the header of the code.",
    group: "formats",
    type: "boolean",
    value: true,
    scope: "post"
  },
  writeTools: {
    title: "Write tool list",
    description: "Output a tool list in the header of the code.",
    group: "formats",
    type: "boolean",
    value: true,
    scope: "post"
  },
  writeVersion: {
    title: "Write version",
    description: "Write the version number in the header of the code.",
    group: "formats",
    type: "boolean",
    value: true, //false,
    scope: "post"
  },
  preloadTool: {
    title: "Preload tool",
    description: "Preloads the next tool at a tool change (if any).",
    group: "preferences",
    type: "boolean",
    value: true,
    scope: "post"
  },
  gotChipConveyor: {
    title: "Use chip transport",
    description: "Enable to turn on chip transport at start of program.",
    group: "configuration",
    type: "boolean",
    value: false,
    scope: "post"
  },
  showSequenceNumbers: {
    title: "Use sequence numbers",
    description: "'Yes' outputs sequence numbers on each block, 'Only on tool change' outputs sequence numbers on tool change blocks only, and 'No' disables the output of sequence numbers.",
    group: "formats",
    type: "enum",
    values: [
      { title: "Yes", id: "true" },
      { title: "No", id: "false" },
      { title: "Only on tool change", id: "toolChange" }
    ],
    value: "true",
    scope: "post"
  },
  sequenceNumberStart: {
    title: "Start sequence number",
    description: "The number at which to start the sequence numbers.",
    group: "formats",
    type: "integer",
    value: 10,
    scope: "post"
  },
  sequenceNumberIncrement: {
    title: "Sequence number increment",
    description: "The amount by which the sequence number is incremented by in each block.",
    group: "formats",
    type: "integer",
    value: 5,
    scope: "post"
  },
  optionalStop: {
    title: "Optional stop",
    description: "Specifies that optional stops M1 should be output at tool changes.",
    group: "preferences",
    type: "boolean",
    value: true,
    scope: "post"
  },
  separateWordsWithSpace: {
    title: "Separate words with space",
    description: "Adds spaces between words if 'yes' is selected.",
    group: "formats",
    type: "boolean",
    value: true,
    scope: "post"
  },
  useRadius: {
    title: "Radius arcs",
    description: "If yes is selected, arcs are output using radius values rather than IJK.",
    group: "preferences",
    type: "boolean",
    value: false,
    scope: "post"
  },
  useParametricFeed: {
    title: "Parametric feed",
    description: "Parametric feed values based on movement type are output.",
    group: "preferences",
    type: "boolean",
    value: false,
    scope: "post"
  },
  showNotes: {
    title: "Show notes",
    description: "Enable to output notes for operations.",
    group: "formats",
    type: "boolean",
    value: true,  // false,
    scope: "post"
  },
  useG0: {
    title: "Use G0",
    description: "Specifies that G0s should be used for rapid moves when moving along a single axis.",
    group: "preferences",
    type: "boolean",
    value: true, // false
    scope: "post"
  },
  safePositionMethod: {
    title: "Safe Retracts",
    description: "Select your desired retract option. 'Clearance Height' retracts to the operation clearance height.",
    group: "homePositions",
    type: "enum",
    values: [
      { title: "G28", id: "G28" },
      { title: "G53", id: "G53" },
      { title: "Clearance Height", id: "clearanceHeight" }
    ],
    value: "G53",
    scope: "post"
  },
  useSubroutines: {
    title: "Use subroutines",
    description: "Select your desired subroutine option. 'All Operations' creates subroutines per each operation, 'Cycles' creates subroutines for cycle operations on same holes, and 'Patterns' creates subroutines for patterned operations.",
    group: "preferences",
    type: "enum",
    values: [
      { title: "No", id: "none" },
      { title: "All Operations", id: "allOperations" },
      { title: "Cycles", id: "cycles" },
      { title: "Patterns", id: "patterns" }
    ],
    value: "none",
    scope: "post"
  },
  useSmoothing: {
    title: "Use G187",
    description: "G187 smoothing mode.",
    group: "preferences",
    type: "enum",
    values: [
      { title: "Off", id: "-1" },
      { title: "Automatic", id: "9999" },
      { title: "Rough", id: "1" },
      { title: "Medium", id: "2" },
      { title: "Finish", id: "3" }
    ],
    value: "-1",
    scope: "post"
  },
  homePositionCenter: {
    title: "Home position center",
    description: "Enable to center the part along X at the end of program for easy access. Requires a CNC with a moving table.",
    group: "homePositions",
    type: "boolean",
    value: true,
    scope: "post"
  },
  optionallyCycleToolsAtStart: {
    title: "Optionally cycle tools at start",
    description: "Cycle through each tool used at the beginning of the program when block delete is turned off.",
    group: "preferences",
    type: "boolean",
    value: false,
    scope: "post"
  },
  measureTools: {
    title: "Optionally measure tools at start",
    description: "Measure each tool used at the beginning of the program when block delete is turned off.",
    group: "preferences",
    type: "boolean",
    value: false,
    scope: "post"
  },
  toolBreakageTolerance: {
    title: "Tool breakage tolerance",
    description: "Specifies the tolerance for which tool break detection will raise an alarm.",
    group: "preferences",
    type: "spatial",
    value: 0.1,
    scope: "post"
  },
  safeStartAllOperations: {
    title: "Safe start all operations",
    description: "Write optional blocks at the beginning of all operations that include all commands to start program.",
    group: "preferences",
    type: "boolean",
    value: false,
    scope: "post"
  },
  fastToolChange: {
    title: "Fast tool change",
    description: "Skip spindle off, coolant off, and Z retract to make tool change quicker.",
    group: "preferences",
    type: "boolean",
    value: false,
    scope: "post"
  },
  useG95forTapping: {
    title: "Use G95 for tapping",
    description: "use IPR/MPR instead of IPM/MPM for tapping",
    group: "preferences",
    type: "boolean",
    value: false,
    scope: "post"
  },
  useG73Retract: {
    title: "G73 cycles include accumulated depth",
    description: "Use G73 Q K format for accumulated depth support.",
    group: "preferences",
    type: "boolean",
    value: false,
    scope: "post"
  },
  setting34: {
    title: "Feed rate calculation diameter",
    description: "Defines the part diameter in inches that the control uses to calculate feed rates (Setting 34).",
    group: "multiAxis",
    type: "spatial",
    range: [0.1, 9999],
    value: 1,
    scope: "post"
  },
  singleResultsFile: {
    title: "Create single results file",
    description: "Set to false if you want to store the measurement results for each probe / inspection toolpath in a separate file",
    group: "probing",
    type: "boolean",
    value: true,
    scope: "post"
  },
  useClampCodes: {
    title: "Use clamp codes",
    description: "Specifies whether clamp codes for rotary axes should be output. For simultaneous toolpaths rotary axes will always get unclamped.",
    group: "multiAxis",
    type: "boolean",
    value: false, //true,
    scope: "post"
  },
  useMultiAxisFeatures: {
    title: "Use DWO",
    description: "Specifies that the Dynamic Work Offset feature (G254/G255) should be used.",
    group: "multiAxis",
    type: "boolean",
    value: false,
    scope: "post"
  },
  programmableCoolant: {
    title: "Programmable coolant",
    description: "Enable if the machine has the programmable coolant option and requires the coolant to be enabled after tool length compensation is enabled.",
    group: "preferences",
    type: "boolean",
    value: false,
    scope: "post"
  }
};

// wcs definiton
wcsDefinitions = {
  useZeroOffset: false,
  wcs: [
    { name: "Standard", format: "G", range: [54, 59] },
    { name: "Extended", format: "G154 P", range: [1, 99] }
  ]
};

// tool offset for the singular chuck tool
var lengthOffset = -1;

var singleLineCoolant = false; // specifies to output multiple coolant codes in one line rather than in separate lines
// samples:
// {id: COOLANT_THROUGH_TOOL, on: 88, off: 89}
// {id: COOLANT_THROUGH_TOOL, on: [8, 88], off: [9, 89]}
// {id: COOLANT_THROUGH_TOOL, on: "M88 P3 (myComment)", off: "M89"}
var coolants = [
  { id: COOLANT_FLOOD, on: 8 },
  { id: COOLANT_MIST },
  { id: COOLANT_THROUGH_TOOL, on: 88, off: 89 },
  { id: COOLANT_AIR, on: 83, off: 84 },
  { id: COOLANT_AIR_THROUGH_TOOL, on: 73, off: 74 },
  { id: COOLANT_SUCTION },
  { id: COOLANT_FLOOD_MIST },
  { id: COOLANT_FLOOD_THROUGH_TOOL, on: [88, 8], off: [89, 9] },
  { id: COOLANT_OFF, off: 9 }
];

// old machines only support 4 digits
var oFormat = createFormat({ width: 5, zeropad: true, decimals: 0 });
var nFormat = createFormat({ decimals: 0 });

var gFormat = createFormat({ prefix: "G", decimals: 0 });
var mFormat = createFormat({ prefix: "M", decimals: 0 });
var hFormat = createFormat({ prefix: "H", decimals: 0 });
var dFormat = createFormat({ prefix: "D", decimals: 0 });
var probeWCSFormat = createFormat({ prefix: "S", decimals: 0, forceDecimal: true });
var probeExtWCSFormat = createFormat({ prefix: "S154.", width: 2, zeropad: true, decimals: 0 });

var xyzFormat = createFormat({ decimals: (unit == MM ? 3 : 4), forceDecimal: true });
var rFormat = xyzFormat; // radius
var abcFormat = createFormat({ decimals: 3, forceDecimal: true, scale: DEG });
var feedFormat = createFormat({ decimals: (unit == MM ? 2 : 3), forceDecimal: true });
var inverseTimeFormat = createFormat({ decimals: 3, forceDecimal: true });
var pitchFormat = createFormat({ decimals: (unit == MM ? 3 : 4), forceDecimal: true });
var toolFormat = createFormat({ decimals: 0 });
var rpmFormat = createFormat({ decimals: 0 });
var secFormat = createFormat({ decimals: 3, forceDecimal: true }); // seconds - range 0.001-1000
var milliFormat = createFormat({ decimals: 0 }); // milliseconds // range 1-9999
var taperFormat = createFormat({ decimals: 1, scale: DEG });

var xOutput = createVariable({ prefix: "X" }, xyzFormat);
var yOutput = createVariable({ prefix: "Y" }, xyzFormat);
var zOutput = createVariable({ onchange: function () { retracted = false; }, prefix: "Z" }, xyzFormat);
var aOutput = createVariable({ prefix: "A" }, abcFormat);
var bOutput = createVariable({ prefix: "B" }, abcFormat);
var cOutput = createVariable({ prefix: "C" }, abcFormat);
var feedOutput = createVariable({ prefix: "F" }, feedFormat);
var inverseTimeOutput = createVariable({ prefix: "F", force: true }, inverseTimeFormat);
var pitchOutput = createVariable({ prefix: "F", force: true }, pitchFormat);
var sOutput = createVariable({ prefix: "S", force: true }, rpmFormat);
var dOutput = createVariable({}, dFormat);

// circular output
var iOutput = createReferenceVariable({ prefix: "I", force: true }, xyzFormat);
var jOutput = createReferenceVariable({ prefix: "J", force: true }, xyzFormat);
var kOutput = createReferenceVariable({ prefix: "K", force: true }, xyzFormat);

var gMotionModal = createModal({}, gFormat); // modal group 1 // G0-G3, ...
var gPlaneModal = createModal({ onchange: function () { gMotionModal.reset(); } }, gFormat); // modal group 2 // G17-19
var gAbsIncModal = createModal({}, gFormat); // modal group 3 // G90-91
var gFeedModeModal = createModal({}, gFormat); // modal group 5 // G93-94
var gUnitModal = createModal({}, gFormat); // modal group 6 // G20-21
var gCycleModal = createModal({}, gFormat); // modal group 9 // G81, ...
var gRetractModal = createModal({ force: true }, gFormat); // modal group 10 // G98-99
var gRotationModal = createModal({
  onchange: function () {
    if (probeVariables.probeAngleMethod == "G68") {
      probeVariables.outputRotationCodes = true;
    }
  }
}, gFormat); // modal group 16 // G68-G69
var mClampModal = createModalGroup(
  { strict: false },
  [
    [10, 11], // 4th axis clamp / unclamp
    [12, 13] // 5th axis clamp / unclamp
  ],
  mFormat
);

// fixed settings
var firstFeedParameter = 100; // the first variable to use with parametric feed
var forceResetWorkPlane = false; // enable to force reset of machine ABC on new orientation
var minimumCyclePoints = 5; // minimum number of points in cycle operation to consider for subprogram
var useDwoForPositioning = true; // specifies to use the DWO feature for XY positioning for multi-axis operations

var allowIndexingWCSProbing = false; // specifies that probe WCS with tool orientation is supported
var probeVariables = {
  outputRotationCodes: false, // defines if it is required to output rotation codes
  probeAngleMethod: "OFF", // OFF, AXIS_ROT, G68, G54.4
  compensationXY: undefined,
  rotationalAxis: -1
};

var SUB_UNKNOWN = 0;
var SUB_PATTERN = 1;
var SUB_CYCLE = 2;

// collected state
var sequenceNumber;
var currentWorkOffset;
var optionalSection = false;
var forceSpindleSpeed = false;
var forceCoolant = false;
var activeMovements; // do not use by default
var currentFeedId;
var maximumCircularRadiiDifference = toPreciseUnit(0.005, MM);
var maximumLineLength = 80; // the maximum number of charaters allowed in a line
var subprograms = [];
var currentPattern = -1;
var firstPattern = false;
var currentSubprogram;
var lastSubprogram;
var initialSubprogramNumber = 90000;
var definedPatterns = new Array();
var incrementalMode = false;
var saveShowSequenceNumbers;
var cycleSubprogramIsActive = false;
var patternIsActive = false;
var lastOperationComment = "";
var incrementalSubprogram;
var retracted = false; // specifies that the tool has been retracted to the safe plane
var measureTool = false;
probeMultipleFeatures = true;
var homePositionCenter = false;

// used to convert blocks to optional for safeStartAllOperations, might get used outside of onSection
var operationNeedsSafeStart = false;

/**
  Writes the specified block.
*/
var skipBlock = false;
function writeBlock() {
  var text = formatWords(arguments);
  if (!text) {
    return;
  }
  var maximumSequenceNumber = ((getProperty("useSubroutines") == "allOperations") || (getProperty("useSubroutines") == "patterns") ||
    (getProperty("useSubroutines") == "cycles")) ? initialSubprogramNumber : 99999;
  if (getProperty("showSequenceNumbers") == "true") {
    if (sequenceNumber >= maximumSequenceNumber) {
      sequenceNumber = getProperty("sequenceNumberStart");
    }
    if (optionalSection || skipBlock) {
      if (text) {
        writeWords("/", "N" + sequenceNumber, text);
      }
    } else {
      writeWords2("N" + sequenceNumber, arguments);
    }
    sequenceNumber += getProperty("sequenceNumberIncrement");
  } else {
    if (optionalSection || skipBlock) {
      writeWords2("/", arguments);
    } else {
      writeWords(arguments);
    }
  }
  skipBlock = false;
}

/**
  Writes the specified block - used for tool changes only.
*/
function writeToolBlock() {
  var show = getProperty("showSequenceNumbers");
  setProperty("showSequenceNumbers", (show == "true" || show == "toolChange") ? "true" : "false");
  writeBlock(arguments);
  setProperty("showSequenceNumbers", show);
}

/**
  Writes the specified optional block.
*/
function writeOptionalBlock() {
  skipBlock = true;
  writeBlock(arguments);
}

function formatComment(text) {
  return "(" + String(text).replace(/[()]/g, "") + ")";
}

/**
  Output a comment.
*/
function writeComment(text) {
  writeln(formatComment(text.substr(0, maximumLineLength - 2)));
}

/**
  Returns the matching HAAS tool type for the tool.
*/
function getHaasToolType(toolType) {
  switch (toolType) {
    case TOOL_DRILL:
    case TOOL_REAMER:
      return 1; // drill
    case TOOL_TAP_RIGHT_HAND:
    case TOOL_TAP_LEFT_HAND:
      return 2; // tap
    case TOOL_MILLING_FACE:
    case TOOL_MILLING_SLOT:
    case TOOL_BORING_BAR:
      return 3; // shell mill
    case TOOL_MILLING_END_FLAT:
    case TOOL_MILLING_END_BULLNOSE:
    case TOOL_MILLING_TAPERED:
    case TOOL_MILLING_DOVETAIL:
      return 4; // end mill
    case TOOL_DRILL_SPOT:
    case TOOL_MILLING_CHAMFER:
    case TOOL_DRILL_CENTER:
    case TOOL_COUNTER_SINK:
    case TOOL_COUNTER_BORE:
    case TOOL_MILLING_THREAD:
    case TOOL_MILLING_FORM:
      return 5; // center drill
    case TOOL_MILLING_END_BALL:
    case TOOL_MILLING_LOLLIPOP:
      return 6; // ball nose
    case TOOL_PROBE:
      return 7; // probe
    default:
      error(localize("Invalid HAAS tool type."));
      return -1;
  }
}

function getHaasProbingType(toolType, use9023) {
  switch (getHaasToolType(toolType)) {
    case 3:
    case 4:
      return (use9023 ? 23 : 1); // rotate
    case 1:
    case 2:
    case 5:
    case 6:
    case 7:
      return (use9023 ? 12 : 2); // non rotate
    case 0:
      return (use9023 ? 13 : 3); // rotate length and dia
    default:
      error(localize("Invalid HAAS tool type."));
      return -1;
  }
}

function writeToolCycleBlock(tool) {
  writeOptionalBlock("T" + toolFormat.format(tool.number), mFormat.format(6)); // get tool
  writeOptionalBlock(mFormat.format(0)); // wait for operator
}

function prepareForToolCheck() {
  onCommand(COMMAND_STOP_SPINDLE);
  onCommand(COMMAND_COOLANT_OFF);

  // cancel TCP so that tool doesn't follow tables
  if (currentSection.isMultiAxis() && operationSupportsTCP) {
    disableLengthCompensation(false, "TCPC OFF");
  }
  if (getCurrentDirection().length != 0) {
    setWorkPlane(new Vector(0, 0, 0));
    forceWorkPlane();
  }
}

function writeToolMeasureBlock(tool, preMeasure) {
  var writeFunction = measureTool ? writeBlock : writeOptionalBlock;
  var comment = measureTool ? formatComment("MEASURE TOOL") : "";

  if (!preMeasure) {
    prepareForToolCheck();
  }
  if (true) { // use Macro P9023 to measure tools
    var probingType = getHaasProbingType(tool.type, true);
    writeFunction(
      gFormat.format(65),
      "P9023",
      "A" + probingType + ".",
      "T" + toolFormat.format(tool.number),
      conditional((probingType != 12), "H" + xyzFormat.format(getBodyLength(tool))),
      conditional((probingType != 12), "D" + xyzFormat.format(tool.diameter)),
      comment
    );
  } else { // use Macro P9995 to measure tools
    writeFunction("T" + toolFormat.format(tool.number), mFormat.format(6)); // get tool
    writeFunction(
      gFormat.format(65),
      "P9995",
      "A0.",
      "B" + getHaasToolType(tool.type) + ".",
      "C" + getHaasProbingType(tool.type, false) + ".",
      "T" + toolFormat.format(tool.number),
      "E" + xyzFormat.format(getBodyLength(tool)),
      "D" + xyzFormat.format(tool.diameter),
      "K" + xyzFormat.format(0.1),
      "I0.",
      comment
    ); // probe tool
  }
  measureTool = false;
}

// Start of machine configuration logic
var compensateToolLength = false; // add the tool length to the pivot distance for nonTCP rotary heads
// internal variables, do not change
var receivedMachineConfiguration;
var operationSupportsTCP;
var multiAxisFeedrate;

function activateMachine() {
  // disable unsupported rotary axes output
  if (!machineConfiguration.isMachineCoordinate(0) && (typeof aOutput != "undefined")) {
    aOutput.disable();
  }
  if (!machineConfiguration.isMachineCoordinate(1) && (typeof bOutput != "undefined")) {
    bOutput.disable();
  }
  if (!machineConfiguration.isMachineCoordinate(2) && (typeof cOutput != "undefined")) {
    cOutput.disable();
  }

  // setup usage of multiAxisFeatures
  useMultiAxisFeatures = getProperty("useMultiAxisFeatures") != undefined ? getProperty("useMultiAxisFeatures") :
    (typeof useMultiAxisFeatures != "undefined" ? useMultiAxisFeatures : false);
  useABCPrepositioning = getProperty("useABCPrepositioning") != undefined ? getProperty("useABCPrepositioning") :
    (typeof useABCPrepositioning != "undefined" ? useABCPrepositioning : false);

  // don't need to modify any settings if 3-axis machine
  if (!machineConfiguration.isMultiAxisConfiguration()) {
    return;
  }

  // save multi-axis feedrate settings from machine configuration
  var mode = machineConfiguration.getMultiAxisFeedrateMode();
  var type = mode == FEED_INVERSE_TIME ? machineConfiguration.getMultiAxisFeedrateInverseTimeUnits() :
    (mode == FEED_DPM ? machineConfiguration.getMultiAxisFeedrateDPMType() : DPM_STANDARD);
  multiAxisFeedrate = {
    mode: mode,
    maximum: machineConfiguration.getMultiAxisFeedrateMaximum(),
    type: type,
    tolerance: mode == FEED_DPM ? machineConfiguration.getMultiAxisFeedrateOutputTolerance() : 0,
    bpwRatio: mode == FEED_DPM ? machineConfiguration.getMultiAxisFeedrateBpwRatio() : 1
  };

  // setup of retract/reconfigure  TAG: Only needed until post kernel supports these machine config settings
  if (receivedMachineConfiguration && machineConfiguration.performRewinds()) {
    safeRetractDistance = machineConfiguration.getSafeRetractDistance();
    safePlungeFeed = machineConfiguration.getSafePlungeFeedrate();
    safeRetractFeed = machineConfiguration.getSafeRetractFeedrate();
  }
  if (typeof safeRetractDistance == "number" && getProperty("safeRetractDistance") != undefined && getProperty("safeRetractDistance") != 0) {
    safeRetractDistance = getProperty("safeRetractDistance");
  }

  // setup for head configurations
  if (machineConfiguration.isHeadConfiguration()) {
    compensateToolLength = typeof compensateToolLength == "undefined" ? false : compensateToolLength;
  }

  // calculate the ABC angles and adjust the points for multi-axis operations
  // rotary heads may require the tool length be added to the pivot length
  // so we need to optimize each section individually
  if (machineConfiguration.isHeadConfiguration() && compensateToolLength) {
    for (var i = 0; i < getNumberOfSections(); ++i) {
      var section = getSection(i);
      if (section.isMultiAxis()) {
        machineConfiguration.setToolLength(getBodyLength(section.getTool())); // define the tool length for head adjustments
        section.optimizeMachineAnglesByMachine(machineConfiguration, OPTIMIZE_AXIS);
      }
    }
  } else { // tables and rotary heads with TCP support can be optimized with a single call
    optimizeMachineAngles2(OPTIMIZE_AXIS);
  }
}

function getBodyLength(tool) {
  for (var i = 0; i < getNumberOfSections(); ++i) {
    var section = getSection(i);
    if (tool.number == section.getTool().number) {
      return section.getParameter("operation:tool_overallLength", tool.bodyLength + tool.holderLength);
    }
  }
  return tool.bodyLength + tool.holderLength;
}

function defineMachine() {
  var useTCP = false;
  if (false) { // note: setup your machine here
    // using 0 instead of -35 to avoid rewind issues
    var bAxis = createAxis({ coordinate: 1, table: true, axis: [0, 1, 0], range: [0 - 0.0001, 110 + 0.0001], preference: 1, reset: 1, tcp: true });
    var cAxis = createAxis({ coordinate: 2, table: true, axis: [0, 0, 1], cyclic: false, range: [-13320, 13320], preference: 0, reset: 1, tcp: true });
    machineConfiguration = new MachineConfiguration(bAxis, cAxis);

    setMachineConfiguration(machineConfiguration);
    if (receivedMachineConfiguration) {
      warning(localize("The provided CAM machine configuration is overwritten by the postprocessor."));
      receivedMachineConfiguration = false; // CAM provided machine configuration is overwritten
    }
  }

  if (!receivedMachineConfiguration) {
    // multiaxis settings
    if (machineConfiguration.isHeadConfiguration()) {
      machineConfiguration.setVirtualTooltip(false); // translate the pivot point to the virtual tool tip for nonTCP rotary heads
    }

    // retract / reconfigure
    var performRewinds = false; // set to true to enable the rewind/reconfigure logic
    if (performRewinds) {
      machineConfiguration.enableMachineRewinds(); // enables the retract/reconfigure logic
      safeRetractDistance = (unit == IN) ? 1 : 25; // additional distance to retract out of stock, can be overridden with a property
      safeRetractFeed = (unit == IN) ? 20 : 500; // retract feed rate
      safePlungeFeed = (unit == IN) ? 10 : 250; // plunge feed rate
      machineConfiguration.setSafeRetractDistance(safeRetractDistance);
      machineConfiguration.setSafeRetractFeedrate(safeRetractFeed);
      machineConfiguration.setSafePlungeFeedrate(safePlungeFeed);
      var stockExpansion = new Vector(toPreciseUnit(0.1, IN), toPreciseUnit(0.1, IN), toPreciseUnit(0.1, IN)); // expand stock XYZ values
      machineConfiguration.setRewindStockExpansion(stockExpansion);
    }

    // multi-axis feedrates
    if (machineConfiguration.isMultiAxisConfiguration()) {
      var useDPMFeeds = false;
      machineConfiguration.setMultiAxisFeedrate(
        useTCP ? FEED_FPM : useDPMFeeds ? FEED_FPM : FEED_INVERSE_TIME,
        9999.99, // maximum output value for inverse time feed rates
        useDPMFeeds ? DPM_COMBINATION : INVERSE_MINUTES, // INVERSE_MINUTES/INVERSE_SECONDS or DPM_COMBINATION/DPM_STANDARD
        0.5, // tolerance to determine when the DPM feed has changed
        1.0 // ratio of rotary accuracy to linear accuracy for DPM calculations
      );
      setMachineConfiguration(machineConfiguration);
    }

    /* home positions */
    // machineConfiguration.setHomePositionX(toPreciseUnit(-29.0, IN));
    // machineConfiguration.setHomePositionY(toPreciseUnit(-8, IN));
    // machineConfiguration.setRetractPlane(toPreciseUnit(2.5, IN));
  }
}
// End of machine configuration logic

function onOpen() {
  receivedMachineConfiguration = machineConfiguration.isReceived();
  if (typeof defineMachine == "function") {
    defineMachine(); // hardcoded machine configuration
  }
  activateMachine(); // enable the machine optimizations and settings

  if (getProperty("useRadius")) {
    maximumCircularSweep = toRad(90); // avoid potential center calculation errors for CNC
  }
  if (!getProperty("useMultiAxisFeatures")) {
    useDwoForPositioning = false;
  }
  if (getProperty("useLiveConnection")) {
    if (getProperty("showSequenceNumbers")) {
      warning(localize("'Use sequence numbers' is switched off due to live connection."));
    }
    setProperty("showSequenceNumbers", "false");
  }

  gRotationModal.format(69); // Default to G69 Rotation Off
  mClampModal.format(10); // Default 4th axis modal code to be clamped
  mClampModal.format(12); // Default 5th axis modal code to be clamped

  if (highFeedrate <= 0) {
    error(localize("You must set 'highFeedrate' because axes are not synchronized for rapid traversal."));
    return;
  }

  if (!getProperty("separateWordsWithSpace")) {
    setWordSeparator("");
  }
  saveShowSequenceNumbers = getProperty("showSequenceNumbers");
  sequenceNumber = getProperty("sequenceNumberStart");
  writeln("%");

  if (programName) {
    var programId;
    try {
      programId = getAsInt(programName);
    } catch (e) {
      error(localize("Program name must be a number."));
      return;
    }
    if (!((programId >= 1) && (programId <= 99999))) {
      error(localize("Program number is out of range."));
      return;
    }
    writeln(
      "O" + oFormat.format(programId) +
      conditional(programComment, " " + formatComment(programComment.substr(0, maximumLineLength - 2 - ("O" + oFormat.format(programId)).length - 1)))
    );
    lastSubprogram = (initialSubprogramNumber - 1);
  } else {
    error(localize("Program name has not been specified."));
    return;
  }
  if (getProperty("useG0")) {
    writeComment(localize("Using G0 which travels along dogleg path."));
  } else {
    writeComment(subst(localize("Using high feed G1 F%1 instead of G0."), feedFormat.format(highFeedrate)));
  }

  if (getProperty("writeVersion")) {
    if ((typeof getHeaderVersion == "function") && getHeaderVersion()) {
      writeComment(localize("post version") + ": " + getHeaderVersion());
    }
    if ((typeof getHeaderDate == "function") && getHeaderDate()) {
      writeComment(localize("post modified") + ": " + getHeaderDate());
    }
  }

  // dump machine configuration
  var vendor = machineConfiguration.getVendor();
  var model = machineConfiguration.getModel();
  var description = machineConfiguration.getDescription();

  if (getProperty("writeMachine") && (vendor || model || description)) {
    writeComment(localize("Machine"));
    if (vendor) {
      writeComment("  " + localize("vendor") + ": " + vendor);
    }
    if (model) {
      writeComment("  " + localize("model") + ": " + model);
    }
    if (description) {
      writeComment("  " + localize("description") + ": " + description);
    }
  }

  // dump tool information
  if (getProperty("writeTools")) {
    var zRanges = {};
    if (is3D()) {
      var numberOfSections = getNumberOfSections();
      for (var i = 0; i < numberOfSections; ++i) {
        var section = getSection(i);
        var zRange = section.getGlobalZRange();
        var tool = section.getTool();
        if (zRanges[tool.number]) {
          zRanges[tool.number].expandToRange(zRange);
        } else {
          zRanges[tool.number] = zRange;
        }
      }
    }

    var tools = getToolTable();
    if (tools.getNumberOfTools() > 0) {
      for (var i = 0; i < tools.getNumberOfTools(); ++i) {
        var tool = tools.getTool(i);
        var comment = "T" + toolFormat.format(tool.number) + " " +
          "D=" + xyzFormat.format(tool.diameter) + " " +
          localize("CR") + "=" + xyzFormat.format(tool.cornerRadius);
        if ((tool.taperAngle > 0) && (tool.taperAngle < Math.PI)) {
          comment += " " + localize("TAPER") + "=" + taperFormat.format(tool.taperAngle) + localize("deg");
        }
        if (zRanges[tool.number]) {
          comment += " - " + localize("ZMIN") + "=" + xyzFormat.format(zRanges[tool.number].getMinimum());
        }
        comment += " - " + getToolTypeName(tool.type);
        writeComment(comment);
      }
    }
  }

  // IG: find tool offset for tool used as turning chuck
  const tool_regex = /T(\d+)/g

  if (!programComment) {
    error(localize("Provide program comment with tool number used as chuck when running Post Process."));
  }
  length_offset_found = programComment.match(tool_regex)
  if (length_offset_found == null) {
    error(localize("Tool number not found in program comment."));
  } else if (length_offset_found.length != 1) {
    error(localize("Multiple tool numbers found in program comment."));
  } else {
    lengthOffset = Number(length_offset_found[0].substr(1))
  }

  // optionally cycle through all tools
  if (getProperty("optionallyCycleToolsAtStart") || getProperty("measureTools")) {
    var tools = getToolTable();
    if (tools.getNumberOfTools() > 0) {
      writeln("");

      writeOptionalBlock(mFormat.format(0), formatComment(localize("Read note"))); // wait for operator
      writeComment(localize("With BLOCK DELETE turned off each tool will cycle through"));
      writeComment(localize("the spindle to verify that the correct tool is in the tool magazine"));
      if (getProperty("measureTools")) {
        writeComment(localize("and to automatically measure it"));
      }
      writeComment(localize("Once the tools are verified turn BLOCK DELETE on to skip verification"));

      for (var i = 0; i < tools.getNumberOfTools(); ++i) {
        var tool = tools.getTool(i);
        if (getProperty("measureTools") && (tool.type == TOOL_PROBE)) {
          continue;
        }
        var comment = "T" + toolFormat.format(tool.number) + " " +
          "D=" + xyzFormat.format(tool.diameter) + " " +
          localize("CR") + "=" + xyzFormat.format(tool.cornerRadius);
        if ((tool.taperAngle > 0) && (tool.taperAngle < Math.PI)) {
          comment += " " + localize("TAPER") + "=" + taperFormat.format(tool.taperAngle) + localize("deg");
        }
        comment += " - " + getToolTypeName(tool.type);
        writeComment(comment);
        if (getProperty("measureTools")) {
          writeToolMeasureBlock(tool, true);
        } else {
          writeToolCycleBlock(tool);
        }
      }
    }
    writeln("");
  }

  if (false /*getProperty("useMultiAxisFeatures")*/) {
    var failed = false;
    var dynamicWCSs = {};
    for (var i = 0; i < getNumberOfSections(); ++i) {
      var section = getSection(i);
      var description = section.hasParameter("operation-comment") ? section.getParameter("operation-comment") : ("#" + (i + 1));
      if (!section.hasDynamicWorkOffset()) {
        error(subst(localize("Dynamic work offset has not been set for operation '%1'."), description));
        failed = true;
      }

      var o = section.getDynamicWCSOrigin();
      var p = section.getDynamicWCSPlane();
      if (dynamicWCSs[section.getDynamicWorkOffset()]) {
        if ((Vector.diff(o, dynamicWCSs[section.getDynamicWorkOffset()].origin).length > 1e-9) ||
          (Matrix.diff(p, dynamicWCSs[section.getDynamicWorkOffset()].plane).n1 > 1e-9)) {
          error(subst(localize("Dynamic WCS mismatch for operation '%1'."), description));
          failed = true;
        }
      } else {
        dynamicWCSs[section.getDynamicWorkOffset()] = { origin: o, plane: p };
      }
    }
    if (failed) {
      return;
    }
  }

  if (false) {
    // check for duplicate tool number
    for (var i = 0; i < getNumberOfSections(); ++i) {
      var sectioni = getSection(i);
      var tooli = sectioni.getTool();
      for (var j = i + 1; j < getNumberOfSections(); ++j) {
        var sectionj = getSection(j);
        var toolj = sectionj.getTool();
        if (tooli.number == toolj.number) {
          if (xyzFormat.areDifferent(tooli.diameter, toolj.diameter) ||
            xyzFormat.areDifferent(tooli.cornerRadius, toolj.cornerRadius) ||
            abcFormat.areDifferent(tooli.taperAngle, toolj.taperAngle) ||
            (tooli.numberOfFlutes != toolj.numberOfFlutes)) {
            error(
              subst(
                localize("Using the same tool number for different cutter geometry for operation '%1' and '%2'."),
                sectioni.hasParameter("operation-comment") ? sectioni.getParameter("operation-comment") : ("#" + (i + 1)),
                sectionj.hasParameter("operation-comment") ? sectionj.getParameter("operation-comment") : ("#" + (j + 1))
              )
            );
            return;
          }
        }
      }
    }
  }

  if ((getNumberOfSections() > 0) && (getSection(0).workOffset == 0)) {
    for (var i = 0; i < getNumberOfSections(); ++i) {
      if (getSection(i).workOffset > 0) {
        error(localize("Using multiple work offsets is not possible if the initial work offset is 0."));
        return;
      }
    }
  }

  // absolute coordinates and feed per min
  writeBlock(gAbsIncModal.format(90), gPlaneModal.format(18));  // IG change from XY -> XZ plane
  gFeedModeModal.format(94); // G94 is an option on pre-NGC controls and can generate an error

  switch (unit) {
    case IN:
      writeBlock(gUnitModal.format(20));
      break;
    case MM:
      writeBlock(gUnitModal.format(21));
      break;
  }

  if (getProperty("gotChipConveyor")) {
    onCommand(COMMAND_START_CHIP_TRANSPORT);
  }
  // Probing Surface Inspection
  if (typeof inspectionWriteVariables == "function") {
    inspectionWriteVariables();
  }
  if (getProperty("useLiveConnection") && (typeof liveConnectionHeader == "function")) {
    liveConnectionHeader();
  }
}

function onComment(message) {
  writeComment(message);
}

/** Force output of X, Y, and Z. */
function forceXYZ() {
  xOutput.reset();
  yOutput.reset();
  zOutput.reset();
}

/** Force output of A, B, and C. */
function forceABC() {
  aOutput.reset();
  bOutput.reset();
  cOutput.reset();
}

function forceFeed() {
  currentFeedId = undefined;
  previousDPMFeed = 0;
  feedOutput.reset();
}

/** Force output of X, Y, Z, A, B, C, and F on next output. */
function forceAny() {
  forceXYZ();
  forceABC();
  forceFeed();
}

var lengthCompensationActive = false;
/** Disables length compensation if currently active or if forced. */
function disableLengthCompensation(force, message) {
  if (lengthCompensationActive || force) {
    writeBlock(gFormat.format(49), conditional(message, formatComment(message)));
    lengthCompensationActive = false;
  }
}

// Start of smoothing logic
var smoothingSettings = {
  roughing: 1, // roughing level for smoothing in automatic mode
  semi: 2, // semi-roughing level for smoothing in automatic mode
  semifinishing: 2, // semi-finishing level for smoothing in automatic mode
  finishing: 3, // finishing level for smoothing in automatic mode
  thresholdRoughing: toPreciseUnit(0.5, MM), // operations with stock/tolerance above that threshold will use roughing level in automatic mode
  thresholdFinishing: toPreciseUnit(0.05, MM), // operations with stock/tolerance below that threshold will use finishing level in automatic mode
  thresholdSemiFinishing: toPreciseUnit(0.1, MM), // operations with stock/tolerance above finishing and below threshold roughing that threshold will use semi finishing level in automatic mode

  differenceCriteria: "level", // options: "level", "tolerance", "both". Specifies criteria when output smoothing codes
  autoLevelCriteria: "stock", // use "stock" or "tolerance" to determine levels in automatic mode
  cancelCompensation: false // tool length compensation must be canceled prior to changing the smoothing level
};

// collected state below, do not edit
var smoothing = {
  cancel: false, // cancel tool length prior to update smoothing for this operation
  isActive: false, // the current state of smoothing
  isAllowed: false, // smoothing is allowed for this operation
  isDifferent: false, // tells if smoothing levels/tolerances/both are different between operations
  level: -1, // the active level of smoothing
  tolerance: -1, // the current operation tolerance
  force: false // smoothing needs to be forced out in this operation
};

function initializeSmoothing() {
  var previousLevel = smoothing.level;
  var previousTolerance = smoothing.tolerance;

  // determine new smoothing levels and tolerances
  smoothing.level = parseInt(getProperty("useSmoothing"), 10);
  smoothing.level = isNaN(smoothing.level) ? -1 : smoothing.level;
  smoothing.tolerance = Math.max(getParameter("operation:tolerance", smoothingSettings.thresholdFinishing), 0);

  // automatically determine smoothing level
  if (smoothing.level == 9999) {
    if (smoothingSettings.autoLevelCriteria == "stock") { // determine auto smoothing level based on stockToLeave
      var stockToLeave = xyzFormat.getResultingValue(getParameter("operation:stockToLeave", 0));
      var verticalStockToLeave = xyzFormat.getResultingValue(getParameter("operation:verticalStockToLeave", 0));
      if (((stockToLeave >= smoothingSettings.thresholdRoughing) && (verticalStockToLeave >= smoothingSettings.thresholdRoughing)) ||
        getParameter("operation:strategy", "") == "face") {
        smoothing.level = smoothingSettings.roughing; // set roughing level
      } else {
        if (((stockToLeave >= smoothingSettings.thresholdSemiFinishing) && (stockToLeave < smoothingSettings.thresholdRoughing)) &&
          ((verticalStockToLeave >= smoothingSettings.thresholdSemiFinishing) && (verticalStockToLeave < smoothingSettings.thresholdRoughing))) {
          smoothing.level = smoothingSettings.semi; // set semi level
        } else if (((stockToLeave >= smoothingSettings.thresholdFinishing) && (stockToLeave < smoothingSettings.thresholdSemiFinishing)) &&
          ((verticalStockToLeave >= smoothingSettings.thresholdFinishing) && (verticalStockToLeave < smoothingSettings.thresholdSemiFinishing))) {
          smoothing.level = smoothingSettings.semifinishing; // set semi-finishing level
        } else {
          smoothing.level = smoothingSettings.finishing; // set finishing level
        }
      }
    } else { // detemine auto smoothing level based on operation tolerance instead of stockToLeave
      if (smoothing.tolerance >= smoothingSettings.thresholdRoughing ||
        getParameter("operation:strategy", "") == "face") {
        smoothing.level = smoothingSettings.roughing; // set roughing level
      } else {
        if (((smoothing.tolerance >= smoothingSettings.thresholdSemiFinishing) && (smoothing.tolerance < smoothingSettings.thresholdRoughing))) {
          smoothing.level = smoothingSettings.semi; // set semi level
        } else if (((smoothing.tolerance >= smoothingSettings.thresholdFinishing) && (smoothing.tolerance < smoothingSettings.thresholdSemiFinishing))) {
          smoothing.level = smoothingSettings.semifinishing; // set semi-finishing level
        } else {
          smoothing.level = smoothingSettings.finishing; // set finishing level
        }
      }
    }
  }
  if (smoothing.level == -1) { // useSmoothing is disabled
    smoothing.isAllowed = false;
  } else { // do not output smoothing for the following operations
    smoothing.isAllowed = !(currentSection.getTool().type == TOOL_PROBE || currentSection.checkGroup(STRATEGY_DRILLING));
  }
  if (!smoothing.isAllowed) {
    smoothing.level = -1;
    smoothing.tolerance = -1;
  }

  switch (smoothingSettings.differenceCriteria) {
    case "level":
      smoothing.isDifferent = smoothing.level != previousLevel;
      break;
    case "tolerance":
      smoothing.isDifferent = xyzFormat.areDifferent(smoothing.tolerance, previousTolerance);
      break;
    case "both":
      smoothing.isDifferent = smoothing.level != previousLevel || xyzFormat.areDifferent(smoothing.tolerance, previousTolerance);
      break;
    default:
      error(localize("Unsupported smoothing criteria."));
      return;
  }

  // tool length compensation needs to be canceled when smoothing state/level changes
  if (smoothingSettings.cancelCompensation) {
    smoothing.cancel = !isFirstSection() && smoothing.isDifferent;
  }
}

function setSmoothing(mode) {
  if (mode == smoothing.isActive && (!mode || !smoothing.isDifferent) && !smoothing.force) {
    return; // return if smoothing is already active or is not different
  }
  if (typeof lengthCompensationActive != "undefined" && smoothingSettings.cancelCompensation) {
    validate(!lengthCompensationActive, "Length compensation is active while trying to update smoothing.");
  }
  if (mode) { // enable smoothing
    writeBlock(
      gFormat.format(187),
      "P" + smoothing.level,
      conditional((smoothingSettings.differenceCriteria != "level"), "E" + xyzFormat.format(smoothing.tolerance))
    );
  } else { // disable smoothing
    writeBlock(gFormat.format(187));
  }
  smoothing.isActive = mode;
  smoothing.force = false;
  smoothing.isDifferent = false;
}
// End of smoothing logic

function FeedContext(id, description, feed) {
  this.id = id;
  this.description = description;
  this.feed = feed;
}

function getFeed(f) {
  if (activeMovements) {
    var feedContext = activeMovements[movement];
    if (feedContext != undefined) {
      if (!feedFormat.areDifferent(feedContext.feed, f)) {
        if (feedContext.id == currentFeedId) {
          return ""; // nothing has changed
        }
        forceFeed();
        currentFeedId = feedContext.id;
        return "F#" + (firstFeedParameter + feedContext.id);
      }
    }
    currentFeedId = undefined; // force Q feed next time
  }
  // IG: lathe mode feed is in mm/rev, so we convert it to mm/min
  return feedOutput.format(f * spindleSpeed); // use feed value
}

function initializeActiveFeeds() {
  activeMovements = new Array();
  var movements = currentSection.getMovements();

  var id = 0;
  var activeFeeds = new Array();
  if (hasParameter("operation:tool_feedCutting")) {
    if (movements & ((1 << MOVEMENT_CUTTING) | (1 << MOVEMENT_LINK_TRANSITION) | (1 << MOVEMENT_EXTENDED))) {
      var feedContext = new FeedContext(id, localize("Cutting"), getParameter("operation:tool_feedCutting"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_CUTTING] = feedContext;
      activeMovements[MOVEMENT_LINK_TRANSITION] = feedContext;
      activeMovements[MOVEMENT_EXTENDED] = feedContext;
    }
    ++id;
    if (movements & (1 << MOVEMENT_PREDRILL)) {
      feedContext = new FeedContext(id, localize("Predrilling"), getParameter("operation:tool_feedCutting"));
      activeMovements[MOVEMENT_PREDRILL] = feedContext;
      activeFeeds.push(feedContext);
    }
    ++id;
  }

  if (hasParameter("operation:finishFeedrate")) {
    if (movements & (1 << MOVEMENT_FINISH_CUTTING)) {
      var feedContext = new FeedContext(id, localize("Finish"), getParameter("operation:finishFeedrate"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_FINISH_CUTTING] = feedContext;
    }
    ++id;
  } else if (hasParameter("operation:tool_feedCutting")) {
    if (movements & (1 << MOVEMENT_FINISH_CUTTING)) {
      var feedContext = new FeedContext(id, localize("Finish"), getParameter("operation:tool_feedCutting"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_FINISH_CUTTING] = feedContext;
    }
    ++id;
  }

  if (hasParameter("operation:tool_feedEntry")) {
    if (movements & (1 << MOVEMENT_LEAD_IN)) {
      var feedContext = new FeedContext(id, localize("Entry"), getParameter("operation:tool_feedEntry"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_LEAD_IN] = feedContext;
    }
    ++id;
  }

  if (hasParameter("operation:tool_feedExit")) {
    if (movements & (1 << MOVEMENT_LEAD_OUT)) {
      var feedContext = new FeedContext(id, localize("Exit"), getParameter("operation:tool_feedExit"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_LEAD_OUT] = feedContext;
    }
    ++id;
  }

  if (hasParameter("operation:noEngagementFeedrate")) {
    if (movements & (1 << MOVEMENT_LINK_DIRECT)) {
      var feedContext = new FeedContext(id, localize("Direct"), getParameter("operation:noEngagementFeedrate"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_LINK_DIRECT] = feedContext;
    }
    ++id;
  } else if (hasParameter("operation:tool_feedCutting") &&
    hasParameter("operation:tool_feedEntry") &&
    hasParameter("operation:tool_feedExit")) {
    if (movements & (1 << MOVEMENT_LINK_DIRECT)) {
      var feedContext = new FeedContext(id, localize("Direct"), Math.max(getParameter("operation:tool_feedCutting"), getParameter("operation:tool_feedEntry"), getParameter("operation:tool_feedExit")));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_LINK_DIRECT] = feedContext;
    }
    ++id;
  }

  if (hasParameter("operation:reducedFeedrate")) {
    if (movements & (1 << MOVEMENT_REDUCED)) {
      var feedContext = new FeedContext(id, localize("Reduced"), getParameter("operation:reducedFeedrate"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_REDUCED] = feedContext;
    }
    ++id;
  }

  if (hasParameter("operation:tool_feedRamp")) {
    if (movements & ((1 << MOVEMENT_RAMP) | (1 << MOVEMENT_RAMP_HELIX) | (1 << MOVEMENT_RAMP_PROFILE) | (1 << MOVEMENT_RAMP_ZIG_ZAG))) {
      var feedContext = new FeedContext(id, localize("Ramping"), getParameter("operation:tool_feedRamp"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_RAMP] = feedContext;
      activeMovements[MOVEMENT_RAMP_HELIX] = feedContext;
      activeMovements[MOVEMENT_RAMP_PROFILE] = feedContext;
      activeMovements[MOVEMENT_RAMP_ZIG_ZAG] = feedContext;
    }
    ++id;
  }
  if (hasParameter("operation:tool_feedPlunge")) {
    if (movements & (1 << MOVEMENT_PLUNGE)) {
      var feedContext = new FeedContext(id, localize("Plunge"), getParameter("operation:tool_feedPlunge"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_PLUNGE] = feedContext;
    }
    ++id;
  }
  if (true) { // high feed
    if ((movements & (1 << MOVEMENT_HIGH_FEED)) || (highFeedMapping != HIGH_FEED_NO_MAPPING)) {
      var feed;
      if (hasParameter("operation:highFeedrateMode") && getParameter("operation:highFeedrateMode") != "disabled") {
        feed = getParameter("operation:highFeedrate");
      } else {
        feed = toPreciseUnit(this.highFeedrate, MM);
      }
      var feedContext = new FeedContext(id, localize("High Feed"), feed);
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_HIGH_FEED] = feedContext;
      activeMovements[MOVEMENT_RAPID] = feedContext;
    }
    ++id;
  }

  for (var i = 0; i < activeFeeds.length; ++i) {
    var feedContext = activeFeeds[i];
    writeBlock("#" + (firstFeedParameter + feedContext.id) + "=" + feedFormat.format(feedContext.feed), formatComment(feedContext.description));
  }
}

var currentWorkPlaneABC = undefined;
var activeG254 = false;

function forceWorkPlane() {
  currentWorkPlaneABC = undefined;
}

function defineWorkPlane(_section, _setWorkPlane) {
  var abc = new Vector(0, 0, 0);
  if (machineConfiguration.isMultiAxisConfiguration()) { // use 5-axis indexing for multi-axis mode
    abc = _section.isMultiAxis() ? _section.getInitialToolAxisABC() : getWorkPlaneMachineABC(_section.workPlane);
    if (_section.isMultiAxis()) {
      cancelTransformationTemp();
      if (_setWorkPlane) {
        if (activeG254) {
          writeBlock(gFormat.format(255)); // cancel DWO
          activeG254 = false;
        }
        forceWorkPlane();
        positionABC(abc, true);
      }
    } else {
      if (_setWorkPlane) {
        setWorkPlane(abc);
      }
    }
  } else { // pure 3D
    var remaining = _section.workPlane;
    if (!isSameDirection(remaining.forward, new Vector(0, 0, 1))) {
      error(localize("Tool orientation is not supported."));
      return abc;
    }
    setRotationTemp(remaining);
  }
  if (currentSection && (currentSection.getId() == _section.getId())) {
    operationSupportsTCP = (_section.isMultiAxis() || !useMultiAxisFeatures) && _section.getOptimizedTCPMode() == OPTIMIZE_NONE;
  }
  return abc;
}

function setWorkPlane(abc) {
  if (!machineConfiguration.isMultiAxisConfiguration()) {
    return; // ignore
  }

  var _skipBlock = false;
  if (!((currentWorkPlaneABC == undefined) ||
    abcFormat.areDifferent(abc.x, currentWorkPlaneABC.x) ||
    abcFormat.areDifferent(abc.y, currentWorkPlaneABC.y) ||
    abcFormat.areDifferent(abc.z, currentWorkPlaneABC.z))) {
    if (operationNeedsSafeStart) {
      _skipBlock = true;
    } else {
      return; // no change
    }
  }
  skipBlock = _skipBlock;
  onCommand(COMMAND_UNLOCK_MULTI_AXIS);

  if (!retracted) {
    skipBlock = _skipBlock;
    moveToSafeRetractPosition(false);
  }

  if (activeG254) {
    skipBlock = _skipBlock;
    activeG254 = false;
    writeBlock(gFormat.format(255)); // cancel DWO
  }

  skipBlock = _skipBlock;
  // positionABC(abc, true);

  if (!currentSection.isMultiAxis()) {
    skipBlock = _skipBlock;
    onCommand(COMMAND_LOCK_MULTI_AXIS);
  }

  if (getProperty("useMultiAxisFeatures") &&
    (abcFormat.isSignificant(abc.x % (Math.PI * 2)) || abcFormat.isSignificant(abc.y % (Math.PI * 2)) || abcFormat.isSignificant(abc.z % (Math.PI * 2)))) {
    skipBlock = _skipBlock;
    activeG254 = true;
    writeBlock(gFormat.format(254)); // enable DWO
  }
  currentWorkPlaneABC = abc;
}

function positionABC(abc, force) {
  if (typeof unwindABC == "function") {
    unwindABC(abc);
  }
  if (force) {
    forceABC();
  }
  var a = aOutput.format(abc.x);
  var b = bOutput.format(abc.y);
  var c = cOutput.format(abc.z);
  if (a || b || c) {
    if (!retracted) {
      if (typeof moveToSafeRetractPosition == "function") {
        moveToSafeRetractPosition();
      } else {
        writeRetract(Z);
      }
    }
    onCommand(COMMAND_UNLOCK_MULTI_AXIS);
    gMotionModal.reset();
    writeBlock(gMotionModal.format(0), a, b, c);
    if (getCurrentSectionId() != -1) {
      setCurrentABC(abc); // required for machine simulation
    }
  }
}

function getWorkPlaneMachineABC(workPlane) {
  var W = workPlane; // map to global frame

  var currentABC = isFirstSection() ? new Vector(0, 0, 0) : getCurrentDirection();
  var abc = machineConfiguration.getABCByPreference(W, currentABC, ABC, PREFER_PREFERENCE, ENABLE_ALL);

  var direction = machineConfiguration.getDirection(abc);
  if (!isSameDirection(direction, W.forward)) {
    error(localize("Orientation not supported."));
    return new Vector();
  }

  var tcp = false;
  if (tcp) {
    setRotationTemp(W); // TCP mode
  } else {
    var O = machineConfiguration.getOrientation(abc);
    var R = machineConfiguration.getRemainingOrientation(abc, W);
    setRotationTemp(R);
  }

  return abc;
}

// TAG setRotation & cancelTransformation will rotate the rotary angle directions, fixed in a future release of the post engine
function setRotationTemp(W) {
  var currentDirection = getCurrentDirection();
  setRotation(W);
  setCurrentDirection(currentDirection);
}

function cancelTransformationTemp() {
  var currentDirection = getCurrentDirection();
  cancelTransformation();
  setCurrentDirection(currentDirection);
}

var UNWIND_ZERO = 1; // rotate axes to closest 0 (eg G28)
var UNWIND_STAY = 2; // set rotary axes origin to current position (eg G92)
var unwindSettings = {
  method: UNWIND_ZERO, // UNWIND_ZERO (move to closest 0 (G28)) or UNWIND_STAY (table does not move (G92))
  codes: [gFormat.format(28), gAbsIncModal.format(91)], // formatted code(s) that will (virtually) unwind axis (G90 G28), (G92), etc.
  workOffsetCode: "", // prefix for workoffset number if it is required to be output
  useAngle: "true", // 'true' outputs angle with standard output variable, 'prefix' uses 'anglePrefix', 'false' does not output angle
  anglePrefix: [], // optional prefixes for output angles specified as ["", "", "C"], use blank string if axis does not unwind
  resetG90: true // set to 'true' if G90 needs to be output after the unwind block
};

function unwindABC(abc) {
  if (typeof unwindSettings == "undefined") {
    return;
  }
  if (unwindSettings.method != UNWIND_ZERO && unwindSettings.method != UNWIND_STAY) {
    error(localize("Unsupported unwindABC method."));
    return;
  }

  var axes = new Array(machineConfiguration.getAxisU(), machineConfiguration.getAxisV(), machineConfiguration.getAxisW());
  var currentDirection = getCurrentDirection();
  for (var i in axes) {
    if (axes[i].isEnabled() && (unwindSettings.useAngle != "prefix" || unwindSettings.anglePrefix[axes[i].getCoordinate] != "")) {
      var j = axes[i].getCoordinate();

      // only use the active axis in calculations
      var tempABC = new Vector(0, 0, 0);
      tempABC.setCoordinate(j, abc.getCoordinate(j));
      var tempCurrent = new Vector(0, 0, 0); // only use the active axis in calculations
      tempCurrent.setCoordinate(j, currentDirection.getCoordinate(j));
      var orientation = machineConfiguration.getOrientation(tempCurrent);

      // get closest angle without respecting 'reset' flag
      // and distance from previous angle to closest abc
      var nearestABC = machineConfiguration.getABCByPreference(orientation, tempABC, ABC, PREFER_PREFERENCE, ENABLE_WCS);
      var distanceABC = abcFormat.getResultingValue(Math.abs(Vector.diff(getCurrentDirection(), abc).getCoordinate(j)));

      // calculate distance from calculated abc to closest abc
      // include move to origin for G28 moves
      var distanceOrigin = 0;
      if (unwindSettings.method == UNWIND_STAY) {
        distanceOrigin = abcFormat.getResultingValue(Math.abs(Vector.diff(nearestABC, abc).getCoordinate(j)));
      } else { // closest angle
        distanceOrigin = abcFormat.getResultingValue(Math.abs(getCurrentDirection().getCoordinate(j))) % 360; // calculate distance for unwinding axis
        distanceOrigin = (distanceOrigin > 180) ? 360 - distanceOrigin : distanceOrigin; // take shortest route to 0
        distanceOrigin += abcFormat.getResultingValue(Math.abs(abc.getCoordinate(j))); // add distance from 0 to new position
      }

      // determine if the axis needs to be rewound and rewind it if required
      var revolutions = distanceABC / 360;
      var angle = unwindSettings.method == UNWIND_STAY ? nearestABC.getCoordinate(j) : 0;
      if (distanceABC > distanceOrigin && (unwindSettings.method == UNWIND_STAY || (revolutions > 1))) { // G28 method will move rotary, so make sure move is greater than 360 degrees
        if (!retracted) {
          if (typeof moveToSafeRetractPosition == "function") {
            moveToSafeRetractPosition();
          } else {
            writeRetract(Z);
          }
        }
        onCommand(COMMAND_UNLOCK_MULTI_AXIS);
        var outputs = [aOutput, bOutput, cOutput];
        outputs[j].reset();
        writeBlock(
          unwindSettings.codes,
          unwindSettings.workOffsetCode ? unwindSettings.workOffsetCode + currentWorkOffset : "",
          unwindSettings.useAngle == "true" ? outputs[j].format(angle) :
            (unwindSettings.useAngle == "prefix" ? unwindSettings.anglePrefix[j] + abcFormat.format(angle) : "")
        );
        if (unwindSettings.resetG90) {
          gAbsIncModal.reset();
          writeBlock(gAbsIncModal.format(90));
        }
        outputs[j].reset();

        // set the current rotary axis angle from the unwind block
        currentDirection.setCoordinate(j, angle);
        setCurrentDirection(currentDirection);
      }
    }
  }
}

function printProbeResults() {
  return currentSection.getParameter("printResults", 0) == 1;
}

function onPassThrough(text) {
  var commands = String(text).split(",");
  for (text in commands) {
    writeBlock(commands[text]);
  }
}

/** Returns true if the spatial vectors are significantly different. */
function areSpatialVectorsDifferent(_vector1, _vector2) {
  return (xyzFormat.getResultingValue(_vector1.x) != xyzFormat.getResultingValue(_vector2.x)) ||
    (xyzFormat.getResultingValue(_vector1.y) != xyzFormat.getResultingValue(_vector2.y)) ||
    (xyzFormat.getResultingValue(_vector1.z) != xyzFormat.getResultingValue(_vector2.z));
}

/** Returns true if the spatial boxes are a pure translation. */
function areSpatialBoxesTranslated(_box1, _box2) {
  return !areSpatialVectorsDifferent(Vector.diff(_box1[1], _box1[0]), Vector.diff(_box2[1], _box2[0])) &&
    !areSpatialVectorsDifferent(Vector.diff(_box2[0], _box1[0]), Vector.diff(_box2[1], _box1[1]));
}

/** Returns true if the spatial boxes are same. */
function areSpatialBoxesSame(_box1, _box2) {
  return !areSpatialVectorsDifferent(_box1[0], _box2[0]) && !areSpatialVectorsDifferent(_box1[1], _box2[1]);
}

function subprogramDefine(_initialPosition, _abc, _retracted, _zIsOutput) {
  // convert patterns into subprograms
  var usePattern = false;
  patternIsActive = false;
  if (currentSection.isPatterned && currentSection.isPatterned() && (getProperty("useSubroutines") == "patterns")) {
    currentPattern = currentSection.getPatternId();
    firstPattern = true;
    for (var i = 0; i < definedPatterns.length; ++i) {
      if ((definedPatterns[i].patternType == SUB_PATTERN) && (currentPattern == definedPatterns[i].patternId)) {
        currentSubprogram = definedPatterns[i].subProgram;
        usePattern = definedPatterns[i].validPattern;
        firstPattern = false;
        break;
      }
    }

    if (firstPattern) {
      // determine if this is a valid pattern for creating a subprogram
      usePattern = subprogramIsValid(currentSection, currentPattern, SUB_PATTERN);
      if (usePattern) {
        currentSubprogram = ++lastSubprogram;
      }
      definedPatterns.push({
        patternType: SUB_PATTERN,
        patternId: currentPattern,
        subProgram: currentSubprogram,
        validPattern: usePattern,
        initialPosition: _initialPosition,
        finalPosition: _initialPosition
      });
    }

    if (usePattern) {
      // make sure Z-position is output prior to subprogram call
      if (!_retracted && !_zIsOutput) {
        writeBlock(gMotionModal.format(0), zOutput.format(_initialPosition.z));
      }

      // call subprogram
      writeBlock(mFormat.format(97), "P" + nFormat.format(currentSubprogram));
      patternIsActive = true;

      if (firstPattern) {
        subprogramStart(_initialPosition, _abc, incrementalSubprogram);
      } else {
        skipRemainingSection();
        setCurrentPosition(getFramePosition(currentSection.getFinalPosition()));
      }
    }
  }

  // Output cycle operation as subprogram
  if (!usePattern && (getProperty("useSubroutines") == "cycles") && currentSection.doesStrictCycle &&
    (currentSection.getNumberOfCycles() == 1) && currentSection.getNumberOfCyclePoints() >= minimumCyclePoints) {
    var finalPosition = getFramePosition(currentSection.getFinalPosition());
    currentPattern = currentSection.getNumberOfCyclePoints();
    firstPattern = true;
    for (var i = 0; i < definedPatterns.length; ++i) {
      if ((definedPatterns[i].patternType == SUB_CYCLE) && (currentPattern == definedPatterns[i].patternId) &&
        !areSpatialVectorsDifferent(_initialPosition, definedPatterns[i].initialPosition) &&
        !areSpatialVectorsDifferent(finalPosition, definedPatterns[i].finalPosition)) {
        currentSubprogram = definedPatterns[i].subProgram;
        usePattern = definedPatterns[i].validPattern;
        firstPattern = false;
        break;
      }
    }

    if (firstPattern) {
      // determine if this is a valid pattern for creating a subprogram
      usePattern = subprogramIsValid(currentSection, currentPattern, SUB_CYCLE);
      if (usePattern) {
        currentSubprogram = ++lastSubprogram;
      }
      definedPatterns.push({
        patternType: SUB_CYCLE,
        patternId: currentPattern,
        subProgram: currentSubprogram,
        validPattern: usePattern,
        initialPosition: _initialPosition,
        finalPosition: finalPosition
      });
    }
    cycleSubprogramIsActive = usePattern;
  }

  // Output each operation as a subprogram
  if (!usePattern && (getProperty("useSubroutines") == "allOperations")) {
    currentSubprogram = ++lastSubprogram;
    writeBlock(mFormat.format(97), "P" + nFormat.format(currentSubprogram));
    firstPattern = true;
    subprogramStart(_initialPosition, _abc, false);
  }
}

function subprogramStart(_initialPosition, _abc, _incremental) {
  redirectToBuffer();
  var comment = "";
  if (hasParameter("operation-comment")) {
    comment = getParameter("operation-comment");
  }
  writeln(
    "N" + nFormat.format(currentSubprogram) +
    conditional(comment, formatComment(comment.substr(0, maximumLineLength - 2 - 6 - 1)))
  );
  setProperty("showSequenceNumbers", "false");
  if (_incremental) {
    setIncrementalMode(_initialPosition, _abc);
  }
  gPlaneModal.reset();
  gMotionModal.reset();
}

function subprogramEnd() {
  if (firstPattern) {
    writeBlock(mFormat.format(99));
    writeln("");
    subprograms += getRedirectionBuffer();
  }
  forceAny();
  firstPattern = false;
  setProperty("showSequenceNumbers", saveShowSequenceNumbers);
  closeRedirection();
}

function subprogramIsValid(_section, _patternId, _patternType) {
  var sectionId = _section.getId();
  var numberOfSections = getNumberOfSections();
  var validSubprogram = _patternType != SUB_CYCLE;

  var masterPosition = new Array();
  masterPosition[0] = getFramePosition(_section.getInitialPosition());
  masterPosition[1] = getFramePosition(_section.getFinalPosition());
  var tempBox = _section.getBoundingBox();
  var masterBox = new Array();
  masterBox[0] = getFramePosition(tempBox[0]);
  masterBox[1] = getFramePosition(tempBox[1]);

  var rotation = getRotation();
  var translation = getTranslation();
  incrementalSubprogram = undefined;

  for (var i = 0; i < numberOfSections; ++i) {
    var section = getSection(i);
    if (section.getId() != sectionId) {
      defineWorkPlane(section, false);
      // check for valid pattern
      if (_patternType == SUB_PATTERN) {
        if (section.getPatternId() == _patternId) {
          var patternPosition = new Array();
          patternPosition[0] = getFramePosition(section.getInitialPosition());
          patternPosition[1] = getFramePosition(section.getFinalPosition());
          tempBox = section.getBoundingBox();
          var patternBox = new Array();
          patternBox[0] = getFramePosition(tempBox[0]);
          patternBox[1] = getFramePosition(tempBox[1]);

          if (areSpatialBoxesSame(masterPosition, patternPosition) && areSpatialBoxesSame(masterBox, patternBox) && !section.isMultiAxis()) {
            incrementalSubprogram = incrementalSubprogram ? incrementalSubprogram : false;
          } else if (!areSpatialBoxesTranslated(masterPosition, patternPosition) || !areSpatialBoxesTranslated(masterBox, patternBox)) {
            validSubprogram = false;
            break;
          } else {
            incrementalSubprogram = true;
          }
        }

        // check for valid cycle operation
      } else if (_patternType == SUB_CYCLE) {
        if ((section.getNumberOfCyclePoints() == _patternId) && (section.getNumberOfCycles() == 1)) {
          var patternInitial = getFramePosition(section.getInitialPosition());
          var patternFinal = getFramePosition(section.getFinalPosition());
          if (!areSpatialVectorsDifferent(patternInitial, masterPosition[0]) && !areSpatialVectorsDifferent(patternFinal, masterPosition[1])) {
            validSubprogram = true;
            break;
          }
        }
      }
    }
  }
  setRotationTemp(rotation);
  setTranslation(translation);
  return (validSubprogram);
}

function setAxisMode(_format, _output, _prefix, _value, _incr) {
  var i = _output.isEnabled();
  if (_output == zOutput) {
    _output = _incr ? createIncrementalVariable({ onchange: function () { retracted = false; }, prefix: _prefix }, _format) : createVariable({ onchange: function () { retracted = false; }, prefix: _prefix }, _format);
  } else {
    _output = _incr ? createIncrementalVariable({ prefix: _prefix }, _format) : createVariable({ prefix: _prefix }, _format);
  }
  _output.format(_value);
  _output.format(_value);
  i = i ? _output.enable() : _output.disable();
  return _output;
}

function setIncrementalMode(xyz, abc) {
  xOutput = setAxisMode(xyzFormat, xOutput, "X", xyz.x, true);
  yOutput = setAxisMode(xyzFormat, yOutput, "Y", xyz.y, true);
  zOutput = setAxisMode(xyzFormat, zOutput, "Z", xyz.z, true);
  aOutput = setAxisMode(abcFormat, aOutput, "A", abc.x, true);
  bOutput = setAxisMode(abcFormat, bOutput, "B", abc.y, true);
  cOutput = setAxisMode(abcFormat, cOutput, "C", abc.z, true);
  gAbsIncModal.reset();
  writeBlock(gAbsIncModal.format(91));
  incrementalMode = true;
}

function setAbsoluteMode(xyz, abc) {
  if (incrementalMode) {
    xOutput = setAxisMode(xyzFormat, xOutput, "X", xyz.x, false);
    yOutput = setAxisMode(xyzFormat, yOutput, "Y", xyz.y, false);
    zOutput = setAxisMode(xyzFormat, zOutput, "Z", xyz.z, false);
    aOutput = setAxisMode(abcFormat, aOutput, "A", abc.x, false);
    bOutput = setAxisMode(abcFormat, bOutput, "B", abc.y, false);
    cOutput = setAxisMode(abcFormat, cOutput, "C", abc.z, false);
    gAbsIncModal.reset();
    writeBlock(gAbsIncModal.format(90));
    incrementalMode = false;
  }
}

function onSection() {
  var forceToolAndRetract = optionalSection && !currentSection.isOptional();
  optionalSection = currentSection.isOptional();

  var insertToolCall = forceToolAndRetract || isFirstSection() ||
    currentSection.getForceToolChange && currentSection.getForceToolChange() ||
    (tool.number != getPreviousSection().getTool().number);

  retracted = false;

  var zIsOutput = false; // true if the Z-position has been output, used for patterns
  var newWorkOffset = isFirstSection() ||
    (getPreviousSection().workOffset != currentSection.workOffset); // work offset changes
  var newWorkPlane = isFirstSection() ||
    !isSameDirection(getPreviousSection().getGlobalFinalToolAxis(), currentSection.getGlobalInitialToolAxis()) ||
    (currentSection.isOptimizedForMachine() && getPreviousSection().isOptimizedForMachine() &&
      Vector.diff(getPreviousSection().getFinalToolAxisABC(), currentSection.getInitialToolAxisABC()).length > 1e-4) ||
    (!machineConfiguration.isMultiAxisConfiguration() && currentSection.isMultiAxis()) ||
    (!getPreviousSection().isMultiAxis() && currentSection.isMultiAxis() ||
      getPreviousSection().isMultiAxis() && !currentSection.isMultiAxis()); // force newWorkPlane between indexing and simultaneous operations

  operationNeedsSafeStart = getProperty("safeStartAllOperations") && !insertToolCall;

  if (insertToolCall || operationNeedsSafeStart) {
    if (getProperty("fastToolChange") && !isProbeOperation()) {
      currentCoolantMode = COOLANT_OFF;
    } else if (insertToolCall) { // no coolant off command if safe start operation
      onCommand(COMMAND_COOLANT_OFF);
    }
  }

  // toolpath starting information for live connection
  if (getProperty("useLiveConnection") && (typeof liveConnectionWriteData == "function")) {
    liveConnectionWriteData("toolpathStart");
  }
  // define smoothing mode
  initializeSmoothing();

  if ((insertToolCall && !getProperty("fastToolChange")) || newWorkOffset || newWorkPlane || toolChecked) {

    // stop spindle before retract during tool change
    if (insertToolCall && !isFirstSection() && !toolChecked && !getProperty("fastToolChange")) {
      onCommand(COMMAND_STOP_SPINDLE);
    }

    // retract to safe plane
    writeRetract(Z);
    writeBlock(gAbsIncModal.format(90));
    zOutput.reset();

    if (forceResetWorkPlane && newWorkPlane) {
      forceWorkPlane();
      setWorkPlane(new Vector(0, 0, 0)); // reset working plane
    }
  }

  if (hasParameter("operation-comment")) {
    var comment = getParameter("operation-comment");
    if (comment && ((comment !== lastOperationComment) || !patternIsActive || insertToolCall)) {
      writeln("");
      writeComment(comment);
      lastOperationComment = comment;
    } else if (!patternIsActive || insertToolCall) {
      writeln("");
    }
  } else {
    writeln("");
  }

  if (getProperty("showNotes") && hasParameter("notes")) {
    var notes = getParameter("notes");
    if (notes) {
      var lines = String(notes).split("\n");
      var r1 = new RegExp("^[\\s]+", "g");
      var r2 = new RegExp("[\\s]+$", "g");
      for (line in lines) {
        var comment = lines[line].replace(r1, "").replace(r2, "");
        if (comment) {
          writeComment(comment);
        }
      }
    }
  }

  defineWorkPlane(currentSection, false);
  var initialPosition = getFramePosition(currentSection.getInitialPosition());
  forceAny();

  if (operationNeedsSafeStart) {
    if (!retracted) {
      skipBlock = true;
      writeRetract(Z);
    }
  }

  if (insertToolCall || operationNeedsSafeStart) {
    if (!isFirstSection() && getProperty("optionalStop") && insertToolCall) {
      onCommand(COMMAND_OPTIONAL_STOP);
    }

    if ((tool.number > 200 && tool.number < 1000) || tool.number > 9999) {
      warning(localize("Tool number out of range."));
    }

    skipBlock = !insertToolCall;
    writeComment("T" + tool.number + ": " + tool.description + "; " + tool.comment)
    // IG: extract work offset from comment
    const wcs_regex = /G(\d+)/g
    wcs = "G54"
    if (tool.comment) {
      tool_wcs_found = tool.comment.match(wcs_regex)
      if (tool_wcs_found != null) {
        if (tool_wcs_found.length != 1) {
          error(localize("Multiple work offsets found in tool comment."));
        } else {
          wcs = tool_wcs_found[0]
        }
      }
    }
    // IG: instead of selecting a tool, select Work offset / Work Coordinate System!
    writeBlock(wcs)
    // writeToolBlock(
    //   "T" + toolFormat.format(tool.number),
    //   mFormat.format(6)
    // );

    if (measureTool) {
      writeToolMeasureBlock(tool, false);
    }
    if (insertToolCall) {
      forceWorkPlane();
    }
    var showToolZMin = false;
    if (showToolZMin) {
      if (is3D()) {
        var numberOfSections = getNumberOfSections();
        var zRange = currentSection.getGlobalZRange();
        var number = tool.number;
        for (var i = currentSection.getId() + 1; i < numberOfSections; ++i) {
          var section = getSection(i);
          if (section.getTool().number != number) {
            break;
          }
          zRange.expandToRange(section.getGlobalZRange());
        }
        writeComment(localize("ZMIN") + "=" + xyzFormat.format(zRange.getMinimum()));
      }
    }
  }

  // activate those two coolant modes before the spindle is turned on
  if ((tool.coolant == COOLANT_THROUGH_TOOL) || (tool.coolant == COOLANT_AIR_THROUGH_TOOL) || (tool.coolant == COOLANT_FLOOD_THROUGH_TOOL)) {
    if (!isFirstSection() && !insertToolCall && (currentCoolantMode != tool.coolant)) {
      onCommand(COMMAND_STOP_SPINDLE);
      forceSpindleSpeed = true;
    }
    setCoolant(tool.coolant);
  } else if ((currentCoolantMode == COOLANT_THROUGH_TOOL) || (currentCoolantMode == COOLANT_AIR_THROUGH_TOOL) || (currentCoolantMode == COOLANT_FLOOD_THROUGH_TOOL)) {
    onCommand(COMMAND_STOP_SPINDLE);
    setCoolant(COOLANT_OFF);
    forceSpindleSpeed = true;
  }

  if (toolChecked) {
    forceSpindleSpeed = true; // spindle must be restarted if tool is checked without a tool change
    toolChecked = false; // state of tool is not known at the beginning of a section since it could be broken for the previous section
  }
  var spindleChanged = tool.type != TOOL_PROBE &&
    (insertToolCall || forceSpindleSpeed || isFirstSection() ||
      (rpmFormat.areDifferent(spindleSpeed, sOutput.getCurrent())) ||
      (tool.clockwise != getPreviousSection().getTool().clockwise));
  if (spindleChanged || (operationNeedsSafeStart && tool.type != TOOL_PROBE)) {
    forceSpindleSpeed = false;

    if (spindleSpeed < 1) {
      error(localize("Spindle speed out of range."));
      return;
    }
    if (spindleSpeed > 99999) {
      warning(localize("Spindle speed exceeds maximum value."));
    }
    skipBlock = !spindleChanged;
    writeBlock(
      sOutput.format(spindleSpeed), mFormat.format(tool.clockwise ? 3 : 4)
    );
  }

  if (getProperty("useParametricFeed") &&
    hasParameter("operation-strategy") &&
    (getParameter("operation-strategy") != "drill") &&
    !(currentSection.hasAnyCycle && currentSection.hasAnyCycle())) {
    if (!insertToolCall &&
      activeMovements &&
      (getCurrentSectionId() > 0) &&
      ((getPreviousSection().getPatternId() == currentSection.getPatternId()) && (currentSection.getPatternId() != 0))) {
      // use the current feeds
    } else {
      initializeActiveFeeds();
    }
  } else {
    activeMovements = undefined;
  }

  // wcs
  if (insertToolCall || operationNeedsSafeStart) { // force work offset when changing tool
    currentWorkOffset = undefined;
    skipBlock = operationNeedsSafeStart && !newWorkOffset && !insertToolCall;
  }
  if (currentSection.workOffset != currentWorkOffset) {
    if (!skipBlock) {
      forceWorkPlane();
    }
    // writeBlock(currentSection.wcs);  // IG: we set work coordinate system when selecting turning tool!
    currentWorkOffset = currentSection.workOffset;
  }

  if (newWorkPlane || (insertToolCall && !retracted)) { // go to home position for safety
    if (!retracted) {
      writeRetract(Z);
    }
    if (getProperty("forceHomeOnIndexing") && machineConfiguration.isMultiAxisConfiguration()) {
      writeRetract(X, Y);
    }
  }

  if (newWorkOffset) {
    forceWorkPlane();
  }

  var abc = defineWorkPlane(currentSection, true);

  setProbeAngle(); // output probe angle rotations if required

  // set coolant after we have positioned at Z
  var coolantIsOutput = (tool.coolant != currentCoolantMode) || operationNeedsSafeStart;
  setCoolant(tool.coolant);

  gMotionModal.reset();

  smoothing.force = operationNeedsSafeStart && (getProperty("useSmoothing") != "-1");
  setSmoothing(smoothing.isAllowed);

  var G = ((highFeedMapping != HIGH_FEED_NO_MAPPING) || !getProperty("useG0")) ? 1 : 0;
  var F = ((highFeedMapping != HIGH_FEED_NO_MAPPING) || !getProperty("useG0")) ? getFeed(highFeedrate) : "";
  if (insertToolCall || retracted || operationNeedsSafeStart || !lengthCompensationActive ||
    (!isFirstSection() && (currentSection.isMultiAxis() != getPreviousSection().isMultiAxis()))) {
    var _skipBlock = !(insertToolCall || retracted ||
      (!isFirstSection() && (currentSection.isMultiAxis() != getPreviousSection().isMultiAxis())));
    // IG: Length offset is from the tool used as chuck at startup
    if ((lengthOffset > 200 && lengthOffset < 1000) || lengthOffset > 9999) {
      error(localize("Length offset out of range."));
      return;
    }

    gMotionModal.reset();
    writeBlock(gPlaneModal.format(17));

    if (!machineConfiguration.isHeadConfiguration()) {
      if (operationSupportsTCP && useDwoForPositioning && currentSection.isMultiAxis()) {
        prepositionDWO(initialPosition, abc, skipBlock);
      } else {
        skipBlock = _skipBlock;
        writeBlock(gAbsIncModal.format(90), gMotionModal.format(G), xOutput.format(initialPosition.x), yOutput.format(initialPosition.y), F);
        skipBlock = _skipBlock;
        writeComment("Tool length offset from program comment: T" + lengthOffset)
        writeBlock(
          gMotionModal.format(0),
          conditional(!currentSection.isMultiAxis() || !operationSupportsTCP, gFormat.format(43)),
          conditional(currentSection.isMultiAxis() && operationSupportsTCP, gFormat.format(234)),
          zOutput.format(initialPosition.z),
          hFormat.format(lengthOffset)
        );
      }
    } else {
      skipBlock = _skipBlock;
      writeBlock(
        gAbsIncModal.format(90),
        gMotionModal.format(currentSection.isMultiAxis() && operationSupportsTCP ? 0 : G),
        conditional(!currentSection.isMultiAxis() || !operationSupportsTCP, gFormat.format(43)),
        conditional(currentSection.isMultiAxis() && operationSupportsTCP, gFormat.format(234)),
        xOutput.format(initialPosition.x),
        yOutput.format(initialPosition.y),
        zOutput.format(initialPosition.z),
        F,
        hFormat.format(lengthOffset)
      );
    }
    zIsOutput = true;
    lengthCompensationActive = true;
    if (_skipBlock) {
      forceXYZ();
      var x = xOutput.format(initialPosition.x);
      var y = yOutput.format(initialPosition.y);
      if (x && y) {
        // axes are not synchronized
        writeBlock(gAbsIncModal.format(90), gMotionModal.format(G), x, y, F);
      } else {
        writeBlock(gAbsIncModal.format(90), gMotionModal.format(0), x, y);
      }
    }
  } else {
    validate(lengthCompensationActive, "Length compensation is not active.");
    if (xyzFormat.getResultingValue(getCurrentPosition().z) < xyzFormat.getResultingValue(initialPosition.z)) {
      writeBlock(gMotionModal.format(0), zOutput.format(initialPosition.z));
      zIsOutput = true;
    }
    var x = xOutput.format(initialPosition.x);
    var y = yOutput.format(initialPosition.y);
    if (x && y) {
      // axes are not synchronized
      writeBlock(gAbsIncModal.format(90), gMotionModal.format(G), x, y, F);
    } else {
      writeBlock(gAbsIncModal.format(90), gMotionModal.format(0), x, y);
    }
  }
  if (gMotionModal.getCurrent() == 0) {
    forceFeed();
  }
  gMotionModal.reset();
  validate(lengthCompensationActive, "Length compensation is not active.");

  // need to reinstate coolant for programmable coolant, which needs to be output after tool length compensation code (Hxx)
  if (getProperty("programmableCoolant") && coolantIsOutput) {
    forceCoolant = true;
    setCoolant(tool.coolant);
  }

  if (insertToolCall || operationNeedsSafeStart) {
    if (getProperty("preloadTool")) {
      var nextTool = getNextTool(tool.number);
      if (nextTool) {
        skipBlock = !insertToolCall;
        writeBlock("T" + toolFormat.format(nextTool.number));
      } else {
        // preload first tool
        var section = getSection(0);
        var firstToolNumber = section.getTool().number;
        if (tool.number != firstToolNumber) {
          skipBlock = !insertToolCall;
          writeBlock("T" + toolFormat.format(firstToolNumber));
        }
      }
    }
  }

  if (isProbeOperation()) {
    validate(probeVariables.probeAngleMethod != "G68", "You cannot probe while G68 Rotation is in effect.");
    validate(probeVariables.probeAngleMethod != "G54.4", "You cannot probe while workpiece setting error compensation G54.4 is enabled.");
    writeBlock(gFormat.format(65), "P" + 9832); // spin the probe on
    inspectionCreateResultsFileHeader();
  } else {
    // surface Inspection
    if (isInspectionOperation() && (typeof inspectionProcessSectionStart == "function")) {
      inspectionProcessSectionStart();
    }
  }
  // define subprogram
  subprogramDefine(initialPosition, abc, retracted, zIsOutput);
}

function prepositionDWO(position, abc, _skipBlock) {
  forceFeed();
  var G = ((highFeedMapping != HIGH_FEED_NO_MAPPING) || !getProperty("useG0")) ? 1 : 0;
  var F = ((highFeedMapping != HIGH_FEED_NO_MAPPING) || !getProperty("useG0")) ? getFeed(highFeedrate) : "";
  var O = machineConfiguration.getOrientation(abc);
  var initialPositionDWO = O.getTransposed().multiply(getGlobalPosition(currentSection.getInitialPosition()));

  skipBlock = _skipBlock;
  writeBlock(gFormat.format(254));
  skipBlock = _skipBlock;
  writeBlock(gAbsIncModal.format(90), gMotionModal.format(G), xOutput.format(initialPositionDWO.x), yOutput.format(initialPositionDWO.y), F);
  skipBlock = _skipBlock;
  writeBlock(gFormat.format(255));
  skipBlock = _skipBlock;
  writeBlock(
    gMotionModal.format(0), // G0 motion mode is required for the G234 command
    gFormat.format(234),
    xOutput.format(position.x), yOutput.format(position.y), zOutput.format(position.z),
    hFormat.format(tool.lengthOffset)
  );
  lengthCompensationActive = true;
}

function onDwell(seconds) {
  if (seconds > 99999.999) {
    warning(localize("Dwelling time is out of range."));
  }
  seconds = clamp(0.001, seconds, 99999.999);
  writeBlock(gFeedModeModal.format(94), gFormat.format(4), "P" + milliFormat.format(seconds * 1000));
}

function onSpindleSpeed(spindleSpeed) {
  writeBlock(sOutput.format(spindleSpeed));
}

function onCycle() {
  writeBlock(gPlaneModal.format(17));
}

function getCommonCycle(x, y, z, r, c) {
  forceXYZ(); // force xyz on first drill hole of any cycle
  if (incrementalMode) {
    zOutput.format(c);
    return [xOutput.format(x), yOutput.format(y),
    "Z" + xyzFormat.format(z - r),
    "R" + xyzFormat.format(r - c)];
  } else {
    return [xOutput.format(x), yOutput.format(y),
    zOutput.format(z),
    "R" + xyzFormat.format(r)];
  }
}

function setCyclePosition(_position) {
  switch (gPlaneModal.getCurrent()) {
    case 17: // XY
      zOutput.format(_position);
      break;
    case 18: // ZX
      yOutput.format(_position);
      break;
    case 19: // YZ
      xOutput.format(_position);
      break;
  }
}

/** Convert approach to sign. */
function approach(value) {
  validate((value == "positive") || (value == "negative"), "Invalid approach.");
  return (value == "positive") ? 1 : -1;
}

function setProbeAngleMethod() {
  probeVariables.probeAngleMethod = (machineConfiguration.getNumberOfAxes() < 5 || is3D()) ? (getProperty("useG54x4") ? "G54.4" : "G68") : "UNSUPPORTED";
  var axes = [machineConfiguration.getAxisU(), machineConfiguration.getAxisV(), machineConfiguration.getAxisW()];
  for (var i = 0; i < axes.length; ++i) {
    if (axes[i].isEnabled() && isSameDirection((axes[i].getAxis()).getAbsolute(), new Vector(0, 0, 1)) && axes[i].isTable()) {
      probeVariables.probeAngleMethod = "AXIS_ROT";
      probeVariables.rotationalAxis = axes[i].getCoordinate();
      break;
    }
  }
  probeVariables.outputRotationCodes = true;
}

/** Output rotation offset based on angular probing cycle. */
function setProbeAngle() {
  if (probeVariables.outputRotationCodes) {
    var probeOutputWorkOffset = currentSection.probeWorkOffset;
    validate(probeOutputWorkOffset <= 6, "Angular Probing only supports work offsets 1-6.");
    if (probeVariables.probeAngleMethod == "G68" && (Vector.diff(currentSection.getGlobalInitialToolAxis(), new Vector(0, 0, 1)).length > 1e-4)) {
      error(localize("You cannot use multi axis toolpaths while G68 Rotation is in effect."));
    }
    var validateWorkOffset = false;
    switch (probeVariables.probeAngleMethod) {
      case "G54.4":
        var param = 26000 + (probeOutputWorkOffset * 10);
        writeBlock("#" + param + "=#135");
        writeBlock("#" + (param + 1) + "=#136");
        writeBlock("#" + (param + 5) + "=#144");
        writeBlock(gFormat.format(54.4), "P" + probeOutputWorkOffset);
        break;
      case "G68":
        gRotationModal.reset();
        gAbsIncModal.reset();
        writeBlock(gRotationModal.format(68), gAbsIncModal.format(90), probeVariables.compensationXY, "R[#194]");
        validateWorkOffset = true;
        break;
      case "AXIS_ROT":
        var param = 5200 + probeOutputWorkOffset * 20 + probeVariables.rotationalAxis + 4;
        writeBlock("#" + param + " = " + "[#" + param + " + #194]");
        forceWorkPlane(); // force workplane to rotate ABC in order to apply rotation offsets
        currentWorkOffset = undefined; // force WCS output to make use of updated parameters
        validateWorkOffset = true;
        break;
      default:
        error(localize("Angular Probing is not supported for this machine configuration."));
        return;
    }
    if (validateWorkOffset) {
      for (var i = currentSection.getId(); i < getNumberOfSections(); ++i) {
        if (getSection(i).workOffset != currentSection.workOffset) {
          error(localize("WCS offset cannot change while using angle rotation compensation."));
          return;
        }
      }
    }
    probeVariables.outputRotationCodes = false;
  }
}

function protectedProbeMove(_cycle, x, y, z) {
  var _x = xOutput.format(x);
  var _y = yOutput.format(y);
  var _z = zOutput.format(z);
  if (_z && z >= getCurrentPosition().z) {
    writeBlock(gFormat.format(65), "P" + 9810, _z, getFeed(cycle.feedrate)); // protected positioning move
  }
  if (_x || _y) {
    writeBlock(gFormat.format(65), "P" + 9810, _x, _y, getFeed(highFeedrate)); // protected positioning move
  }
  if (_z && z < getCurrentPosition().z) {
    writeBlock(gFormat.format(65), "P" + 9810, _z, getFeed(cycle.feedrate)); // protected positioning move
  }
}

function cancelG68Rotation(force) {
  if (force) {
    gRotationModal.reset();
  }
  writeBlock(gRotationModal.format(69));
}

function onCyclePoint(x, y, z) {
  if (isInspectionOperation() && (typeof inspectionCycleInspect == "function")) {
    inspectionCycleInspect(cycle, x, y, z);
    return;
  }
  if (!isSameDirection(getRotation().forward, new Vector(0, 0, 1))) {
    expandCyclePoint(x, y, z);
    return;
  }
  if (isProbeOperation()) {
    if (!isSameDirection(currentSection.workPlane.forward, new Vector(0, 0, 1))) {
      if (!allowIndexingWCSProbing && currentSection.strategy == "probe") {
        error(localize("Updating WCS / work offset using probing is only supported by the CNC in the WCS frame."));
        return;
      } else if (getProperty("useMultiAxisFeatures")) {
        error(localize("Your machine does not support the selected probing operation with DWO enabled."));
        return;
      }
    }
    if (printProbeResults()) {
      writeProbingToolpathInformation(z - cycle.depth + tool.diameter / 2);
      inspectionWriteCADTransform();
      inspectionWriteWorkplaneTransform();
      if (typeof inspectionWriteVariables == "function") {
        inspectionVariables.pointNumber += 1;
      }
    }
    protectedProbeMove(cycle, x, y, z);
  }

  var forceCycle = false;
  switch (cycleType) {
    case "tapping-with-chip-breaking":
    case "left-tapping-with-chip-breaking":
    case "right-tapping-with-chip-breaking":
      forceCycle = true;
      if (!isFirstCyclePoint()) {
        writeBlock(gCycleModal.format(80));
        gMotionModal.reset();
      }
  }
  if (forceCycle || isFirstCyclePoint() || isProbeOperation()) {
    if (!isProbeOperation()) {
      // return to initial Z which is clearance plane and set absolute mode
      repositionToCycleClearance(cycle, x, y, z);
    }

    var F = cycle.feedrate;
    var P = !cycle.dwell ? 0 : clamp(1, cycle.dwell * 1000, 99999999); // in milliseconds

    switch (cycleType) {
      case "drilling":
        writeBlock(
          gRetractModal.format(98), gCycleModal.format(81),
          getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
          feedOutput.format(F)
        );
        break;
      case "counter-boring":
        if (P > 0) {
          writeBlock(
            gRetractModal.format(98), gCycleModal.format(82),
            getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
            "P" + milliFormat.format(P), // not optional
            feedOutput.format(F)
          );
        } else {
          writeBlock(
            gRetractModal.format(98), gCycleModal.format(81),
            getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
            feedOutput.format(F)
          );
        }
        break;
      case "chip-breaking":
        if ((!getProperty("useG73Retract") && (cycle.accumulatedDepth < cycle.depth)) ||
          (getProperty("useG73Retract") && (cycle.accumulatedDepth < cycle.depth) &&
            (cycle.incrementalDepthReduction > 0))) {
          expandCyclePoint(x, y, z);
        } else if (cycle.accumulatedDepth < cycle.depth) {
          writeBlock(
            gRetractModal.format(98), gCycleModal.format(73),
            getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
            ("Q" + xyzFormat.format(cycle.incrementalDepth)),
            ("K" + xyzFormat.format(cycle.accumulatedDepth)),
            conditional(P > 0, "P" + milliFormat.format(P)), // optional
            feedOutput.format(F)
          );
        } else {
          writeBlock(
            gRetractModal.format(98), gCycleModal.format(73),
            getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
            (((cycle.incrementalDepthReduction > 0) ? "I" : "Q") + xyzFormat.format(cycle.incrementalDepth)),
            conditional(cycle.incrementalDepthReduction > 0, "J" + xyzFormat.format(cycle.incrementalDepthReduction)),
            conditional(cycle.incrementalDepthReduction > 0, "K" + xyzFormat.format(cycle.minimumIncrementalDepth)),
            conditional(P > 0, "P" + milliFormat.format(P)), // optional
            feedOutput.format(F)
          );
        }
        break;
      case "deep-drilling":
        writeBlock(
          gRetractModal.format(98), gCycleModal.format(83),
          getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
          (((cycle.incrementalDepthReduction > 0) ? "I" : "Q") + xyzFormat.format(cycle.incrementalDepth)),
          conditional(cycle.incrementalDepthReduction > 0, "J" + xyzFormat.format(cycle.incrementalDepthReduction)),
          conditional(cycle.incrementalDepthReduction > 0, "K" + xyzFormat.format(cycle.minimumIncrementalDepth)),
          conditional(P > 0, "P" + milliFormat.format(P)), // optional
          feedOutput.format(F)
        );
        break;
      case "tapping":
        var tappingFPM = tool.getThreadPitch() * rpmFormat.getResultingValue(spindleSpeed);
        F = (getProperty("useG95forTapping") ? tool.getThreadPitch() : tappingFPM);
        if (getProperty("useG95forTapping")) {
          writeBlock(gFeedModeModal.format(95));
        }
        writeBlock(
          gRetractModal.format(98), gCycleModal.format((tool.type == TOOL_TAP_LEFT_HAND) ? 74 : 84),
          getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
          pitchOutput.format(F)
        );
        forceFeed();
        break;
      case "left-tapping":
        var tappingFPM = tool.getThreadPitch() * rpmFormat.getResultingValue(spindleSpeed);
        F = (getProperty("useG95forTapping") ? tool.getThreadPitch() : tappingFPM);
        if (getProperty("useG95forTapping")) {
          writeBlock(gFeedModeModal.format(95));
        }
        writeBlock(
          gRetractModal.format(98), gCycleModal.format(74),
          getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
          pitchOutput.format(F)
        );
        forceFeed();
        break;
      case "right-tapping":
        var tappingFPM = tool.getThreadPitch() * rpmFormat.getResultingValue(spindleSpeed);
        F = (getProperty("useG95forTapping") ? tool.getThreadPitch() : tappingFPM);
        if (getProperty("useG95forTapping")) {
          writeBlock(gFeedModeModal.format(95));
        }
        writeBlock(
          gRetractModal.format(98), gCycleModal.format(84),
          getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
          pitchOutput.format(F)
        );
        forceFeed();
        break;
      case "tapping-with-chip-breaking":
      case "left-tapping-with-chip-breaking":
      case "right-tapping-with-chip-breaking":
        var tappingFPM = tool.getThreadPitch() * rpmFormat.getResultingValue(spindleSpeed);
        F = (getProperty("useG95forTapping") ? tool.getThreadPitch() : tappingFPM);
        if (getProperty("useG95forTapping")) {
          writeBlock(gFeedModeModal.format(95));
        }
        // Parameter 57 bit 6, REPT RIG TAP, is set to 1 (On)
        // On Mill software versions12.09 and above, REPT RIG TAP has been moved from the Parameters to Setting 133
        var u = cycle.stock;
        var step = cycle.incrementalDepth;
        var first = true;
        while (u > cycle.bottom) {
          if (step < cycle.minimumIncrementalDepth) {
            step = cycle.minimumIncrementalDepth;
          }
          u -= step;
          step -= cycle.incrementalDepthReduction;
          gCycleModal.reset(); // required
          if ((u - 0.001) <= cycle.bottom) {
            u = cycle.bottom;
          }
          if (first) {
            first = false;
            writeBlock(
              gRetractModal.format(99), gCycleModal.format((tool.type == TOOL_TAP_LEFT_HAND ? 74 : 84)),
              getCommonCycle((gPlaneModal.getCurrent() == 19) ? u : x, (gPlaneModal.getCurrent() == 18) ? u : y, (gPlaneModal.getCurrent() == 17) ? u : z, cycle.retract, cycle.clearance),
              pitchOutput.format(F)
            );
          } else {
            var position;
            var depth;
            switch (gPlaneModal.getCurrent()) {
              case 17:
                xOutput.reset();
                position = xOutput.format(x);
                depth = zOutput.format(u);
                break;
              case 18:
                zOutput.reset();
                position = zOutput.format(z);
                depth = yOutput.format(u);
                break;
              case 19:
                yOutput.reset();
                position = yOutput.format(y);
                depth = xOutput.format(u);
                break;
            }
            writeBlock(conditional(u <= cycle.bottom, gRetractModal.format(98)), position, depth);
          }
          if (incrementalMode) {
            setCyclePosition(cycle.retract);
          }
        }
        forceFeed();
        break;
      case "fine-boring":
        writeBlock(
          gRetractModal.format(98), gCycleModal.format(76),
          getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
          "P" + milliFormat.format(P), // not optional
          "Q" + xyzFormat.format(cycle.shift),
          feedOutput.format(F)
        );
        forceSpindleSpeed = true;
        break;
      case "back-boring":
        if (P > 0) {
          expandCyclePoint(x, y, z);
        } else {
          var dx = (gPlaneModal.getCurrent() == 19) ? cycle.backBoreDistance : 0;
          var dy = (gPlaneModal.getCurrent() == 18) ? cycle.backBoreDistance : 0;
          var dz = (gPlaneModal.getCurrent() == 17) ? cycle.backBoreDistance : 0;
          writeBlock(
            gRetractModal.format(98), gCycleModal.format(77),
            getCommonCycle(x - dx, y - dy, z - dz, cycle.bottom, cycle.clearance),
            "Q" + xyzFormat.format(cycle.shift),
            feedOutput.format(F)
          );
          forceSpindleSpeed = true;
        }
        break;
      case "reaming":
        if (feedFormat.getResultingValue(cycle.feedrate) != feedFormat.getResultingValue(cycle.retractFeedrate)) {
          expandCyclePoint(x, y, z);
          break;
        }
        writeBlock(
          gRetractModal.format(98), gCycleModal.format(85),
          getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
          feedOutput.format(F)
        );
        break;
      case "stop-boring":
        if (P > 0) {
          expandCyclePoint(x, y, z);
        } else {
          writeBlock(
            gRetractModal.format(98), gCycleModal.format(86),
            getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
            feedOutput.format(F)
          );
          forceSpindleSpeed = true;
        }
        break;
      case "manual-boring":
        writeBlock(
          gRetractModal.format(98), gCycleModal.format(88),
          getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
          "P" + milliFormat.format(P), // not optional
          feedOutput.format(F)
        );
        break;
      case "boring":
        if (feedFormat.getResultingValue(cycle.feedrate) != feedFormat.getResultingValue(cycle.retractFeedrate)) {
          expandCyclePoint(x, y, z);
          break;
        }
        writeBlock(
          gRetractModal.format(98), gCycleModal.format(89),
          getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
          "P" + milliFormat.format(P), // not optional
          feedOutput.format(F)
        );
        break;

      case "probing-x":
        protectedProbeMove(cycle, x, y, z - cycle.depth);
        writeBlock(
          gFormat.format(65), "P" + 9811,
          "X" + xyzFormat.format(x + approach(cycle.approach1) * (cycle.probeClearance + tool.diameter / 2)),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          getProbingArguments(cycle, true)
        );
        break;
      case "probing-y":
        protectedProbeMove(cycle, x, y, z - cycle.depth);
        writeBlock(
          gFormat.format(65), "P" + 9811,
          "Y" + xyzFormat.format(y + approach(cycle.approach1) * (cycle.probeClearance + tool.diameter / 2)),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          getProbingArguments(cycle, true)
        );
        break;
      case "probing-z":
        protectedProbeMove(cycle, x, y, Math.min(z - cycle.depth + cycle.probeClearance, cycle.retract));
        writeBlock(
          gFormat.format(65), "P" + 9811,
          "Z" + xyzFormat.format(z - cycle.depth),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          getProbingArguments(cycle, true)
        );
        break;
      case "probing-x-wall":
        protectedProbeMove(cycle, x, y, z);
        writeBlock(
          gFormat.format(65), "P" + 9812,
          "X" + xyzFormat.format(cycle.width1),
          zOutput.format(z - cycle.depth),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "R" + xyzFormat.format(cycle.probeClearance),
          getProbingArguments(cycle, true)
        );
        break;
      case "probing-y-wall":
        protectedProbeMove(cycle, x, y, z);
        writeBlock(
          gFormat.format(65), "P" + 9812,
          "Y" + xyzFormat.format(cycle.width1),
          zOutput.format(z - cycle.depth),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "R" + xyzFormat.format(cycle.probeClearance),
          getProbingArguments(cycle, true)
        );
        break;
      case "probing-x-channel":
        protectedProbeMove(cycle, x, y, z - cycle.depth);
        writeBlock(
          gFormat.format(65), "P" + 9812,
          "X" + xyzFormat.format(cycle.width1),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          // not required "R" + xyzFormat.format(cycle.probeClearance),
          getProbingArguments(cycle, true)
        );
        break;
      case "probing-x-channel-with-island":
        protectedProbeMove(cycle, x, y, z);
        writeBlock(
          gFormat.format(65), "P" + 9812,
          "X" + xyzFormat.format(cycle.width1),
          zOutput.format(z - cycle.depth),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "R" + xyzFormat.format(-cycle.probeClearance),
          getProbingArguments(cycle, true)
        );
        break;
      case "probing-y-channel":
        protectedProbeMove(cycle, x, y, z - cycle.depth);
        writeBlock(
          gFormat.format(65), "P" + 9812,
          "Y" + xyzFormat.format(cycle.width1),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          // not required "R" + xyzFormat.format(cycle.probeClearance),
          getProbingArguments(cycle, true)
        );
        break;
      case "probing-y-channel-with-island":
        protectedProbeMove(cycle, x, y, z);
        writeBlock(
          gFormat.format(65), "P" + 9812,
          "Y" + xyzFormat.format(cycle.width1),
          zOutput.format(z - cycle.depth),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "R" + xyzFormat.format(-cycle.probeClearance),
          getProbingArguments(cycle, true)
        );
        break;
      case "probing-xy-circular-boss":
        protectedProbeMove(cycle, x, y, z);
        writeBlock(
          gFormat.format(65), "P" + 9814,
          "D" + xyzFormat.format(cycle.width1),
          "Z" + xyzFormat.format(z - cycle.depth),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "R" + xyzFormat.format(cycle.probeClearance),
          getProbingArguments(cycle, true)
        );
        break;
      case "probing-xy-circular-partial-boss":
        protectedProbeMove(cycle, x, y, z);
        writeBlock(
          gFormat.format(65), "P" + 9823,
          "A" + xyzFormat.format(cycle.partialCircleAngleA),
          "B" + xyzFormat.format(cycle.partialCircleAngleB),
          "C" + xyzFormat.format(cycle.partialCircleAngleC),
          "D" + xyzFormat.format(cycle.width1),
          "Z" + xyzFormat.format(z - cycle.depth),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "R" + xyzFormat.format(cycle.probeClearance),
          getProbingArguments(cycle, true)
        );
        break;
      case "probing-xy-circular-hole":
        protectedProbeMove(cycle, x, y, z - cycle.depth);
        writeBlock(
          gFormat.format(65), "P" + 9814,
          "D" + xyzFormat.format(cycle.width1),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          // not required "R" + xyzFormat.format(cycle.probeClearance),
          getProbingArguments(cycle, true)
        );
        break;
      case "probing-xy-circular-partial-hole":
        protectedProbeMove(cycle, x, y, z - cycle.depth);
        writeBlock(
          gFormat.format(65), "P" + 9823,
          "A" + xyzFormat.format(cycle.partialCircleAngleA),
          "B" + xyzFormat.format(cycle.partialCircleAngleB),
          "C" + xyzFormat.format(cycle.partialCircleAngleC),
          "D" + xyzFormat.format(cycle.width1),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          getProbingArguments(cycle, true)
        );
        break;
      case "probing-xy-circular-hole-with-island":
        protectedProbeMove(cycle, x, y, z);
        writeBlock(
          gFormat.format(65), "P" + 9814,
          "Z" + xyzFormat.format(z - cycle.depth),
          "D" + xyzFormat.format(cycle.width1),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "R" + xyzFormat.format(-cycle.probeClearance),
          getProbingArguments(cycle, true)
        );
        break;
      case "probing-xy-circular-partial-hole-with-island":
        protectedProbeMove(cycle, x, y, z);
        writeBlock(
          gFormat.format(65), "P" + 9823,
          "Z" + xyzFormat.format(z - cycle.depth),
          "A" + xyzFormat.format(cycle.partialCircleAngleA),
          "B" + xyzFormat.format(cycle.partialCircleAngleB),
          "C" + xyzFormat.format(cycle.partialCircleAngleC),
          "D" + xyzFormat.format(cycle.width1),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "R" + xyzFormat.format(-cycle.probeClearance),
          getProbingArguments(cycle, true)
        );
        break;
      case "probing-xy-rectangular-hole":
        protectedProbeMove(cycle, x, y, z - cycle.depth);
        writeBlock(
          gFormat.format(65), "P" + 9812,
          "X" + xyzFormat.format(cycle.width1),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          // not required "R" + xyzFormat.format(-cycle.probeClearance),
          getProbingArguments(cycle, true)
        );
        if (getProperty("useLiveConnection") && (typeof liveConnectionStoreResults == "function")) {
          liveConnectionStoreResults();
        }
        writeBlock(
          gFormat.format(65), "P" + 9812,
          "Y" + xyzFormat.format(cycle.width2),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          // not required "R" + xyzFormat.format(-cycle.probeClearance),
          getProbingArguments(cycle, true)
        );
        break;
      case "probing-xy-rectangular-boss":
        protectedProbeMove(cycle, x, y, z);
        writeBlock(
          gFormat.format(65), "P" + 9812,
          "Z" + xyzFormat.format(z - cycle.depth),
          "X" + xyzFormat.format(cycle.width1),
          "R" + xyzFormat.format(cycle.probeClearance),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          getProbingArguments(cycle, true)
        );
        if (getProperty("useLiveConnection") && (typeof liveConnectionStoreResults == "function")) {
          liveConnectionStoreResults();
        }
        writeBlock(
          gFormat.format(65), "P" + 9812,
          "Z" + xyzFormat.format(z - cycle.depth),
          "Y" + xyzFormat.format(cycle.width2),
          "R" + xyzFormat.format(cycle.probeClearance),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          getProbingArguments(cycle, true)
        );
        break;
      case "probing-xy-rectangular-hole-with-island":
        protectedProbeMove(cycle, x, y, z);
        writeBlock(
          gFormat.format(65), "P" + 9812,
          "Z" + xyzFormat.format(z - cycle.depth),
          "X" + xyzFormat.format(cycle.width1),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "R" + xyzFormat.format(-cycle.probeClearance),
          getProbingArguments(cycle, true)
        );
        if (getProperty("useLiveConnection") && (typeof liveConnectionStoreResults == "function")) {
          liveConnectionStoreResults();
        }
        writeBlock(
          gFormat.format(65), "P" + 9812,
          "Z" + xyzFormat.format(z - cycle.depth),
          "Y" + xyzFormat.format(cycle.width2),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "R" + xyzFormat.format(-cycle.probeClearance),
          getProbingArguments(cycle, true)
        );
        break;
      case "probing-xy-inner-corner":
        var cornerX = x + approach(cycle.approach1) * (cycle.probeClearance + tool.diameter / 2);
        var cornerY = y + approach(cycle.approach2) * (cycle.probeClearance + tool.diameter / 2);
        var cornerI = 0;
        var cornerJ = 0;
        if (cycle.probeSpacing !== undefined) {
          cornerI = cycle.probeSpacing;
          cornerJ = cycle.probeSpacing;
        }
        if ((cornerI != 0) && (cornerJ != 0)) {
          if (currentSection.strategy == "probe") {
            setProbeAngleMethod();
            probeVariables.compensationXY = "X[#185] Y[#186]";
          }
        }
        protectedProbeMove(cycle, x, y, z - cycle.depth);
        writeBlock(
          gFormat.format(65), "P" + 9815, xOutput.format(cornerX), yOutput.format(cornerY),
          conditional(cornerI != 0, "I" + xyzFormat.format(cornerI)),
          conditional(cornerJ != 0, "J" + xyzFormat.format(cornerJ)),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          getProbingArguments(cycle, true)
        );
        break;
      case "probing-xy-outer-corner":
        var cornerX = x + approach(cycle.approach1) * (cycle.probeClearance + tool.diameter / 2);
        var cornerY = y + approach(cycle.approach2) * (cycle.probeClearance + tool.diameter / 2);
        var cornerI = 0;
        var cornerJ = 0;
        if (cycle.probeSpacing !== undefined) {
          cornerI = cycle.probeSpacing;
          cornerJ = cycle.probeSpacing;
        }
        if ((cornerI != 0) && (cornerJ != 0)) {
          if (currentSection.strategy == "probe") {
            setProbeAngleMethod();
            probeVariables.compensationXY = "X[#185] Y[#186]";
          }
        }
        protectedProbeMove(cycle, x, y, z - cycle.depth);
        writeBlock(
          gFormat.format(65), "P" + 9816, xOutput.format(cornerX), yOutput.format(cornerY),
          conditional(cornerI != 0, "I" + xyzFormat.format(cornerI)),
          conditional(cornerJ != 0, "J" + xyzFormat.format(cornerJ)),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          getProbingArguments(cycle, true)
        );
        break;
      case "probing-x-plane-angle":
        protectedProbeMove(cycle, x, y, z - cycle.depth);
        writeBlock(
          gFormat.format(65), "P" + 9843,
          "X" + xyzFormat.format(x + approach(cycle.approach1) * (cycle.probeClearance + tool.diameter / 2)),
          "D" + xyzFormat.format(cycle.probeSpacing),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "A" + xyzFormat.format(cycle.nominalAngle != undefined ? cycle.nominalAngle : 90),
          getProbingArguments(cycle, false)
        );
        if (currentSection.strategy == "probe") {
          setProbeAngleMethod();
          probeVariables.compensationXY = "X" + xyzFormat.format(0) + " Y" + xyzFormat.format(0);
        }
        break;
      case "probing-y-plane-angle":
        protectedProbeMove(cycle, x, y, z - cycle.depth);
        writeBlock(
          gFormat.format(65), "P" + 9843,
          "Y" + xyzFormat.format(y + approach(cycle.approach1) * (cycle.probeClearance + tool.diameter / 2)),
          "D" + xyzFormat.format(cycle.probeSpacing),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "A" + xyzFormat.format(cycle.nominalAngle != undefined ? cycle.nominalAngle : 0),
          getProbingArguments(cycle, false)
        );
        if (currentSection.strategy == "probe") {
          setProbeAngleMethod();
          probeVariables.compensationXY = "X" + xyzFormat.format(0) + " Y" + xyzFormat.format(0);
        }
        break;
      case "probing-xy-pcd-hole":
        protectedProbeMove(cycle, x, y, z);
        writeBlock(
          gFormat.format(65), "P" + 9819,
          "A" + xyzFormat.format(cycle.pcdStartingAngle),
          "B" + xyzFormat.format(cycle.numberOfSubfeatures),
          "C" + xyzFormat.format(cycle.widthPCD),
          "D" + xyzFormat.format(cycle.widthFeature),
          "K" + xyzFormat.format(z - cycle.depth),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          getProbingArguments(cycle, false)
        );
        if (cycle.updateToolWear) {
          error(localize("Action -Update Tool Wear- is not supported with this cycle"));
          return;
        }
        break;
      case "probing-xy-pcd-boss":
        protectedProbeMove(cycle, x, y, z);
        writeBlock(
          gFormat.format(65), "P" + 9819,
          "A" + xyzFormat.format(cycle.pcdStartingAngle),
          "B" + xyzFormat.format(cycle.numberOfSubfeatures),
          "C" + xyzFormat.format(cycle.widthPCD),
          "D" + xyzFormat.format(cycle.widthFeature),
          "Z" + xyzFormat.format(z - cycle.depth),
          "Q" + xyzFormat.format(cycle.probeOvertravel),
          "R" + xyzFormat.format(cycle.probeClearance),
          getProbingArguments(cycle, false)
        );
        if (cycle.updateToolWear) {
          error(localize("Action -Update Tool Wear- is not supported with this cycle"));
          return;
        }
        break;
      default:
        expandCyclePoint(x, y, z);
    }

    // place cycle operation in subprogram
    if (cycleSubprogramIsActive) {
      if (forceCycle || cycleExpanded || isProbeOperation()) {
        cycleSubprogramIsActive = false;
      } else {
        // call subprogram
        writeBlock(mFormat.format(97), "P" + nFormat.format(currentSubprogram));
        subprogramStart(new Vector(x, y, z), new Vector(0, 0, 0), false);
      }
    }
    if (incrementalMode) { // set current position to clearance height
      setCyclePosition(cycle.clearance);
    }

    // 2nd through nth cycle point
  } else {
    if (cycleExpanded) {
      expandCyclePoint(x, y, z);
    } else {
      var _x;
      var _y;
      var _z;
      if (!xyzFormat.areDifferent(x, xOutput.getCurrent()) &&
        !xyzFormat.areDifferent(y, yOutput.getCurrent()) &&
        !xyzFormat.areDifferent(z, zOutput.getCurrent())) {
        switch (gPlaneModal.getCurrent()) {
          case 17: // XY
            xOutput.reset(); // at least one axis is required
            break;
          case 18: // ZX
            zOutput.reset(); // at least one axis is required
            break;
          case 19: // YZ
            yOutput.reset(); // at least one axis is required
            break;
        }
      }
      if (incrementalMode) { // set current position to retract height
        setCyclePosition(cycle.retract);
      }
      writeBlock(xOutput.format(x), yOutput.format(y), zOutput.format(z));
      if (incrementalMode) { // set current position to clearance height
        setCyclePosition(cycle.clearance);
      }
    }
  }
}

function getProbingArguments(cycle, updateWCS) {
  var outputWCSCode = updateWCS && currentSection.strategy == "probe";
  var probeOutputWorkOffset = currentSection.probeWorkOffset;
  if (outputWCSCode) {
    validate(
      probeOutputWorkOffset > 0 && (probeOutputWorkOffset > 6 ? probeOutputWorkOffset - 6 : probeOutputWorkOffset) <= 99,
      "Work offset is out of range."
    );
    var nextWorkOffset = hasNextSection() ? getNextSection().workOffset == 0 ? 1 : getNextSection().workOffset : -1;
    if (probeOutputWorkOffset == nextWorkOffset) {
      currentWorkOffset = undefined;
    }
  }
  return [
    (cycle.angleAskewAction == "stop-message" ? "B" + xyzFormat.format(cycle.toleranceAngle ? cycle.toleranceAngle : 0) : undefined),
    ((cycle.updateToolWear && cycle.toolWearErrorCorrection < 100) ? "F" + xyzFormat.format(cycle.toolWearErrorCorrection ? cycle.toolWearErrorCorrection / 100 : 100) : undefined),
    (cycle.wrongSizeAction == "stop-message" ? "H" + xyzFormat.format(cycle.toleranceSize ? cycle.toleranceSize : 0) : undefined),
    (cycle.outOfPositionAction == "stop-message" ? "M" + xyzFormat.format(cycle.tolerancePosition ? cycle.tolerancePosition : 0) : undefined),
    ((cycle.updateToolWear && cycleType == "probing-z") ? "T" + xyzFormat.format(cycle.toolLengthOffset) : undefined),
    ((cycle.updateToolWear && cycleType !== "probing-z") ? "T" + xyzFormat.format(cycle.toolDiameterOffset) : undefined),
    (cycle.updateToolWear ? "V" + xyzFormat.format(cycle.toolWearUpdateThreshold ? cycle.toolWearUpdateThreshold : 0) : undefined),
    (cycle.printResults ? "W" + xyzFormat.format(1 + cycle.incrementComponent) : undefined), // 1 for advance feature, 2 for reset feature count and advance component number. first reported result in a program should use W2.
    conditional(outputWCSCode, (probeOutputWorkOffset > 6 ? probeExtWCSFormat.format((probeOutputWorkOffset - 6)) : probeWCSFormat.format(probeOutputWorkOffset)))
  ];
}

function onCycleEnd() {
  if (isProbeOperation()) {
    zOutput.reset();
    gMotionModal.reset();
    writeBlock(gFormat.format(65), "P" + 9810, zOutput.format(cycle.retract)); // protected retract move
  } else {
    if (cycleSubprogramIsActive) {
      subprogramEnd();
      cycleSubprogramIsActive = false;
    }
    if (!cycleExpanded) {
      writeBlock(gCycleModal.format(80), conditional(getProperty("useG95forTapping"), gFeedModeModal.format(94)));
      gMotionModal.reset();
    }
  }
  if (getProperty("useLiveConnection") && isProbeOperation() && typeof liveConnectionWriteData == "function") {
    liveConnectionWriteData("macroEnd");
  }
}

var pendingRadiusCompensation = -1;

function onRadiusCompensation() {
  pendingRadiusCompensation = radiusCompensation;
}

function onRapid(_x, _y, _z) {
  var x = xOutput.format(_x);
  var y = yOutput.format(_y);
  var z = zOutput.format(_z);
  if (x || y || z) {
    if (pendingRadiusCompensation >= 0) {
      error(localize("Radius compensation mode cannot be changed at rapid traversal."));
      return;
    }
    if (!getProperty("useG0") && (((x ? 1 : 0) + (y ? 1 : 0) + (z ? 1 : 0)) > 1)) {
      // axes are not synchronized
      writeBlock(gFeedModeModal.format(94), gMotionModal.format(1), x, y, z, getFeed(highFeedrate));
    } else {
      writeBlock(gMotionModal.format(0), x, y, z);
      forceFeed();
    }
  }
}

function onLinear(_x, _y, _z, feed) {
  if (pendingRadiusCompensation >= 0) {
    // ensure that we end at desired position when compensation is turned off
    xOutput.reset();
    yOutput.reset();
  }
  var x = xOutput.format(_x);
  var y = yOutput.format(_y);
  var z = zOutput.format(_z);
  var f = getFeed(feed);
  if (x || y || z) {
    if (pendingRadiusCompensation >= 0) {
      pendingRadiusCompensation = -1;
      var d = tool.diameterOffset;
      if ((d > 200 && d < 1000) || d > 9999) {
        warning(localize("Diameter offset out of range."));
      }
      writeBlock(gPlaneModal.format(17));
      switch (radiusCompensation) {
        case RADIUS_COMPENSATION_LEFT:
          dOutput.reset();
          writeBlock(gFeedModeModal.format(94), gMotionModal.format(1), gFormat.format(41), x, y, z, dOutput.format(d), f);
          break;
        case RADIUS_COMPENSATION_RIGHT:
          dOutput.reset();
          writeBlock(gFeedModeModal.format(94), gMotionModal.format(1), gFormat.format(42), x, y, z, dOutput.format(d), f);
          break;
        default:
          writeBlock(gFeedModeModal.format(94), gMotionModal.format(1), gFormat.format(40), x, y, z, f);
      }
    } else {
      writeBlock(gFeedModeModal.format(94), gMotionModal.format(1), x, y, z, f);
    }
  } else if (f) {
    if (getNextRecord().isMotion()) { // try not to output feed without motion
      forceFeed(); // force feed on next line
    } else {
      writeBlock(gFeedModeModal.format(94), gMotionModal.format(1), f);
    }
  }
}

var forceG0 = false;
function onRapid5D(_x, _y, _z, _a, _b, _c) {
  if (!currentSection.isOptimizedForMachine()) {
    error(localize("This post configuration has not been customized for 5-axis simultaneous toolpath."));
    return;
  }
  if (pendingRadiusCompensation >= 0) {
    error(localize("Radius compensation mode cannot be changed at rapid traversal."));
    return;
  }

  var num =
    (xyzFormat.areDifferent(_x, xOutput.getCurrent()) ? 1 : 0) +
    (xyzFormat.areDifferent(_y, yOutput.getCurrent()) ? 1 : 0) +
    (xyzFormat.areDifferent(_z, zOutput.getCurrent()) ? 1 : 0) +
    ((aOutput.isEnabled() && abcFormat.areDifferent(_a, aOutput.getCurrent())) ? 1 : 0) +
    ((bOutput.isEnabled() && abcFormat.areDifferent(_b, bOutput.getCurrent())) ? 1 : 0) +
    ((cOutput.isEnabled() && abcFormat.areDifferent(_c, cOutput.getCurrent())) ? 1 : 0);
  /*
  if (!getProperty("useG0") && !forceG0 && (operationSupportsTCP || (num > 1))) {
    invokeOnLinear5D(_x, _y, _z, _a, _b, _c, highFeedrate); // onLinear5D handles inverse time feedrates
    return;
  }
  */
  var x = xOutput.format(_x);
  var y = yOutput.format(_y);
  var z = zOutput.format(_z);
  var a = aOutput.format(_a);
  var b = bOutput.format(_b);
  var c = cOutput.format(_c);

  if (x || y || z || a || b || c) {
    if (!getProperty("useG0") && (operationSupportsTCP || (num > 1))) {
      // axes are not synchronized
      writeBlock(gFeedModeModal.format(94), gMotionModal.format(1), x, y, z, a, b, c, getFeed(highFeedrate));
    } else {
      writeBlock(gMotionModal.format(0), x, y, z, a, b, c);
      forceFeed();
    }
  }
}

function onLinear5D(_x, _y, _z, _a, _b, _c, feed, feedMode) {
  if (!currentSection.isOptimizedForMachine()) {
    error(localize("This post configuration has not been customized for 5-axis simultaneous toolpath."));
    return;
  }
  if (pendingRadiusCompensation >= 0) {
    error(localize("Radius compensation cannot be activated/deactivated for 5-axis move."));
    return;
  }

  var x = xOutput.format(_x);
  var y = yOutput.format(_y);
  var z = zOutput.format(_z);
  var a = aOutput.format(_a);
  var b = bOutput.format(_b);
  var c = cOutput.format(_c);

  if (feedMode == FEED_INVERSE_TIME) {
    forceFeed();
  }
  var f;
  switch (feedMode) {
    case FEED_INVERSE_TIME:
      f = inverseTimeOutput.format(feed);
      break;
    case FEED_DPM:
      f = feedOutput.format(feed);
      break;
    default: // FEED_FPM
      f = (operationSupportsTCP || !(a || b || c)) ? getFeed(feed) : getFeedDPM(_x, _y, _z, feed);
      break;
  }
  var fMode = (feedMode == FEED_INVERSE_TIME) ? 93 : 94;

  if (x || y || z || a || b || c) {
    writeBlock(gFeedModeModal.format(fMode), gMotionModal.format(1), x, y, z, a, b, c, f);
  } else if (f) {
    if (getNextRecord().isMotion()) { // try not to output feed without motion
      forceFeed(); // force feed on next line
    } else {
      writeBlock(gFeedModeModal.format(fMode), gMotionModal.format(1), f);
    }
  }
}

var dpmFeedToler = 0.5;
var previousDPMFeed = 0;
function getFeedDPM(_x, _y, _z, feed) {
  var xyz = new Vector(_x, _y, _z);
  var axis = machineConfiguration.getNumberOfAxes() == 5 ? machineConfiguration.getAxisV() : machineConfiguration.getAxisU();
  var d = Vector.diff(xyz, axis.getOffset()).abs;
  if (isSameDirection(axis.getAxis(), new Vector(0, 0, 1)) || isSameDirection(axis.getAxis(), new Vector(0, 0, -1))) {
    radius = new Vector(d.x, d.y, 0).length;
  } else if (isSameDirection(axis.getAxis(), new Vector(0, 1, 0)) || isSameDirection(axis.getAxis(), new Vector(0, -1, 0))) {
    radius = new Vector(d.x, 0, d.z).length;
  } else {
    radius = new Vector(0, d.y, d.z).length;
  }
  var feedRate = feed / (radius / (toPreciseUnit(getProperty("setting34"), IN) / 2.0));
  var dpmFeed = Math.min(feedRate, highFeedrate);
  if (Math.abs(dpmFeed - previousDPMFeed) < dpmFeedToler) {
    return "";
  }
  previousDPMFeed = dpmFeed;
  return feedOutput.format(dpmFeed);
}

function moveToSafeRetractPosition(isRetracted) {
  var _skipBlock = skipBlock;
  if (!isRetracted) {
    writeRetract(Z);
  }
  if (getProperty("forceHomeOnIndexing")) {
    skipBlock = _skipBlock;
    writeRetract(X, Y);
  }
}

// Start of onRewindMachine logic
/** Allow user to override the onRewind logic. */
function onRewindMachineEntry(_a, _b, _c) {
  return false;
}

/** Retract to safe position before indexing rotaries. */
function onMoveToSafeRetractPosition() {
  // cancel TCP so that tool doesn't follow rotaries
  if (currentSection.isMultiAxis() && operationSupportsTCP) {
    disableLengthCompensation(false, "TCPC OFF");
  }
  moveToSafeRetractPosition(false);
}

/** Rotate axes to new position above reentry position */
function onRotateAxes(_x, _y, _z, _a, _b, _c) {
  // position rotary axes
  xOutput.disable();
  yOutput.disable();
  zOutput.disable();
  forceG0 = true;
  unwindABC(new Vector(_a, _b, _c));
  invokeOnRapid5D(_x, _y, _z, _a, _b, _c);
  setCurrentABC(new Vector(_a, _b, _c));
  xOutput.enable();
  yOutput.enable();
  zOutput.enable();
}

/** Return from safe position after indexing rotaries. */
function onReturnFromSafeRetractPosition(_x, _y, _z) {
  // reinstate TCP
  if (operationSupportsTCP) {
    if (useDwoForPositioning) {
      prepositionDWO(new Vector(_x, _y, _z), getCurrentDirection(), false);
    } else {
      writeBlock(gMotionModal.format(0), gFormat.format(234), hFormat.format(tool.lengthOffset), formatComment("TCPC ON"));
      forceFeed();
      lengthCompensationActive = true;
    }
  } else {
    // position in XY
    forceXYZ();
    xOutput.reset();
    yOutput.reset();
    zOutput.disable();
    invokeOnRapid(_x, _y, _z);

    // position in Z
    zOutput.enable();
    invokeOnRapid(_x, _y, _z);
  }
}
// End of onRewindMachine logic

function onCircular(clockwise, cx, cy, cz, x, y, z, feed) {
  if (isSpiral()) {
    var startRadius = getCircularStartRadius();
    var endRadius = getCircularRadius();
    var dr = Math.abs(endRadius - startRadius);
    if (dr > maximumCircularRadiiDifference) { // maximum limit
      linearize(tolerance); // or alternatively use other G-codes for spiral motion
      return;
    }
  }

  if (pendingRadiusCompensation >= 0) {
    error(localize("Radius compensation cannot be activated/deactivated for a circular move."));
    return;
  }

  var start = getCurrentPosition();

  if (isFullCircle()) {
    if (getProperty("useRadius") || isHelical()) { // radius mode does not support full arcs
      linearize(tolerance);
      return;
    }
    switch (getCircularPlane()) {
      case PLANE_XY:
        writeBlock(gPlaneModal.format(17), gFeedModeModal.format(94), gMotionModal.format(clockwise ? 2 : 3), iOutput.format(cx - start.x, 0), jOutput.format(cy - start.y, 0), getFeed(feed));
        break;
      case PLANE_ZX:
        writeBlock(gPlaneModal.format(18), gFeedModeModal.format(94), gMotionModal.format(clockwise ? 2 : 3), iOutput.format(cx - start.x, 0), kOutput.format(cz - start.z, 0), getFeed(feed));
        break;
      case PLANE_YZ:
        writeBlock(gPlaneModal.format(19), gFeedModeModal.format(94), gMotionModal.format(clockwise ? 2 : 3), jOutput.format(cy - start.y, 0), kOutput.format(cz - start.z, 0), getFeed(feed));
        break;
      default:
        linearize(tolerance);
    }
  } else if (!getProperty("useRadius")) {
    switch (getCircularPlane()) {
      case PLANE_XY:
        writeBlock(gPlaneModal.format(17), gFeedModeModal.format(94), gMotionModal.format(clockwise ? 2 : 3), xOutput.format(x), yOutput.format(y), zOutput.format(z), iOutput.format(cx - start.x, 0), jOutput.format(cy - start.y, 0), getFeed(feed));
        break;
      case PLANE_ZX:
        writeBlock(gPlaneModal.format(18), gFeedModeModal.format(94), gMotionModal.format(clockwise ? 2 : 3), xOutput.format(x), yOutput.format(y), zOutput.format(z), iOutput.format(cx - start.x, 0), kOutput.format(cz - start.z, 0), getFeed(feed));
        break;
      case PLANE_YZ:
        writeBlock(gPlaneModal.format(19), gFeedModeModal.format(94), gMotionModal.format(clockwise ? 2 : 3), xOutput.format(x), yOutput.format(y), zOutput.format(z), jOutput.format(cy - start.y, 0), kOutput.format(cz - start.z, 0), getFeed(feed));
        break;
      default:
        linearize(tolerance);
    }
  } else { // use radius mode
    var r = getCircularRadius();
    if (toDeg(getCircularSweep()) > (180 + 1e-9)) {
      r = -r; // allow up to <360 deg arcs
    }
    switch (getCircularPlane()) {
      case PLANE_XY:
        writeBlock(gPlaneModal.format(17), gFeedModeModal.format(94), gMotionModal.format(clockwise ? 2 : 3), xOutput.format(x), yOutput.format(y), zOutput.format(z), "R" + rFormat.format(r), getFeed(feed));
        break;
      case PLANE_ZX:
        writeBlock(gPlaneModal.format(18), gFeedModeModal.format(94), gMotionModal.format(clockwise ? 2 : 3), xOutput.format(x), yOutput.format(y), zOutput.format(z), "R" + rFormat.format(r), getFeed(feed));
        break;
      case PLANE_YZ:
        writeBlock(gPlaneModal.format(19), gFeedModeModal.format(94), gMotionModal.format(clockwise ? 2 : 3), xOutput.format(x), yOutput.format(y), zOutput.format(z), "R" + rFormat.format(r), getFeed(feed));
        break;
      default:
        linearize(tolerance);
    }
  }
}

var currentCoolantMode = COOLANT_OFF;
var coolantOff = undefined;
var isOptionalCoolant = false;

function setCoolant(coolant) {
  var coolantCodes = getCoolantCodes(coolant);
  if (Array.isArray(coolantCodes)) {
    if (singleLineCoolant) {
      skipBlock = isOptionalCoolant;
      writeBlock(coolantCodes.join(getWordSeparator()));
    } else {
      for (var c in coolantCodes) {
        skipBlock = isOptionalCoolant;
        writeBlock(coolantCodes[c]);
      }
    }
    return undefined;
  }
  return coolantCodes;
}

var isSpecialCoolantActive = false;

function getCoolantCodes(coolant) {
  isOptionalCoolant = false;
  var multipleCoolantBlocks = new Array(); // create a formatted array to be passed into the outputted line
  if (!coolants) {
    error(localize("Coolants have not been defined."));
  }
  if (tool.type == TOOL_PROBE) { // avoid coolant output for probing
    coolant = COOLANT_OFF;
  }
  if (coolant == currentCoolantMode) {
    if (operationNeedsSafeStart && coolant != COOLANT_OFF && !isSpecialCoolantActive) {
      isOptionalCoolant = true;
    } else if (!forceCoolant || coolant == COOLANT_OFF) {
      return undefined; // coolant is already active
    }
  }
  if ((coolant != COOLANT_OFF) && (currentCoolantMode != COOLANT_OFF) && (coolantOff != undefined) && !isOptionalCoolant && !forceCoolant) {
    if (Array.isArray(coolantOff)) {
      for (var i in coolantOff) {
        multipleCoolantBlocks.push(coolantOff[i]);
      }
    } else {
      multipleCoolantBlocks.push(coolantOff);
    }
  }
  forceCoolant = false;

  if (isSpecialCoolantActive) {
    forceSpindleSpeed = true;
  }
  var m;
  var coolantCodes = {};
  for (var c in coolants) { // find required coolant codes into the coolants array
    if (coolants[c].id == coolant) {
      isSpecialCoolantActive = (coolants[c].id == COOLANT_THROUGH_TOOL) || (coolants[c].id == COOLANT_FLOOD_THROUGH_TOOL) || (coolants[c].id == COOLANT_AIR_THROUGH_TOOL);
      coolantCodes.on = coolants[c].on;
      if (coolants[c].off != undefined) {
        coolantCodes.off = coolants[c].off;
        break;
      } else {
        for (var i in coolants) {
          if (coolants[i].id == COOLANT_OFF) {
            coolantCodes.off = coolants[i].off;
            break;
          }
        }
      }
    }
  }
  if (coolant == COOLANT_OFF) {
    m = !coolantOff ? coolantCodes.off : coolantOff; // use the default coolant off command when an 'off' value is not specified
  } else {
    coolantOff = coolantCodes.off;
    m = coolantCodes.on;
  }

  if (!m) {
    onUnsupportedCoolant(coolant);
    m = 9;
  } else {
    if (Array.isArray(m)) {
      for (var i in m) {
        multipleCoolantBlocks.push(m[i]);
      }
    } else {
      multipleCoolantBlocks.push(m);
    }
    currentCoolantMode = coolant;
    for (var i in multipleCoolantBlocks) {
      if (typeof multipleCoolantBlocks[i] == "number") {
        multipleCoolantBlocks[i] = mFormat.format(multipleCoolantBlocks[i]);
      }
    }
    return multipleCoolantBlocks; // return the single formatted coolant value
  }
  return undefined;
}

var mapCommand = {
  COMMAND_END: 2,
  COMMAND_SPINDLE_CLOCKWISE: 3,
  COMMAND_SPINDLE_COUNTERCLOCKWISE: 4,
  COMMAND_STOP_SPINDLE: 5,
  COMMAND_ORIENTATE_SPINDLE: 19,
  COMMAND_LOAD_TOOL: 6
};

function onCommand(command) {
  switch (command) {
    case COMMAND_STOP:
      writeBlock(mFormat.format(0));
      forceSpindleSpeed = true;
      forceCoolant = true;
      return;
    case COMMAND_OPTIONAL_STOP:
      writeBlock(mFormat.format(1));
      forceSpindleSpeed = true;
      forceCoolant = true;
      return;
    case COMMAND_COOLANT_ON:
      setCoolant(COOLANT_FLOOD);
      return;
    case COMMAND_COOLANT_OFF:
      setCoolant(COOLANT_OFF);
      return;
    case COMMAND_START_SPINDLE:
      onCommand(tool.clockwise ? COMMAND_SPINDLE_CLOCKWISE : COMMAND_SPINDLE_COUNTERCLOCKWISE);
      return;
    case COMMAND_LOCK_MULTI_AXIS:
      if (machineConfiguration.isMultiAxisConfiguration() && (machineConfiguration.getNumberOfAxes() >= 4)) {
        var _skipBlock = skipBlock;
        writeBlock(mClampModal.format(10)); // lock 4th-axis motion
        if (machineConfiguration.getNumberOfAxes() == 5) {
          skipBlock = _skipBlock;
          writeBlock(mClampModal.format(12)); // lock 5th-axis motion
        }
      }
      return;
    case COMMAND_UNLOCK_MULTI_AXIS:
      var outputClampCodes = getProperty("useClampCodes") || currentSection.isMultiAxis();
      if (outputClampCodes && machineConfiguration.isMultiAxisConfiguration() && (machineConfiguration.getNumberOfAxes() >= 4)) {
        var _skipBlock = skipBlock;
        writeBlock(mClampModal.format(11)); // unlock 4th-axis motion
        if (machineConfiguration.getNumberOfAxes() == 5) {
          skipBlock = _skipBlock;
          writeBlock(mClampModal.format(13)); // unlock 5th-axis motion
        }
      }
      return;
    case COMMAND_BREAK_CONTROL:
      if (!toolChecked) { // avoid duplicate COMMAND_BREAK_CONTROL
        prepareForToolCheck();
        writeBlock(
          gFormat.format(65),
          "P" + 9853,
          "T" + toolFormat.format(tool.number),
          "B" + xyzFormat.format(0),
          "H" + xyzFormat.format(getProperty("toolBreakageTolerance"))
        );
        toolChecked = true;
        lengthCompensationActive = false; // macro 9853 cancels tool length compensation
      }
      return;
    case COMMAND_TOOL_MEASURE:
      measureTool = true;
      return;
    case COMMAND_START_CHIP_TRANSPORT:
      writeBlock(mFormat.format(31));
      return;
    case COMMAND_STOP_CHIP_TRANSPORT:
      writeBlock(mFormat.format(33));
      return;
    case COMMAND_PROBE_ON:
      return;
    case COMMAND_PROBE_OFF:
      return;
  }

  var stringId = getCommandStringId(command);
  var mcode = mapCommand[stringId];
  if (mcode != undefined) {
    writeBlock(mFormat.format(mcode));
  } else {
    onUnsupportedCommand(command);
  }
}

var toolChecked = false; // specifies that the tool has been checked with the probe

function onSectionEnd() {
  if (isInspectionOperation() && !isLastSection()) {
    writeBlock(gFormat.format(103), "P0", formatComment("LOOKAHEAD ON"));
  }
  if (!isLastSection() && (getNextSection().getTool().coolant != tool.coolant)) {
    setCoolant(COOLANT_OFF);
  }
  if ((((getCurrentSectionId() + 1) >= getNumberOfSections()) ||
    (tool.number != getNextSection().getTool().number)) &&
    tool.breakControl) {
    onCommand(COMMAND_BREAK_CONTROL);
  } else {
    toolChecked = false;
  }

  if (true) {
    if (isRedirecting()) {
      if (firstPattern) {
        var finalPosition = getFramePosition(currentSection.getFinalPosition());
        var abc;
        if (currentSection.isMultiAxis() && machineConfiguration.isMultiAxisConfiguration()) {
          abc = currentSection.getFinalToolAxisABC();
        } else {
          abc = currentWorkPlaneABC;
        }
        if (abc == undefined) {
          abc = new Vector(0, 0, 0);
        }
        setAbsoluteMode(finalPosition, abc);
        subprogramEnd();
      }
    }
  }
  forceAny();

  if (currentSection.isMultiAxis()) {
    writeBlock(gFeedModeModal.format(94)); // inverse time feed off
    if (operationSupportsTCP) {
      disableLengthCompensation(false, "TCPC OFF");
    }
  }

  if (isProbeOperation()) {
    writeBlock(gFormat.format(65), "P" + 9833); // spin the probe off
    if (probeVariables.probeAngleMethod != "G68") {
      setProbeAngle(); // output probe angle rotations if required
    }
  }

  if (getProperty("useLiveConnection") && (typeof liveConnectionWriteData == "function")) {
    if (isInspectionOperation()) {
      liveConnectionWriteData("inspectSurfaceAlarm");
    }
    liveConnectionWriteData("toolpathEnd");
  }
  operationNeedsSafeStart = false; // reset for next section
}

/** Output block to do safe retract and/or move to home position. */
function writeRetract() {
  var words = []; // store all retracted axes in an array
  var retractAxes = new Array(false, false, false);
  var method = getProperty("safePositionMethod");
  if (method == "clearanceHeight") {
    if (!is3D()) {
      error(localize("Safe retract option 'Clearance Height' is only supported when all operations are along the setup Z-axis."));
    }
    return;
  }
  validate(arguments.length != 0, "No axis specified for writeRetract().");

  for (i in arguments) {
    retractAxes[arguments[i]] = true;
  }
  if ((retractAxes[0] || retractAxes[1]) && !retracted && !skipBlock) { // retract Z first before moving to X/Y home
    error(localize("Retracting in X/Y is not possible without being retracted in Z."));
    return;
  }
  // special conditions
  if (retractAxes[0] || retractAxes[1]) {
    method = "G53";
  }
  cancelG68Rotation(); // G68 has to be canceled for retracts

  // define home positions
  var _xHome;
  var _yHome;
  var _zHome;
  if (method == "G28") {
    _xHome = toPreciseUnit(0, MM);
    _yHome = toPreciseUnit(0, MM);
    _zHome = toPreciseUnit(0, MM);
  } else {
    if (homePositionCenter &&
      hasParameter("part-upper-x") && hasParameter("part-lower-x")) {
      _xHome = (getParameter("part-upper-x") + getParameter("part-lower-x")) / 2;
    } else {
      _xHome = machineConfiguration.hasHomePositionX() ? machineConfiguration.getHomePositionX() : toPreciseUnit(0, MM);
    }
    _yHome = machineConfiguration.hasHomePositionY() ? machineConfiguration.getHomePositionY() : toPreciseUnit(0, MM);
    _zHome = machineConfiguration.getRetractPlane() != 0 ? machineConfiguration.getRetractPlane() : toPreciseUnit(0, MM);
  }
  for (var i = 0; i < arguments.length; ++i) {
    switch (arguments[i]) {
      case X:
        // special conditions
        if (homePositionCenter) { // output X in standard block by itself if centering
          writeBlock(gMotionModal.format(0), "X" + xyzFormat.format(_xHome));
          xOutput.reset();
          break;
        }
        words.push("X" + xyzFormat.format(_xHome));
        xOutput.reset();
        break;
      case Y:
        words.push("Y" + xyzFormat.format(_yHome));
        yOutput.reset();
        break;
      case Z:
        words.push("Z" + xyzFormat.format(_zHome));
        zOutput.reset();
        retracted = !skipBlock;
        break;
      default:
        error(localize("Unsupported axis specified for writeRetract()."));
        return;
    }
  }
  if (words.length > 0) {
    switch (method) {
      case "G28":
        gMotionModal.reset();
        gAbsIncModal.reset();
        writeBlock(gFormat.format(28), gAbsIncModal.format(91), words);
        writeBlock(gAbsIncModal.format(90));
        break;
      case "G53":
        gMotionModal.reset();
        writeBlock(gAbsIncModal.format(90), gFormat.format(53), gMotionModal.format(0), words);
        break;
      default:
        error(localize("Unsupported safe position method."));
        return;
    }
  }
}

var isDPRNTopen = false;
function inspectionCreateResultsFileHeader() {
  if (getProperty("useLiveConnection") && controlType != "NGC") {
    return; // do not DPRNT if Live connection is active on a classic control
  }
  if (isDPRNTopen) {
    if (!getProperty("singleResultsFile")) {
      writeln("DPRNT[END]");
      writeBlock("PCLOS");
      isDPRNTopen = false;
    }
  }

  if (isProbeOperation() && !printProbeResults()) {
    return; // if print results is not desired by probe/ probeWCS
  }

  if (!isDPRNTopen) {
    writeBlock("PCLOS");
    writeBlock("POPEN");
    // check for existence of none alphanumeric characters but not spaces
    var resFile;
    if (getProperty("singleResultsFile")) {
      resFile = getParameter("job-description") + "-RESULTS";
    } else {
      resFile = getParameter("operation-comment") + "-RESULTS";
    }
    resFile = resFile.replace(/:/g, "-");
    resFile = resFile.replace(/[^a-zA-Z0-9 -]/g, "");
    resFile = resFile.replace(/\s/g, "-");
    writeln("DPRNT[START]");
    writeln("DPRNT[RESULTSFILE*" + resFile + "]");
    if (hasGlobalParameter("document-id")) {
      writeln("DPRNT[DOCUMENTID*" + getGlobalParameter("document-id") + "]");
    }
    if (hasGlobalParameter("model-version")) {
      writeln("DPRNT[MODELVERSION*" + getGlobalParameter("model-version") + "]");
    }
  }
  if (isProbeOperation() && printProbeResults()) {
    isDPRNTopen = true;
  }
}

function getPointNumber() {
  if (typeof inspectionWriteVariables == "function") {
    return (inspectionVariables.pointNumber);
  } else {
    return ("#172[60]");
  }
}

function inspectionWriteCADTransform() {
  if (getProperty("useLiveConnection") && controlType != "NGC") {
    return; // do not DPRNT if Live connection is active on a classic control
  }
  var cadOrigin = currentSection.getModelOrigin();
  var cadWorkPlane = currentSection.getModelPlane().getTransposed();
  var cadEuler = cadWorkPlane.getEuler2(EULER_XYZ_S);
  writeln(
    "DPRNT[G331" +
    "*N" + getPointNumber() +
    "*A" + abcFormat.format(cadEuler.x) +
    "*B" + abcFormat.format(cadEuler.y) +
    "*C" + abcFormat.format(cadEuler.z) +
    "*X" + xyzFormat.format(-cadOrigin.x) +
    "*Y" + xyzFormat.format(-cadOrigin.y) +
    "*Z" + xyzFormat.format(-cadOrigin.z) +
    "]"
  );
}

function inspectionWriteWorkplaneTransform() {
  var orientation = (machineConfiguration.isMultiAxisConfiguration()) ? machineConfiguration.getOrientation(getCurrentDirection()) : currentSection.workPlane;
  var abc = orientation.getEuler2(EULER_XYZ_S);
  if ((getProperty("useLiveConnection"))) {
    liveConnectorInterface("WORKPLANE");
    writeBlock(inspectionVariables.liveConnectionWPA + " = " + abcFormat.format(abc.x));
    writeBlock(inspectionVariables.liveConnectionWPB + " = " + abcFormat.format(abc.y));
    writeBlock(inspectionVariables.liveConnectionWPC + " = " + abcFormat.format(abc.z));
    writeBlock("IF [" + inspectionVariables.workplaneStartAddress, "EQ -1] THEN",
      inspectionVariables.workplaneStartAddress, "=", currentSection.getParameter("autodeskcam:operation-id")
    );
  }
  if (getProperty("useLiveConnection") && controlType != "NGC") {
    return; // do not DPRNT if Live connection is active on a classic control
  }
  writeln("DPRNT[G330" +
    "*N" + getPointNumber() +
    "*A" + abcFormat.format(abc.x) +
    "*B" + abcFormat.format(abc.y) +
    "*C" + abcFormat.format(abc.z) +
    "*X0*Y0*Z0*I0*R0]"
  );
}

function writeProbingToolpathInformation(cycleDepth) {
  if (getProperty("useLiveConnection") && controlType != "NGC") {
    return; // do not DPRNT if Live connection is active on a classic control
  }
  writeln("DPRNT[TOOLPATHID*" + getParameter("autodeskcam:operation-id") + "]");
  if (isInspectionOperation()) {
    writeln("DPRNT[TOOLPATH*" + getParameter("operation-comment") + "]");
  } else {
    writeln("DPRNT[CYCLEDEPTH*" + xyzFormat.format(cycleDepth) + "]");
  }
}

function onClose() {
  if (!(getProperty("useLiveConnection") && controlType != "NGC")) {
    if (isDPRNTopen) {
      writeln("DPRNT[END]");
      writeBlock("PCLOS");
      isDPRNTopen = false;

    }
  }
  if (!getProperty("useLiveConnection") && typeof inspectionProcessSectionEnd == "function") {
    inspectionProcessSectionEnd();
  }

  cancelG68Rotation();
  writeln("");

  optionalSection = false;

  onCommand(COMMAND_STOP_SPINDLE);
  onCommand(COMMAND_COOLANT_OFF);

  // retract
  writeRetract(Z);
  if (!getProperty("homePositionCenter") || (machineConfiguration.isMultiAxisConfiguration() && getCurrentDirection().length != 0)) {
    writeRetract(X, Y);
  }

  if (activeG254) {
    writeBlock(gFormat.format(255)); // cancel DWO
    activeG254 = false;
  }
  // Unwind Rotary table at end
  if (machineConfiguration.isMultiAxisConfiguration()) {
    unwindABC(new Vector(0, 0, 0)); // force unwind at the end of the program
    positionABC(new Vector(0, 0, 0), true);
  }
  if (getProperty("homePositionCenter")) {
    homePositionCenter = getProperty("homePositionCenter");
    if (getProperty("safePositionMethod") == "clearanceHeight") {
      retracted = true;
      setProperty("safePositionMethod", "G53");
      writeRetract(X);
    } else {
      writeRetract(X, Y);
    }
  }

  if (getProperty("useLiveConnection")) {
    writeComment("Live Connection Footer"); // Live connection write footer
    writeBlock(inspectionVariables.liveConnectionStatus, "= 2"); // If using live connection set results active to a 2 to signify program end
  }

  onImpliedCommand(COMMAND_END);
  onImpliedCommand(COMMAND_STOP_SPINDLE);
  writeBlock(mFormat.format(30)); // stop program, spindle stop, coolant off
  if (subprograms.length > 0) {
    writeln("");
    write(subprograms);
  }
  writeln("");
  writeln("%");
}

/*
keywords += (keywords ? " MODEL_IMAGE" : "MODEL_IMAGE");

function onTerminate() {
  var outputPath = getOutputPath();
  var programFilename = FileSystem.getFilename(outputPath);
  var programSize = FileSystem.getFileSize(outputPath);
  var postPath = findFile("setup-sheet-excel-2007.cps");
  var intermediatePath = getIntermediatePath();
  var a = "--property unit " + ((unit == IN) ? "0" : "1"); // use 0 for inch and 1 for mm
  if (programName) {
    a += " --property programName \"'" + programName + "'\"";
  }
  if (programComment) {
    a += " --property programComment \"'" + programComment + "'\"";
  }
  a += " --property programFilename \"'" + programFilename + "'\"";
  a += " --property programSize \"" + programSize + "\"";
  a += " --noeditor --log temp.log \"" + postPath + "\" \"" + intermediatePath + "\" \"" + FileSystem.replaceExtension(outputPath, "xlsx") + "\"";
  execute(getPostProcessorPath(), a, false, "");
  executeNoWait("excel", "\"" + FileSystem.replaceExtension(outputPath, "xlsx") + "\"", false, "");
}
*/
