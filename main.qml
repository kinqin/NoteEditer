import QtQuick 2.14
import QtQuick.Window 2.14
import Qt.labs.platform 1.1
import Qt.labs.settings 1.1
import file.save.FileDeal 1.0
import event.key.filter 1.0

Window {
    id:win
    visible: true
    width: 300//settingPage.mainWinWidth//Screen.width * 0.5
    height: 200//settingPage.mainWinHeight
    x: (Screen.width-width)*0.5
    y: (Screen.desktopAvailableHeight)-height-10
    title: qsTr("NoteEditer")
    flags: Qt.FramelessWindowHint|Qt.Window
    color: "#00000000"

    Behavior on width{
        NumberAnimation{
            duration: 300
        }
    }

    Behavior on height{
        PropertyAnimation{
            duration: 300
        }
    }

    Behavior on x{
        PropertyAnimation{
            duration: 500
        }
    }

    Behavior on y{
        PropertyAnimation{
            duration: 500
        }
    }


    //TODO: settings
    Settings{
        id: settings
        property alias setAutoSave: settingPage.autoSave

        property alias windowWidth: settingPage.mainWinWidth
        property alias windowHeight: settingPage.mainWinHeight
        property alias windowX: settingPage.mainWinX
        property alias windowY: settingPage.mainWinY
        property alias curPos: settingPage.posCur

        property alias windowOpacity: settingPage.mainWinOpacity
        property alias inputWindowOpacity: settingPage.inputOpacity

        property alias defaultFilePath: settingPage.fileUrl

        property alias typeView: settingPage.keyPress
        property alias loadtextFormat: loadText.textFormat

        property alias windowColor: settingPage.mainWinColor
        property alias editRecColor: settingPage.editWinColor

        property alias fontColor: settingPage.fontColor
        property alias editFontColor: settingPage.editFontColor
        property alias fontSize: settingPage.fontSize
        property alias editFontSize: settingPage.editFontSize

    }

    /*设置窗口*/
    SettingPage{
        id:settingPage
        x: mainWinX+mainWinWidth*0.5
        y: Screen.height * 0.5
//        x: 800;
        visible: false
        autoSave: true

        mainWinWidth: win.width
        mainWinHeight: win.height
        mainWinX: win.x
        mainWinY: win.y

        mainWinColor: rec.color
        editWinColor:inputRec.color

        mainWinOpacity: rec.opacity
        inputOpacity: inputRec.opacity

        fontColor: loadText.color
        editFontColor: textEdit.color
        fontSize: loadText.font.pixelSize
        editFontSize: textEdit.font.pixelSize

        fileUrl: fileDeal.getFilePath(StandardPaths.writableLocation(StandardPaths.DocumentsLocation) + "/Note.md")

        property var tmpText: ""

        onFileUrlIsChanged: {
            fileUrl = fileDeal.getFilePath(fileUrl);
            loadText.text =  fileDeal.loadFileDeal(fileUrl);
        }

        onMainWinWidthChanged: win.width = settingPage.mainWinWidth
        onMainWinHeightChanged: win.height = settingPage.mainWinHeight
        onMainWinXChanged: win.x = settingPage.mainWinX
        onMainWinYChanged: win.y = settingPage.mainWinY

        onMainWinOpacityChanged: rec.opacity = mainWinOpacity
        onInputOpacityChanged: inputRec.opacity = inputOpacity

        onKeyPressChanged: {
            tmpText = loadText.text;
            loadText.clear();
            switch(keyPress){
            case typeList[0]:
                loadText.textFormat = Text.PlainText
                break;
            case typeList[1]:
                loadText.textFormat = Text.MarkdownText
                break;
            case typeList[2]:
                loadText.textFormat = Text.RichText
                break;
            case typeList[3]:
                loadText.textFormat = Text.AutoText
                break;
            default:
                break;
            }
            loadText.text = tmpText;
        }

        onMainWinColorChanged: rec.color = mainWinColor;
        onEditWinColorChanged: inputRec.color = editWinColor

        onFontColorChanged: loadText.color = fontColor
        onFontSizeChanged: loadText.font.pixelSize = fontSize
        onEditFontColorChanged: textEdit.color = editFontColor
        onEditFontSizeChanged: textEdit.font.pixelSize = editFontSize

    }

    function loadSettingPage(){
        settingPage.visible = true
    }

    /*右键菜单*/
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.RightButton
        onClicked: zoomMenu.open()
    }

    Menu {
        id: zoomMenu

        MenuItem {
            text: qsTr("设置")
            shortcut: "Ctrl+,"
            onTriggered: {
                loadSettingPage()
            }
        }

        MenuItem {
            text: qsTr("保存")
            shortcut: "Ctrl+S"
            onTriggered: {
                fileDeal.saveFileDeal(loadText.text,settingPage.fileDefault);
            }
        }
    }

