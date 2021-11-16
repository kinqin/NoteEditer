#include "filedeal.h"
#include <QFile>
#include <QDebug>

FileDeal::FileDeal(QObject *parent) : QObject(parent)
{

}

void FileDeal::saveFileDeal(QString text, QString savePath)
{
    QFile saveFile(savePath);
    if(saveFile.exists()){
        //qDebug()<<saveFile.fileName();
    }
    saveFile.open(QIODevice::WriteOnly|QIODevice::Text);
    saveFile.write(text.toUtf8());
    saveFile.close();
}

QString FileDeal::loadFileDeal(QString filePath)
{
//    filePath = getFilePath(filePath);
//    qDebug()<<"filePath"<<filePath;
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
    return filePath.mid(8);
}
