import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
  id: root
  width: 640
  height: 580
  visible: true
  title: qsTr("NumPad")

  Rectangle {
    id: textField
    width: numPad.width
    height: numPad.height / 6
    color: "red"
    anchors {
      left: numPad.left
      right: numPad.right
      topMargin: 400
    }
    TextField {
      id: visibleContent
      text: ""
      width: textField.width
      height: textField.height
      horizontalAlignment: Text.AlignHCenter
      verticalAlignment: Text.AlignVCenter
      onCursorPositionChanged: console.log("Cursor position changed:",
                                           cursorPosition)
    }
  }
  Rectangle {
    id: numPad
    width: 280
    height: 300
    anchors.centerIn: parent
    color: "#e3e1dc"

    GridLayout {
      width: numPad.width
      height: numPad.height
      columns: 3
      anchors.centerIn: parent

      Repeater {
        model: ["7", "8", "9", "4", "5", "6", "1", "2", "3", "C", "0", "\u23CE", "<", ",", ">"]

        Button {
          id: control
          text: modelData
          onClicked: handleNumericButton(text)
          contentItem: Text {
            text: control.text
            font: control.font
            opacity: enabled ? 1 : 0.3
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
          }
          background: Rectangle {
            color: control.text === "<"
                   || control.text === ">" ? "#4195bf" : "#140309"

            implicitWidth: numPad / 2
            implicitHeight: 45
            opacity: enabled ? 1 : 0.3
            border.color: control.down ? "#212120" : "#212120"
            border.width: 1
            radius: 2
          }
          enabled: text !== "<" || visibleContent.cursorPosition > 0
        }
      }
    }
  }

  function handleNumericButton(text) {
    console.log("Numeric button clicked:", text)
    if (text === "C") {
      if (visibleContent.text.length > 0) {
        visibleContent.text = visibleContent.text.slice(0, -1)
      }
    } else if (text === "\u23CE") {
      console.log("Finalized Entry : ", visibleContent.text)
    } else if (text === "<") {
      if (visibleContent.cursorPosition > 0) {
        visibleContent.cursorPosition = visibleContent.cursorPosition - 1
      }
    } else if (text === ">") {
      if (visibleContent.cursorPosition >= 0) {
        visibleContent.cursorPosition = visibleContent.cursorPosition + 1
      }
    } else {
      visibleContent.text = visibleContent.text.slice(
            0,
            visibleContent.cursorPosition) + text + visibleContent.text.slice(
            visibleContent.cursorPosition)
    }
    visibleContent.forceActiveFocus()
  }
}
