#include "filedeal.h"
#include <QFile>
#include <QDebug>
#include <QMessageBox>

//#ifdef Q_OS_WIN
//#include "winsock2.h"
//#endif

FileDeal::FileDeal(QObject *parent) : QObject(parent)
{

}

void FileDeal::saveFileDeal(QString text, QString savePath)
{
    QFile saveFile(savePath);

    if(saveFile.open(QIODevice::WriteOnly|QIODevice::Text)){
        saveFile.write(text.toUtf8());
        saveFile.close();
    }else{
        QMessageBox::information(NULL, "ERROR", "file invalid: "+savePath,QMessageBox::Yes);
    }

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
    return filePath.mid(8);
#endif
#ifdef Q_OS_LINUX
    return filePath.mid(7);
#endif

}