//    Qt文本处理filedeal.cpp
    FileDeal{
        id:fileDeal
    }

//    Qt 按键过滤filterevent.cpp
    Filterevent{
        objectName: "filterEvent"

        onSettingShow: {
            loadSettingPage();
        }

        onFileSave: {
            fileDeal.saveFileDeal(loadText.text,settingPage.fileDefault);
        }

        onQuitApp: {
            Qt.quit();
        }
    }

//    主窗口
    Rectangle{
        id: mainWindow
        anchors.fill: parent
        radius: 8
        color: "#00000000"

        Keys.onEscapePressed: {
//            console.log("Esc")
            //win.visible = false
            win.showMinimized();
        }

//    输入窗口
        Rectangle{
            id: inputRec
            anchors.bottom: parent.bottom
            height: 30
            width: parent.width
            radius: 8
            opacity: 0.8
            color: "#3399ff"

            Flickable{
                id: editFlick
                width: parent.width
                height: parent.height
                contentHeight: textEdit.paintedHeight
                contentWidth: textEdit.paintedWidth

                function ensureVisible(r)
                {
                   if (contentX >= r.x)
                       contentX = r.x;
                   else if (contentX+width <= r.x+r.width)
                       contentX = r.x+r.width-width;
                   if (contentY >= r.y)
                       contentY = r.y;
                   else if (contentY+height <= r.y+r.height)
                       contentY = r.y+r.height-height;
                }

                TextEdit{
                    id:textEdit
                    color: "#ffffff"
                    width: inputRec.width
                    height: inputRec.height
                    leftPadding: inputRec.radius
                    topPadding: inputRec.radius * 0.5
                    focus: true
                    clip: false
                    wrapMode: TextEdit.Wrap
                    selectByMouse: true
                    font.pixelSize: 14

                    /*光标跟随*/
                    onCursorRectangleChanged: editFlick.ensureVisible(cursorRectangle)

                    Keys.onPressed: {
                        if(event.modifiers === Qt.ControlModifier && event.key === Qt.Key_Return){
                            if(loadText.textFormat === Text.PlainText){
                                loadText.text += (textEdit.text += "\n");
                            }else{
                                loadText.text += (textEdit.text );
                            }
                            textEdit.clear();
                        }
                    }
                }
            }
        }

//        显示窗口
        Rectangle{
            id:rec
            radius: 8
            opacity: 0.8
            anchors.bottom: inputRec.top
            anchors.bottomMargin: 5
            width: parent.width
            height: parent.height - inputRec.height-5
            color: "#454545"

            Behavior on color{
                PropertyAnimation{
                    duration: 1000
                }
            }

            Behavior on opacity{
                PropertyAnimation{
                    duration: 1000
                }
            }

            Flickable {
                 id: flick
                 width: parent.width; height: parent.height;
                 contentWidth: loadText.paintedWidth
                 contentHeight: loadText.paintedHeight

                TextEdit {
                    id:loadText
                    width: rec.width
                    height: rec.height
                    color: "#ffffff"
                    leftPadding: rec.radius
                    rightPadding: rec.radius
                    readOnly: true
                    textFormat: Text.MarkdownText
                    wrapMode: TextEdit.Wrap
                    clip: false
                    font.pixelSize: 14
                    /*selectByMouse无法跟随flick*/
                    //selectByMouse: true

                    Component.onCompleted: loadText.text = fileDeal.loadFileDeal(settingPage.fileUrl);

                    onContentSizeChanged: flick.contentY = contentHeight-flick.height

                    onTextChanged: {
//                        console.log(loadText.text)
                        if(settingPage.autoSave){
                            fileDeal.saveFileDeal(loadText.text,settingPage.fileUrl);
                        }
                    }
                }
            }
        }
    }

    /*系统托盘*/
    SystemTrayIcon {
        visible: true
        tooltip: "NoteEditer"
        icon.source: "qrc:/icon/logo.png"
        onActivated: {
            //showMinimized()之后状态为3？
            if(win.visibility === Qt.WindowMaximized){
                win.showMinimized()
            }else{
                win.showNormal()
            }
//            console.log(Screen.desktopAvailableHeight)
//            console.log(Screen.height)
            win.raise()
            win.requestActivate()
        }


        menu: Menu {
            id:mmenu
            MenuItem{
                text: qsTr("设置");
                onTriggered: {
                    loadSettingPage();
                }
            }

            MenuItem{
                text: qsTr("退出");
                onTriggered: Qt.quit();
            }
        }
    }

}


