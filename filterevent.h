#ifndef FILTEREVENT_H
#define FILTEREVENT_H

#include <QObject>

class filterevent : public QObject
{
    Q_OBJECT
public:
    explicit filterevent(QObject *parent = nullptr);
protected:
    bool eventFilter(QObject *watched, QEvent *event) override;

signals:
    void settingShow();
    void fileSave();
    void quitApp();
};

#endif // FILTEREVENT_H
