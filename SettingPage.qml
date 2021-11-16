import QtQuick 2.0
import QtQuick.Window 2.3
import QtQuick.Controls 2.5
import Qt.labs.platform 1.0


Window {
    id:root
    width: 300
    height: 300
    visible: false
    minimumWidth: 300
    minimumHeight: 200

    property alias autoSave: saveOrNotBtn.isChecked
    property real mainWinWidget;
    property real mainWinHeight;
    property real mainWinOpacity;
    property real inputOpacity;
    property var mainWinColor;

    property var defaultRadius: autoSave.height * 0.5
    property color borderColor: "#CCEEDD"
    property var fileDefault: StandardPaths.writableLocation(StandardPaths.DocumentsLocation) + "/Note.md"
    property alias filePathDialog: fileDialog.currentFile

    property var typeList: ["Txt","MarkDown","Rich","Auto"]
    property var keyPress: typeList[1]

    signal sizeChanged();
    signal opacityChanged();
    signal recInOpacityChanged();
    signal loadTypeChanged();
    signal filePathChanged();
    signal windowColorChanged();


    //自动保存
    Rectangle{
        id: autoSave
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.9
        height: 25
        border.color: borderColor
        radius: defaultRadius

        Text{
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: parent.radius
            text: "自动保存功能"
            font.pixelSize: 13
        }

        StandardBtnYesNo{
            id: saveOrNotBtn
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            btnHight: parent.height
//            btnWidth: 120

            Component.onCompleted: {
                if(isChecked){
                    // TODO: setting界面加载配置文件
                    console.log("################")
                }
            }

            onYesPress: {
                console.log("yes")
            }

            onNoPress: {
                console.log("no")
            }
        }

    }

    //TODO: 文件路径配置  DONE
    Rectangle{
        id: filePath
        anchors.top: autoSave.bottom
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        width: autoSave.width
        height: 25
        border.color: "#CCEEDD"
        radius: height * 0.5

//      路径
        Rectangle{
            id: pathDis
            width: parent.width - selectBtnText.width
            height: parent.height
            anchors.left: parent.left
            anchors.leftMargin: parent.radius
            border.color: borderColor
            clip: true

            Text{
                anchors.verticalCenter: parent.verticalCenter
                text: fileDefault
                font.pixelSize: 13
            }
        }

        Rectangle{
            id: selectBtnText
            width: pathSelectBtn.contentWidth + radius * 2
            height: parent.height
            anchors.right: parent.right
            anchors.top: parent.top
            radius: defaultRadius
            color: "#3399ff"
            Text {
                id: pathSelectBtn
                text: qsTr("选择路径")
//                font.pixelSize: 13
                anchors.centerIn: parent
                color: "#ffffff"
            }

            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onPressed: {
                    //console.log("open file dialog")
                    fileDialog.open()
                }
            }
        }
    }

    FileDialog{
        id:fileDialog
        folder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
        onAccepted: {
            //console.log("select",currentFile)
            filePathChanged();
//            fileDefault = currentFile
        }
    }


    //TODO: 自定义主窗口大小 ****位置****
    Rectangle{
        id:windowSize
        width: autoSave.width
        height: autoSave.height
        anchors.horizontalCenter: parent.horizontalCenter
        border.color: borderColor
        anchors.top: filePath.bottom
        anchors.topMargin: 5
        radius: defaultRadius

        Rectangle{
            width: parent.width * 0.5
            height: parent.height
            anchors.left: parent.left
            radius: height * 0.5
            border.color: parent.border.color
            color: "#3399ff"

            MouseArea{
                anchors.fill: winWidth
                cursorShape: Qt.IBeamCursor
                onWheel: {
                    if(!wheel.modifiers){
                        if(wheel.angleDelta.y > 0){
                            winWidth.text = Number(winWidth.text) + 10
                        }else{
                            if(winWidth.text > 0){
                                winWidth.text = Number(winWidth.text) - 10
                            }else{
                                winWidth.text = 0;
                            }

                        }
                    }
                }
            }

            Text {
                id: loadWidth
                text: qsTr("width: ")
                anchors.left: parent.left
                anchors.leftMargin: parent.radius
                anchors.verticalCenter: parent.verticalCenter
                width: contentWidth
                color: "#FFFFFF"
            }

            TextInput{
                id: winWidth
                anchors.left: loadWidth.right
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width * 0.5
                color: "#FF0000"
                clip: true
                text: mainWinWidget
                selectByMouse: true

                onTextChanged: {
                    root.mainWinWidget = winWidth.text
                    root.sizeChanged();
                }

            }
        }

        Rectangle{
            width: parent.width * 0.5
            height: parent.height
            anchors.right: parent.right
            radius: height * 0.5
            border.color: parent.border.color
            color: "#3399ff"

            MouseArea{
                anchors.fill: winHeight
                cursorShape: Qt.IBeamCursor
                onWheel: {
                    if(!wheel.modifiers){
                        if(wheel.angleDelta.y > 0){
                            winHeight.text = Number(winHeight.text) + 10
                        }else{
                            if(winHeight.text > 0){
                                winHeight.text = Number(winHeight.text) - 10
                            }else{
                                winHeight.text = 0;
                            }
                        }
                    }
                }
            }

            Text {
                id: loadHeight
                text: qsTr("height: ")
                anchors.left: parent.left
                anchors.leftMargin: parent.radius
                anchors.verticalCenter: parent.verticalCenter
                width: contentWidth
                color: "#FFFFFF"
            }

            TextInput{
                id: winHeight
                anchors.left: loadHeight.right
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width * 0.5
                color: "#FF0000"
                clip: true
                text: mainWinHeight
                selectByMouse: true

                onTextChanged: {
                    root.mainWinHeight = winHeight.text
                    root.sizeChanged();
                }

            }

        }

    }


    //TODO: 设置透明度   DONE
    Rectangle{
        id: opacitySet
        height: autoSave.height
        width: autoSave.width
        anchors.top: windowSize.bottom
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        border.color: borderColor
        radius: defaultRadius

        MouseArea{
            anchors.fill: progressBar
            onWheel: {
                if(!wheel.modifiers){
                    if(wheel.angleDelta.y > 0){
                        progressBar.value += 0.1
                    }else{
                        progressBar.value -= 0.1
                    }
                }
            }
        }

        Text {
            id: opa
            text: qsTr("透明度: ")
            width: contentWidth
            anchors.left: parent.left
            anchors.leftMargin: parent.radius
            anchors.verticalCenter: parent.verticalCenter
        }

        Slider{
            id: progressBar
            width: parent.width - opa.width - parent.radius * 2
            height: parent.height
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: opa.right
            from: 0
            to: 1
            value: mainWinOpacity
            stepSize: 0.1

            onValueChanged: {
                mainWinOpacity = value
                root.opacityChanged();
            }

        }
    }

    Rectangle{
        id: inputOpacitySet
        height: autoSave.height
        width: autoSave.width
        anchors.top: opacitySet.bottom
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        border.color: borderColor
        radius: defaultRadius

        MouseArea{
            anchors.fill: inputProgressBar
            onWheel: {
                if(!wheel.modifiers){
                    if(wheel.angleDelta.y > 0){
                        inputProgressBar.value += 0.1
                    }else{
                        inputProgressBar.value -= 0.1
                    }
                }
            }
        }

        Text {
            id: inputOpa
            text: qsTr("透明度: ")
            width: contentWidth
            anchors.left: parent.left
            anchors.leftMargin: parent.radius
            anchors.verticalCenter: parent.verticalCenter
        }

        Slider{
            id: inputProgressBar
            width: parent.width - opa.width - parent.radius * 2
            height: parent.height
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: inputOpa.right
            from: 0
            to: 1
            value: inputOpacity
            stepSize: 0.1

            onValueChanged: {
                inputOpacity = value
                root.recInOpacityChanged();
            }

        }
    }

    //TODO: 显示文本类型  DONE
    Rectangle{
        id: viewType
        width: autoSave.width
        height: autoSave.height
        anchors.horizontalCenter: parent.horizontalCenter
        border.color: borderColor
        anchors.top: inputOpacitySet.bottom
        anchors.topMargin: 5
        radius: defaultRadius

        Rectangle{
            id: typeTxt
            height: parent.height
            width: parent.width * 0.25
            anchors.left: parent.left
            radius: parent.radius
            border.color: borderColor
            color: (keyPress === typeTxtText.text) ? "#3399ff" : "#ffffff"

            Rectangle{
                width: parent.width * 0.5
                height: parent.height - 2
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: 1
                color: parent.color
            }

            Text {
                id: typeTxtText
                anchors.centerIn: parent
                text: typeList[0]
                color: (keyPress === typeTxtText.text) ? "#ffffff" : "#000000"
            }

            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    keyPress = typeList[0]
                    loadTypeChanged();
                }
            }
        }

        Rectangle{
            id: typeMd
            height: parent.height
            width: parent.width * 0.25
            anchors.left: typeTxt.right
            border.color: borderColor
            color: (keyPress === typeMdText.text) ? "#3399ff" : "#ffffff"

            Text {
                id: typeMdText
                anchors.centerIn: parent
                text: typeList[1]
                color: (keyPress === typeMdText.text) ? "#ffffff" : "#000000"
            }

            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    keyPress = typeList[1]
                    loadTypeChanged();
                }
            }
        }

        Rectangle{
            id: typeRich
            height: parent.height
            width: parent.width * 0.25
            anchors.left: typeMd.right
            border.color: borderColor
            color: (keyPress === typeRichText.text) ? "#3399ff" : "#ffffff"

            Text {
                id: typeRichText
                anchors.centerIn: parent
                text: typeList[2]
                color: (keyPress === typeRichText.text) ? "#ffffff" : "#000000"
            }

            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    keyPress = typeList[2]
                    loadTypeChanged();
                }
            }
        }

        Rectangle{
            id: typeAuto
            height: parent.height
            width: parent.width * 0.25
            anchors.right: parent.right
            radius: parent.radius
            border.color: borderColor
            color: (keyPress === plainText.text) ? "#3399ff" : "#ffffff"

            Rectangle{
                width: parent.width * 0.5
                height: parent.height - 2
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 1
                color: parent.color

            }

            Text {
                id: plainText
                anchors.centerIn: parent
                text: typeList[3]
                color: (keyPress === plainText.text) ? "#ffffff" : "#000000"
            }

            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    keyPress = typeList[3]
                    loadTypeChanged();
                }
            }
        }
    }

    //TODO: COLOR设置 字体 输入框 输入框字体
    Rectangle{
        id: colorSet
        width: autoSave.width
        height: autoSave.height
        anchors.horizontalCenter: parent.horizontalCenter
        border.color: borderColor
        anchors.top: viewType.bottom
        anchors.topMargin: 5
        radius: defaultRadius

        Rectangle{
            id: textRec
            anchors.left: parent.left
            anchors.leftMargin: parent.radius
            anchors.top: parent.top
            anchors.topMargin: 1
            width: colorBg.contentWidth
            height: parent.height - 2

            Text {
                id: colorBg
                text: qsTr("背景色: ")
                anchors.centerIn: parent
            }

        }

        Rectangle{
            id: colorRec
            anchors.left: textRec.right
            anchors.top: parent.top
            color: mainWinColor
            radius: defaultRadius
            width: parent.width - selectColorBtn.width - textRec.width - radius
            height: parent.height

        }

        Rectangle{
            id: selectColorBtn
            anchors.right: parent.right
            anchors.top: parent.top
            width: colorSelectText.contentWidth + radius * 2
            height: parent.height
            radius: defaultRadius
            border.color: parent.border.color
            color: "#3399ff"

            Text {
                id: colorSelectText
                text: "选择颜色"
                color: "#ffffff"
                anchors.centerIn: parent
            }

            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    colorDialog.open();
                }
            }
        }

    }

    ColorDialog{
        id: colorDialog
        onAccepted: {
            mainWinColor = currentColor
            windowColorChanged();
        }
    }

}
