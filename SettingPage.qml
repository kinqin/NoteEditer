import QtQuick 2.0
import QtQuick.Window 2.3
import QtQuick.Controls 2.5
import Qt.labs.platform 1.0


Window {
    id:root
    width: 400
    height: 440
    visible: false
    minimumWidth: 300
    minimumHeight: 200

    property alias autoSave: saveOrNotBtn.isChecked
    property real mainWinWidth;
    property real mainWinHeight;
    property real mainWinX;
    property real mainWinY;

    property real mainWinOpacity;
    property real inputOpacity;

    property var mainWinColor;
    property var editWinColor;

    property var fontColor;
    property var editFontColor;
    property var fontSize;
    property var editFontSize;

    property var fileUrl;
    property var typeList: ["Txt","MarkDown","Rich","Auto"]
    property var keyPress: typeList[1]
    property var posList: ["default","center","custom"]
    property var posCur: posList[0]

    property var modBackgroundColor: "#3399ff"
    property var modForegroundColor: "#ffffff"

    property var defaultRadius: autoSaveRoot.height * 0.5
    property var borderColor: "#CCEEDD"

    signal fileUrlIsChanged();

    //自动保存
    Rectangle{
        id: autoSaveRoot
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

        }

    }

    //TODO: 文件路径配置  DONE
    Rectangle{
        id: filePathRoot
        anchors.top: autoSaveRoot.bottom
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        width: autoSaveRoot.width
        height: 25
        border.color: "#CCEEDD"
        radius: defaultRadius

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
                text: fileUrl
                font.pixelSize: 14
            }
        }

        Rectangle{
            id: selectBtnText
            width: pathSelectBtn.contentWidth + radius * 2
            height: parent.height
            anchors.right: parent.right
            anchors.top: parent.top
            radius: defaultRadius
            color: modBackgroundColor
            Text {
                id: pathSelectBtn
                text: qsTr(" 选择文件 ")
                font.pixelSize: 14
                anchors.centerIn: parent
                color: modForegroundColor
            }

            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    fileDialog.open()
                }
            }
        }
    }

    FileDialog{
        id:fileDialog
        folder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
        onAccepted: {
            fileUrl = currentFile
            fileUrlIsChanged();
        }
    }

    //TODO: 自定义主窗口大小 ****位置**** DONE
    Rectangle{
        id:windowSizeRoot
        width: autoSaveRoot.width
        height: autoSaveRoot.height
        anchors.horizontalCenter: parent.horizontalCenter
        border.color: borderColor
        anchors.top: filePathRoot.bottom
        anchors.topMargin: 5
        radius: defaultRadius

        Rectangle{
            width: parent.width * 0.5
            height: parent.height
            anchors.left: parent.left
            radius: height * 0.5
            border.color: parent.border.color
            color: modBackgroundColor

            MouseArea{
                anchors.fill: winWidth
                cursorShape: Qt.IBeamCursor
                onWheel: {
                    if(!wheel.modifiers){
                        if(wheel.angleDelta.y > 0){
                            mainWinWidth = Number(mainWinWidth) + 10
                        }else{
                            if(mainWinWidth > 0){
                                mainWinWidth = Number(mainWinWidth) - 10
                            }else{
                                mainWinWidth = 0;
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
                color: modForegroundColor
            }

            TextInput{
                id: winWidth
                anchors.left: loadWidth.right
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width * 0.5
                color: "#FF0000"
                clip: true
                text: mainWinWidth
                selectByMouse: true
            }
        }

        Rectangle{
            width: parent.width * 0.5
            height: parent.height
            anchors.right: parent.right
            radius: height * 0.5
            border.color: parent.border.color
            color: modBackgroundColor

            MouseArea{
                anchors.fill: winHeight
                cursorShape: Qt.IBeamCursor
                onWheel: {
                    if(!wheel.modifiers){
                        if(wheel.angleDelta.y > 0){
                            mainWinHeight = Number(mainWinHeight) + 10
                        }else{
                            if(mainWinHeight > 0){
                                mainWinHeight = Number(mainWinHeight) - 10
                            }else{
                                mainWinHeight = 0;
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
                color: modForegroundColor
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
            }

        }

    }

    Rectangle{
        id: windowPosRoot
        anchors.top: windowSizeRoot.bottom
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        width: autoSaveRoot.width
        height: autoSaveRoot.height
        border.color: "#CCEEDD"
        radius: height * 0.5

        Rectangle{
            id: defaultPos
            anchors.left: parent.left
            anchors.top: parent.top
            width: defaultPosText.contentWidth + parent.radius * 2
            height: parent.height
            radius: parent.radius
            border.color: parent.border.color
            color: defaultPosText.text === posCur ? modBackgroundColor : modForegroundColor

            Rectangle{
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: 1
                width: parent.width * 0.5
                height: parent.height - 2
                color: parent.color
            }

            Text {
                id: defaultPosText
                text: qsTr("default")
                anchors.centerIn: parent
                color: defaultPosText.text === posCur ? modForegroundColor : "#000000"
            }

            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    posCur = posList[0]
                    mainWinX = (Screen.width-mainWinWidth)*0.5
                    mainWinY = (Screen.desktopAvailableHeight)-mainWinHeight-10
                }
            }
        }

        Rectangle{
            id: centerPos
            anchors.left: defaultPos.right
            anchors.top: parent.top
            width: defaultPos.width
            height: parent.height
            border.color: parent.border.color
            color: centerPosText.text === posCur ? modBackgroundColor : modForegroundColor

            Text{
                id: centerPosText
                text: "center"
                anchors.centerIn: parent
                color: centerPosText.text === posCur ? modForegroundColor : "#000000"
            }

            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    posCur = posList[1]
                    mainWinX = (Screen.width-mainWinWidth)*0.5
                    mainWinY = (Screen.height-mainWinHeight)*0.5
                }
            }
        }

        Rectangle{
            id: customPos
            anchors.left: centerPos.right
            anchors.top: parent.top
            border.color: parent.border.color
            width: defaultPos.width
            height: parent.height
            color: customPosText.text === posCur ? modBackgroundColor : modForegroundColor

            Text{
                id: customPosText
                text: "custom"
                anchors.centerIn: parent
                color: customPosText.text === posCur ? modForegroundColor : "#000000"
            }

            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    posCur = posList[2]
                }
            }
        }

        Rectangle{
            id: xDis
            anchors.left: customPos.right
            anchors.top: parent.top
            border.color: parent.border.color
            width: (parent.width - defaultPos.width - centerPos.width - customPos.width)*0.5+1
            height: parent.height
            clip: true
            color: modBackgroundColor

            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.IBeamCursor
                onWheel: {
                    if(!wheel.modifiers){
                        if(wheel.angleDelta.y > 0){
                            mainWinX = Number(mainWinX) + 10
                        }else{
                            if(mainWinX > 0){
                                mainWinX = Number(mainWinX) - 10
                            }else{
                                mainWinX = 0;
                            }

                        }
                    }
                }
            }

            TextInput{
                id: xDisInput
                anchors.centerIn: parent
                text: mainWinX
                readOnly: customPosText.text !== posCur
                color: "#ff0000"
            }

        }

        Rectangle{
            id: yDis
            anchors.right: parent.right
            anchors.top: parent.top
            border.color: parent.border.color
            width: xDis.width + 1
            height: parent.height
            clip: true
            radius: parent.radius
            color: modBackgroundColor

            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.IBeamCursor
                onWheel: {
                    if(!wheel.modifiers){
                        if(wheel.angleDelta.y > 0){
                            mainWinY = Number(mainWinY) + 10
                        }else{
                            if(mainWinY > 0){
                                mainWinY = Number(mainWinY) - 10
                            }else{
                                mainWinY = 0;
                            }

                        }
                    }
                }

            }

            Rectangle{
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 1
                width: parent.width * 0.5
                height: parent.height - 2
                color: parent.color
            }

            TextInput{
                id: yDisInput
                anchors.centerIn: parent
                text: mainWinY
                readOnly: customPosText.text !== posCur
                color: "#ff0000"
            }
        }
    }

    //TODO: 设置透明度   DONE
    Rectangle{
        id: winOpacityRoot
        height: autoSaveRoot.height
        width: autoSaveRoot.width
        anchors.top: windowPosRoot.bottom
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        border.color: borderColor
        radius: defaultRadius

        MouseArea{
            anchors.fill: progressBar
            onWheel: {
                if(!wheel.modifiers){
                    if(wheel.angleDelta.y > 0){
                        mainWinOpacity += 0.1
                    }else{
                        mainWinOpacity -= 0.1
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
        }
    }

    Rectangle{
        id: editOpacityRoot
        height: autoSaveRoot.height
        width: autoSaveRoot.width
        anchors.top: winOpacityRoot.bottom
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        border.color: borderColor
        radius: defaultRadius

        MouseArea{
            anchors.fill: inputProgressBar
            onWheel: {
                if(!wheel.modifiers){
                    if(wheel.angleDelta.y > 0){
                        inputOpacity += 0.1
                    }else{
                        inputOpacity -= 0.1
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
        }
    }

    //TODO: 显示文本类型  DONE
    Rectangle{
        id: docTypeRoot
        width: autoSaveRoot.width
        height: autoSaveRoot.height
        anchors.horizontalCenter: parent.horizontalCenter
        border.color: borderColor
        anchors.top: editOpacityRoot.bottom
        anchors.topMargin: 5
        radius: defaultRadius

        Rectangle{
            id: typeTxt
            height: parent.height
            width: parent.width * 0.25
            anchors.left: parent.left
            radius: parent.radius
            border.color: borderColor
            color: (keyPress === typeTxtText.text) ? modBackgroundColor : modForegroundColor

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
                color: (keyPress === typeTxtText.text) ? modForegroundColor : "#000000"
            }

            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: keyPress = typeList[0]
            }
        }

        Rectangle{
            id: typeMd
            height: parent.height
            width: parent.width * 0.25
            anchors.left: typeTxt.right
            border.color: borderColor
            color: (keyPress === typeMdText.text) ? modBackgroundColor : modForegroundColor

            Text {
                id: typeMdText
                anchors.centerIn: parent
                text: typeList[1]
                color: (keyPress === typeMdText.text) ? modForegroundColor : "#000000"
            }

            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: keyPress = typeList[1]
            }

        }

        Rectangle{
            id: typeRich
            height: parent.height
            width: parent.width * 0.25
            anchors.left: typeMd.right
            border.color: borderColor
            color: (keyPress === typeRichText.text) ? modBackgroundColor : modForegroundColor

            Text {
                id: typeRichText
                anchors.centerIn: parent
                text: typeList[2]
                color: (keyPress === typeRichText.text) ? modForegroundColor : "#000000"
            }

            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: keyPress = typeList[2]
            }
        }

        Rectangle{
            id: typeAuto
            height: parent.height
            width: parent.width * 0.25
            anchors.right: parent.right
            radius: parent.radius
            border.color: borderColor
            color: (keyPress === plainText.text) ? modBackgroundColor : modForegroundColor

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
                color: (keyPress === plainText.text) ? modForegroundColor : "#000000"
            }

            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: keyPress = typeList[3]
            }
        }
    }

    //TODO: COLOR设置 字体 输入框 输入框字体
    Rectangle{
        id: winColorRoot
        width: autoSaveRoot.width
        height: autoSaveRoot.height
        anchors.horizontalCenter: parent.horizontalCenter
        border.color: borderColor
        anchors.top: docTypeRoot.bottom
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
            color: modBackgroundColor

            Text {
                id: colorSelectText
                text: "选择颜色"
                color: modForegroundColor
                anchors.centerIn: parent
            }

            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: colorDialog.open();
            }
        }

    }

    Rectangle{
        id: editColorRoot
        width: autoSaveRoot.width
        height: autoSaveRoot.height
        anchors.horizontalCenter: parent.horizontalCenter
        border.color: borderColor
        anchors.top: winColorRoot.bottom
        anchors.topMargin: 5
        radius: defaultRadius

        Rectangle{
            id: editTextRec
            anchors.left: parent.left
            anchors.leftMargin: parent.radius
            anchors.top: parent.top
            anchors.topMargin: 1
            width: editColorBg.contentWidth
            height: parent.height - 2

            Text {
                id: editColorBg
                text: qsTr("编辑区背景色: ")
                anchors.centerIn: parent
            }

        }

        Rectangle{
            id: editColorRec
            anchors.left: editTextRec.right
            anchors.top: parent.top
            color: editWinColor
            radius: defaultRadius
            width: parent.width - editColorBtn.width - editTextRec.width - radius
            height: parent.height

        }

        Rectangle{
            id: editColorBtn
            anchors.right: parent.right
            anchors.top: parent.top
            width: colorSelectText.contentWidth + radius * 2
            height: parent.height
            radius: defaultRadius
            border.color: parent.border.color
            color: modBackgroundColor

            Text {
                id: editColorSelectText
                text: "选择颜色"
                color: modForegroundColor
                anchors.centerIn: parent
            }

            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: editerColorDialog.open();
            }
        }

    }
