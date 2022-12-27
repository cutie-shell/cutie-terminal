import Cutie 1.0
import CutieTerminal 1.0
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import QMLTermWidget 1.0

CutieWindow {
	id: mainWindow
	width: 400
	height: 800
	visible: true
	title: qsTr("Terminal")

	onActiveChanged: {
		modifierHolder.forceActiveFocus();
		Qt.inputMethod.show();
	}

	initialPage: CutiePage {
		width: mainWindow.width
		height: mainWindow.height

		QMLTermWidget {
			id: terminal
			anchors.fill: parent
			anchors.margins: 15
			anchors.bottomMargin: modKeyArea.height + 15
			font.family: "Monospace"
			font.pointSize: 9
			session: QMLTermSession{
				id: mainsession
				initialWorkingDirectory: "$HOME"
			}
			Component.onCompleted: {
				mainsession.startShellProgram();
				setForegroundColor((Atmosphere.variant == "dark") ? "#ffffff" : "#000000");
			}

			Connections {
				target: Atmosphere
				onVariantChanged: {
					terminal.setForegroundColor((Atmosphere.variant == "dark") ? "#ffffff" : "#000000");
				}
			}

			TapHandler {
				onTapped: {
					modifierHolder.forceActiveFocus();
					Qt.inputMethod.show();
				}
			}

			QMLTermScrollbar {
				terminal: terminal
				width: 20
				Rectangle {
					opacity: 0.4
					anchors.margins: 5
					radius: width * 0.5
					anchors.fill: parent
				}
			}
		}
		ScrollView {
			id: modKeyArea
			anchors.bottom: parent.bottom
			anchors.left: parent.left
			anchors.right: parent.right
			Row {
				leftPadding: 25
				rightPadding: 25
				topPadding: 5
				bottomPadding: 10
				spacing: 10
				CutieButton {
					id: ctrlButton
					text: qsTr("Ctrl")
					checkable: true
					focusPolicy: Qt.NoFocus
				}
				CutieButton {
					id: altButton
					text: qsTr("Alt")
					checkable: true
					focusPolicy: Qt.NoFocus
				}
			}
		}
		CutieTextField {
			id: modifierHolder
			visible: false
			inputMethodHints: Qt.ImhNoPredictiveText | Qt.ImhNoAutoUppercase | Qt.ImhMultiLine
			focus: true
			Keys.onPressed: { 
				if (ctrlButton.checked) {
					terminal.simulateKeyPress(event.key, Qt.ControlModifier | event.modifiers, 
						true, event.nativeScanCode, event.text);
				} else if (altButton.checked) {
					terminal.simulateKeyPress(event.key, Qt.AltModifier | event.modifiers, 
						true, event.nativeScanCode, event.text);
				} else {
					terminal.simulateKeyPress(event.key, event.modifiers, 
						true, event.nativeScanCode, event.text);
				}
				forceActiveFocus();
				Qt.inputMethod.show();
			}
		}
	}
}
