package integration.gamepad;

import broker.input.GamepadBase;
import broker.input.ButtonStatus;
import broker.input.Stick;
import broker.input.builtin.simple.Button;
import broker.input.builtin.simple.ButtonStatusMap;

/**
	Example of user-defined virtual gamepad.
**/
class Gamepad extends GamepadBase<Button, ButtonStatusMap, Stick> {
	final parameters: GamepadParameters;

	public function new(
		buttons: ButtonStatusMap,
		stick: Stick,
		parameters: GamepadParameters
	) {
		super(buttons, stick);
		this.parameters = parameters;
	}

	override public function update() {
		final buttons = this.buttons;
		final stick = this.stick;
		final prm = this.parameters;

		buttons.forEachValue(ButtonStatus.updateCallback);

		final speed = if (prm.speedChangeButtonStatus.isPressed)
			prm.alternativeSpeed
		else
			prm.defaultSpeed;

		prm.heapsPadPort.updateStickFromLeftAnalog(stick);
		if (stick.distance > prm.analogStickThreshold) {
			stick.setDistance(speed);
		} else {
			buttons.reflectToStick(stick);
			stick.multiplyDistance(speed);
		}
	}
}
