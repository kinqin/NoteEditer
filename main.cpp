#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include "filedeal.h"
#include "filterevent.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QApplication app(argc, argv);
    //注册c++类
    qmlRegisterType<FileDeal>("file.save.FileDeal",1,0,"FileDeal");
    qmlRegisterType<filterevent>("event.key.filter",1,0,"Filterevent");
    //QSetting保存位置
    app.setOrganizationName("Personal Note");
    app.setOrganizationDomain("github.com/kinqin/NoteEditer");
    app.setApplicationName("NoteEditer");
    //设置应用图标
    app.setWindowIcon(QIcon(":/icon/logo.png"));

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    //安装事件过滤器
    QObject* mainRootItem = engine.rootObjects()[0];
    QObject* filterEvent = mainRootItem->findChild<QObject*>("filterEvent");
    mainRootItem->installEventFilter(filterEvent);
    
    return app.exec();
}
