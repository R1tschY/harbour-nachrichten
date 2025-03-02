#pragma once

#include <QAbstractListModel>
#include <QJsonArray>

class JsonListModel : public QAbstractListModel {
    Q_OBJECT
    Q_PROPERTY(QString values READ values WRITE setValues NOTIFY valuesChanged)
    Q_PROPERTY(QStringList properties READ properties WRITE setProperties NOTIFY propertiesChanged)

public:
    explicit JsonListModel(QObject* parent = nullptr);

    // Basic functionality:
    int rowCount(const QModelIndex& parent = QModelIndex()) const override;

    QVariant data(const QModelIndex& index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    QString values() const;
    void setValues(const QString& values);

    QStringList properties() const;
    void setProperties(const QStringList& properties);

signals:
    void valuesChanged();
    void propertiesChanged();

private:
    QJsonArray m_values;
    QStringList m_properties;
};

