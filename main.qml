//2
import QtMultimedia
import QtQuick
import QtQuick.Window
import QtQuick.Controls
import "components"

ApplicationWindow {

    flags: Qt.Window | Qt.WindowStaysOnTopHint

    visible: true
    width: Screen.width
    height: Screen.height
    visibility: Window.FullScreen

    property int currentSongIndex: 0
    property string state: "1"
    property var songList: ["snow_buried_tales.mp3", "moonlike_smile.mp3", "unfinished_frescoes.mp3"]

    function getTimeOfDay() {
        var currentTime = new Date()
        var hours = currentTime.getHours()
        console.log(hours)

        if (hours >= 6 && hours < 12) {
            return "morning"
        } else if (hours >= 12 && hours < 18) {
            return "morning"
        } else {
            return "night"
        }
    }

    function changeSong(direction) {
        if (direction === 1) {
            currentSongIndex = (currentSongIndex + 1) % songList.length
        } else if (direction === -1) {
            currentSongIndex = (currentSongIndex - 1 + songList.length) % songList.length
        }

        if (currentSongIndex === songList.length) {
            currentSongIndex = 0
        }

        musicPlayer.stop()
        musicPlayer.source = "sounds/" + songList[currentSongIndex]
        console.log("sounds/" + songList[currentSongIndex])
        console.log(currentSongIndex)
        musicPlayer.play()
    }

    MouseArea {
        id: clickArea
        anchors.fill: parent
        onClicked: {

            if (state === "door") {

            } else {
                state = "login"
                basicImage.visible = loginPanel.visible = true
                console.log("Made Visible")
                console.log(musicPlayer.source)
                console.log(state)
            }
        }
    }

    Column {
        spacing: 8
        opacity: 1

        anchors {
            top: parent.top
            right: parent.right
            topMargin: 50
            rightMargin: 19
        }

        DateTimePanel {
            id: dateTimePanel
        }
    }

    Column {
        spacing: 8
        opacity: 1
        anchors {
            top: parent.top
            left: parent.left
            topMargin: 450
            leftMargin: 19
        }

        PlayerPanel {
            id: playerPanel
        }
    }

    Image {
        id: mainbg
        anchors.fill: parent
        height: parent.height
        width: parent.width
        fillMode: Image.PreserveAspectCrop
        source: "backgrounds/bg.png"
        asynchronous: false
        cache: true
        mipmap: true
        clip: true
        visible: false
    }

    MediaPlayer {
        id: musicPlayer
        source: "sounds/unfinished_frescoes.mp3"
        audioOutput: AudioOutput {
            volume: 1.0
            muted: false
        }
        Component.onCompleted: {
            console.log("Load Music at First")
            console.log(musicPlayer.source)
            musicPlayer.play()
            musicPlayer.playbackStateChanged.connect(function (state) {
                if (state === MediaPlayer.EndOfMedia) {
                    console.log("Music Ended")
                    changeSong(1)
                }
            })
        }
        loops: -1
    }

    MediaPlayer {
        id: videoPlayer1
        source: "backgrounds/" + getTimeOfDay() + "bg.mp4"
        videoOutput: videoOutput1
        Component.onCompleted: {
            console.log("Load Background Video at First")
            videoPlayer1.play()
        }
        audioOutput: AudioOutput {
            volume: 0.0
            muted: true
        }
        loops: -1
    }

    MediaPlayer {
        id: videoPlayer2
        source: "backgrounds/loading.mp4"
        videoOutput: videoOutput2
        audioOutput: AudioOutput {
            volume: 0.0
            muted: true
        }
    }

    VideoOutput {
        id: videoOutput1
        anchors.fill: parent
        z: 1
    }

    VideoOutput {
        id: videoOutput2
        anchors.fill: parent
        visible: true
        z: 32
    }

    Image {
        id: basicImage
        visible: false
        source: "1.png"
        width: Math.min(parent.width, sourceSize.width)
        height: sourceSize.height * (width / sourceSize.width)
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.topMargin: 540
        z: 3

        Text {
            anchors.top: parent.top
            anchors.topMargin: 385
            anchors.right: parent.right
            anchors.rightMargin: 350
            text: "nicefaa6waa"
            font.pixelSize: 15
            color: "black"
            z: 3
        }
        Text {
            anchors.top: parent.top
            anchors.topMargin: 385
            anchors.right: parent.right
            anchors.rightMargin: 80
            text: "ibrahim-mammadli"
            font.pixelSize: 15
            color: "black"
            z: 3
        }
    }

    Item {
        id: contentPanel
        z: 3

        anchors {
            fill: parent
            topMargin: -400
            rightMargin: 50
            leftMargin: 50
        }

        LoginPanel {
            id: loginPanel
            anchors.fill: parent
            visible: false
        }
    }
}
