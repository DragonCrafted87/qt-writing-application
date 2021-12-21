
#include <cstdio>
#include <iostream>
#ifdef _WIN32
#    include <windows.h>
#endif

#include <cstdlib>

#include <QApplication>
#include <QByteArray>
#include <QConstOverload>
#include <QDateTime>
#include <QList>
#include <QMessageLogContext>
#include <QString>
#include <QStringList>
#include <QStringLiteral>
#include <QWidgetList>

#include "hmi/mainwindow.h"

void verboseMessageHandler(QtMsgType type, const QMessageLogContext & context, const QString & msg)
{
    static const QStringList typeStr{"[   Debug]", "[ Warning]", "[Critical]", "[   Fatal]"};

    if (type <= QtFatalMsg)
    {
        QString file_name = QString(context.file);
        qsizetype file_name_base_index = file_name.indexOf("src", 1) + 4;
        qsizetype file_name_size = file_name.size();
        file_name = file_name.last(file_name_size - file_name_base_index);

        QByteArray localMsg = msg.toLocal8Bit();
        QString contextString(QStringLiteral("(%1, %2, %3)").arg(file_name).arg(context.function).arg(context.line));

        QString timeStr(QDateTime::currentDateTime().toString("yy-MM-dd HH:mm:ss:zzz"));

        std::cerr << timeStr.toStdString() << " - " << typeStr[type].toStdString() << " " << contextString.toStdString()
                  << " " << localMsg.toStdString() << std::endl;

        if (type == QtFatalMsg)
        {
            abort();
        }
    }
}



auto main(int argc, char ** argv) -> int
{
#ifdef _WIN32
    if (AttachConsole(ATTACH_PARENT_PROCESS))
    {
        freopen("CONOUT$", "w", stdout);    // NOLINT
        freopen("CONOUT$", "w", stderr);    // NOLINT
    }
#endif

    QApplication application(argc, argv);
    QApplication::setApplicationName(APPLICATION_NAME);
    QApplication::setApplicationVersion(APPLICATION_VERSION);

    qInstallMessageHandler(verboseMessageHandler);

    MainWindow primary_window;
    primary_window.show();
    return QApplication::exec();
}
