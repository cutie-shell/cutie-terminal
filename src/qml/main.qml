import Cutie
import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import QMLTermWidget

CutieWindow {
	id: mainWindow
	width: 400
	height: 800
	visible: true
	title: qsTr("Terminal")

	Component.onCompleted: {
		terminal.forceActiveFocus();
		Qt.inputMethod.show();
	}

	initialPage: CutiePage {
		width: mainWindow.width
		height: mainWindow.height

		QMLTermWidget {
			id: terminal
			anchors.fill: parent
			anchors.margins: 15
			font.family: "Monospace"
			font.pointSize: 9

			session: QMLTermSession{
				id: mainsession
				initialWorkingDirectory: "$HOME"
			}

			Component.onCompleted: {
				mainsession.startShellProgram();
				setForegroundColor(Atmosphere.textColor);
			}

			Connections {
				target: Atmosphere
				onVariantChanged: {
					terminal.setForegroundColor(Atmosphere.textColor);
				}
			}

			TapHandler {
				onTapped: {
					terminal.forceActiveFocus();
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
	}
}
