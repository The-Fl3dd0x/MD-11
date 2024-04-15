# McDonnell Douglas MD-11 FMS
# Copyright (c) 2024 Josh Davidson (Octal450)

# Properties and Data
var Internal = {
	bankAngle1: props.globals.initNode("/fms/internal/bank-limit-1"),
	bankAngle2: props.globals.initNode("/fms/internal/bank-limit-2"),
	bankAngleVss: props.globals.initNode("/fms/internal/bank-limit-vss"),
	cgPercentMac: props.globals.initNode("/fms/internal/cg-percent-mac"),
	engOn: 0,
};

var RouteManager = {
	active: props.globals.getNode("/autopilot/route-manager/active"),
	alternateAirport: props.globals.getNode("/autopilot/route-manager/alternate/airport"),
	cruiseAlt: props.globals.getNode("/autopilot/route-manager/cruise/altitude-ft"),
	currentWp: props.globals.getNode("/autopilot/route-manager/current-wp"),
	departureAirport: props.globals.getNode("/autopilot/route-manager/departure/airport"),
	destinationAirport: props.globals.getNode("/autopilot/route-manager/destination/airport"),
};

var Speeds = {
	athrMax: props.globals.getNode("/fms/speeds/athr-max"),
	athrMaxMach: props.globals.getNode("/fms/speeds/athr-max-mach"),
	athrMin: props.globals.getNode("/fms/speeds/athr-min"),
	athrMinMach: props.globals.getNode("/fms/speeds/athr-min-mach"),
	flap15Max: props.globals.getNode("/fms/speeds/flap-0-15-max-kts"),
	flap28Max: props.globals.getNode("/fms/speeds/flap-28-max-kts"),
	flap35Max: props.globals.getNode("/fms/speeds/flap-35-max-kts"),
	flap50Max: props.globals.getNode("/fms/speeds/flap-50-max-kts"),
	flapGearMax: props.globals.getNode("/fms/speeds/flap-gear-max"),
	gearExtMax: props.globals.getNode("/fms/speeds/gear-ext-max-kts"),
	gearRetMax: props.globals.getNode("/fms/speeds/gear-ret-max-kts"),
	slatMax: props.globals.getNode("/fms/speeds/slat-max-kts"),
	v1: props.globals.getNode("/fms/speeds/v1"),
	v2: props.globals.getNode("/fms/speeds/v2"),
	v2Plus10: props.globals.getNode("/fms/speeds/v2-plus-10"),
	vcl: props.globals.getNode("/fms/speeds/vcl"),
	vclTo: props.globals.getNode("/fms/speeds/vcl-to"),
	vfr: props.globals.getNode("/fms/speeds/vfr"),
	vmax: props.globals.getNode("/fms/speeds/vmax"),
	vmin: props.globals.getNode("/fms/speeds/vmin"),
	vminTape: props.globals.getNode("/fms/speeds/vmin-tape"),
	vmoMmo: props.globals.getNode("/fms/speeds/vmo-mmo"),
	vr: props.globals.getNode("/fms/speeds/vr"),
	vsr: props.globals.getNode("/fms/speeds/vsr"),
	vsrTape: props.globals.getNode("/fms/speeds/vsr-tape"),
	vsrTo: props.globals.getNode("/fms/speeds/vsr-to"),
	vss: props.globals.getNode("/fms/speeds/vss"),
	vssTape: props.globals.getNode("/fms/speeds/vss-tape"),
};

# Logic
var CORE = {
	init: func() {
		EditFlightData.reset();
		me.resetRadio();
	},
	loop: func() {
		if (pts.Engines.Engine.state[0].getValue() == 3 or pts.Engines.Engine.state[1].getValue() == 3 or pts.Engines.Engine.state[2].getValue() == 3) {
			Internal.engOn = 1;
		} else {
			Internal.engOn = 0;
		}
		
		EditFlightData.loop();
	},
	resetFms: func() {
		afs.ITAF.init(1); # First
		EditFlightData.reset();
		mcdu.BASE.reset(); # Last
	},
	resetRadio: func() {
		pts.Instrumentation.Adf.Frequencies.selectedKhz[0].setValue(0);
		pts.Instrumentation.Adf.Frequencies.selectedKhz[1].setValue(0);
		pts.Instrumentation.Nav.Frequencies.selectedMhz[0].setValue(0);
		pts.Instrumentation.Nav.Frequencies.selectedMhz[1].setValue(0);
		pts.Instrumentation.Nav.Frequencies.selectedMhz[2].setValue(0);
		pts.Instrumentation.Nav.Radials.selectedDeg[0].setValue(0);
		pts.Instrumentation.Nav.Radials.selectedDeg[1].setValue(0);
		pts.Instrumentation.Nav.Radials.selectedDeg[2].setValue(0);
	},
};
