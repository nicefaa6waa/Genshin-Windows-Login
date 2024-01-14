import QtQuick
import QtQuick.Controls

Column {
    spacing: 0

    Text {
        id: dateLabel

        anchors.right: parent.right
        opacity: 0.8

        renderType: Text.NativeRendering
        font.pointSize: 30
        color: "#7c7f93"

        function updateDate() {
            text = new Date().toLocaleDateString(Qt.locale(), "dddd, MMMM d")
        }
    }

    Text {
        id: timeLabel

        anchors.right: parent.right
        opacity: 0.8
        renderType: Text.NativeRendering
        color: "#7c7f93"

        function updateTime() {
            text = new Date().toLocaleTimeString(Qt.locale(), "hh:mm AP")
        }
    }

    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
            timeLabel.updateTime()
            dateLabel.updateDate()
        }
    }

    Component.onCompleted: {
        timeLabel.updateTime()
        dateLabel.updateDate()
    }
}
