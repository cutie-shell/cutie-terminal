#pragma once

#include <QObject>
#include <QKeySequence>
#include <QQuickItem>

class Util : public QObject
{
    Q_OBJECT
    
public:
    Util(QObject *parent = nullptr);
    static Util *self() { return new Util(); }
    Q_INVOKABLE uint getKeyFromString(QString key);
};

