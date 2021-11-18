#include "filterevent.h"
#include <QEvent>
#include <QKeyEvent>

filterevent::filterevent(QObject *parent) : QObject(parent)
{

}

bool filterevent::eventFilter(QObject *watched, QEvent *event)
{
    if(event->type() == QEvent::KeyPress){
        QKeyEvent *keyEvent = static_cast<QKeyEvent*>(event);
        if(keyEvent->modifiers() & Qt::ControlModifier){
            switch (keyEvent->key()) {
            case Qt::Key_Comma:
                emit settingShow();
                break;
            case Qt::Key_S:
                emit fileSave();
                break;
            case Qt::Key_Q:
                emit quitApp();
                break;
            default:
                break;
            }
        }

    }
    return QObject::eventFilter(watched,event);
}
