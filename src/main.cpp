#include "mainwindow.h"

#include <QApplication>
#include <windows.h>

auto main(int argc, char * argv[]) -> int
{
#ifdef _WIN32
    if (AttachConsole(ATTACH_PARENT_PROCESS))
    {
        freopen("CONOUT$", "w", stdout);
        freopen("CONOUT$", "w", stderr);
    }
#endif

    QApplication a(argc, argv);
    MainWindow w;
    w.show();
    return QApplication::exec();
}
