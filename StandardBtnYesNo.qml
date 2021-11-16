import QtQuick 2.0

Rectangle{
    id:root
    width: 100
    height: 20
    //color: "#c7edcc"
    color: "#eeeeee"
    radius: 5

    property alias btnHight: root.height;
    property alias btnWidth: root.width;
    property alias onText: yesText.text;
    property alias offText: noText.text;

    property color checkedColor: "#3399ff";
    property color noCheckColor: "#ffffff";
    property bool isChecked: true

    signal yesPress();
    signal noPress();

    Rectangle{
        id: btnYes
        width: parent.width * 0.5
        height: parent.height
        radius: parent.height * 0.5
        color: root.isChecked ? checkedColor : noCheckColor

        Rectangle{
           width: parent.width * 0.5
           height: parent.height
           anchors.right:parent.right
           anchors.top: parent.top
           color: parent.color
        }

        Text {
            id: yesText
            anchors.centerIn: parent
            text: qsTr("打开")
            color: root.isChecked ? noCheckColor : "#000000"
        }

        MouseArea{
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onPressed: {
                root.isChecked = true
                root.yesPress()
            }
        }

    }

    Rectangle{
        id: btnNo
        x:btnYes.x+btnYes.width;y:btnYes.y
        width: parent.width * 0.5
        height: parent.height
        radius: parent.height *0.5

        color: root.isChecked ? noCheckColor : checkedColor

        Rectangle{
           width: parent.width * 0.5
           height: parent.height
           anchors.left: parent.left
           anchors.top: parent.top
           color: parent.color
        }

        Text {
            id: noText
            anchors.centerIn: parent
            text: qsTr("关闭")
            color: root.isChecked ? "#000000" : noCheckColor
        }

        MouseArea{
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onPressed: {
                root.isChecked = false
                root.noPress()
            }
        }
    }
}

