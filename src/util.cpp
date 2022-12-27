#include "util.h"
#include <QQuickWindow>

Util::Util(QObject *parent) 
    : QObject{ parent }
{}

uint Util::getKeyFromString(QString key)
{
    QKeySequence seq = QKeySequence(key);
    return seq.count() > 0 ? seq[0] : 0;
}
