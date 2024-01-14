//2
import QtQuick
import QtQuick.Window
import QtQuick.Controls

Item {
    property string user: ""
    property string password: ""
    property int inputHeight: Screen.height * 0.21 * 0.25
    property int inputWidth: Screen.width * 0.21
    property var users: []
    property bool credentialsLoaded: false
    property string currentState

    function loadCredentials(callback) {
        console.log("Function loadCredentials run")
        var xhr = new XMLHttpRequest
        var filePath = "qrc:/components/credentials.txt"

        xhr.open("GET", filePath)
        xhr.onreadystatechange = function () {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    var fileContent = xhr.responseText.split("\n")

                    for (var i = 0; i < fileContent.length; i++) {
                        var credentials = fileContent[i].split(":")
                        if (credentials.length === 2) {
                            users.push({
                                           "username": credentials[0],
                                           "password": credentials[1]
                                       })
                        }
                    }
                    credentialsLoaded = true
                    callback()
                } else {
                    console.error("Failed to load credentials file: " + filePath
                                  + ", status: " + xhr.status)
                }
            }
        }

        xhr.send()
    }

    function checkCredentials(username, password) {
        for (var i = 0; i < users.length; ++i) {
            if (users[i].username.trim() === username.trim()
                    && users[i].password.trim() === password.trim()) {
                console.log("Credentials are valid for user: " + username)
                return true
            }
        }
        console.log("Invalid credentials for user: " + username)
        return false
    }

    function checkAndLogin() {
        loadCredentials(function () {
            console.log("Kullanici Terefinden girilen ad ve Parol:",
                        user, password)
            console.log(currentState)
            console.log(currentState === "login")
            if (checkCredentials(user, password)) {
                state = "door"
                console.log("video player2 baslamalidi")
                videoPlayer2.play()
                videoPlayer2.playbackStateChanged.connect(function () {
                    console.log("video player3 baslamalidi")
                    Qt.quit()
                })
            } else {
                passwordField.text = ""
            }
        })
    }

    Column {
        spacing: 15
        anchors {
            left: parent.left
            top: parent.top
            topMargin: 700
            leftMargin: 500
        }

        TextField {
            id: usernameField
            visible: true
            placeholderText: "Username"
            height: 50
            width: 430
            renderType: Text.NativeRendering
            font.pointSize: 9
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            background: Rectangle {
                color: "transparent"
            }
        }

        TextField {
            id: passwordField
            visible: true
            placeholderText: "Password"
            height: 50
            width: 430
            renderType: Text.NativeRendering
            font.pointSize: 9
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            echoMode: TextInput.Password
            onAccepted: loginButton.clicked()

            background: Rectangle {
                color: "transparent"
            }
        }
    }

    Column {
        spacing: 10
        anchors {
            top: parent.top
            left: parent.left
            topMargin: 878
            leftMargin: 498
        }

        Button {
            id: loginButton
            visible: true
            opacity: 1
            hoverEnabled: false
            height: 55
            width: 440

            enabled: usernameField.text !== ""
                     && passwordField.text !== "" ? true : false
            text: "Login!!"

            background: Rectangle {
                color: "transparent"
            }

            contentItem: Text {
                id: buttonText

                renderType: Text.NativeRendering
                font.pointSize: 9
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                color: "#00FF00"
                opacity: 0.5
                text: "Login!!"
            }

            onClicked: {
                user = usernameField.text
                password = passwordField.text
                checkAndLogin()
            }
        }
    }
}
