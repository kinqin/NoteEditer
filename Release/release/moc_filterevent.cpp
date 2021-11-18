/****************************************************************************
** Meta object code from reading C++ file 'filterevent.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.14.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../../filterevent.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'filterevent.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.14.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_filterevent_t {
    QByteArrayData data[5];
    char stringdata0[42];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_filterevent_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_filterevent_t qt_meta_stringdata_filterevent = {
    {
QT_MOC_LITERAL(0, 0, 11), // "filterevent"
QT_MOC_LITERAL(1, 12, 11), // "settingShow"
QT_MOC_LITERAL(2, 24, 0), // ""
QT_MOC_LITERAL(3, 25, 8), // "fileSave"
QT_MOC_LITERAL(4, 34, 7) // "quitApp"

    },
    "filterevent\0settingShow\0\0fileSave\0"
    "quitApp"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_filterevent[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
       3,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       3,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   29,    2, 0x06 /* Public */,
       3,    0,   30,    2, 0x06 /* Public */,
       4,    0,   31,    2, 0x06 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

       0        // eod
};

void filterevent::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<filterevent *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->settingShow(); break;
        case 1: _t->fileSave(); break;
        case 2: _t->quitApp(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (filterevent::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&filterevent::settingShow)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (filterevent::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&filterevent::fileSave)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (filterevent::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&filterevent::quitApp)) {
                *result = 2;
                return;
            }
        }
    }
    Q_UNUSED(_a);
}

QT_INIT_METAOBJECT const QMetaObject filterevent::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_filterevent.data,
    qt_meta_data_filterevent,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *filterevent::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *filterevent::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_filterevent.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int filterevent::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 3)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 3;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 3)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 3;
    }
    return _id;
}

// SIGNAL 0
void filterevent::settingShow()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void filterevent::fileSave()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void filterevent::quitApp()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
