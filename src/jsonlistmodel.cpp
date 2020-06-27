#include "jsonlistmodel.h"

#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonParseError>

JsonListModel::JsonListModel(QObject* parent)
    : QAbstractListModel(parent)
{
}

int JsonListModel::rowCount(const QModelIndex& parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    return m_values.size();
}

QVariant JsonListModel::data(const QModelIndex& index, int role) const
{
    if (!index.isValid())
        return QVariant();

    int row = index.row();
    if (row < 0 || row >= m_values.size())
        return QVariant();
    QJsonValue value = m_values[row];

    if (!value.isObject())
        return QVariant();

    int pindex = role - Qt::UserRole;
    if (pindex == m_properties.size()) // modelData
        return value.toVariant();

    if (pindex < 0 || pindex > m_properties.size())
        return QVariant();

    return value.toObject()[m_properties[pindex]].toVariant();
}

QHash<int, QByteArray> JsonListModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    int i = Qt::UserRole;
    for (const QString& prop : m_properties) {
        roles.insert(i++, prop.toUtf8());
    }
    roles.insert(i++, "modelData");
    return roles;
}

QString JsonListModel::values() const
{
    return QString::fromUtf8(QJsonDocument(m_values).toJson());
}

void JsonListModel::setValues(const QString& values)
{
    QJsonParseError error;
    QJsonDocument doc = QJsonDocument::fromJson(values.toUtf8(), &error);
    if (error.error != QJsonParseError::NoError) {
        return;
    }
    if (!doc.isArray()) {
        return;
    }

    beginResetModel();
    m_values = doc.array();
    emit valuesChanged();
    endResetModel();
}

QStringList JsonListModel::properties() const
{
    return m_properties;
}

void JsonListModel::setProperties(const QStringList& properties)
{
    beginResetModel();
    m_properties = properties;
    emit propertiesChanged();
    endResetModel();
}
