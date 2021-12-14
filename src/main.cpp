
#include <cstdio>
#ifdef _WIN32
#    include <windows.h>
#endif

#include <QApplication>
#include <QWidgetList>

#include "hmi/mainwindow.h"

auto main(int argc, char ** argv) -> int
{
#ifdef _WIN32
    if (AttachConsole(ATTACH_PARENT_PROCESS))
    {
        freopen("CONOUT$", "w", stdout);    // NOLINT
        freopen("CONOUT$", "w", stderr);    // NOLINT
    }
#endif

    QApplication a(argc, argv);
    MainWindow w;
    w.show();
    return QApplication::exec();
}
