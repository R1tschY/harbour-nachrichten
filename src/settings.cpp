#include "settings.h"

#include <QString>
#include <QVariant>
#include <QSettings>

namespace Cute {

Settings::Settings(QObject *parent)
    : QObject(parent)
    , m_inner(new QSettings())
{
}

Settings::~Settings() = default;

QString Settings::fileName() const
{
    return m_inner->fileName();
}


void Settings::setFileName(const QString &fileName)
{
    if (m_inner->fileName() == fileName)
        return;

    m_inner.reset(new QSettings(fileName));
    emit fileNameChanged();
}

int Settings::length() const
{
    return m_inner->allKeys().length();
}

QVariant Settings::key(int index)
{
    QString key = m_inner->allKeys().at(index);
    if (!key.isNull()) {
        return m_inner->value(key).toString();
    }
    return QVariant();
}

QVariant Settings::getItem(const QString& keyName)
{
    return m_inner->value(keyName);
}

void Settings::setItem(const QString& keyName, const QString& keyValue)
{
    m_inner->setValue(keyName, keyValue);
    doAutoSync();
}

void Settings::removeItem(const QString& keyName)
{
    m_inner->remove(keyName);
    doAutoSync();
}

void Settings::clear()
{
    m_inner->clear();
    doAutoSync();
}

void Settings::sync()
{
    m_inner->sync();
}

bool Settings::autoSync() const
{
    return m_autoSync;
}

void Settings::setAutoSync(bool autoSync)
{
    if (m_autoSync == autoSync)
        return;

    m_autoSync = autoSync;
    emit autoSyncChanged();
}

void Settings::doAutoSync()
{
    if (m_autoSync) {
        sync();
    }
}

} // namespace Cute
