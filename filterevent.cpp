#include "filterevent.h"
#include <QEvent>
#include <QKeyEvent>
#include <QtDebug>

filterevent::filterevent(QObject *parent) : QObject(parent)
{

}

bool filterevent::eventFilter(QObject *watched, QEvent *event)
{
    if(event->type() == QEvent::KeyPress){
        QKeyEvent *keyEvent = static_cast<QKeyEvent*>(event);
        if(keyEvent->key() == Qt::Key_Comma && (keyEvent->modifiers() & Qt::ControlModifier)){
            qDebug()<<"setting key press";
            emit settingShow();
        }

    }
    return QObject::eventFilter(watched,event);
}