//字体属性
    Rectangle{
        id: textAttrRoot
        anchors.top: editColorRoot.bottom
        width: autoSaveRoot.width
        height: autoSaveRoot.height
        anchors.horizontalCenter: parent.horizontalCenter
        border.color: borderColor
        anchors.topMargin: 5
        radius: defaultRadius

        Rectangle{
            id: textColorRec
            anchors.left: parent.left
            anchors.top: parent.top
            width: parent.width*0.25
            height: parent.height
            radius: parent.radius
            border.color: borderColor
            color: modBackgroundColor

            Text {
                text: qsTr("字体颜色")
                anchors.centerIn: parent
                color: modForegroundColor
            }
        }

        Rectangle{
            id: textColorSet
            anchors.left: textColorRec.right
            anchors.top: parent.top
            width: textColorRec.width
            height: parent.height
            border.color: borderColor
            radius: parent.radius
            color: fontColor

            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: fontColorDialog.open()
            }
        }

        Rectangle{
            id:textSizeRec
            anchors.left: textColorSet.right
            anchors.top: parent.top
            width: textColorRec.width
            height: parent.height
            border.color: borderColor
            radius: parent.radius
            color: modBackgroundColor

            Text {
                text: qsTr("字体大小")
                anchors.centerIn: parent
                color: modForegroundColor
            }
        }

        Rectangle{
            anchors.right: parent.right
            anchors.top: parent.top
            width: textColorRec.width
            height: parent.height
            border.color: borderColor
            radius: defaultRadius

            Text {
                id: fontSizeSet
                text: fontSize
                anchors.centerIn: parent
                color: "#ff0000"
            }

            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.IBeamCursor

                onWheel: {
                    if(!wheel.modifiers){
                        if(wheel.angleDelta.y > 0){
                            fontSize = Number(fontSize) + 1
                        }else{
                            if(fontSize > 0){
                                fontSize= Number(fontSize) - 1
                            }else{
                                fontSize = 0;
                            }

                        }
                    }
                }
            }
        }

    }


    Rectangle{
        id: editTextAttrRoot
        anchors.top: textAttrRoot.bottom
        width: autoSaveRoot.width
        height: autoSaveRoot.height
        anchors.horizontalCenter: parent.horizontalCenter
        border.color: borderColor
        anchors.topMargin: 5
        radius: defaultRadius

        Rectangle{
            id: editTextColorRec
            anchors.left: parent.left
            anchors.top: parent.top
            width: parent.width*0.25
            height: parent.height
            radius: parent.radius
            border.color: borderColor
            color: modBackgroundColor

            Text {
                text: qsTr("编辑框字体颜色")
                anchors.centerIn: parent
                color: modForegroundColor
            }
        }

        Rectangle{
            id: editTextColorSet
            anchors.left: editTextColorRec.right
            anchors.top: parent.top
            width: editTextColorRec.width
            height: parent.height
            border.color: borderColor
            radius: parent.radius
            color: editFontColor

            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: editFontColorDialog.open()
            }
        }

        Rectangle{
            id:editTextSizeRec
            anchors.left: editTextColorSet.right
            anchors.top: parent.top
            width: editTextColorRec.width
            height: parent.height
            border.color: borderColor
            radius: parent.radius
            color: modBackgroundColor

            Text {
                text: qsTr("字体大小")
                anchors.centerIn: parent
                color: modForegroundColor
            }
        }

        Rectangle{
            anchors.right: parent.right
            anchors.top: parent.top
            width: editTextColorRec.width
            height: parent.height
            border.color: borderColor
            radius: defaultRadius

            Text {
                id: editFontSizeSet
                text: editFontSize
                anchors.centerIn: parent
                color: "#ff0000"
            }

            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.IBeamCursor

                onWheel: {
                    if(!wheel.modifiers){
                        if(wheel.angleDelta.y > 0){
                            editFontSize = Number(editFontSize) + 1
                        }else{
                            if(editFontSize > 0){
                                editFontSize= Number(editFontSize) - 1
                            }else{
                                editFontSize = 0;
                            }

                        }
                    }
                }
            }
        }

    }

    ColorDialog{
        id: colorDialog
        onAccepted: mainWinColor = currentColor;
    }

    ColorDialog{
        id:editerColorDialog
        onAccepted: editWinColor = currentColor;
    }

    ColorDialog{
        id: fontColorDialog
        onAccepted: fontColor = currentColor
    }

    ColorDialog{
        id: editFontColorDialog
        onAccepted: editFontColor = currentColor
    }

    Image {
        id: noteEditer
        source: "qrc:/icon/textBg.png"
        width: autoSaveRoot.width
        height: 80
        anchors.top: editTextAttrRoot.bottom
        anchors.topMargin: 15
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
