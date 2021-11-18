/****************************************************************************
** Meta object code from reading C++ file 'filedeal.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.14.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../../filedeal.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'filedeal.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.14.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_FileDeal_t {
    QByteArrayData data[11];
    char stringdata0[105];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_FileDeal_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_FileDeal_t qt_meta_stringdata_FileDeal = {
    {
QT_MOC_LITERAL(0, 0, 8), // "FileDeal"
QT_MOC_LITERAL(1, 9, 15), // "loadTextChanged"
QT_MOC_LITERAL(2, 25, 0), // ""
QT_MOC_LITERAL(3, 26, 8), // "initText"
QT_MOC_LITERAL(4, 35, 8), // "loadPath"
QT_MOC_LITERAL(5, 44, 12), // "saveFileDeal"
QT_MOC_LITERAL(6, 57, 4), // "text"
QT_MOC_LITERAL(7, 62, 8), // "savePath"
QT_MOC_LITERAL(8, 71, 12), // "loadFileDeal"
QT_MOC_LITERAL(9, 84, 8), // "filePath"
QT_MOC_LITERAL(10, 93, 11) // "getFilePath"

    },
    "FileDeal\0loadTextChanged\0\0initText\0"
    "loadPath\0saveFileDeal\0text\0savePath\0"
    "loadFileDeal\0filePath\0getFilePath"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_FileDeal[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
       8,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       3,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   54,    2, 0x06 /* Public */,
       3,    0,   55,    2, 0x06 /* Public */,
       4,    0,   56,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       5,    2,   57,    2, 0x0a /* Public */,
       5,    1,   62,    2, 0x2a /* Public | MethodCloned */,
       8,    1,   65,    2, 0x0a /* Public */,
       8,    0,   68,    2, 0x2a /* Public | MethodCloned */,
      10,    1,   69,    2, 0x0a /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void, QMetaType::QString, QMetaType::QString,    6,    7,
    QMetaType::Void, QMetaType::QString,    6,
    QMetaType::QString, QMetaType::QString,    9,
    QMetaType::QString,
    QMetaType::QString, QMetaType::QString,    9,

       0        // eod
};

void FileDeal::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<FileDeal *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->loadTextChanged(); break;
        case 1: _t->initText(); break;
        case 2: _t->loadPath(); break;
        case 3: _t->saveFileDeal((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 4: _t->saveFileDeal((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 5: { QString _r = _t->loadFileDeal((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 6: { QString _r = _t->loadFileDeal();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 7: { QString _r = _t->getFilePath((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (FileDeal::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&FileDeal::loadTextChanged)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (FileDeal::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&FileDeal::initText)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (FileDeal::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&FileDeal::loadPath)) {
                *result = 2;
                return;
            }
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject FileDeal::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_FileDeal.data,
    qt_meta_data_FileDeal,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *FileDeal::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *FileDeal::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_FileDeal.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int FileDeal::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 8)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 8;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 8)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 8;
    }
    return _id;
}

// SIGNAL 0
void FileDeal::loadTextChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void FileDeal::initText()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void FileDeal::loadPath()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
