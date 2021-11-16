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
    qmlRegisterType<FileDeal>("file.save.FileDeal",1,0,"FileDeal");
    qmlRegisterType<filterevent>("event.key.filter",1,0,"Filterevent");

    app.setOrganizationName("Personal Note");
    app.setOrganizationDomain("github.com/kinqin/NoteEditer");
    app.setApplicationName("NoteEditer");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    QObject* mainRootItem = engine.rootObjects()[0];
    QObject* filterEvent = mainRootItem->findChild<QObject*>("filterEvent");
    mainRootItem->installEventFilter(filterEvent);
    
    return app.exec();
}
