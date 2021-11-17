import QtQuick 2.14
import QtQuick.Window 2.14
import Qt.labs.platform 1.1
import Qt.labs.settings 1.1
import file.save.FileDeal 1.0
import event.key.filter 1.0

Window {
    id:win
    visible: true
    width: settingPage.mainWinWidget//Screen.width * 0.5
    height: settingPage.mainWinHeight
    x: (Screen.width-width)*0.5
    y: (Screen.desktopAvailableHeight)-height-10
    title: qsTr("NoteEditer")
    flags: Qt.FramelessWindowHint|Qt.Window
    color: "#00000000"

    property string noteText;

    Behavior on width{
        NumberAnimation{
            duration: 500
        }
    }

    Behavior on height{
        PropertyAnimation{
            duration: 500
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
        property alias textColor: loadText.color
        property alias setAutoSave: settingPage.autoSave
        property alias windowWidth: settingPage.mainWinWidget
        property alias windowHeight: settingPage.mainWinHeight
        property alias windowOpacity: settingPage.mainWinOpacity
        property alias inputWindowOpacity: settingPage.inputOpacity
        property alias defaultFilePath: settingPage.fileDefault
        property alias typeView: settingPage.keyPress
        property alias windowColor: rec.color
        property alias windowX: settingPage.mainWinX
        property alias windowY: settingPage.mainWinY
    }

    /*设置窗口*/
    SettingPage{
        id:settingPage
//        x: (Screen.width-width)*0.5
        y: Screen.height * 0.5
        x: 800;
        //visible: true
        autoSave: true
        mainWinWidget: win.width
        mainWinHeight: win.height
        mainWinX: win.x
        mainWinY: win.y
        mainWinColor: rec.color
        mainWinOpacity: rec.opacity
        inputOpacity: inputRec.opacity
        fileDefault: fileDeal.getFilePath(StandardPaths.writableLocation(StandardPaths.DocumentsLocation) + "/Note.md")

        property var tmpText: ""

        onFilePathChanged: {
            fileDefault = fileDeal.getFilePath(filePathDialog)
            loadText.text =  fileDeal.loadFileDeal(fileDefault);
        }

        onSizeChanged: {
//            console.log("change")
            win.width = settingPage.mainWinWidget
            win.height = settingPage.mainWinHeight
        }

        onPosChanged: {
            win.x = settingPage.mainWinX
            win.y = settingPage.mainWinY
        }

        onOpacityChanged: {
            rec.opacity = mainWinOpacity
        }

        onRecInOpacityChanged: {
            inputRec.opacity = inputOpacity
        }

        onLoadTypeChanged: {
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

        onWindowColorChanged: {
            rec.color = mainWinColor
        }
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
                    textFormat: TextEdit.MarkdownText
                    wrapMode: TextEdit.Wrap
                    clip: false
                    /*selectByMouse无法跟随flick*/
                    //selectByMouse: true

                    Component.onCompleted: {
//                        console.log("加载中...\n",win.noteText);
                        loadText.text = fileDeal.loadFileDeal(settingPage.fileDefault);
                    }

                    onContentSizeChanged:  {
//                        console.log(flick.contentY,contentHeight,flick.height)
                        flick.contentY = contentHeight-flick.height
                    }

                    onTextChanged: {
//                        console.log(loadText.text)
                        if(settingPage.autoSave){
                            fileDeal.saveFileDeal(loadText.text,settingPage.fileDefault);
                        }
                    }
                }
            }
        }
    }

    /*系统托盘*/
    SystemTrayIcon {
        visible: true
        tooltip: "toolTip"
        icon.source: "qrc:/icon/icon.png"
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
                text: qsTr("设置")
                onTriggered: {
                    loadSettingPage()
                }
            }

            MenuItem{
                text: qsTr("退出")
                onTriggered: Qt.quit()
            }
        }
    }

}


