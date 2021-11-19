#include "filedeal.h"
#include <QFile>
#include <QDebug>

//#ifdef Q_OS_WIN
//#include "winsock2.h"
//#endif

FileDeal::FileDeal(QObject *parent) : QObject(parent)
{

}

void FileDeal::saveFileDeal(QString text, QString savePath)
{
    QFile saveFile(savePath);
//    if(saveFile.exists()){
//        return;
//    }
    saveFile.open(QIODevice::WriteOnly|QIODevice::Text);
    saveFile.write(text.toUtf8());
    saveFile.close();
}

QString FileDeal::loadFileDeal(QString filePath)
{
//    filePath = getFilePath(filePath);
    QFile loadFile(filePath);
    if(!loadFile.exists()){
        return 0;
    }
    loadFile.open(QIODevice::WriteOnly|QIODevice::ReadOnly);
    QString f = loadFile.readAll();
    loadFile.close();
    return f;
}

QString FileDeal::getFilePath(QString filePath)
{
#ifdef Q_OS_WIN
    qDebug()<<"当前系统：windows";
    return filePath.mid(8);
#endif
#ifdef Q_OS_LINUX
    qDebug()<<"当前系统：linux";
    return filePath.mid(7);
#endif

}
