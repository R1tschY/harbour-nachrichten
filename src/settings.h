#pragma once

#include <QObject>
#include <QScopedPointer>
#include <QVariant>

class QSettings;

namespace Cute {

class Settings : public QObject
{
    Q_OBJECT
    Q_PROPERTY(
        QString fileName READ fileName WRITE setFileName NOTIFY fileNameChanged)
    Q_PROPERTY(
        bool autoSync READ autoSync WRITE setAutoSync NOTIFY autoSyncChanged)

    Q_PROPERTY(int length READ length)
public:
    explicit Settings(QObject *parent = nullptr);
    ~Settings() override;

    QString fileName() const;
    void setFileName(const QString &fileName);

    int length() const;

    Q_INVOKABLE QVariant key(int index);
    Q_INVOKABLE QVariant getItem(const QString& keyName);
    Q_INVOKABLE void setItem(const QString& keyName, const QString& keyValue);
    Q_INVOKABLE void removeItem(const QString& keyName);
    Q_INVOKABLE void clear();

    Q_INVOKABLE void sync();

    bool autoSync() const;
    void setAutoSync(bool autoSync);

signals:
    void fileNameChanged();
    void autoSyncChanged();

private:
    QScopedPointer<QSettings> m_inner;
    bool m_autoSync = true;

    void doAutoSync();
};

} // namespace Cute
