#ifndef FILEDEAL_H
#define FILEDEAL_H

#include <QObject>

class FileDeal : public QObject
{
    Q_OBJECT
public:
    explicit FileDeal(QObject *parent = nullptr);

signals:
    void loadTextChanged();
    void initText();
    void loadPath();

public slots:
    void saveFileDeal(QString text,QString savePath = "./Note.md");
    QString loadFileDeal(QString filePath = "./Note.md");
    QString getFilePath(QString filePath);

private:
    QString m_text;
    QString m_savePath;
};

#endif // FILEDEAL_H
