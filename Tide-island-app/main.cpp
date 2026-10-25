#include <QCoreApplication>
#include <QGuiApplication>
#include <QDebug>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "backend.hpp"

int main(int argc, char *argv[]) {
    bool ensureNiriShortcuts = false;
    bool validateQml = false;
    bool openLockSettings = false;
    for (int index = 1; index < argc; ++index) {
        const QString argument = QString::fromLocal8Bit(argv[index]);
        ensureNiriShortcuts = ensureNiriShortcuts || argument == QStringLiteral("--ensure-niri-shortcuts");
        validateQml = validateQml || argument == QStringLiteral("--validate-qml");
        openLockSettings = openLockSettings || argument == QStringLiteral("--lock-screen");
    }

    if (ensureNiriShortcuts) {
        QCoreApplication app(argc, argv);
        Backend backend;
        if (!backend.niriShortcutBindingsNeedApply())
            return 0;
        if (backend.ensureNiriShortcutBindings())
            return 0;
        qCritical().noquote() << backend.errorString();
        return 1;
    }

    QGuiApplication app(argc, argv);
    Backend backend;
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty(QStringLiteral("backend"), &backend);
    engine.loadFromModule(QStringLiteral("TideIsland"), QStringLiteral("Main"));
    if (engine.rootObjects().isEmpty()) return -1;
    if (openLockSettings)
        QMetaObject::invokeMethod(engine.rootObjects().first(), "selectPage", Q_ARG(QVariant, 6));
    if (validateQml) return 0;
    return app.exec();
}
