#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setWindowIcon(QIcon(":/NumPad/assets/Icons/numpad.png"));

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/NumPad/Main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
